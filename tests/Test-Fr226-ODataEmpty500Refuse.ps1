#requires -Version 5.1
# FR #226: hard rule + helper refuse OData company probing after empty HTTP 500s.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$saasSrc = Join-Path $repo 'docs\skill-sources\programming\SAAS_OIDC_LOGIN.md'
$odataSrc = Join-Path $repo 'docs\skill-sources\programming\ODATA_REST_CLOUD.md'
$saasSkill = Join-Path $repo '.grok\skills\priority-saas-oidc-login\SKILL.md'
$odataSkill = Join-Path $repo '.grok\skills\priority-odata-dev\SKILL.md'
$saasCat = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-oidc-login\SKILL.md'
$odataCat = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-odata-dev\SKILL.md'
$odataLib = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-odata-dev\runner\lib\odata.ps1'

foreach ($p in @($saasSrc, $odataSrc, $saasSkill, $odataSkill, $saasCat, $odataCat, $odataLib)) {
  Gate ("exists:" + [IO.Path]::GetFileName($p)) (Test-Path -LiteralPath $p) $p
}

$blob = [IO.File]::ReadAllText($saasSrc) + [IO.File]::ReadAllText($odataSrc) +
  [IO.File]::ReadAllText($saasSkill) + [IO.File]::ReadAllText($odataSkill) +
  [IO.File]::ReadAllText($saasCat) + [IO.File]::ReadAllText($odataCat)

Gate 'fr226-pin' ($blob -match 'FR #226') 'FR #226 cited'
Gate 'empty-500' ($blob -match 'empty HTTP 500' -or $blob -match 'empty HTTP \*\*500\*\*') 'empty HTTP 500'
Gate 'env-max' ($blob -match 'PRIORITY_ODATA_EMPTY_500_MAX') 'env PRIORITY_ODATA_EMPTY_500_MAX'
Gate 'helper-name' ($blob -match 'Assert-ODataCompanyProbeAllowed' -or $blob -match 'Register-ODataEmpty500Probe') 'helper named in docs'
Gate 'no-bom-saas' (-not ([IO.File]::ReadAllBytes($saasSkill)[0..2] -join ',').Equals('239,187,191')) 'saas skill no BOM check skipped if short'
# BOM check properly
function Assert-NoBom([string]$Path) {
  $b = [IO.File]::ReadAllBytes($Path)
  return -not ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF)
}
Gate 'bom-saas' (Assert-NoBom $saasSkill) $saasSkill
Gate 'bom-odata' (Assert-NoBom $odataSkill) $odataSkill
Gate 'bom-lib' (Assert-NoBom $odataLib) $odataLib

# helper behaviour
. $odataLib
Reset-ODataEmpty500Probe
$env:PRIORITY_ODATA_EMPTY_500_MAX = '2'
$r1 = Register-ODataEmpty500Probe -StatusCode 500 -Body '' -CompanyGuess 'Acme'
Gate 'count1' ($r1.ok -and $r1.count -eq 1 -and -not $r1.refuse) ("count=$($r1.count) refuse=$($r1.refuse)")
$r2 = Register-ODataEmpty500Probe -StatusCode 500 -Body '{}' -CompanyGuess 'Acme2'
Gate 'refuse2' ((-not $r2.ok) -and $r2.refuse -and $r2.reason -eq 'odata_company_probe_refused') $r2.reason
$threw = $false
try {
  Reset-ODataEmpty500Probe
  Assert-ODataCompanyProbeAllowed -StatusCode 500 -Body '' -CompanyGuess 'X' | Out-Null
  Assert-ODataCompanyProbeAllowed -StatusCode 500 -Body 'null' -CompanyGuess 'Y' | Out-Null
} catch {
  $threw = $true
}
Gate 'assert-throws' $threw 'Assert-ODataCompanyProbeAllowed throws at max'
$rOk = Register-ODataEmpty500Probe -StatusCode 401 -Body '' -CompanyGuess 'Z'
Gate 'not-500' ($rOk.ok -and $rOk.reason -eq 'not_empty_500') $rOk.reason

# catalog sync
Gate 'saas-sync' ([IO.File]::ReadAllText($saasSkill) -eq [IO.File]::ReadAllText($saasCat)) 'saas .grok == catalog'
Gate 'odata-sync' ([IO.File]::ReadAllText($odataSkill) -eq [IO.File]::ReadAllText($odataCat)) 'odata .grok == catalog'

if ($failed -gt 0) { Write-Host "Test-Fr226-ODataEmpty500Refuse FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr226-ODataEmpty500Refuse PASS'
exit 0
