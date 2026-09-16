#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"

if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT8 SKIP: not on AllowedComputer (run on CE-PRIORITY-DEV1). Mutex helper is covered by tests/unit-mutex.ps1'
    exit 0
}

Import-FormPrepModule
$job = Start-Job -ScriptBlock {
    param($Root)
    Import-Module (Join-Path $Root 'src\CE.FormPrep.psd1') -Force
    Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV -TimeoutMinutes 15
} -ArgumentList $script:RepoRoot

Start-Sleep -Seconds 6
$second = Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV -SkipCli -SkipWeb
try { Stop-Job $job -ErrorAction SilentlyContinue; Remove-Job $job -Force -ErrorAction SilentlyContinue } catch { }

Assert-ExitCode -Result $second -Expected 2 -Label 'AT8'
if ($second.reason -ne 'mutex_held' -and ($second.errors | Where-Object { $_.text -match 'mutex' }).Count -eq 0) {
    throw "AT8 expected mutex_held, got reason=$($second.reason)"
}
if ([int]$second.parkedCount -ne 0) { throw 'AT8 nested park is forbidden' }
Write-Host 'AT8 PASS'
exit 0
