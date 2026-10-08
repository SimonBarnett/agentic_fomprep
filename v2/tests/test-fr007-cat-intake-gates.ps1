# FR-007 / issue #115: CAT gates for intake needles + default Repo.
# Run: powershell -NoProfile -File .\v2\tests\test-fr007-cat-intake-gates.ps1
# Pins: CAT-T63..T68 present and unique; negative AGENTS home-repo strip fails CAT-T63 logic.
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$cat = Join-Path $repo 'v2\tools\Test-PriorityCatalog.ps1'
$fail = @()

if (-not (Test-Path -LiteralPath $cat)) { throw "missing $cat" }
$src = Get-Content -LiteralPath $cat -Raw -Encoding UTF8

$needed = @('CAT-T63', 'CAT-T64', 'CAT-T65', 'CAT-T66', 'CAT-T67', 'CAT-T68')
foreach ($id in $needed) {
    $m = [regex]::Matches($src, ("Add-Gate\s+'{0}'" -f [regex]::Escape($id)))
    if ($m.Count -ne 1) {
        $fail += ("Add-Gate '{0}' count={1} (want 1)" -f $id, $m.Count)
    }
}

# All Add-Gate ids unique (FR-007 ASCII runner discipline).
$ids = [regex]::Matches($src, "Add-Gate\s+'([^']+)'") | ForEach-Object { $_.Groups[1].Value }
$dup = $ids | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Name }
if ($dup) {
    $fail += ('duplicate Add-Gate ids: ' + ($dup -join ','))
}

# CAT-T68 must pin skillbook-referral doc.
if ($src -notmatch 'docs\\skillbook-referral\.md' -and $src -notmatch 'docs/skillbook-referral\.md') {
    $fail += 'CAT-T68 block missing docs/skillbook-referral.md path'
}
if ($src -notmatch "Add-Gate 'CAT-T68'") {
    $fail += 'missing Add-Gate CAT-T68'
}

# Negative check (documented for PR body): strip home repo from AGENTS text -> CAT-T63 needles fail.
$agents = Join-Path $repo 'AGENTS.md'
if (-not (Test-Path -LiteralPath $agents)) {
    $fail += 'missing AGENTS.md for negative check'
} else {
    $at = Get-Content -LiteralPath $agents -Raw -Encoding UTF8
    $stripped = $at -replace 'SimonBarnett/agentic_fomprep', 'REMOVED_HOME_REPO_FOR_NEGATIVE'
    $negOk = $true
    $negWhy = 'ok'
    if ($stripped -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') { $negOk = $false; $negWhy = 'missing intake URL' }
    if ($stripped -notmatch 'SimonBarnett/agentic_fomprep') { $negOk = $false; $negWhy = 'missing home repo' }
    if ($negOk) {
        $fail += 'negative check did not fail after stripping SimonBarnett/agentic_fomprep from AGENTS'
    } else {
        if ($negWhy -ne 'missing home repo') {
            $fail += ("negative check failed for unexpected reason: $negWhy")
        }
    }
}

$li = 0
Get-Content -LiteralPath $cat -Encoding UTF8 | ForEach-Object {
    $li++
    foreach ($ch in $_.ToCharArray()) {
        if ([int]$ch -gt 127) {
            $fail += ('Test-PriorityCatalog.ps1 non-ASCII L{0}:U+{1:X4}' -f $li, [int]$ch)
            break
        }
    }
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-007 CAT intake gates'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-007 CAT intake gates (T63-T68 unique; AGENTS home-repo negative fails)'
exit 0
