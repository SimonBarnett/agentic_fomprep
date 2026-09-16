#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
. (Join-Path $script:RepoRoot 'src\Private\New-ResultObject.ps1')
. (Join-Path $script:RepoRoot 'src\Private\Get-PrepErrors.ps1')

$r = New-ResultObject
$rest = Add-ParsedErrorLines -Result $r -Source 'emsg' -Text "ZCLA_PARTLONGDESC mentioned`ncompile error on ZCLA_PARTLONGDESC" -NameHints @('ZCLA_PARTLONGDESC')
$sevs = @($r.errors | ForEach-Object { $_.severity })
if ($sevs -contains 'Blocker') { throw 'E4: name mention must not be Blocker' }
if ($sevs -notcontains 'Warning') { throw 'expected Warning on name mention / compile error' }
Write-Host 'unit-error-parse PASS'
exit 0
