#requires -Version 5.1
# FR-047 / #429: VISION.md records last-user + USERLOGIN and keeps LASTPREPDATE; UTF-8 no BOM.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$visionPath = Join-Path $repo 'VISION.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$raw = [IO.File]::ReadAllBytes($visionPath)
Gate 'vision-no-bom' (-not ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF)) 'UTF-8 without BOM'
$v = [Text.Encoding]::UTF8.GetString($raw)
Gate 'vision-last-user' ($v -match 'last-user') 'VISION names last-user file'
Gate 'vision-userlogin' ($v -match 'USERLOGIN') 'VISION names USERLOGIN'
Gate 'vision-lastprepdate' ($v -match 'LASTPREPDATE') 'VISION keeps LASTPREPDATE prep gate'
Gate 'vision-execpreplock' ($v -match 'EXECPREPLOCK') 'VISION keeps EXECPREPLOCK'
Gate 'vision-allowlive' ($v -match 'allowLive') 'VISION keeps allowLive write gate'
Gate 'vision-no-tokens-in-last-user' ($v -match 'must not contain tokens' -or $v -match 'does not store tokens' -or $v -match 'no token') 'last-user file must not contain tokens'
Gate 'vision-os-user-ineligible' ($v -match 'OS user remains ineligible' -or $v -match 'OS user is never') 'OS user ineligible as default'

$li = 0
Get-Content -LiteralPath $visionPath -Encoding UTF8 | ForEach-Object {
  $li++
  foreach ($ch in $_.ToCharArray()) {
    if ([int]$ch -gt 127) {
      Gate 'vision-ascii' $false ("non-ASCII L{0}:U+{1:X4}" -f $li, [int]$ch)
      break
    }
  }
}
if ($failed -eq 0) { Gate 'vision-ascii' $true 'VISION.md is ASCII' }

if ($failed -gt 0) { Write-Host "Test-Fr429-VisionLastUser FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr429-VisionLastUser PASS'
exit 0
