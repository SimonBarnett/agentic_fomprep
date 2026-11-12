# docs/mrb-542: hostile pins for service-desk renew-license-login-errors (PR #542).
# Run: pwsh -NoProfile -File .\v2\tests\test-mrb542-hostile-renew-license-login-errors.ps1
$ErrorActionPreference = "Stop"
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

$paths = @(
    (Join-Path $repo ".grok\skills\priority-service-desk-renew-license-login-errors\SKILL.md"),
    (Join-Path $repo "v2\apps\mcp-catalog\catalog\priority-service-desk-renew-license-login-errors\SKILL.md"),
    (Join-Path $repo "docs\skill-sources\medatech-network\service-desk\renew-license-login-errors.md"),
    (Join-Path $repo ".grok\skills\priority-service-desk-renew-license-login-errors\meta.json"),
    (Join-Path $repo "v2\apps\mcp-catalog\catalog\priority-service-desk-renew-license-login-errors\meta.json")
)
foreach ($p in $paths) {
    if (-not (Test-Path -LiteralPath $p)) { $fail += "missing $p"; continue }
    $b = [System.IO.File]::ReadAllBytes($p)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $fail += "BOM: $p"
    }
}

$needles = @(
    "Renew License",
    "licence error",
    "Business Rules",
    "Autofill Rules",
    "SC262447",
    "SC262456",
    "SC262592",
    "does not include using the application",
    "Do not remove or move user licences first",
    "do not upload or share licence files"
)
foreach ($skill in @($paths[0], $paths[1], $paths[2])) {
    if (-not (Test-Path -LiteralPath $skill)) { continue }
    $t = [System.IO.File]::ReadAllText($skill)
    foreach ($n in $needles) {
        if ($t.IndexOf($n, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
            $fail += "missing needle '$n' in $skill"
        }
    }
    foreach ($bad in @("password=", "si@", "@medatechuk", "Bearer ", "api_key", "-----BEGIN")) {
        if ($t.IndexOf($bad, [StringComparison]::OrdinalIgnoreCase) -ge 0) {
            $fail += "forbidden token '$bad' in $skill"
        }
    }
}

$idx = Join-Path $repo ".grok\skills\PRIORITY-AGENT-SKILLS.md"
if (Test-Path -LiteralPath $idx) {
    $ix = [System.IO.File]::ReadAllText($idx)
    if ($ix -notmatch "priority-service-desk-renew-license-login-errors") {
        $fail += "PRIORITY-AGENT-SKILLS.md missing skill id"
    }
} else {
    $fail += "missing PRIORITY-AGENT-SKILLS.md"
}

$log = Join-Path $repo "docs\skill-harvest-log.md"
if (Test-Path -LiteralPath $log) {
    $lt = [System.IO.File]::ReadAllText($log)
    if ($lt -notmatch "priority-service-desk-renew-license-login-errors") {
        $fail += "skill-harvest-log missing skill id"
    }
} else {
    $fail += "missing skill-harvest-log.md"
}

$h1 = (Get-FileHash $paths[0]).Hash
$h2 = (Get-FileHash $paths[1]).Hash
if ($h1 -ne $h2) { $fail += ".grok and catalog SKILL.md hash mismatch" }
$m1 = (Get-FileHash $paths[3]).Hash
$m2 = (Get-FileHash $paths[4]).Hash
if ($m1 -ne $m2) { $fail += ".grok and catalog meta.json hash mismatch" }

if ($fail.Count -gt 0) {
    Write-Host "FAIL mrb-542 hostile renew-license-login-errors"
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}
Write-Host "PASS mrb-542 hostile renew-license-login-errors"
exit 0
