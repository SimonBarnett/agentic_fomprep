#Requires -Version 5.1
[CmdletBinding()]
param(
    [string]$InstancesPath = $env:PRIORITY_DBA_INSTANCES,
    [string]$InstanceId,
    [string]$OutDir
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'lib\Resolve-RepoRoot.ps1')

if (-not $InstancesPath) {
    $InstancesPath = Join-Path $env:USERPROFILE '.priority-dba\instances.json'
}

$auditLib = Join-Path $PSScriptRoot '..\..\priority-backup-audit\runner\lib\Read-DbaInstances.ps1'
. $auditLib

try {
    $cfg = Get-DbaInstancesConfig -Path $InstancesPath -InstanceId $InstanceId
} catch {
    Write-Output (@{ ok = $false; reason = 'config_error'; message = $_.Exception.Message } | ConvertTo-Json -Compress)
    exit 2
}

if (Test-DbaLiveSkipped -Config $cfg) {
    Write-DbaSkipJson -Reason 'live_skip' -Message 'allowLiveDba is false or sqlHost is an example host; configure instances.json for live health collect.'
}

$repo = Get-PriorityRepoRoot -StartDir $PSScriptRoot
$sqlFile = Join-Path $repo 'docs\skill-sources\dba\dba_instance_health_collect.sql'
if (-not (Test-Path -LiteralPath $sqlFile)) {
    Write-Output (@{ ok = $false; reason = 'source_sql_missing'; path = $sqlFile } | ConvertTo-Json -Compress)
    exit 2
}

$targetDir = if ($OutDir) { $OutDir } else { Join-Path $cfg.reportRoot 'health-collect' }
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

$results = @()
foreach ($inst in $cfg.instanceIds) {
    $outFile = Join-Path $targetDir ("health_{0}_{1}.txt" -f $inst, (Get-Date -Format 'yyyyMMdd_HHmm'))
    $server = '{0}\{1}' -f $cfg.sqlHost, $inst
    $args = @('-S', $server, '-E', '-C', '-i', $sqlFile, '-o', $outFile, '-b')
    & sqlcmd.exe @args 2>&1 | Out-Null
    $code = $LASTEXITCODE
    $results += [ordered]@{ instance = $inst; server = $server; outFile = $outFile; exitCode = $code }
}

Write-Output (@{ ok = ($results | Where-Object { $_.exitCode -ne 0 }).Count -eq 0; results = $results } | ConvertTo-Json -Compress -Depth 4)
if (($results | Where-Object { $_.exitCode -ne 0 }).Count -gt 0) { exit 1 }
exit 0
