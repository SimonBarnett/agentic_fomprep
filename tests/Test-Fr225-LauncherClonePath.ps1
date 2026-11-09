#requires -Version 5.1
# Pin for FR agentic_fomprep#225 + AI-root resolve: find/create X:\AI on C→D→E…Z; reject empty stubs.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$cs = Join-Path $repo 'launcher\Program.cs'
$ai = Join-Path $repo 'launcher\AiRoot.cs'
$readme = Join-Path $repo 'launcher\README.md'
$agents = Join-Path $repo 'AGENTS.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
Gate 'cs-exists' (Test-Path -LiteralPath $cs) $cs
Gate 'airoot-exists' (Test-Path -LiteralPath $ai) $ai
Gate 'readme-exists' (Test-Path -LiteralPath $readme) $readme
Gate 'agents-exists' (Test-Path -LiteralPath $agents) $agents
$src = if (Test-Path -LiteralPath $cs) { [IO.File]::ReadAllText($cs) } else { '' }
$aiSrc = if (Test-Path -LiteralPath $ai) { [IO.File]::ReadAllText($ai) } else { '' }
$rd = if (Test-Path -LiteralPath $readme) { [IO.File]::ReadAllText($readme) } else { '' }
$ag = if (Test-Path -LiteralPath $agents) { [IO.File]::ReadAllText($agents) } else { '' }
Gate 'find-requires-git' ($src -match '\.git' -and $src -match 'FindClone|EnsureClone') 'clone discovery requires .git'
Gate 'resolve-ai-root' ($src -match 'AiRoot\.Resolve' -and $aiSrc -match 'FolderName\s*=\s*"AI"') 'uses AiRoot.Resolve for X:\AI'
Gate 'drive-order-cde' ($aiSrc -match "for \(char c = 'C'; c <= 'Z'" -or ($aiSrc -match "'C'" -and $aiSrc -match "'D'" -and $aiSrc -match "'E'")) 'drive order starts C then D…Z'
Gate 'create-if-missing' ($aiSrc -match 'create\(' -or $aiSrc -match 'CreateDirectory') 'creates \AI when missing'
Gate 'no-hardcoded-d-ai-default' ($src -notmatch 'PRIORITY_AGENT_ROOT\)\s*\?\?\s*@"D:\\ai"') 'default is not hardcoded D:\ai'
Gate 'warn-stub' ($src -match 'not a git clone' -or $src -match 'empty stub' -or $src -match 'no \.git') 'warns when preferred path lacks .git'
Gate 'readme-stub' ($rd -match '(?i)empty stub' -or $rd -match '(?i)not a git (repo|clone)') 'README documents empty stub'
Gate 'readme-ai-order' ($rd -match '(?i)C:.*D:.*E:') 'README documents C then D then E AI root order'
Gate 'readme-create' ($rd -match '(?i)creat') 'README documents create when missing'
Gate 'readme-use-fomprep-dir' ($rd -match 'FOMPREP_DIR' -or $rd -match '\{\{FOMPREP_DIR\}\}') 'README: use resolved FOMPREP_DIR'
Gate 'agents-clone-path' ($ag -match '(?i)clone' -and ($ag -match '(?i)\\\\AI' -or $ag -match 'PRIORITY_AGENT_ROOT' -or $ag -match 'FOMPREP_DIR' -or $ag -match 'AI root')) 'AGENTS.md notes AI root / clone path'
Gate 'readme-no-default-d-ai' ($readme -notmatch '(?i)clone root, default ``D:\\ai``') 'README --root default is not hardcoded D:\\ai'
if ($failed -gt 0) { Write-Host "Test-Fr225-LauncherClonePath FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr225-LauncherClonePath PASS'
exit 0
