#requires -Version 5.1
# Hostile pin for MRB agentic_fomprep#197: Priority Agent launcher contracts.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$cs = Join-Path $repo 'launcher\Program.cs'
$rules = Join-Path $repo 'launcher\agent-rules.md'
$readme = Join-Path $repo 'launcher\README.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
Gate 'cs-exists' (Test-Path -LiteralPath $cs) $cs
Gate 'rules-exists' (Test-Path -LiteralPath $rules) $rules
$src = if (Test-Path -LiteralPath $cs) { [IO.File]::ReadAllText($cs) } else { '' }
$rl = if (Test-Path -LiteralPath $rules) { [IO.File]::ReadAllText($rules) } else { '' }
$rd = if (Test-Path -LiteralPath $readme) { [IO.File]::ReadAllText($readme) } else { '' }
Gate 'topic-priority-customer' ($src -match 'priority-customer') 'customers from GitHub topic'
$constBlock = if ($src -match '(?s)const string Owner.*?static bool DryRun') { $Matches[0] } else { $src.Substring(0, [Math]::Min(1200, $src.Length)) }
Gate 'consts-no-customer' ($constBlock -notmatch 'rees|trutex|euroflo') 'consts use topic not customer names'
Gate 'ff-only' ($src -match 'merge", "--ff-only"') 'fomprep fast-forward ff-only'
Gate 'no-reset' ($src -notmatch 'reset --hard' -and $src -notmatch 'checkout --force') 'never reset dirty clone'
Gate 'ask-haitch' ($src -match 'Ask Haitch:') 'new customer/project is Haitch handoff'
Gate 'never-create' ($src -match 'does not create customer repos') 'launcher creates nothing'
Gate 'passwords-dir' ($src -match 'C:\\passwords' -or $src -match 'PRIORITY_AGENT_PASSWORDS') 'secrets outside repo'
Gate 'never-read-secrets' ($src -match 'contents not read' -or $src -match 'never reads') 'launcher does not read password file'
Gate 'hours-session-tag' ($src -match 'session:' -and $src -match 'HoursCheck') 'mandatory hours session tag'
Gate 'hours-dev-test' ($src -match 'dev' -and $src -match 'test' -and $rl -match 'MANDATORY') 'dev+test hours lines'
Gate 'harvest-general' ($rl -match 'SimonBarnett/agentic_fomprep') 'general harvest to fomprep PR'
Gate 'harvest-customer' ($rl -match 'customer repo') 'customer harvest to customer repo'
Gate 'no-touch-priority' ($rl -match 'without asking first' -and $rl -match "Don't message the customer's people") 'rules v2 connect no-ask; still ask before messaging people'
Gate 'vision-agent-entry' ((Test-Path (Join-Path $repo 'VISION.md'))) 'VISION.md present for quote'
Gate 'readme-topic' ($rd -match 'priority-customer') 'README documents topic list'
if ($failed -gt 0) { Write-Host "Test-Mrb197-PriorityAgentLauncher FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb197-PriorityAgentLauncher PASS'
exit 0