# FR-001 / issue #109: AGENTS.md CAST IRON Bobiverse intake (tests-first).
# Run: powershell -NoProfile -File .\v2\tests\test-fr001-agents-cast-iron-intake.ps1
# Out of scope: catalog Add-Gate (FR-007) and tools wrappers (FR-004/FR-005).
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$agents = Join-Path $repo 'AGENTS.md'
if (-not (Test-Path -LiteralPath $agents)) { throw "missing AGENTS.md at $agents" }

$text = Get-Content -LiteralPath $agents -Raw -Encoding UTF8
$fail = @()

if ($text -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
    $fail += 'AGENTS.md missing Bobiverse intake URL https://irc.ntsa.uk/bob/v1/intake'
}
if ($text -notmatch 'Report-FomprepIntakeIssue\.ps1') {
    $fail += 'AGENTS.md missing Report-FomprepIntakeIssue.ps1 example'
}
if ($text -notmatch 'Invoke-FomprepHarvest\.ps1') {
    $fail += 'AGENTS.md missing Invoke-FomprepHarvest.ps1 session-close example'
}
# Filing command must name this product repo (not rely on bobiverse default).
if ($text -notmatch 'SimonBarnett/agentic_fomprep') {
    $fail += 'AGENTS.md missing SimonBarnett/agentic_fomprep in CAST IRON filing guidance'
}
# Must not tell agents to default product filings to bobiverse.
if ($text -match '(?i)default\s+-Repo\s+SimonBarnett/bobiverse') {
    $fail += 'AGENTS.md tells agents to default -Repo SimonBarnett/bobiverse for filings'
}
# Keep Form Prep CAST IRON (do not gut).
if ($text -notmatch 'EXECPREPLOCK\.UPD') {
    $fail += 'AGENTS.md lost Form Prep CAST IRON EXECPREPLOCK.UPD gate'
}
if ($text -notmatch 'Priority Agent') {
    $fail += 'AGENTS.md lost Priority Agent ownership framing'
}

# ASCII-only (CAT-T60 / PS 5.1 consumers).
$nonAscii = @()
$li = 0
Get-Content -LiteralPath $agents -Encoding UTF8 | ForEach-Object {
    $li++
    foreach ($ch in $_.ToCharArray()) {
        if ([int]$ch -gt 127) {
            $nonAscii += ('L{0}:U+{1:X4}' -f $li, [int]$ch)
            break
        }
    }
}
if ($nonAscii.Count -gt 0) {
    $fail += ('AGENTS.md non-ASCII: ' + ($nonAscii -join ', '))
}

# UTF-8 without BOM.
$bytes = [System.IO.File]::ReadAllBytes($agents)
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    $fail += 'AGENTS.md has UTF-8 BOM'
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-001 AGENTS.md CAST IRON intake'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-001 AGENTS.md CAST IRON Bobiverse intake'
exit 0
