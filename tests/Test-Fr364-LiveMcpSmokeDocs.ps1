#requires -Version 5.1
# Pin: FR #364 - live resolve_skills / get_dag_node smoke is documented and scripted.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$doc = Join-Path $repo 'docs\amplify-hosting.md'
Gate 'doc-exists' (Test-Path -LiteralPath $doc) $doc
$raw = if (Test-Path -LiteralPath $doc) { [IO.File]::ReadAllText($doc) } else { '' }
$raw = $raw -replace "`r`n", "`n" -replace "`r", "`n"
Gate 'live-section' ($raw -match '(?m)^## Live evidence \(FR #364\)') 'Live evidence (FR #364) heading'
Gate 'smoke-live-cmd' ($raw -match 'smoke:live' -and $raw -match 'smoke-mcp-live\.mjs') 'docs cite npm run smoke:live / smoke-mcp-live.mjs'
Gate 'resolve-task' ($raw -match 'resolve_skills' -and $raw -match 'form prep UAT') 'docs record resolve_skills sample task'
Gate 'dag-node' ($raw -match 'get_dag_node' -and $raw -match 'priority-formprep') 'docs record get_dag_node known id'
$script = Join-Path $repo 'v2\apps\mcp-catalog\scripts\smoke-mcp-live.mjs'
Gate 'script-exists' (Test-Path -LiteralPath $script) $script
$sj = if (Test-Path -LiteralPath $script) { [IO.File]::ReadAllText($script) } else { '' }
Gate 'script-origin' ($sj -match 'mcp\.ntsa\.uk' -and $sj -match 'resolve_skills' -and $sj -match 'get_dag_node') 'live script hits public origin + both tools'
$pkg = Join-Path $repo 'v2\apps\mcp-catalog\package.json'
$pj = if (Test-Path -LiteralPath $pkg) { [IO.File]::ReadAllText($pkg) } else { '' }
Gate 'pkg-smoke-live' ($pj -match '"smoke:live"') 'package.json smoke:live script'
if ($failed -gt 0) { Write-Host "Test-Fr364-LiveMcpSmokeDocs FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr364-LiveMcpSmokeDocs PASS'
exit 0
