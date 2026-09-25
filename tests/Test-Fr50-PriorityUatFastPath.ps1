#requires -Version 5.1
# MRB tests for parked FR: priority UAT fast path + video pack split (PR #50)
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $repo 'docs'))) { $repo = $PSScriptRoot }
$fr = Join-Path $repo 'docs\feature-request-priority-uat-fast-path-and-video-skill.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
Gate 'FR50-exists' (Test-Path -LiteralPath $fr) $fr
$text = if (Test-Path -LiteralPath $fr) { Get-Content -LiteralPath $fr -Raw -Encoding UTF8 } else { '' }
Gate 'FR50-fast-standard' ($text -match 'fastest method' -or $text -match 'fast path') 'standard test is fast path'
Gate 'FR50-screenshots-pass-only' ($text -match 'screenshots only if everything passed' -or $text -match 'screenshots only on full PASS') 'screenshots only on full PASS'
Gate 'FR50-no-mandatory-video' ($text -match 'no mandatory video' -or $text -match 'no video') 'no mandatory video on standard path'
Gate 'FR50-video-external' ($text -match 'uat-video-pack' -and $text -match 'bob-design-uat') 'video pack lives in bob-design-uat'
Gate 'FR50-case-on-fail' ($text -match 'CASE') 'CASE on fail retained'
Gate 'FR50-non-goal-v1' ($text -match 'Prepare-NamedForm') 'non-goal: do not edit v1 Prepare-NamedForm'
Gate 'FR50-acceptance-parked' ($text -match 'FR parked under') 'acceptance lists park'
if ($failed -gt 0) { Write-Host "Test-Fr50-PriorityUatFastPath FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr50-PriorityUatFastPath PASS'
exit 0
