# FR-004 / issue #112: tools/Report-FomprepIntakeIssue.ps1 (tests-first acceptance).
# Run: powershell -NoProfile -File .\v2\tests\test-fr004-report-fomprep-intake.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$script = Join-Path $repo 'tools\Report-FomprepIntakeIssue.ps1'
if (-not (Test-Path -LiteralPath $script)) { throw "missing $script" }

$fail = @()
$src = Get-Content -LiteralPath $script -Raw -Encoding UTF8

if ($src -notmatch "SimonBarnett/agentic_fomprep") {
    $fail += 'script source missing default repo SimonBarnett/agentic_fomprep'
}
if ($src -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') {
    $fail += 'script source missing default IntakeUrl'
}
if ($src -notmatch '\[switch\]\$DryRun') {
    $fail += 'script missing -DryRun switch'
}
if ($src -match '(?i)password\s*=\s*hunter2' -or $src -match 'Bearer eyJ') {
    $fail += 'script contains realistic secret literal (forbidden)'
}

# ASCII-only source.
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

# DryRun default repo.
$dryOut = & $script -Kind issue -Title 'fr004 dryrun' -Body 'acceptance body' -DryRun -NoDelegate 2>&1 |
    Out-String
if ($dryOut -notmatch '"repo"\s*:\s*"SimonBarnett/agentic_fomprep"') {
    $fail += 'DryRun JSON missing repo SimonBarnett/agentic_fomprep'
}

# Empty title reject.
$threw = $false
try {
    & $script -Kind fr -Title '   ' -Body 'body' -DryRun -NoDelegate | Out-Null
} catch { $threw = $true }
if (-not $threw) { $fail += 'empty Title did not throw' }

# Empty body reject.
$threw = $false
try {
    & $script -Kind fr -Title 'title' -Body '  ' -DryRun -NoDelegate | Out-Null
} catch { $threw = $true }
if (-not $threw) { $fail += 'empty Body did not throw' }

# Secret refuse (synthetic marker, not a live secret).
$threw = $false
try {
    & $script -Kind issue -Title 'x' -Body 'password=PLACEHOLDER_NOT_REAL' -DryRun -NoDelegate | Out-Null
} catch { $threw = $true }
if (-not $threw) { $fail += 'secret-looking Body did not throw' }

# Offline queue: unreachable intake must write outbox, not uncaught throw.
$tmpOut = Join-Path $env:TEMP ('fr004-outbox-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Force -Path $tmpOut | Out-Null
try {
    $r = & $script -Kind harvest -Title 'fr004 offline' -Body 'queue me' `
        -IntakeUrl 'http://127.0.0.1:1/nope' -TimeoutSec 2 -OutboxDir $tmpOut -NoDelegate
    if (-not $r.queued_local) { $fail += 'offline run did not set queued_local' }
    if (-not $r.outbox -or @($r.outbox).Count -lt 1) { $fail += 'offline run wrote no outbox path' }
    else {
        $p0 = @($r.outbox)[0]
        if (-not (Test-Path -LiteralPath $p0)) { $fail += "outbox file missing: $p0" }
        else {
            $qj = Get-Content -LiteralPath $p0 -Raw -Encoding UTF8
            if ($qj -notmatch '"repo"\s*:\s*"SimonBarnett/agentic_fomprep"') {
                $fail += 'queued JSON missing default repo'
            }
        }
    }
}
catch {
    $fail += ('offline run threw uncaught: ' + $_.Exception.Message)
}
finally {
    Remove-Item -LiteralPath $tmpOut -Recurse -Force -ErrorAction SilentlyContinue
}

# Kind ValidateSet: invalid kind should fail bind.
$threw = $false
try {
    & $script -Kind 'bogus' -Title 't' -Body 'b' -DryRun -NoDelegate 2>&1 | Out-Null
} catch { $threw = $true }
if (-not $threw) { $fail += 'invalid -Kind did not throw' }

if ($fail.Count -gt 0) {
    Write-Host 'FAIL FR-004 Report-FomprepIntakeIssue'
    $fail | ForEach-Object { Write-Host ("  - " + $_) }
    exit 1
}

Write-Host 'PASS FR-004 Report-FomprepIntakeIssue'
exit 0
