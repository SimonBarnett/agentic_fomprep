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
Gate 'stdio-add' ($src -match '"mcp", "add", McpName, "--"' -and $src -match 'new\[\] \{ exe, "--mcp-catalog" \}') 'grok mcp add stdio (exe fallback)'
Gate 'node-stdio' ($src -match 'v2", "apps", "mcp-catalog", "stdio.mjs"' -and $src -match 'major >= 18') 'prefers node <clone>/v2/apps/mcp-catalog/stdio.mjs on Node 18+'
$stdio = Join-Path $repo 'v2\apps\mcp-catalog\stdio.mjs'
Gate 'stdio-mjs' ((Test-Path $stdio) -and ([IO.File]::ReadAllText($stdio) -match 'list_catalog')) 'repo stdio entry point exists'
Gate 'doctor-handshake' ($src -match 'handshake OK') 'doctor must report handshake OK'
Gate 'catalog-dir' ($src -match 'v2.*mcp-catalog.*catalog') 'serves clone catalog'
Gate 'four-tools' ($cat -match 'list_catalog' -and $cat -match 'get_skill' -and $cat -match 'get_instance_schema' -and $cat -match 'get_runner_files') 'same 4 tools'
Gate 'path-dotdot' ($cat -match 'Contains\("\.\."\)') 'runner path rejects ..'
Gate 'no-compile' ($cat -match 'does not compile Priority forms' -or $cat -match 'does not prepare forms') 'catalog-only'
Gate 'rules-v2' ([int]([regex]::Match($rl, 'rules-version:\s*(\d+)').Groups[1].Value) -ge 2) 'rules-version >= 2'
Gate 'passwords-local' ($rl -match 'on the machine you are running on' -and $rl -match 'redqueen' -and $rl -match 'ask Haitch for it') 'C:\passwords is local; missing file -> ask Haitch'
Gate 'connect-no-ask' ($rl -match "don't need to ask first" -or $rl -match 'without asking first') 'rules v2 connect'
Gate 'no-echo-secrets' ($rl -match 'Never.*commit' -or $rl -match 'Never\*\* commit') 'still never commit/echo'
Gate 'no-message-people' ($rl -match "Don't message the customer's people" -or $rl -match 'message the customer') 'ask before messaging people'
if ($failed -gt 0) { Write-Host "Test-Mrb200-CatalogStdio FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb200-CatalogStdio PASS'
exit 0
