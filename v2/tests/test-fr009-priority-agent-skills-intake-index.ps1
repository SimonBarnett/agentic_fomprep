# FR-009 / issue #117: PRIORITY-AGENT-SKILLS index lists intake tools (tests-first).
# Run: powershell -NoProfile -File .\v2\tests\test-fr009-priority-agent-skills-intake-index.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$manifest = Join-Path $repo '.grok\skills\PRIORITY-AGENT-SKILLS.md'
$sync = Join-Path $repo 'tools\Sync-PriorityGrokSkills.ps1'
$fail = @()

if (-not (Test-Path -LiteralPath $manifest)) {
    $fail += 'missing .grok/skills/PRIORITY-AGENT-SKILLS.md'
}
else {
    $text = Get-Content -LiteralPath $manifest -Raw -Encoding UTF8
    if ($text -notmatch 'Report-FomprepIntakeIssue\.ps1') {
        $fail += 'manifest missing tools/Report-FomprepIntakeIssue.ps1'
    }
    if ($text -notmatch 'Invoke-FomprepHarvest\.ps1') {
        $fail += 'manifest missing tools/Invoke-FomprepHarvest.ps1'
    }
    if ($text -notmatch 'skillbook-referral') {
        $fail += 'manifest missing skillbook-referral pointer'
    }
    $bytes = [System.IO.File]::ReadAllBytes($manifest)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $fail += 'PRIORITY-AGENT-SKILLS.md has UTF-8 BOM'
    }
}

if (-not (Test-Path -LiteralPath $sync)) {
    $fail += 'missing tools/Sync-PriorityGrokSkills.ps1'
}
else {
    $st = Get-Content -LiteralPath $sync -Raw -Encoding UTF8
    if ($st -notmatch 'Report-FomprepIntakeIssue\.ps1') {
        $fail += 'Sync-PriorityGrokSkills.ps1 generator missing Report-FomprepIntakeIssue.ps1'
    }
    if ($st -notmatch 'Invoke-FomprepHarvest\.ps1') {
        $fail += 'Sync-PriorityGrokSkills.ps1 generator missing Invoke-FomprepHarvest.ps1'
    }
    if ($st -notmatch 'skillbook-referral') {
        $fail += 'Sync-PriorityGrokSkills.ps1 generator missing skillbook-referral'
    }
    # Keep no-BOM writer (CAT-T60).
    if ($st -notmatch 'UTF8Encoding\s+\$false' -and $st -notmatch 'UTF8Encoding \$false') {
        $fail += 'Sync writer lost UTF8Encoding $false (BOM risk)'
    }
    if ($st -match 'Set-Content[^\n]*-Encoding\s+UTF8' -and $st -match 'PRIORITY-AGENT-SKILLS') {
        $fail += 'Sync reintroduced Set-Content -Encoding UTF8 for manifest'
    }
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-009 PRIORITY-AGENT-SKILLS intake index'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-009 PRIORITY-AGENT-SKILLS intake index'
exit 0
