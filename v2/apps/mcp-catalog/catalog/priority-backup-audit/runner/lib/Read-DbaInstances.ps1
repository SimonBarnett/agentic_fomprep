function Get-DbaInstancesConfig {
    param(
        [string]$Path,
        [string]$InstanceId
    )
    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) {
        throw 'instances.json missing; copy runner/instances.example.json and set sqlHost, instanceIds, reportRoot.'
    }
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json

    $sqlHost = $null
    $instanceIds = @()
    $reportRoot = $null
    $allowLiveDba = $null
    $dbaInstances = @()
    $archive = $null

    if ($raw.sqlHost) { $sqlHost = [string]$raw.sqlHost }
    if ($raw.instanceIds) { $instanceIds = @($raw.instanceIds | ForEach-Object { [string]$_ }) }
    if ($raw.reportRoot) { $reportRoot = [string]$raw.reportRoot }
    if ($null -ne $raw.allowLiveDba) { $allowLiveDba = [bool]$raw.allowLiveDba }
    if ($raw.dbaInstances) { $dbaInstances = @($raw.dbaInstances) }
    if ($raw.archive) { $archive = $raw.archive }

    if (-not $sqlHost -or $instanceIds.Count -eq 0) {
        if (-not $raw.instances) { throw 'instances.json must include sqlHost+instanceIds or instances[] rows.' }
        $row = $null
        if ($InstanceId) {
            $row = @($raw.instances | Where-Object { $_.id -eq $InstanceId } | Select-Object -First 1)
            if (-not $row) { throw "Unknown instance id: $InstanceId" }
        } else {
            $row = $raw.instances | Select-Object -First 1
        }
        if (-not $sqlHost) {
            if ($row.sqlHost) { $sqlHost = [string]$row.sqlHost }
            elseif ($row.sqlInstance -match '^([^\\]+)') { $sqlHost = $Matches[1] }
            else { throw 'Set sqlHost on the allowlist row.' }
        }
        if ($instanceIds.Count -eq 0) {
            $instanceIds = if ($row.sqlInstance -match '\\([^\\]+)$') { @($Matches[1]) } else { @('DEV') }
        }
        if (-not $reportRoot) {
            $reportRoot = if ($row.agentWork) { Join-Path ([string]$row.agentWork) 'dba-reports' } else { Join-Path $env:USERPROFILE 'priority-dba-reports' }
        }
        if ($null -eq $allowLiveDba -and $null -ne $row.allowLive) { $allowLiveDba = [bool]$row.allowLive }
    }

    if (-not $reportRoot) {
        $reportRoot = Join-Path $env:USERPROFILE 'priority-dba-reports'
    }
    if ($null -eq $allowLiveDba) {
        $allowLiveDba = -not ($sqlHost -match '(?i)example\.com$')
    }

    $postMoveRows = Get-DbaPostMoveInstanceRows -DbaInstances $dbaInstances -InstanceIds $instanceIds

    return [pscustomobject]@{
        sqlHost         = $sqlHost
        instanceIds     = $instanceIds
        reportRoot      = $reportRoot
        allowLiveDba    = $allowLiveDba
        dbaInstances    = $postMoveRows
        archive         = $archive
    }
}

function Get-DbaPostMoveInstanceRows {
    param(
        [array]$DbaInstances,
        [string[]]$InstanceIds
    )
    if (-not $DbaInstances -or $DbaInstances.Count -eq 0) { return @() }
    $wanted = @($InstanceIds | ForEach-Object { [string]$_ })
    $rows = @()
    foreach ($di in $DbaInstances) {
        $key = if ($di.sqlInstanceName) { [string]$di.sqlInstanceName } else { [string]$di.id }
        if ($wanted.Count -gt 0 -and $key -notin $wanted -and [string]$di.id -notin $wanted) { continue }
        $rows += $di
    }
    return $rows
}

function Test-DbaLiveSkipped {
    param($Config)
    if (-not $Config) { return $true }
    if ($Config.allowLiveDba -eq $false) { return $true }
    if ($Config.sqlHost -match '(?i)example\.com$') { return $true }
    return $false
}

function Write-DbaSkipJson {
    param([string]$Reason, [string]$Message)
    Write-Output (@{ ok = $false; reason = $Reason; message = $Message; skip = $true } | ConvertTo-Json -Compress)
    exit 2
}
