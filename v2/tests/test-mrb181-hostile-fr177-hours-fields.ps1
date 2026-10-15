# docs/mrb-181: hostile pins for FR-177 hours webhook field names (product #181).
# Run: powershell -NoProfile -File .\v2\tests\test-mrb181-hostile-fr177-hours-fields.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

$logSkill = Join-Path $repo '.grok\skills\hours-log-work-session\SKILL.md'
$logSrc = Join-Path $repo 'docs\skill-sources\hours\hours-log-work-session.md'
$classify = Join-Path $repo '.grok\skills\hours-classify\SKILL.md'
$fr177 = Join-Path $repo 'v2\tests\test-fr177-hours-webhook-field-names.ps1'

foreach ($p in @($logSkill, $logSrc, $classify, $fr177)) {
    if (-not (Test-Path -LiteralPath $p)) { $fail += "missing $p"; continue }
    $b = [System.IO.File]::ReadAllBytes($p)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $fail += "BOM: $p"
    }
}

$t = Get-Content -LiteralPath $logSkill -Raw -Encoding UTF8
foreach ($n in @('`start`', '`customer`', '`project`', 'started_at', 'customer_slug', 'project_slug', 'jeeves/docs/webhooks.md', 'missing_start', 'rejected_aliases')) {
    if ($t -notmatch [regex]::Escape($n)) { $fail += "log skill missing $n" }
}
if ($t -match '(?m)^\|\s*`started_at`\s*\|') { $fail += 'log skill Inputs accepts started_at' }
if ($t -match '(?m)^\|\s*customer slug\s*\|') { $fail += 'log skill Inputs uses customer slug label' }

$c = Get-Content -LiteralPath $classify -Raw -Encoding UTF8
if ($c -notmatch 'webhook fields ``customer`` and ``project``' -and $c -notmatch 'webhook `customer` / `project`' -and $c -notmatch '`customer` and `project`') {
    if ($c -notmatch [regex]::Escape('`customer`') -or $c -notmatch [regex]::Escape('`project`')) {
        $fail += 'classify missing webhook customer/project'
    }
}
if ($c -notmatch 'customer_slug' -or $c -notmatch 'project_slug') {
    $fail += 'classify missing rejected slug callout'
}

$pin = Get-Content -LiteralPath $fr177 -Raw -Encoding UTF8
if ($pin -notmatch 'CAT-T72' -and $pin -notmatch 'FR #177') { $fail += 'fr177 pin missing FR #177 marker' }
if ($pin -notmatch 'started_at' -or $pin -notmatch 'customer_slug') { $fail += 'fr177 pin missing alias needles' }

if ($fail.Count -gt 0) {
    Write-Host 'FAIL docs/mrb-181 hostile FR-177'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}
Write-Host 'PASS docs/mrb-181 hostile FR-177'
exit 0