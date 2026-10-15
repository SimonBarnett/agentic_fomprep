# FR #182 / #183: CAT-T51 catalog meta.json + related SKILL.md UTF-8 without BOM.
# CAT-T51 gates meta.json under v2/apps/mcp-catalog/catalog/* (not SKILL.md).
# Also strip priority-help-wizards SKILL mirrors and harvest-priority-skills (CAT-T65).
# Run: powershell -NoProfile -File .\v2\tests\test-fr182-cat-t51-meta-no-bom.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

function Test-HasUtf8Bom([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return $false }
    $b = [System.IO.File]::ReadAllBytes($Path)
    return ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF)
}

$catalog = Join-Path $repo 'v2\apps\mcp-catalog\catalog'
$opsDirs = @(
    'priority-help-wizards',
    'priority-ops-customer-guides',
    'priority-ops-financials',
    'priority-ops-install-upgrade',
    'priority-ops-integrations',
    'priority-ops-packages',
    'priority-ops-procedures',
    'priority-ops-reports',
    'priority-ops-sop',
    'priority-ops-support-desk',
    'priority-ops-system-admin',
    'priority-ops-training'
)

$bomMeta = @()
foreach ($d in $opsDirs) {
    $meta = Join-Path $catalog (Join-Path $d 'meta.json')
    if (-not (Test-Path -LiteralPath $meta)) {
        $fail += "missing $meta"
        continue
    }
    if (Test-HasUtf8Bom $meta) { $bomMeta += $d }
}

# Full catalog scan (CAT-T51 scope)
Get-ChildItem -LiteralPath $catalog -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $meta = Join-Path $_.FullName 'meta.json'
    if ((Test-Path -LiteralPath $meta) -and (Test-HasUtf8Bom $meta)) {
        if ($bomMeta -notcontains $_.Name) { $bomMeta += $_.Name }
    }
}

if ($bomMeta.Count -gt 0) {
    $fail += ('CAT-T51 meta.json BOM: ' + ($bomMeta -join ', '))
}

$skillPaths = @(
    (Join-Path $catalog 'priority-help-wizards\SKILL.md'),
    (Join-Path $repo '.grok\skills\priority-help-wizards\SKILL.md'),
    (Join-Path $repo '.grok\skills\harvest-priority-skills\SKILL.md')
)
$bomSkill = @()
foreach ($p in $skillPaths) {
    if (-not (Test-Path -LiteralPath $p)) {
        $fail += "missing $p"
        continue
    }
    if (Test-HasUtf8Bom $p) { $bomSkill += $p.Substring($repo.Length + 1) }
}
if ($bomSkill.Count -gt 0) {
    $fail += ('SKILL.md BOM: ' + ($bomSkill -join ', '))
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-182 CAT-T51 / related no-BOM'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-182 CAT-T51 meta.json + help-wizards/harvest-priority SKILL no BOM'
exit 0
