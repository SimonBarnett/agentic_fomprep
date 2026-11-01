#requires -Version 5.1
# docs/mrb-253: hostile source pin — Fr201 rules-v2 uses >= 2 like Mrb200 (FR #251).
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$fr201 = Join-Path $repo 'tests\Test-Fr201-VisionRulesV2.ps1'
$mrb200 = Join-Path $repo 'tests\Test-Mrb200-CatalogStdio.ps1'
$a = if (Test-Path -LiteralPath $fr201) { [IO.File]::ReadAllText($fr201) } else { '' }
$b = if (Test-Path -LiteralPath $mrb200) { [IO.File]::ReadAllText($mrb200) } else { '' }
Gate 'fr201-exists' ($a.Length -gt 0) $fr201
Gate 'mrb200-exists' ($b.Length -gt 0) $mrb200
# Require parsed int compare (same shape as Mrb200), not an exact document stamp.
Gate 'fr201-ge2' ($a -match '\$rulesVer\s*-ge\s*2' -or $a -match '-ge\s*2\)') 'Fr201 Gate uses -ge 2'
Gate 'fr201-parse' ($a -match 'rules-version:\\s\*\(\\d\+\)') 'Fr201 parses rules-version digits'
# Reject exact-only Gate: match 'rules-version:' + whitespace class + literal 2 as the Gate predicate.
$exactOnly = [regex]::new("Gate\s+'rules-v2'\s+\(\s*\$rl\s+-match\s+'rules-version:\\\\s\*2'\s*\)")
Gate 'fr201-no-exact2' (-not $exactOnly.IsMatch($a)) 'Fr201 no longer exact-matches document version 2'
Gate 'mrb200-ge2' ($b -match '-ge\s*2') 'Mrb200 still -ge 2'
if ($failed -gt 0) { Write-Host "Test-Mrb253-Fr201RulesVersionGe2 FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb253-Fr201RulesVersionGe2 PASS'
exit 0
