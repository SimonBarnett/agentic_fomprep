# Composes formlimited_audit SQL from v2/config pin.json. Offline-testable; no connection.

function Get-SqlPinRequiredKeys {
    return @(
        'ExecTable',
        'ExecNameCol',
        'ExecIdCol',
        'FormLimitedTable',
        'FormLimitedExecCol'
    )
}

function Get-FormPrepSqlPinRequiredKeys {
    $keys = @(Get-SqlPinRequiredKeys)
    $keys += @('LockTable')
    return @($keys)
}

function Get-FormPrepLockColKeys {
    return @('ExecId', 'Upd', 'LastPrep')
}

function Get-SqlPinGaps {
    param($Pin)
    $gaps = @()
    if ($null -eq $Pin) {
        return @('pin object is null')
    }
    if (-not $Pin.PinComplete) {
        return @('PinComplete is false')
    }
    foreach ($k in (Get-SqlPinRequiredKeys)) {
        $v = $Pin.$k
        if (Test-ShellPinTokenEmpty $v) { $gaps += $k }
    }
    return @($gaps)
}

function Get-FormPrepSqlPinGaps {
    param($Pin)
    $gaps = @(Get-SqlPinGaps -Pin $Pin)
    if ($null -eq $Pin) { return $gaps }
    if (Test-ShellPinTokenEmpty $Pin.LockTable) { $gaps += 'LockTable' }
    $lc = $Pin.LockCols
    if ($null -eq $lc) {
        $gaps += 'LockCols'
    } else {
        foreach ($k in (Get-FormPrepLockColKeys)) {
            $v = $lc.$k
            if (Test-ShellPinTokenEmpty $v) { $gaps += ('LockCols.' + $k) }
        }
    }
    return @($gaps | Select-Object -Unique)
}

function Test-SqlPinReady {
    param($Pin)
    return ((Get-SqlPinGaps -Pin $Pin).Count -eq 0)
}

function Test-FormPrepSqlPinReady {
    param($Pin)
    return ((Get-FormPrepSqlPinGaps -Pin $Pin).Count -eq 0)
}

function New-FormLimitedAuditSql {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Pin,
        [Parameter(Mandatory = $true)][string[]]$FormNames
    )
    $gaps = @(Get-SqlPinGaps -Pin $Pin)
    if ($gaps.Count -gt 0) {
        throw ('SQL pin incomplete: ' + ($gaps -join ', '))
    }
    $names = @($FormNames | ForEach-Object { [string]$_ } | Where-Object { $_ })
    if ($names.Count -lt 1) {
        throw 'formlimited_audit needs a form set'
    }
    foreach ($f in $names) {
        if ($f -notmatch '^[A-Za-z][A-Za-z0-9_]*$') {
            throw "bad form name '$f'"
        }
    }
    $flTable = ConvertTo-SqlIdent ([string]$Pin.FormLimitedTable)
    $execTable = ConvertTo-SqlIdent ([string]$Pin.ExecTable)
    $flExec = ConvertTo-SqlIdent ([string]$Pin.FormLimitedExecCol)
    $execId = ConvertTo-SqlIdent ([string]$Pin.ExecIdCol)
    $eName = ConvertTo-SqlIdent ([string]$Pin.ExecNameCol)
    $params = @{}
    $ph = @()
    $i = 0
    foreach ($f in $names) {
        $k = "@f$i"
        $params[$k] = $f
        $ph += $k
        $i++
    }
    $sql = @"
SELECT FL.*
FROM $flTable FL
INNER JOIN $execTable E ON FL.$flExec = E.$execId
WHERE E.$eName IN ($($ph -join ', '))
"@
    return [pscustomobject]@{
        Sql          = $sql
        Parameters   = $params
        Placeholders = @($ph)
        FormNames    = @($names)
    }
}

function Test-FormLimitedAuditComposed {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$Sql,
        [Parameter(Mandatory = $true)][hashtable]$Parameters,
        [Parameter(Mandatory = $true)][string[]]$FormNames,
        [Parameter(Mandatory = $true)]$Pin
    )
    if ($FormNames.Count -lt 1) { return $false }
    $built = New-FormLimitedAuditSql -Pin $Pin -FormNames $FormNames
    $flExec = ConvertTo-SqlIdent ([string]$Pin.FormLimitedExecCol)
    $execId = ConvertTo-SqlIdent ([string]$Pin.ExecIdCol)
    $eName = ConvertTo-SqlIdent ([string]$Pin.ExecNameCol)
    $joinNeedle = 'FL.' + $flExec + ' = E.' + $execId
    if ($Sql -notmatch [regex]::Escape($joinNeedle)) { return $false }
    if ($Sql -notmatch ('WHERE E\.' + [regex]::Escape($eName) + ' IN \(')) { return $false }
    if ($Parameters.Count -ne $FormNames.Count) { return $false }
    foreach ($n in $FormNames) {
        if ($Sql -match [regex]::Escape($n)) { return $false }
        $found = $false
        foreach ($v in $Parameters.Values) {
            if ([string]$v -eq $n) { $found = $true; break }
        }
        if (-not $found) { return $false }
    }
    foreach ($ph in $built.Placeholders) {
        if ($Sql -notmatch [regex]::Escape($ph)) { return $false }
        if (-not $Parameters.ContainsKey($ph)) { return $false }
    }
    if ($Sql -match 'FORMLIMITED WHERE FORM') { return $false }
    return $true
}
