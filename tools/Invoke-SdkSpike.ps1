#requires -Version 5.1
# Spike: Web SDK procStart FORMPREPDRCT. Password via env, not argv.
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force
. (Join-Path $repo 'src\Private\Get-WinrunCredential.ps1')
$cfg = Get-FormPrepConfig
$cred = Get-WinrunCredential -Target $cfg.CredentialTarget
if (-not $cred) { throw 'No CredMan CE/Priority/Si' }
$out = Join-Path $cfg.AgentWork 'sdk-spike'
if (-not (Test-Path $out)) { New-Item -ItemType Directory -Path $out | Out-Null }
$env:PRIORITY_SDK_PASSWORD = $cred.Password
try {
    $js = Join-Path $repo 'src\sdk\run-formprep.mjs'
    $name = 'ZCLA_PARTLONGDESC'
    & node $js --name $name --company $cfg.Company --proc FORMPREPDRCT --url $cfg.WebBaseUrl --user $cfg.PriorityUser --out $out --language 2
    Write-Host ("node_exit={0}" -f $LASTEXITCODE)
} finally {
    Remove-Item Env:PRIORITY_SDK_PASSWORD -ErrorAction SilentlyContinue
}
if (Test-Path (Join-Path $out 'steps.json')) {
    Write-Host '--- steps.json ---'
    Get-Content (Join-Path $out 'steps.json') -Raw
}
if (Test-Path (Join-Path $out 'login-error.json')) {
    Write-Host '--- login-error ---'
    Get-Content (Join-Path $out 'login-error.json') -Raw
}
if (Test-Path (Join-Path $out 'proc-error.json')) {
    Write-Host '--- proc-error ---'
    Get-Content (Join-Path $out 'proc-error.json') -Raw
}
