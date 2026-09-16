#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
. (Join-Path $script:RepoRoot 'src\Private\Get-FormExec.ps1')
. (Join-Path $script:RepoRoot 'src\Private\New-ParkSnapshot.ps1')

$stale = [pscustomobject]@{ Pid = 0; LockExpiry = 0; Computer = 'CE-PRIORITY-DEV' }
if (Test-LockIsLive -Row $stale) { throw 'P1-L1: PID=0 + computer set must not be live' }
$live = [pscustomobject]@{ Pid = 123; LockExpiry = 1; Computer = 'CE-PRIORITY-DEV' }
if (-not (Test-LockIsLive -Row $live)) { throw 'P1-L1: PID=123 LOCKEXPIRY=1 must be live' }

$big = [int64]3000000001
$cast = ConvertTo-Int64Id $big
if ($cast -ne $big) { throw "P0-I1: int64 $big overflowed to $cast" }
Write-Host 'unit-lock-execid PASS'
exit 0
