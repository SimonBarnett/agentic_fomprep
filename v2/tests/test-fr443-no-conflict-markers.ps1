# FR-443 / issue #443: harvest log (and skill index) must not keep orphan ======= markers.
# Run: powershell -NoProfile -File .\v2\tests\test-fr443-no-conflict-markers.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$fail = @()

function Test-HasConflictMarkerLine {
    param([string]$Text)
    foreach ($line in ($Text -split '\r?\n')) {
        if ($line.StartsWith('<<<<<<<') -or $line.StartsWith('=======') -or $line.StartsWith('>>>>>>>')) {
            return $true
        }
    }
    return $false
}

$synthetic = "keep this bullet`n=======`nkeep that bullet"
if (-not (Test-HasConflictMarkerLine $synthetic)) {
    $fail += 'detector missed synthetic ======= line'
}

$paths = @(
    (Join-Path $repo 'docs\skill-harvest-log.md'),
    (Join-Path $repo '.grok\skills\PRIORITY-AGENT-SKILLS.md')
)
foreach ($p in $paths) {
    if (-not (Test-Path -LiteralPath $p)) {
        $fail += "missing $p"
        continue
    }
    $text = [System.IO.File]::ReadAllText($p)
    if (Test-HasConflictMarkerLine $text) {
        $fail += "conflict marker in $p"
    }
}

if ($fail.Count -gt 0) {
    Write-Host ('FAIL ' + ($fail -join '; '))
    exit 1
}
Write-Host 'PASS FR-443 no orphan conflict markers in harvest log / PRIORITY-AGENT-SKILLS'
exit 0
