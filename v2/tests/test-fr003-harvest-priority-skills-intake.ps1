# FR-003 / issue #111: harvest-priority-skills documents Bobiverse intake (tests-first).
# Run: powershell -NoProfile -File .\v2\tests\test-fr003-harvest-priority-skills-intake.ps1
# Out of scope: harvest-agent-skills (FR-002), wrapper scripts (FR-004/005).
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$skill = Join-Path $repo '.grok\skills\harvest-priority-skills\SKILL.md'
if (-not (Test-Path -LiteralPath $skill)) { throw "missing $skill" }

$text = Get-Content -LiteralPath $skill -Raw -Encoding UTF8
$fail = @()

if ($text -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
    $fail += 'skill missing Bobiverse intake URL https://irc.ntsa.uk/bob/v1/intake'
}
if ($text -notmatch 'SimonBarnett/agentic_fomprep') {
    $fail += 'skill missing SimonBarnett/agentic_fomprep'
}
if ($text -notmatch 'tools[/\\]Report-FomprepIntakeIssue\.ps1') {
    $fail += 'skill missing tools/Report-FomprepIntakeIssue.ps1'
}
if ($text -notmatch 'tools[/\\]Invoke-FomprepHarvest\.ps1') {
    $fail += 'skill missing tools/Invoke-FomprepHarvest.ps1'
}
# Keep routing: CE Day Works / CE DBA forbidden here.
if ($text -notmatch 'ce-dayworks') {
    $fail += 'skill lost ce-dayworks routing row'
}
if ($text -notmatch 'ce-priority') {
    $fail += 'skill lost ce-priority routing row'
}
if ($text -notmatch '(?i)requires a Clarkson Evans Priority installation' -and $text -notmatch 'CE Day Works \*\*product\*\*') {
    # either Do-not line or table forbids CE product/DBA
    if ($text -notmatch 'Day Works' -or $text -notmatch 'DBA') {
        $fail += 'skill lost CE Day Works / CE DBA forbid guidance'
    }
}
# Keep Sync-PriorityGrokSkills after catalog harvest.
if ($text -notmatch 'Sync-PriorityGrokSkills\.ps1') {
    $fail += 'skill lost Sync-PriorityGrokSkills.ps1 step'
}
# Same-turn AUTOMATIC still present.
if ($text -notmatch '(?i)AUTOMATIC' -and $text -notmatch '(?i)same-turn') {
    $fail += 'skill lost AUTOMATIC same-turn harvest duty'
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
    Write-Host 'FAIL FR-003 harvest-priority-skills Bobiverse intake'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-003 harvest-priority-skills Bobiverse intake'
exit 0
