#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$InstancesPath = $env:PRIORITY_DBA_INSTANCES
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib\Resolve-RepoRoot.ps1')
$auditLib = Join-Path $PSScriptRoot '..\..\priority-backup-audit\runner\lib\Read-DbaInstances.ps1'
. $auditLib

if (-not $InstancesPath) {
    $InstancesPath = Join-Path $env:USERPROFILE '.priority-dba\instances.json'
}

try {
    $cfg = Get-DbaInstancesConfig -Path $InstancesPath
} catch {
    Write-Output (@{ ok = $false; reason = 'config_error'; message = $_.Exception.Message } | ConvertTo-Json -Compress)
    exit 2
}

if (Test-DbaLiveSkipped -Config $cfg) {
    Write-DbaSkipJson -Reason 'live_skip' -Message 'allowLiveDba is false or sqlHost is an example host; set allowLiveDba true and real sqlHost for live post-move health.'
}

if (-not $cfg.dbaInstances -or $cfg.dbaInstances.Count -eq 0) {
    Write-Output (@{ ok = $false; reason = 'config_incomplete'; message = 'instances.json needs dbaInstances[] with backup roots and job names for post-move health.' } | ConvertTo-Json -Compress)
    exit 2
}

$repo = Get-PriorityRepoRoot -StartDir $PSScriptRoot
$script = Join-Path $repo 'docs\skill-sources\dba\Invoke-PostMoveHealth.ps1'
if (-not (Test-Path -LiteralPath $script)) {
    Write-Output (@{ ok = $false; reason = 'source_script_missing'; path = $script } | ConvertTo-Json -Compress)
    exit 2
}

$archiveJson = if ($cfg.archive) { ($cfg.archive | ConvertTo-Json -Depth 6 -Compress) } else { $null }
& $script -SqlHost $cfg.sqlHost -ReportRoot $cfg.reportRoot -InstanceIds $cfg.instanceIds -DbaInstancesJson ($cfg.dbaInstances | ConvertTo-Json -Depth 8 -Compress) -ArchiveJson $archiveJson
exit $LASTEXITCODE
