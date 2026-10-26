#requires -Version 5.1
# Pin for FR agentic_fomprep#225: document dual clone path + reject empty D:\ai stub.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$cs = Join-Path $repo 'launcher\Program.cs'
$readme = Join-Path $repo 'launcher\README.md'
$agents = Join-Path $repo 'AGENTS.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
Gate 'cs-exists' (Test-Path -LiteralPath $cs) $cs
Gate 'readme-exists' (Test-Path -LiteralPath $readme) $readme
Gate 'agents-exists' (Test-Path -LiteralPath $agents) $agents
$src = if (Test-Path -LiteralPath $cs) { [IO.File]::ReadAllText($cs) } else { '' }
$rd = if (Test-Path -LiteralPath $readme) { [IO.File]::ReadAllText($readme) } else { '' }
$ag = if (Test-Path -LiteralPath $agents) { [IO.File]::ReadAllText($agents) } else { '' }
Gate 'find-requires-git' ($src -match '\.git' -and $src -match 'FindClone|EnsureClone') 'clone discovery requires .git'
Gate 'search-c-ai' ($src -match 'C:\\ai') 'searches C:\ai fallback'
Gate 'warn-stub' ($src -match 'not a git clone' -or $src -match 'empty stub' -or $src -match 'no \.git') 'warns when preferred path lacks .git'
Gate 'readme-stub' ($rd -match '(?i)empty stub' -or $rd -match '(?i)not a git (repo|clone)') 'README documents empty stub'
Gate 'readme-dual' ($rd -match 'C:\\ai\\agentic_fomprep' -and ($rd -match 'PRIORITY_AGENT_ROOT' -or $rd -match '--root')) 'README dual path / override'
Gate 'readme-use-fomprep-dir' ($rd -match 'FOMPREP_DIR' -or $rd -match '\{\{FOMPREP_DIR\}\}') 'README: use resolved FOMPREP_DIR'
Gate 'agents-clone-path' ($ag -match '(?i)clone' -and ($ag -match 'D:\\ai\\agentic_fomprep' -or $ag -match 'PRIORITY_AGENT_ROOT' -or $ag -match 'FOMPREP_DIR')) 'AGENTS.md notes clone path'
if ($failed -gt 0) { Write-Host "Test-Fr225-LauncherClonePath FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr225-LauncherClonePath PASS'
exit 0
