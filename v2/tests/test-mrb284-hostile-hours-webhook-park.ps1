# docs/mrb-284: hostile pins for Priority Agent hours webhook docs park (PR #284 / FR-F #283).
# Run: powershell -NoProfile -File .\v2\tests\test-mrb284-hostile-hours-webhook-park.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

function Assert-NoBom([string]$Path) {
    $b = [System.IO.File]::ReadAllBytes($Path)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $script:fail += "BOM: $Path"
    }
}

function Assert-Ascii([string]$Path) {
    $t = [System.IO.File]::ReadAllText($Path)
    $non = @()
    foreach ($ch in $t.ToCharArray()) {
        if ([int][char]$ch -gt 127) { $non += [int][char]$ch }
    }
    if ($non.Count -gt 0) { $script:fail += "non-ascii $($non.Count) in $Path" }
}

$vision = Join-Path $repo 'docs\feature-request-priority-agent-hours-webhook-2026-11-07.md'
$frFiles = @(
    'FR-A-launcher-hourscheck-webhook.md',
    'FR-B-agent-rules-webhook-hours.md',
    'FR-C-readme-hours-template-legacy.md',
    'FR-D-skills-hours-host-hygiene.md',
    'FR-E-cat-hostile-pins.md',
    'FR-F-docs-park-pointer.md'
) | ForEach-Object { Join-Path $repo "docs\fr\$_" }

foreach ($p in (@($vision) + $frFiles)) {
    if (-not (Test-Path -LiteralPath $p)) { $fail += "missing $p"; continue }
    Assert-NoBom $p
    Assert-Ascii $p
    $t = Get-Content -LiteralPath $p -Raw -Encoding UTF8
    # Park mirrors must not Closes implementation issues in body lines
    foreach ($ln in ($t -split "`r?`n")) {
        if ($ln.Trim().StartsWith('Closes ')) {
            $fail += "unexpected Closes line in $($p): $ln"
        }
    }
}

if (-not (Test-Path -LiteralPath $vision)) {
    Write-Output ('FAIL: ' + ($fail -join '; '))
    exit 1
}

$v = Get-Content -LiteralPath $vision -Raw -Encoding UTF8
foreach ($n in @(
    'https://bob.ntsa.uk/bob/v1/hours',
    'bob.ntsa.uk',
    'idempotency_key',
    'HoursCheck',
    '#278',
    '#279',
    '#280',
    '#281',
    '#282',
    '#283'
)) {
    if ($v -notmatch [regex]::Escape($n)) { $fail += "vision missing $n" }
}
# Must not teach HTTP Bob paths on IRC host as the store
if ($v -match 'Default public base:.*irc\.ntsa\.uk') { $fail += 'vision default base on irc host' }
# Host rule present
if ($v -notmatch 'irc\.ntsa\.uk') { $fail += 'vision missing IRC host keep rule' }

$fra = Get-Content -LiteralPath (Join-Path $repo 'docs\fr\FR-A-launcher-hourscheck-webhook.md') -Raw -Encoding UTF8
if ($fra -notmatch 'origin/hours' -and $fra -notmatch 'git fetch origin/hours') {
    # still require explicit not-git-hours intent
    if ($fra -notmatch 'not') { $fail += 'FR-A missing not-git-hours intent' }
}
if ($fra -notmatch 'bob\.ntsa\.uk/bob/v1/hours') { $fail += 'FR-A missing hours URL' }

$frf = Get-Content -LiteralPath (Join-Path $repo 'docs\fr\FR-F-docs-park-pointer.md') -Raw -Encoding UTF8
if ($frf -notmatch 'Refs' -and $frf -notmatch 'not Closes') {
    if ($frf -notmatch 'implementation') { $fail += 'FR-F missing Refs/not-Closes process intent' }
}

if ($fail.Count -gt 0) {
    Write-Output ('FAIL mrb-284 hostile park: ' + ($fail -join '; '))
    exit 1
}
Write-Output 'PASS mrb-284 hostile park pins'
exit 0
