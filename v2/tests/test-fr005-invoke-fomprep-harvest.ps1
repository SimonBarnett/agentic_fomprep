# FR-005 / issue #113: tools/Invoke-FomprepHarvest.ps1 acceptance.
# Run: powershell -NoProfile -File .\v2\tests\test-fr005-invoke-fomprep-harvest.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$script = Join-Path $repo 'tools\Invoke-FomprepHarvest.ps1'
if (-not (Test-Path -LiteralPath $script)) { throw "missing $script" }

$fail = @()
$src = Get-Content -LiteralPath $script -Raw -Encoding UTF8

if ($src -notmatch "SimonBarnett/agentic_fomprep") {
    $fail += 'script source missing default repo SimonBarnett/agentic_fomprep'
}
if ($src -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
    $fail += 'script source missing intake URL'
}
if ($src -notmatch '\[switch\]\$Flush') {
    $fail += 'script missing -Flush'
}
if ($src -notmatch 'Report-FomprepIntakeIssue') {
    $fail += 'script missing documented relationship to Report-FomprepIntakeIssue'
}
if ($src -match '(?i)password\s*=\s*hunter2' -or $src -match 'Bearer eyJ') {
    $fail += 'script contains realistic secret literal'
}

$li = 0
Get-Content -LiteralPath $script -Encoding UTF8 | ForEach-Object {
    $li++
    foreach ($ch in $_.ToCharArray()) {
        if ([int]$ch -gt 127) {
            $fail += ('script non-ASCII L{0}:U+{1:X4}' -f $li, [int]$ch)
            break
        }
    }
}

# DryRun default repo / kind=harvest.
$dryOut = & $script -Summary 'fr005 dryrun' -Lesson 'default product repo' -DryRun -NoDelegate 2>&1 | Out-String
if ($dryOut -notmatch '"repo"\s*:\s*"SimonBarnett/agentic_fomprep"') {
    $fail += 'DryRun JSON missing repo SimonBarnett/agentic_fomprep'
}
if ($dryOut -notmatch '"kind"\s*:\s*"harvest"') {
    $fail += 'DryRun JSON missing kind harvest'
}

# Empty harvest (no Summary, not Flush) exits non-zero / throws.
$threw = $false
try {
    & $script -NoDelegate 2>&1 | Out-Null
} catch { $threw = $true }
if (-not $threw) { $fail += 'empty harvest (no Summary, no Flush) did not throw' }

# -Flush alone does not require Summary/Lesson.
$tmpOut = Join-Path $env:TEMP ('fr005-flush-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path $tmpOut | Out-Null
try {
    $r = & $script -Flush -NoDefaultOutboxes -OutboxDir $tmpOut -DryRun -NoDelegate
    if (-not $r.flush) { $fail += '-Flush alone did not return flush receipt' }
}
catch {
    $fail += ('-Flush alone threw: ' + $_.Exception.Message)
}
finally {
    Remove-Item -LiteralPath $tmpOut -Recurse -Force -ErrorAction SilentlyContinue
}

# Offline queue when intake unreachable.
$tmpQ = Join-Path $env:TEMP ('fr005-q-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path $tmpQ | Out-Null
try {
    $r = & $script -Summary 'fr005 offline' -Lesson 'queue me' `
        -IntakeUrl 'http://127.0.0.1:1/nope' -TimeoutSec 2 -OutboxDir $tmpQ -NoDelegate
    if (-not $r.queued_local) { $fail += 'offline harvest did not set queued_local' }
    if (-not $r.outbox -or @($r.outbox).Count -lt 1) { $fail += 'offline harvest wrote no outbox' }
    else {
        $qj = Get-Content -LiteralPath @($r.outbox)[0] -Raw -Encoding UTF8
        if ($qj -notmatch '"repo"\s*:\s*"SimonBarnett/agentic_fomprep"') {
            $fail += 'queued harvest JSON missing default repo'
        }
        if ($qj -notmatch '"kind"\s*:\s*"harvest"') {
            $fail += 'queued harvest JSON missing kind harvest'
        }
    }
}
catch {
    $fail += ('offline harvest threw uncaught: ' + $_.Exception.Message)
}
finally {
    Remove-Item -LiteralPath $tmpQ -Recurse -Force -ErrorAction SilentlyContinue
}

# Secret refuse.
$threw = $false
try {
    & $script -Summary 'x' -Lesson 'password=PLACEHOLDER_NOT_REAL_VALUE99' -DryRun -NoDelegate | Out-Null
} catch { $threw = $true }
if (-not $threw) { $fail += 'secret-looking Lesson did not throw' }

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-005 Invoke-FomprepHarvest'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-005 Invoke-FomprepHarvest'
exit 0
