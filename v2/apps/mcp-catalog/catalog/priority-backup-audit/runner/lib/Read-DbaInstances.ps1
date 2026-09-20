function Get-DbaInstancesConfig {
    param(
        [string]$Path,
        [string]$InstanceId
    )
    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) {
        throw 'instances.json missing; copy runner/instances.example.json and set sqlHost, instanceIds, reportRoot.'
    }
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($raw.sqlHost -and $raw.instanceIds) {
        return [pscustomobject]@{
            sqlHost     = [string]$raw.sqlHost
            instanceIds = @($raw.instanceIds | ForEach-Object { [string]$_ })
            reportRoot  = [string]$raw.reportRoot
        }
    }
    if (-not $raw.instances) { throw 'instances.json must include sqlHost+instanceIds or instances[] rows.' }
    $row = $null
    if ($InstanceId) {
        $row = @($raw.instances | Where-Object { $_.id -eq $InstanceId } | Select-Object -First 1)
        if (-not $row) { throw "Unknown instance id: $InstanceId" }
    } else {
        $row = $raw.instances | Select-Object -First 1
    }
    $ids = if ($row.sqlInstance -match '\\([^\\]+)$') { @($Matches[1]) } else { @('DEV') }
    $hostName = if ($row.sqlHost) { [string]$row.sqlHost } elseif ($row.sqlInstance -match '^([^\\]+)') { $Matches[1] } else { throw 'Set sqlHost on the allowlist row.' }
    $report = if ($row.agentWork) { Join-Path ([string]$row.agentWork) 'dba-reports' } else { Join-Path $env:USERPROFILE 'priority-dba-reports' }
    return [pscustomobject]@{
        sqlHost     = $hostName
        instanceIds = $ids
        reportRoot  = $report
    }
}
