#requires -Version 5.1
$ErrorActionPreference = "Stop"
$repo = Split-Path -Parent $PSScriptRoot
$fr = Join-Path $repo "docs\feature-request-priority-uat-fast-path-and-video-skill.md"
$failed = 0
function Assert-True([bool]$Cond,[string]$Msg){ if($Cond){Write-Host "PASS $Msg"} else {Write-Host "FAIL $Msg"; $script:failed++} }
Assert-True (Test-Path -LiteralPath $fr) "FR file exists"
$text = Get-Content -LiteralPath $fr -Raw -Encoding UTF8
Assert-True ($text -match "fastest") "decision: fastest path"
Assert-True ($text -match "screenshots only if everything passed" -or $text -match "screenshots only on full PASS") "screenshots only on full PASS"
Assert-True ($text -match "no mandatory video" -or $text -match "no video") "no mandatory video on standard path"
Assert-True ($text -match "uat-video-pack") "points to bob-design-uat uat-video-pack"
Assert-True ($text -match "bob-design-uat") "video skill lives in bob-design-uat"
Assert-True ($text -match "CASE") "CASE on fail retained"
Assert-True ($text -match "priority-uat-orchestrator") "orchestrator named"
Assert-True ($text -match "WCF" -or $text -match "priority-web-sdk") "prefer WCF/SDK"
Assert-True ($text -match "Do not duplicate video rules") "non-goal: no video rules in fomprep"
Assert-True ($text -match "\[x\].*FR parked" -or $text -match "\[x\] FR parked") "acceptance park checkbox checked"
Assert-True ($text -notmatch "(?i)password\s*=") "no password assignment"
Assert-True ($text -notmatch "(?i)XAI_API_KEY") "no API key"
if ($failed -gt 0) { Write-Host "RESULT FAIL $failed"; exit 1 }
Write-Host "RESULT PASS"; exit 0
