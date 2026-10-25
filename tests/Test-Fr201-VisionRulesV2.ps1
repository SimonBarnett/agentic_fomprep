#requires -Version 5.1
# FR #201: VISION.md must match Priority Agent rules v2 (PR #200 Simon decision).
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$visionPath = Join-Path $repo 'VISION.md'
$rulesPath = Join-Path $repo 'launcher\agent-rules.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$raw = [IO.File]::ReadAllBytes($visionPath)
Gate 'vision-no-bom' (-not ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF)) 'UTF-8 without BOM'
$v = [Text.Encoding]::UTF8.GetString($raw)
$rl = [IO.File]::ReadAllText($rulesPath)

Gate 'rules-v2' ($rl -match 'rules-version:\s*2') 'agent-rules still rules-version 2'
Gate 'rules-connect-no-ask' ($rl -match 'without asking first') 'rules keep connect without ask'
Gate 'vision-connect-no-ask' ($v -match 'without asking first' -or $v -match "don't need to ask first") 'VISION allows connect without ask'
Gate 'vision-prefer-dev' ($v -match 'Prefer DEV' -or $v -match 'prefer DEV') 'VISION prefers DEV for changes'
Gate 'vision-no-echo-secrets' ($v -match 'never commit' -or $v -match 'Never.*commit' -or $v -match 'never echo') 'VISION keeps never commit/echo secrets'
Gate 'vision-ask-before-message' ($v -match 'ask Simon before messaging') 'VISION asks before messaging people'
Gate 'vision-no-stale-allowlist-lede' ($v -notmatch 'execution still requires a user allowlist') 'drop stale allowlist lede'
Gate 'vision-no-refuse-live-pri-bound' ($v -notmatch 'refuse live/PRI') 'Bounds no longer hard-refuse live/PRI'
Gate 'vision-no-allowlist-nongoal' ($v -notmatch 'Live/PRI execution without an explicit user allowlist') 'Non-goals drop allowlist gate'
Gate 'vision-passwords-file' ($v -match 'connections\.txt' -or $v -match 'C:\passwords') 'VISION cites machine passwords/connections file'

if ($failed -gt 0) { Write-Host "Test-Fr201-VisionRulesV2 FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr201-VisionRulesV2 PASS'
exit 0
