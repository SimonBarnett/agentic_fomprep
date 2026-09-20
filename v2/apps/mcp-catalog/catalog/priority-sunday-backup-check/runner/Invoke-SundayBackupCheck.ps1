#Requires -Version 5.1
[CmdletBinding()]
param(
    [switch]$DryRun,
    [string]$InstancesPath = $env:PRIORITY_DBA_INSTANCES
)

$ErrorActionPreference = 'Stop'
$auditLib = Join-Path $PSScriptRoot '..\..\priority-backup-audit\runner\lib\Read-DbaInstances.ps1'
$rootLib = Join-Path $PSScriptRoot '..\..\priority-backup-audit\runner\lib\Resolve-RepoRoot.ps1'
. $rootLib
. $auditLib

$repo = Get-PriorityRepoRoot -StartDir $PSScriptRoot
$routine = Join-Path $repo 'docs\skill-sources\dba\sunday-ce-priority-backup-check.ROUTINE.md'

if ($DryRun) {
    $checklist = @{
        ok        = $true
        dryRun    = $true
        sqlHost   = $null
        instances = @()
        steps     = @(
            'Agent history: {INST}_FULL_WEEKLY, _DIFF_DAILY, _BAK_CLEANUP; PRI_TLOG_HOURLY on PRI'
            'msdb backupset + files under G: backup roots'
            'PRI: log_reuse_wait / truncation not stuck on LOG_BACKUP'
            'Notify Haitch pass/fail - do not Teams infra contacts directly for backup notices'
        )
        routineDoc = $routine
        note       = 'Load sqlHost and instanceIds from instances.json for live checks.'
    }
    Write-Output ($checklist | ConvertTo-Json -Compress -Depth 4)
    exit 0
}

if (-not $InstancesPath) {
    $InstancesPath = Join-Path $env:USERPROFILE '.priority-dba\instances.json'
}

try {
    $cfg = Get-DbaInstancesConfig -Path $InstancesPath
} catch {
    Write-Output (@{ ok = $false; reason = 'config_error'; message = $_.Exception.Message } | ConvertTo-Json -Compress)
    exit 2
}

$checklist = @{
    ok        = $true
    dryRun    = $false
    sqlHost   = $cfg.sqlHost
    instances = $cfg.instanceIds
    steps     = @(
        'Agent history: {INST}_FULL_WEEKLY, _DIFF_DAILY, _BAK_CLEANUP; PRI_TLOG_HOURLY on PRI'
        'msdb backupset + files under G: backup roots'
        'PRI: log_reuse_wait / truncation not stuck on LOG_BACKUP'
        'Notify Haitch pass/fail - do not Teams infra contacts directly for backup notices'
    )
    routineDoc = $routine
}

Write-Output (@{ ok = $false; reason = 'live_check_not_automated'; message = 'Run checklist steps manually or extend runner with SQL queries.'; checklist = $checklist } | ConvertTo-Json -Compress -Depth 5)
exit 2
