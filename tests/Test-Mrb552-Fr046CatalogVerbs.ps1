#requires -Version 5.1
# MRB #552 hostile pins for FR-046 / #428 catalog help verbs.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$skill = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-wcf\SKILL.md'
$grok = Join-Path $repo '.grok\skills\priority-saas-wcf\SKILL.md'
$ps1 = Join-Path $repo 'v2\tools\Test-PriorityCatalog.ps1'
$help = Join-Path $repo 'v2\apps\priority-saas-wcf\bin\priority-wcf.mjs'

$skillRaw = [IO.File]::ReadAllText($skill)
$grokRaw = [IO.File]::ReadAllText($grok)
Gate 'skill-grok-equal' ($skillRaw -eq $grokRaw) 'catalog SKILL equals grok mirror'
Gate 'whoami' ($skillRaw -match 'whoami') 'skill names whoami'
Gate 'prepare-interface' ($skillRaw -match 'prepare interface') 'skill names prepare interface'
Gate 'table' ($skillRaw -match '(?i)\btable\b') 'skill names table'
Gate 'interface' ($skillRaw -match '(?i)\binterface\b') 'skill names interface'

$stripped = $skillRaw -replace '(?i)whoami', 'identity-cmd'
$wouldPass = ($stripped -match 'whoami') -and ($stripped -match 'prepare interface') -and ($stripped -match '(?i)\btable\b') -and ($stripped -match '(?i)\binterface\b')
Gate 'whoami-removed-fails' (-not $wouldPass) 'removing whoami fails the FR-046 needles'

$ps1Raw = [IO.File]::ReadAllText($ps1)
$t75 = [regex]::Matches($ps1Raw, "Add-Gate\s+'CAT-T75'")
Gate 'cat-t75-once' ($t75.Count -eq 1) ("CAT-T75 Add-Gate count={0}" -f $t75.Count)

$ids = @()
Get-Content -LiteralPath $ps1 -Encoding UTF8 | ForEach-Object {
  if ($_ -match "Add-Gate\s+'([^']+)'") { $ids += $Matches[1] }
}
$dup = $ids | Group-Object | Where-Object { $_.Count -gt 1 }
Gate 'ids-unique' ($null -eq $dup) $(if ($dup) { 'dupes ' + (($dup | ForEach-Object Name) -join ',') } else { 'Add-Gate ids unique' })

$helpRaw = [IO.File]::ReadAllText($help)
Gate 'help-whoami' ($helpRaw -match 'whoami') 'client names whoami'
Gate 'help-table' ($helpRaw -match '\btable\b') 'client names table'
Gate 'help-interface' ($helpRaw -match '\binterface\b') 'client names interface'

$sb = [IO.File]::ReadAllBytes($skill)
Gate 'skill-no-bom' (-not ($sb.Length -ge 3 -and $sb[0] -eq 0xEF -and $sb[1] -eq 0xBB -and $sb[2] -eq 0xBF)) 'SKILL.md UTF-8 no BOM'

if ($failed -gt 0) { Write-Host "Test-Mrb552-Fr046CatalogVerbs FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb552-Fr046CatalogVerbs PASS'
exit 0
