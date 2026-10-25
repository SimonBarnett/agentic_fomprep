#requires -Version 5.1
# Hostile pin for MRB agentic_fomprep#217: priority-price-quotation-create harvest + CAT-T51.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
function HasBom([string]$Path) {
  $b = [IO.File]::ReadAllBytes($Path)
  return ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF)
}
$id = 'priority-price-quotation-create'
$src = Join-Path $repo 'docs\skill-sources\quotes\priority-price-quotation-create.md'
$catSkill = Join-Path $repo "v2\apps\mcp-catalog\catalog\$id\SKILL.md"
$catMeta = Join-Path $repo "v2\apps\mcp-catalog\catalog\$id\meta.json"
$grok = Join-Path $repo ".grok\skills\$id\SKILL.md"
$grokMeta = Join-Path $repo ".grok\skills\$id\meta.json"
$pwNeedle = 'pass' + 'word='
Gate 'src-exists' (Test-Path $src) $src
Gate 'catalog-skill' (Test-Path $catSkill) $catSkill
Gate 'catalog-meta' (Test-Path $catMeta) $catMeta
Gate 'grok-sync' (Test-Path $grok) $grok
Gate 'cat-meta-no-bom' (-not (HasBom $catMeta)) 'catalog meta.json no BOM'
Gate 'grok-meta-no-bom' (-not (HasBom $grokMeta)) 'grok meta.json no BOM'
$blob = [IO.File]::ReadAllText($src) + [IO.File]::ReadAllText($catSkill)
Gate 'no-pw-eq' ($blob -notmatch $pwNeedle) 'no hunter literal'
Gate 'env-password' ($blob -match 'PRIORITY_ODATA_PASSWORD') 'password from env only'
Gate 'never-price' ($blob -match 'Never send' -and $blob -match 'PRICE') 'never send PRICE'
Gate 'reverse-post' ($blob -match 'reverse' -and $blob -match 'LINE 1') 'POST reverse; LINE 1 insert'
Gate 'draft-first' ($blob -match 'approv') 'live writes after draft approval'
Gate 'cprof' ($blob -match 'CPROF') 'CPROF entity'
$meta = Get-Content -LiteralPath $catMeta -Raw
Gate 'meta-name' ($meta -match $id) 'meta name matches folder'
if ($failed -gt 0) { Write-Host "Test-Mrb217-PriceQuotationCreate FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb217-PriceQuotationCreate PASS'
exit 0
