# docs/mrb-521: hostile pins for service-desk inactive-user-login-error-500 (PR #521).
# Run: powershell -NoProfile -File .\v2\tests\test-mrb521-hostile-inactive-user-login.ps1
$ErrorActionPreference = "Stop"
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

$paths = @(
    (Join-Path $repo ".grok\skills\priority-service-desk-inactive-user-login-error-500\SKILL.md"),
    (Join-Path $repo "v2\apps\mcp-catalog\catalog\priority-service-desk-inactive-user-login-error-500\SKILL.md"),
    (Join-Path $repo "docs\skill-sources\medatech-network\service-desk\inactive-user-login-error-500.md"),
    (Join-Path $repo ".grok\skills\priority-service-desk-inactive-user-login-error-500\meta.json"),
    (Join-Path $repo "v2\apps\mcp-catalog\catalog\priority-service-desk-inactive-user-login-error-500\meta.json")
)
foreach ($p in $paths) {
    if (-not (Test-Path -LiteralPath $p)) { $fail += "missing $p"; continue }
    $b = [System.IO.File]::ReadAllBytes($p)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $fail += "BOM: $p"
    }
}

$needles = @(
    "Error 500 at login was because the user had been made inactive",
    "only this user is affected",
    "marked inactive",
    "licence is available",
    "marks the user active",
    "SC262976",
    "not a cloud outage"
)
foreach ($skill in @($paths[0], $paths[1], $paths[2])) {
    if (-not (Test-Path -LiteralPath $skill)) { continue }
    $t = [System.IO.File]::ReadAllText($skill)
    foreach ($n in $needles) {
        if ($t.IndexOf($n, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
            $fail += "missing needle '$n' in $skill"
        }
    }
    # no customer PII / secrets
    foreach ($bad in @("password=", "si@", "@medatechuk", "Bearer ", "api_key")) {
        if ($t.IndexOf($bad, [StringComparison]::OrdinalIgnoreCase) -ge 0) {
            $fail += "forbidden token '$bad' in $skill"
        }
    }
}

$idx = Join-Path $repo ".grok\skills\PRIORITY-AGENT-SKILLS.md"
if (Test-Path -LiteralPath $idx) {
    $ix = [System.IO.File]::ReadAllText($idx)
    if ($ix -notmatch "priority-service-desk-inactive-user-login-error-500") {
        $fail += "PRIORITY-AGENT-SKILLS.md missing skill id"
    }
} else {
    $fail += "missing PRIORITY-AGENT-SKILLS.md"
}

$log = Join-Path $repo "docs\skill-harvest-log.md"
if (Test-Path -LiteralPath $log) {
    $lt = [System.IO.File]::ReadAllText($log)
    if ($lt -notmatch "priority-service-desk-inactive-user-login-error-500") {
        $fail += "skill-harvest-log missing skill id"
    }
} else {
    $fail += "missing skill-harvest-log.md"
}

# dual catalog mirror
$h1 = (Get-FileHash $paths[0]).Hash
$h2 = (Get-FileHash $paths[1]).Hash
if ($h1 -ne $h2) { $fail += ".grok and catalog SKILL.md hash mismatch" }
$m1 = (Get-FileHash $paths[3]).Hash
$m2 = (Get-FileHash $paths[4]).Hash
if ($m1 -ne $m2) { $fail += ".grok and catalog meta.json hash mismatch" }

if ($fail.Count -gt 0) {
    Write-Host "FAIL mrb-521 hostile inactive-user-login"
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}
Write-Host "PASS mrb-521 hostile inactive-user-login"
exit 0