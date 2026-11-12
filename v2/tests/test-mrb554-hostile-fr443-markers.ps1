# MRB-554 hostile pin for FR-443: detector catches all three marker kinds;
# line-prefix only (embedded ======= in prose does not fail); CAT-T76 wired.
# Run: powershell -NoProfile -File .\v2\tests\test-mrb554-hostile-fr443-markers.ps1
$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$failed = 0
function Gate([string]$Name, [bool]$Ok, [string]$Detail) {
  if ($Ok) { Write-Host "PASS $Name" }
  else { Write-Host "FAIL $Name : $Detail"; $script:failed++ }
}

function Test-HasConflictMarkerLine {
  param([string]$Text)
  foreach ($line in ($Text -split '\r?\n')) {
    if ($line.StartsWith('<<<<<<<') -or $line.StartsWith('=======') -or $line.StartsWith('>>>>>>>')) {
      return $true
    }
  }
  return $false
}

Gate 'detect-eq' (Test-HasConflictMarkerLine "keep`n=======`nkeep") 'missed ======='
Gate 'detect-lt' (Test-HasConflictMarkerLine "<<<<<<< HEAD") 'missed <<<<<<<'
Gate 'detect-gt' (Test-HasConflictMarkerLine ">>>>>>> main") 'missed >>>>>>>'
Gate 'prose-ok' (-not (Test-HasConflictMarkerLine 'use ======= carefully in prose')) 'prose false positive'
Gate 'clean-ok' (-not (Test-HasConflictMarkerLine "- dated bullet`n- other bullet")) 'clean false positive'

$fixture = Join-Path $repo 'v2\tests\test-fr443-no-conflict-markers.ps1'
Gate 'fixture-exists' (Test-Path -LiteralPath $fixture) 'test-fr443 missing'
$cat = Join-Path $repo 'v2\tools\Test-PriorityCatalog.ps1'
$catText = [System.IO.File]::ReadAllText($cat)
Gate 'cat-t76' ($catText -match "Add-Gate 'CAT-T76'") 'CAT-T76 not wired'
Gate 'cat-t75' ($catText -match "Add-Gate 'CAT-T75'") 'CAT-T75 lost in fold'

if ($failed -gt 0) { Write-Host "test-mrb554-hostile-fr443-markers FAIL ($failed)"; exit 1 }
Write-Host 'test-mrb554-hostile-fr443-markers PASS'
exit 0
