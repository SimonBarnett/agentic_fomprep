#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
Import-FormPrepModule

$fake = Join-Path $PSScriptRoot 'fixtures\fake-dev.psd1'
$result = Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV -ConfigPath $fake
Assert-ExitCode -Result $result -Expected 2 -Label 'AT6'
if ([int]$result.parkedCount -ne 0) {
    throw "AT6 parked $($result.parkedCount) rows - must be zero"
}
$blockers = @($result.errors | Where-Object { $_.severity -eq 'Blocker' })
if ($blockers.Count -eq 0) {
    throw 'AT6 expected a Blocker error'
}
Write-Host "AT6 PASS exit=$($result.exitCode) parked=$($result.parkedCount) reason=$($result.reason)"
exit 0
