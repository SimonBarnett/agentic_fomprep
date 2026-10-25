#requires -Version 5.1
# Hostile pin for MRB agentic_fomprep#200: local stdio catalog + rules v2.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$cs = Join-Path $repo 'launcher\Program.cs'
$mcp = Join-Path $repo 'launcher\CatalogMcp.cs'
$rules = Join-Path $repo 'launcher\agent-rules.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$src = [IO.File]::ReadAllText($cs)
$cat = [IO.File]::ReadAllText($mcp)
$rl = [IO.File]::ReadAllText($rules)
Gate 'mcp-catalog-flag' ($src -match '--mcp-catalog') 'stdio mode flag'
Gate 'no-http-register' ($src -notmatch 'mcp add.*https://mcp-priority') 'does not register hosted URL'
Gate 'stdio-add' ($src -match 'mcp", "add", McpName, "--", exe, "--mcp-catalog"') 'grok mcp add stdio exe'
Gate 'doctor-handshake' ($src -match 'handshake OK') 'doctor must report handshake OK'
Gate 'catalog-dir' ($src -match 'v2.*mcp-catalog.*catalog') 'serves clone catalog'
Gate 'four-tools' ($cat -match 'list_catalog' -and $cat -match 'get_skill' -and $cat -match 'get_instance_schema' -and $cat -match 'get_runner_files') 'same 4 tools'
Gate 'path-dotdot' ($cat -match 'Contains\("\.\."\)') 'runner path rejects ..'
Gate 'no-compile' ($cat -match 'does not compile Priority forms' -or $cat -match 'does not prepare forms') 'catalog-only'
Gate 'rules-v2' ($rl -match 'rules-version:\s*2') 'rules-version 2'
Gate 'connect-no-ask' ($rl -match "don't need to ask first" -or $rl -match 'without asking first') 'rules v2 connect'
Gate 'no-echo-secrets' ($rl -match 'Never.*commit' -or $rl -match 'Never\*\* commit') 'still never commit/echo'
Gate 'no-message-people' ($rl -match "Don't message the customer's people" -or $rl -match 'message the customer') 'ask before messaging people'
if ($failed -gt 0) { Write-Host "Test-Mrb200-CatalogStdio FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb200-CatalogStdio PASS'
exit 0
