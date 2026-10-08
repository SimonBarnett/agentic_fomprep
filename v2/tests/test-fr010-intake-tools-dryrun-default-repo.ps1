# FR-010 / issue #118: DryRun proves Report + Harvest default repo (offline only).
# Run: powershell -NoProfile -File .\v2\tests\test-fr010-intake-tools-dryrun-default-repo.ps1
# Also invoked by Test-PriorityCatalog CAT-T69.
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$report = Join-Path $repo 'tools\Report-FomprepIntakeIssue.ps1'
$harvest = Join-Path $repo 'tools\Invoke-FomprepHarvest.ps1'
$fail = @()

if (-not (Test-Path -LiteralPath $report)) { $fail += "missing $report" }
if (-not (Test-Path -LiteralPath $harvest)) { $fail += "missing $harvest" }

if ($fail.Count -eq 0) {
    # Report: omit -Repo; DryRun JSON must default to product repo. No live POST.
    $reportOut = & $report -Kind issue -Title 'fr010 dryrun report' -Body 'acceptance body' -DryRun -NoDelegate 2>&1 |
        Out-String
    if ($reportOut -notmatch '"repo"\s*:\s*"SimonBarnett/agentic_fomprep"') {
        $fail += 'Report DryRun missing default repo SimonBarnett/agentic_fomprep'
    }
    if ($reportOut -notmatch '"kind"\s*:\s*"issue"') {
        $fail += 'Report DryRun missing kind issue'
    }

    # Harvest: omit -Repo; kind=harvest.
    $harvestOut = & $harvest -Summary 'fr010 dryrun harvest' -Lesson 'default product repo' -DryRun -NoDelegate 2>&1 |
        Out-String
    if ($harvestOut -notmatch '"repo"\s*:\s*"SimonBarnett/agentic_fomprep"') {
        $fail += 'Harvest DryRun missing default repo SimonBarnett/agentic_fomprep'
    }
    if ($harvestOut -notmatch '"kind"\s*:\s*"harvest"') {
        $fail += 'Harvest DryRun missing kind harvest'
    }

    # Kind validation rejects garbage (Report ValidateSet).
    $threw = $false
    try {
        & $report -Kind 'bogus' -Title 't' -Body 'b' -DryRun -NoDelegate 2>&1 | Out-Null
    } catch { $threw = $true }
    if (-not $threw) { $fail += 'Report invalid -Kind did not throw' }

    # Breaking default: empty Title still rejected (sanity; offline).
    $threw = $false
    try {
        & $report -Kind fr -Title '   ' -Body 'body' -DryRun -NoDelegate | Out-Null
    } catch { $threw = $true }
    if (-not $threw) { $fail += 'Report empty Title did not throw' }
}

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-010 intake tools DryRun default repo'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-010 intake tools DryRun default repo'
exit 0
