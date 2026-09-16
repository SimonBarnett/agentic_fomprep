#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT2 SKIP: not on AllowedComputer. Requires throwaway form ZCLA_AGENT_PREP_AT2 on DEV only.'
    exit 0
}
Import-FormPrepModule
$result = Prepare-Forms -Names 'ZCLA_AGENT_PREP_AT2' -Environment DEV -TimeoutMinutes 15
if ($result.ok) { throw 'AT2 expected ok=false' }
$hit = @($result.errors | Where-Object { $_.formHint -eq 'ZCLA_AGENT_PREP_AT2' })
if ($hit.Count -eq 0) { throw 'AT2 expected error formHint=ZCLA_AGENT_PREP_AT2' }
if (-not $result.restoreOk) { throw 'AT2 must restore the park' }
Write-Host 'AT2 PASS'
exit 0
