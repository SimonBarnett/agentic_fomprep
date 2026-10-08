# FR-008 / issue #116: VISION.md honesty-box intake success bound (tests-first).
# Run: powershell -NoProfile -File .\v2\tests\test-fr008-vision-honesty-box-intake.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$vision = Join-Path $repo 'VISION.md'
if (-not (Test-Path -LiteralPath $vision)) { throw "missing $vision" }

$fail = @()
$text = Get-Content -LiteralPath $vision -Raw -Encoding UTF8

if ($text -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
    $fail += 'VISION.md missing Bobiverse intake URL https://irc.ntsa.uk/bob/v1/intake'
}
if ($text -notmatch 'SimonBarnett/agentic_fomprep') {
    $fail += 'VISION.md missing SimonBarnett/agentic_fomprep'
}
# Dual-mode CWD / skillbook (referral).
if ($text -notmatch '(?i)skillbook' -and $text -notmatch 'skillbook-referral') {
    $fail += 'VISION.md missing dual-mode skillbook / referral cue'
}
if ($text -notmatch '(?i)\bCWD\b' -and $text -notmatch 'repo root') {
    $fail += 'VISION.md missing CWD / repo-root dual-mode cue'
}
# Do not weaken Form Prep success or DEV refuse.
if ($text -notmatch 'EXECPREPLOCK') {
    $fail += 'VISION.md lost EXECPREPLOCK Form Prep success gate'
}
if ($text -notmatch 'LASTPREPDATE') {
    $fail += 'VISION.md lost LASTPREPDATE Form Prep success gate'
}
if ($text -notmatch 'live/PRI|Live/PRI') {
    $fail += 'VISION.md lost live/PRI refuse'
}

$li = 0
Get-Content -LiteralPath $vision -Encoding UTF8 | ForEach-Object {
    $li++
    foreach ($ch in $_.ToCharArray()) {
        if ([int]$ch -gt 127) {
            $fail += ('VISION.md non-ASCII L{0}:U+{1:X4}' -f $li, [int]$ch)
            break
        }
    }
}
$bytes = [System.IO.File]::ReadAllBytes($vision)
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    $fail += 'VISION.md has UTF-8 BOM'
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-008 VISION honesty-box intake'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-008 VISION honesty-box intake'
exit 0
