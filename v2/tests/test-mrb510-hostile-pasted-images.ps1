# docs/mrb-510: hostile pins for service-desk pasted-images-slow-text (PR #510).
# Run: powershell -NoProfile -File .\v2\tests\test-mrb510-hostile-pasted-images.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

$paths = @(
    (Join-Path $repo '.grok\skills\priority-service-desk-pasted-images-slow-text\SKILL.md'),
    (Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-service-desk-pasted-images-slow-text\SKILL.md'),
    (Join-Path $repo 'docs\skill-sources\medatech-network\service-desk\pasted-images-slow-text.md'),
    (Join-Path $repo '.grok\skills\priority-service-desk-pasted-images-slow-text\meta.json'),
    (Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-service-desk-pasted-images-slow-text\meta.json')
)
foreach ($p in $paths) {
    if (-not (Test-Path -LiteralPath $p)) { $fail += "missing $p"; continue }
    $b = [System.IO.File]::ReadAllBytes($p)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $fail += "BOM: $p"
    }
}

$needles = @(
    'possible cause',
    'does not rule out server or network',
    'performance investigation',
    'saves and verifies any images',
    'image button',
    'SC263088'
)
foreach ($skill in @($paths[0], $paths[1], $paths[2])) {
    if (-not (Test-Path -LiteralPath $skill)) { continue }
    $t = [System.IO.File]::ReadAllText($skill)
    foreach ($n in $needles) {
        if ($t.IndexOf($n, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
            $fail += "missing needle '$n' in $skill"
        }
    }
    if ($t -match 'This is not a server performance problem and not a network problem') {
        $fail += "stale absolute exclusion still present in $skill"
    }
}

$idx = Join-Path $repo '.grok\skills\PRIORITY-AGENT-SKILLS.md'
if (Test-Path -LiteralPath $idx) {
    $ix = [System.IO.File]::ReadAllText($idx)
    if ($ix -notmatch 'priority-service-desk-pasted-images-slow-text') {
        $fail += 'PRIORITY-AGENT-SKILLS.md missing skill id'
    }
} else {
    $fail += 'missing PRIORITY-AGENT-SKILLS.md'
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL mrb-510 hostile pasted-images'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}
Write-Host 'PASS mrb-510 hostile pasted-images'
exit 0
