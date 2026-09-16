#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT7 SKIP: not on AllowedComputer.'
    exit 0
}
Import-FormPrepModule
$cfg = Get-DevConfig
$conn = New-FormPrepSqlConnection -Config $cfg
$parkBefore = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK" -Scalar)
$conn.Close(); $conn.Dispose()
$state = $cfg.StorageState
$backup = "$state.bak-at7"
if (Test-Path -LiteralPath $state) {
    Copy-Item -LiteralPath $state -Destination $backup -Force
    Remove-Item -LiteralPath $state -Force
}
try {
    # P1-S1: no -SkipWeb. Missing storageState must refuse before park.
    $result = Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV
    Assert-ExitCode -Result $result -Expected 2 -Label 'AT7'
    if ([int]$result.parkedCount -ne 0) { throw 'AT7 must not park' }
    if ($result.reason -ne 'auth_expired') {
        throw "AT7 expected reason=auth_expired, got reason=$($result.reason) auth=$($result.auth)"
    }
    $conn2 = New-FormPrepSqlConnection -Config $cfg
    $parkAfter = [int](Invoke-FormPrepSql -Connection $conn2 -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK" -Scalar)
    $conn2.Close(); $conn2.Dispose()
    if ($parkAfter -ne $parkBefore) {
        throw "AT7 inserted park rows ($parkBefore -> $parkAfter)"
    }
    Write-Host 'AT7 PASS parkedCount=0 parkTable unchanged'
} finally {
    if (Test-Path -LiteralPath $backup) {
        Copy-Item -LiteralPath $backup -Destination $state -Force
        Remove-Item -LiteralPath $backup -Force
    }
}
exit 0
