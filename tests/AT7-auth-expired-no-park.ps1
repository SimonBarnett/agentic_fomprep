#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT7 SKIP: not on AllowedComputer.'
    exit 0
}
Import-FormPrepModule
$cfg = Get-DevConfig
$state = $cfg.StorageState
$backup = "$state.bak-at7"
if (Test-Path -LiteralPath $state) {
    Copy-Item -LiteralPath $state -Destination $backup -Force
    Remove-Item -LiteralPath $state -Force
}
try {
    $result = Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV
    Assert-ExitCode -Result $result -Expected 2 -Label 'AT7'
    if ([int]$result.parkedCount -ne 0) { throw 'AT7 must not park' }
    if ($result.reason -ne 'auth_expired' -and $result.auth -ne 'expired') {
        throw "AT7 expected auth_expired, got reason=$($result.reason) auth=$($result.auth)"
    }
    Write-Host 'AT7 PASS'
} finally {
    if (Test-Path -LiteralPath $backup) {
        Copy-Item -LiteralPath $backup -Destination $state -Force
        Remove-Item -LiteralPath $backup -Force
    }
}
exit 0
