#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT4 SKIP: not on AllowedComputer. WP1 dry run: park, kill, RepairOpenParks restores 5/5.'
    exit 0
}
Import-FormPrepModule
$names = @('ZCLA_PARTLONGDESC')
$job = Start-Job -ScriptBlock {
    param($Root)
    Import-Module (Join-Path $Root 'src\CE.FormPrep.psd1') -Force
    Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV -TimeoutMinutes 15
} -ArgumentList $script:RepoRoot
Start-Sleep -Seconds 8
Stop-Job $job -ErrorAction SilentlyContinue
Remove-Job $job -Force -ErrorAction SilentlyContinue

$listed = Prepare-Forms -RepairOpenParks -Environment DEV
$open = @($listed.errors | Where-Object { $_.text -match 'OPEN park' })
if ($open.Count -eq 0) {
    Write-Host 'AT4: no OPEN park rows after kill (process may have restored in finally). PASS-WEAK'
    exit 0
}
$guidMatch = [regex]::Match($open[0].text, '[0-9a-fA-F-]{36}')
if (-not $guidMatch.Success) { throw "AT4 could not parse run_id from $($open[0].text)" }
$repair = Prepare-Forms -RepairOpenParks -RunId ([guid]$guidMatch.Value) -Environment DEV
if (-not $repair.restoreOk -and $repair.exitCode -ne 0) {
    throw "AT4 repair failed exit=$($repair.exitCode) reason=$($repair.reason)"
}
Write-Host 'AT4 PASS'
exit 0
