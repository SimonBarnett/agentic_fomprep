#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT1 SKIP: not on AllowedComputer. Run on CE-PRIORITY-DEV1 after recon/pin.'
    exit 0
}
Import-FormPrepModule
$names = @('ZCLA_PARTLONGDESC', 'ZCLA_PARTLONGDHIST', 'ZCLA_PARTLONGDREV')
$result = Prepare-Forms -Names $names -Environment DEV -TimeoutMinutes 15 -PostHooks FormKeysRepair
Assert-ExitCode -Result $result -Expected 0 -Label 'AT1'
if (-not $result.ok) { throw 'AT1 ok=false' }
if ($result.prepared.Count -ne 3) { throw "AT1 prepared=$($result.prepared.Count)" }
if (-not $result.restoreOk) { throw 'AT1 restoreOk=false' }
if ($result.restoredCount -ne $result.parkedCount) { throw 'AT1 restore count mismatch' }
Write-Host 'AT1 PASS'
exit 0
