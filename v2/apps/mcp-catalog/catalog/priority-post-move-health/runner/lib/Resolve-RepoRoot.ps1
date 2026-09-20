function Get-PriorityRepoRoot {
    param([string]$StartDir = $PSScriptRoot)
    $d = $StartDir
    while ($d) {
        $git = Join-Path $d '.git'
        if (Test-Path -LiteralPath $git) { return $d }
        $parent = Split-Path -Parent $d
        if (-not $parent -or $parent -eq $d) { break }
        $d = $parent
    }
    throw 'Priority repo root (.git) not found from runner path.'
}

function Get-DbaInstancesConfig {
    param([string]$Path)
    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) {
        throw 'instances.json missing; copy priority-backup-audit/runner/instances.example.json.'
    }
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($raw.sqlHost -and $raw.instanceIds) {
        return [pscustomobject]@{
            sqlHost    = [string]$raw.sqlHost
            reportRoot = [string]$raw.reportRoot
        }
    }
    $row = $raw.instances | Select-Object -First 1
    $hostName = if ($row.sqlHost) { [string]$row.sqlHost } elseif ($row.sqlInstance -match '^([^\\]+)') { $Matches[1] } else { throw 'Set sqlHost.' }
    $report = if ($row.agentWork) { Join-Path ([string]$row.agentWork) 'dba-reports' } else { Join-Path $env:USERPROFILE 'priority-dba-reports' }
    return [pscustomobject]@{ sqlHost = $hostName; reportRoot = $report }
}
