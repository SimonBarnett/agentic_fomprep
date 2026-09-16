#requires -Version 5.1
# Headed Playwright: log in as Si, save storageState. Do not copy the JSON to inetpub (it is a session cookie dump).
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$web = Join-Path $repo 'src\web'
$out = 'C:\Priority\tmp\agent-formprep\si-web-state.json'
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw 'node is required' }
$script = Join-Path $web 'save-storage-state.mjs'
& node $script $out
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "storageState saved: $out"
Write-Host 'Keep this file off IIS/inetpub. Restrict ACL to the agent account.'
