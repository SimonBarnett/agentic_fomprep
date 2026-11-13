#requires -Version 5.1
# FR #600: copyps POST-FIELD + FORMCLTRIGTEXT Form Prep gate + Session 0 note.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$eng = [IO.File]::ReadAllText((Join-Path $repo '.grok\skills\priority-form-engineering\SKILL.md'))
$prepAfter = [IO.File]::ReadAllText((Join-Path $repo '.grok\skills\priority-form-prep-after-sql-change\SKILL.md'))
$formprep = [IO.File]::ReadAllText((Join-Path $repo '.grok\skills\priority-formprep\SKILL.md'))
$harvest = [IO.File]::ReadAllText((Join-Path $repo '.grok\skills\harvest-agent-skills\SKILL.md'))

Gate 'eng-copyps' ($eng -match "SQL\.ENV\s*<>\s*'copyps'" -or $eng -match 'copyps') 'form-engineering documents copyps POST-FIELD gate'
Gate 'eng-warehouses' ($eng -match 'WAREHOUSES\.LOCNAME') 'form-engineering documents WAREHOUSES.LOCNAME bins'
Gate 'after-formcltrigtext' ($prepAfter -match 'FORMCLTRIGTEXT') 'form-prep-after-sql mentions FORMCLTRIGTEXT'
Gate 'after-artifact' ($prepAfter -match 'prep artifact mtime' -or $prepAfter -match 'artifact mtime') 'form-prep-after-sql mentions prep artifact mtime'
Gate 'formprep-session0' ($formprep -match 'Session 0' -and $formprep -match 'WINACTIV') 'formprep documents Session 0 WINACTIV hang'
Gate 'harvest-pointer' ($harvest -match 'copyps' -and $harvest -match 'FORMCLTRIGTEXT' -and $harvest -match 'Session 0') 'harvest-agent-skills pointer present'
# catalog mirrors match .grok
foreach ($s in @('priority-form-engineering','priority-form-prep-after-sql-change','priority-formprep')) {
    $a = [IO.File]::ReadAllText((Join-Path $repo ".grok\skills\$s\SKILL.md"))
    $b = [IO.File]::ReadAllText((Join-Path $repo "v2\apps\mcp-catalog\catalog\$s\SKILL.md"))
    Gate "mirror-$s" ($a -eq $b) ".grok and catalog SKILL.md match for $s"
}

if ($failed -gt 0) { Write-Host "Test-Fr600-CopypsFormPrepSession0 FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr600-CopypsFormPrepSession0 PASS'
exit 0
