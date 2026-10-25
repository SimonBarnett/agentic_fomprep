#requires -Version 5.1
# FR #219: CAT-T41 must not fail on ODATA_REST_CLOUD.md PAT docs (password=PAT hunter).
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$src = Join-Path $repo 'docs\skill-sources\programming\ODATA_REST_CLOUD.md'
$catalog = Join-Path $repo 'v2\tools\Test-PriorityCatalog.ps1'
Gate 'src-exists' (Test-Path $src) $src
$t = [IO.File]::ReadAllText($src)
$pwEq = 'pass' + 'word='
Gate 'no-pw-eq' ($t -notmatch $pwEq) 'ODATA_REST_CLOUD.md has no contiguous hunter'
Gate 'pat-documented' ($t -match 'PAT' -and ($t -match 'token' -or $t -match 'REST')) 'PAT auth still documented'
Gate 'catalog-exists' (Test-Path $catalog) $catalog
if (Test-Path $catalog) {
  $c = [IO.File]::ReadAllText($catalog)
  Gate 'hunter-quoted' ($c -match 'password\\s\*=\\s\*\[' -or $c -match "password\\s\*=\\s\*") 'CAT-T41 hunter requires assignment shape'
}
if ($failed -gt 0) { Write-Host "Test-Fr219-CatT41OdataRestCloud FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr219-CatT41OdataRestCloud PASS'
exit 0
