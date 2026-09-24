#Requires -Version 5.1
<#
.SYNOPSIS
  Read-only backup audit wrapper. Calls docs/skill-sources/dba/Invoke-BackupAudit.ps1 or Invoke-LiveAudit.ps1.
  Windows integrated auth only. Offline: exits 2 when source script or SQL is unreachable (audit script still writes errors to TSV).
#>
[CmdletBinding()]
param(
    [ValidateSet('inventory', 'live')]
    [string]$Mode = 'inventory',
    [string]$InstancesPath = $env:PRIORITY_DBA_INSTANCES,
    [int]$HistoryDays = 14
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib\Resolve-RepoRoot.ps1')
. (Join-Path $PSScriptRoot 'lib\Read-DbaInstances.ps1')

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
    Write-DbaSkipJson -Reason 'live_skip' -Message 'allowLiveDba is false or sqlHost is an example host; configure instances.json for live DBA.'
}

$repo = Get-PriorityRepoRoot -StartDir $PSScriptRoot
$scriptName = if ($Mode -eq 'live') { 'Invoke-LiveAudit.ps1' } else { 'Invoke-BackupAudit.ps1' }
$script = Join-Path $repo ("docs\skill-sources\dba\{0}" -f $scriptName)
if (-not (Test-Path -LiteralPath $script)) {
    Write-Output (@{ ok = $false; reason = 'source_script_missing'; path = $script } | ConvertTo-Json -Compress)
    exit 2
}

$mountPaths = @()
foreach ($di in @($cfg.dbaInstances)) {
    if ($di.dataMountPath) { $mountPaths += [string]$di.dataMountPath }
    if ($di.logBackupMountPath) { $mountPaths += [string]$di.logBackupMountPath }
}

if ($Mode -eq 'live') {
    & $script -SqlHost $cfg.sqlHost -Instances $cfg.instanceIds -OutRoot $cfg.reportRoot
} else {
    $auditArgs = @{
        SqlHost      = $cfg.sqlHost
        Instances    = $cfg.instanceIds
        OutRoot      = $cfg.reportRoot
        HistoryDays  = $HistoryDays
    }
    if ($mountPaths.Count -gt 0) { $auditArgs['MountPaths'] = $mountPaths }
    & $script @auditArgs
}
exit $LASTEXITCODE
