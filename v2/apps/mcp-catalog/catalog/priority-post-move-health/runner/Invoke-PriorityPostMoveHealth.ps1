#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$InstancesPath = $env:PRIORITY_DBA_INSTANCES
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib\Resolve-RepoRoot.ps1')

if (-not $InstancesPath) {
    $InstancesPath = Join-Path $env:USERPROFILE '.priority-dba\instances.json'
}

try {
    $cfg = Get-DbaInstancesConfig -Path $InstancesPath
} catch {
    Write-Output (@{ ok = $false; reason = 'config_error'; message = $_.Exception.Message } | ConvertTo-Json -Compress)
    exit 2
}

$repo = Get-PriorityRepoRoot -StartDir $PSScriptRoot
$script = Join-Path $repo 'docs\skill-sources\dba\Invoke-PostMoveHealth.ps1'
if (-not (Test-Path -LiteralPath $script)) {
    Write-Output (@{ ok = $false; reason = 'source_script_missing'; path = $script } | ConvertTo-Json -Compress)
    exit 2
}

& $script -SqlHost $cfg.sqlHost -ReportRoot $cfg.reportRoot
exit $LASTEXITCODE
