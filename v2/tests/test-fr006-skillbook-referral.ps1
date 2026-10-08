# FR-006 / issue #114: docs/skillbook-referral.md for non-CWD agents (tests-first).
# Run: powershell -NoProfile -File .\v2\tests\test-fr006-skillbook-referral.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$doc = Join-Path $repo 'docs\skillbook-referral.md'
$agents = Join-Path $repo 'AGENTS.md'
$fail = @()

if (-not (Test-Path -LiteralPath $doc)) {
    $fail += 'missing docs/skillbook-referral.md'
}
else {
    $text = Get-Content -LiteralPath $doc -Raw -Encoding UTF8
    if ($text -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
        $fail += 'doc missing Bobiverse intake URL'
    }
    if ($text -notmatch 'SimonBarnett/agentic_fomprep') {
        $fail += 'doc missing SimonBarnett/agentic_fomprep'
    }
    if ($text -notmatch 'Mode A') {
        $fail += 'doc missing Mode A'
    }
    if ($text -notmatch 'Mode B') {
        $fail += 'doc missing Mode B'
    }
    if ($text -notmatch '(?i)CWD' -and $text -notmatch 'repo root') {
        $fail += 'doc Mode A must describe CWD / repo root'
    }
    if ($text -notmatch 'harvest-priority-skills' -or $text -notmatch 'harvest-agent-skills') {
        $fail += 'doc Mode B must name harvest-priority-skills / harvest-agent-skills'
    }
    if ($text -notmatch 'ce-dayworks') {
        $fail += 'doc missing ce-dayworks wrong-book row'
    }
    if ($text -notmatch 'ce-priority') {
        $fail += 'doc missing ce-priority wrong-book row'
    }
    if ($text -notmatch 'SimonBarnett/bobiverse' -and $text -notmatch 'agentic_irc' -and $text -notmatch 'agentic_build') {
        $fail += 'doc missing fleet/IRC wrong-book (bobiverse / agentic_irc / agentic_build)'
    }

    $li = 0
    Get-Content -LiteralPath $doc -Encoding UTF8 | ForEach-Object {
        $li++
        foreach ($ch in $_.ToCharArray()) {
            if ([int]$ch -gt 127) {
                $fail += ('doc non-ASCII L{0}:U+{1:X4}' -f $li, [int]$ch)
                break
            }
        }
    }
    $bytes = [System.IO.File]::ReadAllBytes($doc)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $fail += 'docs/skillbook-referral.md has UTF-8 BOM'
    }
}

if (-not (Test-Path -LiteralPath $agents)) {
    $fail += 'missing AGENTS.md'
}
else {
    $at = Get-Content -LiteralPath $agents -Raw -Encoding UTF8
    if ($at -notmatch 'skillbook-referral\.md') {
        $fail += 'AGENTS.md missing pointer to docs/skillbook-referral.md in discovery/referral path'
    }
    # Prefer Skill discovery section names the doc (FR asks README or AGENTS Skill discovery).
    if ($at -notmatch '(?s)## Skill discovery.{0,800}skillbook-referral\.md') {
        # CAST IRON already points; require Skill discovery section also points for discoverability.
        $fail += 'AGENTS.md Skill discovery section missing skillbook-referral.md pointer'
    }
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-006 skillbook-referral'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-006 skillbook-referral'
exit 0
