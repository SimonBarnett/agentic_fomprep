# FR #177: hours-log-work-session Inputs match bobiverse hours webhook Agent field map.
# SoT: https://github.com/SimonBarnett/bobiverse/blob/main/jeeves/docs/webhooks.md
# Run: powershell -NoProfile -File .\v2\tests\test-fr177-hours-webhook-field-names.ps1
# Also invoked by Test-PriorityCatalog CAT-T72.
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

$paths = @(
    (Join-Path $repo '.grok\skills\hours-log-work-session\SKILL.md'),
    (Join-Path $repo 'docs\skill-sources\hours\hours-log-work-session.md')
)

foreach ($p in $paths) {
    if (-not (Test-Path -LiteralPath $p)) {
        $fail += "missing $p"
        continue
    }
    $t = Get-Content -LiteralPath $p -Raw -Encoding UTF8
    $b = [System.IO.File]::ReadAllBytes($p)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $fail += "BOM: $p"
    }
    $asciiBad = @()
    $li = 0
    Get-Content -LiteralPath $p -Encoding UTF8 | ForEach-Object {
        $li++
        foreach ($ch in $_.ToCharArray()) {
            if ([int]$ch -gt 127) {
                $asciiBad += ('L{0}:U+{1:X4}' -f $li, [int]$ch)
                break
            }
        }
    }
    if ($asciiBad.Count -gt 0) {
        $fail += ("non-ASCII $p -> " + ($asciiBad -join ','))
    }

    # Accepted canonical create fields (Agent field map)
    foreach ($needle in @('`start`', '`end`', '`customer`', '`project`', '`idempotency_key`', '`on_behalf_of`', '`agent`', '`repo_url`', '`source`')) {
        if ($t -notmatch [regex]::Escape($needle)) {
            $fail += "missing accepted field $needle in $p"
        }
    }

    # Rejected aliases must be called out explicitly
    foreach ($alias in @('started_at', 'customer_slug', 'project_slug')) {
        if ($t -notmatch [regex]::Escape($alias)) {
            $fail += "missing rejected-alias callout $alias in $p"
        }
    }

    # SoT link to bobiverse webhooks.md
    if ($t -notmatch 'jeeves/docs/webhooks\.md' -and $t -notmatch 'SimonBarnett/bobiverse.*webhooks\.md') {
        $fail += "missing webhooks.md SoT link in $p"
    }

    # Must not present slug labels as the webhook field names in the Inputs table
    if ($t -match '(?m)^\|\s*customer slug\s*\|' -or $t -match '(?m)^\|\s*project slug\s*\|') {
        $fail += "Inputs still uses customer slug / project slug labels in $p"
    }
    if ($t -match '(?m)^\|\s*`started_at`\s*\|' -or $t -match '(?m)^\|\s*started_at\s*\|') {
        $fail += "Inputs still lists started_at as an accepted field in $p"
    }
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-177 hours webhook field names'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-177 hours webhook field names'
exit 0
