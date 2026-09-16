#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT3 SKIP: not on AllowedComputer. Replay a saved modal fixture on DEV if the live dialog is not reproducible.'
    exit 0
}
Write-Host 'AT3: force an index-rebuild / IGNORE_DUP_KEY dialog if reproducible; expect dialogs.action=blocked-run and no Ignore click.'
Write-Host 'AT3 SKIP-IMPL: live dialog is environment-specific. Confirm on DEV1 or waive in README with a reason.'
exit 0
