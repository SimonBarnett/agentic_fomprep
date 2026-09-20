# Install SQL gate + compile revision lookup. Table/column names come from pins.
# Do not invent ENAMEs or table names.

function ConvertTo-RevisionSqlValue {
    param([string]$Revision)
    if ([string]::IsNullOrWhiteSpace($Revision)) { return $null }
    $t = $Revision.Trim()
    $n = 0
    if ([int]::TryParse($t, [ref]$n)) { return $n }
    return $t
}

function Test-VersionRevisionExists {
    param(
        $Connection,
        $Pin,
        [string]$Revision
    )
    if ($null -eq $Connection) { throw 'SQL connection is required' }
    if ($null -eq $Pin) { throw 'pin missing' }
    if (Test-ShellPinTokenEmpty $Pin.VersionRevisionsTable) {
        throw 'VersionRevisionsTable is unpinned'
    }
    if (Test-ShellPinTokenEmpty $Pin.VersionRevisionCol) {
        throw 'VersionRevisionCol is unpinned'
    }
    $rev = ConvertTo-RevisionSqlValue $Revision
    if ($null -eq $rev) { return $false }
    $table = ConvertTo-SqlIdent ([string]$Pin.VersionRevisionsTable)
    $col = ConvertTo-SqlIdent ([string]$Pin.VersionRevisionCol)
    $q = "SELECT COUNT(*) FROM $table WHERE $col = @r"
    $n = Invoke-FormPrepSql -Connection $Connection -Query $q -Parameters @{ '@r' = $rev } -Scalar
    return [int]$n -gt 0
}

function Test-PinnedEnameInExec {
    param(
        $Connection,
        $Pin,
        [string]$Ename
    )
    if ([string]::IsNullOrWhiteSpace($Ename)) { return $false }
    if ($null -eq $Pin -or (Test-ShellPinTokenEmpty $Pin.ExecTable) -or (Test-ShellPinTokenEmpty $Pin.ExecNameCol)) {
        throw 'ExecTable / ExecNameCol unpinned'
    }
    $execTable = ConvertTo-SqlIdent ([string]$Pin.ExecTable)
    $enameCol = ConvertTo-SqlIdent ([string]$Pin.ExecNameCol)
    $n = Invoke-FormPrepSql -Connection $Connection -Query "SELECT COUNT(*) FROM $execTable WHERE $enameCol = @n" -Parameters @{ '@n' = $Ename } -Scalar
    return [int]$n -gt 0
}

function Get-InstallLogSnapshot {
    param(
        $Connection,
        $Pin,
        [string]$Revision
    )
    if ($null -eq $Pin) { throw 'pin missing' }
    if (Test-ShellPinTokenEmpty $Pin.InstallLogTable) {
        throw 'InstallLogTable is unpinned'
    }
    if (Test-ShellPinTokenEmpty $Pin.InstallLogRevisionCol) {
        throw 'InstallLogRevisionCol is unpinned'
    }
    if (Test-ShellPinTokenEmpty $Pin.InstallLogDateCol) {
        throw 'InstallLogDateCol is unpinned'
    }
    $table = ConvertTo-SqlIdent ([string]$Pin.InstallLogTable)
    $revCol = ConvertTo-SqlIdent ([string]$Pin.InstallLogRevisionCol)
    $dateCol = ConvertTo-SqlIdent ([string]$Pin.InstallLogDateCol)
    $rev = ConvertTo-RevisionSqlValue $Revision
    $q = "SELECT COUNT(*) AS n, MAX($dateCol) AS lastDate FROM $table WHERE $revCol = @r"
    $tbl = Invoke-FormPrepSql -Connection $Connection -Query $q -Parameters @{ '@r' = $rev }
    $n = 0
    $last = $null
    if ($tbl -and $tbl.Rows.Count -gt 0) {
        $n = [int]$tbl.Rows[0].n
        $raw = $tbl.Rows[0].lastDate
        if ($null -ne $raw -and $raw -isnot [DBNull]) { $last = $raw }
    }
    return [pscustomobject]@{
        revision = [string]$Revision
        count    = $n
        lastDate = $last
    }
}

function Test-InstallLogAdvanced {
    param(
        $Before,
        $After,
        [datetime]$StartedAt = [datetime]::MinValue
    )
    if ($null -eq $After) { return $false }
    $beforeCount = 0
    if ($Before) { $beforeCount = [int]$Before.count }
    if ([int]$After.count -gt $beforeCount) { return $true }
    if ($null -eq $After.lastDate) { return $false }
    $afterDt = $null
    try { $afterDt = [datetime]$After.lastDate } catch { $afterDt = $null }
    if ($afterDt -and $StartedAt -ne [datetime]::MinValue -and $afterDt -ge $StartedAt.AddMinutes(-1)) {
        return $true
    }
    if ($Before -and $null -ne $Before.lastDate) {
        try {
            $beforeDt = [datetime]$Before.lastDate
            if ($afterDt -and $afterDt -gt $beforeDt) { return $true }
        } catch { }
    }
    return $false
}

function Get-MissingExecEnames {
    param(
        $Connection,
        $Pin,
        [string[]]$Names
    )
    $missing = @()
    $wanted = @($Names | Where-Object { $_ } | Select-Object -Unique)
    if ($wanted.Count -lt 1) { return @() }
    if ($null -eq $Connection) {
        return @($wanted)
    }
    foreach ($n in $wanted) {
        if (-not (Test-PinnedEnameInExec -Connection $Connection -Pin $Pin -Ename $n)) {
            $missing += , $n
        }
    }
    return @($missing)
}

function New-InstallGateObject {
    param(
        $Before,
        $After,
        [datetime]$StartedAt,
        [string[]]$Takesingleent,
        [string[]]$MissingEnames
    )
    $advanced = Test-InstallLogAdvanced -Before $Before -After $After -StartedAt $StartedAt
    $missing = @($MissingEnames)
    return [ordered]@{
        logAdvanced      = [bool]$advanced
        beforeCount      = $(if ($Before) { [int]$Before.count } else { 0 })
        afterCount       = $(if ($After) { [int]$After.count } else { 0 })
        beforeLastDate   = $(if ($Before -and $Before.lastDate) { [string]$Before.lastDate } else { $null })
        afterLastDate    = $(if ($After -and $After.lastDate) { [string]$After.lastDate } else { $null })
        takesingleent    = @($Takesingleent)
        entitiesMissing  = @($missing)
        entitiesPresent  = [bool]($missing.Count -eq 0)
    }
}

function Test-WcfWalkContradiction {
    param($Pin, $Walk)
    if ($null -eq $Pin -or $null -eq $Walk) {
        return @{ contradict = $false; detail = 'no pin or walk transcript' }
    }
    $seen = [bool]$Walk.fileStepSeen
    if (Test-WcfFileStepPinTrue $Pin) {
        if (-not $seen) {
            return @{ contradict = $true; detail = 'WcfFileStepWorks=true but walk transcript has no file/path input' }
        }
        return @{ contradict = $false; detail = 'WcfFileStepWorks=true and file/path input seen' }
    }
    if (Test-WcfFileStepPinFalse $Pin) {
        if ($seen) {
            return @{ contradict = $true; detail = 'WcfFileStepWorks=false but walk transcript has file/path input' }
        }
        return @{ contradict = $false; detail = 'WcfFileStepWorks=false and no file/path input' }
    }
    return @{ contradict = $false; detail = 'WcfFileStepWorks unpinned (null); no contradiction' }
}
