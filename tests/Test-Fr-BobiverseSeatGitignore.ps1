#requires -Version 5.1
# Pin: FR #349 - .bobiverse-seat must be gitignored so harvest/MRB tips cannot commit seat markers.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$gi = Join-Path $repo '.gitignore'
Gate 'gitignore-exists' (Test-Path -LiteralPath $gi) $gi
$raw = if (Test-Path -LiteralPath $gi) { [IO.File]::ReadAllText($gi) } else { '' }
Gate 'seat-root' ($raw -match '(?m)^\.bobiverse-seat$') '.bobiverse-seat line'
Gate 'seat-nested' ($raw -match '(?m)^\*\*/\.bobiverse-seat$' -or $raw -match '(?m)^\.bobiverse-seat$') 'nested or root pattern covers seat markers'
$skill = Join-Path $repo '.grok\skills\harvest-agent-skills\SKILL.md'
Gate 'skill-exists' (Test-Path -LiteralPath $skill) $skill
$sk = if (Test-Path -LiteralPath $skill) { [IO.File]::ReadAllText($skill) } else { '' }
Gate 'skill-docs-seat' ($sk -match '(?i)bobiverse-seat' -and $sk -match '(?i)untracked|gitignore|\.gitignore') 'harvest-agent-skills documents seat marker untracked'
# Live check-ignore when git available
Push-Location $repo
try {
  $probe = Join-Path $repo '.bobiverse-seat-fr349-probe'
  # Do not create real .bobiverse-seat if missing; use git check-ignore with stdin path
  $chk = & git check-ignore -v -- .bobiverse-seat 2>&1 | Out-String
  Gate 'check-ignore' ($LASTEXITCODE -eq 0 -and $chk -match 'bobiverse-seat') ("git check-ignore: " + $chk.Trim())
} finally {
  Pop-Location
}
if ($failed -gt 0) { Write-Host "Test-Fr-BobiverseSeatGitignore FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr-BobiverseSeatGitignore PASS'
exit 0
