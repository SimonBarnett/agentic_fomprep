#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
. (Join-Path $script:RepoRoot 'src\Private\Get-FormExec.ps1')

if (Test-LastPrepAdvanced -Before 0 -After 0) { throw '0 vs 0 must not be advanced' }
if (Test-LastPrepAdvanced -Before 45221 -After 45221) { throw 'same-day 45221 vs 45221 must not be advanced' }
if (-not (Test-LastPrepAdvanced -Before 0 -After 45221)) { throw '0 vs 45221 must be advanced' }
if (-not (Test-LastPrepAdvanced -Before 45221 -After 45222)) { throw '45221 vs 45222 must be advanced' }
if (Test-LastPrepAdvanced -Before 5 -After 0) { throw '5 vs 0 must not be advanced' }
if (Test-LastPrepAdvanced -Before 0 -After $null) { throw 'null After must not be advanced' }
if (-not (Test-LastPrepAdvanced -Before $null -After 9)) { throw 'null Before vs 9 must be advanced' }
try {
    $null = [datetime]45221
    # DateTime cast of a day-serial must not be how we decide success.
} catch { }
Write-Host 'unit-lastprep PASS'
exit 0
