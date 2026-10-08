# FR-002 / issue #110: harvest-agent-skills documents Bobiverse intake (tests-first).
# Run: powershell -NoProfile -File .\v2\tests\test-fr002-harvest-agent-skills-intake.ps1
# Out of scope: harvest-priority-skills twin (FR-003), wrapper scripts (FR-004/005).
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$skill = Join-Path $repo '.grok\skills\harvest-agent-skills\SKILL.md'
if (-not (Test-Path -LiteralPath $skill)) { throw "missing $skill" }

$text = Get-Content -LiteralPath $skill -Raw -Encoding UTF8
$fail = @()

if ($text -notmatch '(?m)^github:\s*https://github\.com/SimonBarnett/agentic_fomprep\s*$') {
    $fail += 'frontmatter github: must be https://github.com/SimonBarnett/agentic_fomprep'
}
if ($text -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
    $fail += 'skill missing Bobiverse intake URL https://irc.ntsa.uk/bob/v1/intake'
}
if ($text -notmatch 'SimonBarnett/agentic_fomprep') {
    $fail += 'skill missing SimonBarnett/agentic_fomprep as intake repo'
}
if ($text -notmatch 'tools[/\\]Report-FomprepIntakeIssue\.ps1') {
    $fail += 'skill missing tools/Report-FomprepIntakeIssue.ps1'
}
if ($text -notmatch 'tools[/\\]Invoke-FomprepHarvest\.ps1') {
    $fail += 'skill missing tools/Invoke-FomprepHarvest.ps1'
}
# Prefer branch+PR; intake when blocked / for gaps.
if ($text -notmatch '(?i)pull\s+request' -and $text -notmatch '(?i)\bPR\b') {
    $fail += 'skill lost branch+PR preferred path'
}
# Wrong-book table rows for IRC / fleet / MUD must remain.
if ($text -notmatch 'SimonBarnett/agentic_irc') {
    $fail += 'wrong-book table lost agentic_irc row'
}
if ($text -notmatch 'SimonBarnett/agentic_build') {
    $fail += 'wrong-book table lost agentic_build row'
}
if ($text -notmatch 'SimonBarnett/mud-skill') {
    $fail += 'wrong-book table lost mud-skill row'
}

$nonAscii = @()
$li = 0
Get-Content -LiteralPath $skill -Encoding UTF8 | ForEach-Object {
    $li++
    foreach ($ch in $_.ToCharArray()) {
        if ([int]$ch -gt 127) {
            $nonAscii += ('L{0}:U+{1:X4}' -f $li, [int]$ch)
            break
        }
    }
}
if ($nonAscii.Count -gt 0) {
    $fail += ('SKILL.md non-ASCII: ' + ($nonAscii -join ', '))
}

$bytes = [System.IO.File]::ReadAllBytes($skill)
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    $fail += 'SKILL.md has UTF-8 BOM'
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-002 harvest-agent-skills Bobiverse intake'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-002 harvest-agent-skills Bobiverse intake'
exit 0
