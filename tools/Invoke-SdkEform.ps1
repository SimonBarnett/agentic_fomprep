#requires -Version 5.1
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force
. (Join-Path $repo 'src\Private\Get-WinrunCredential.ps1')
$cfg = Get-FormPrepConfig
$cred = Get-WinrunCredential -Target $cfg.CredentialTarget
if (-not $cred) { throw 'No CredMan' }
$out = Join-Path $cfg.AgentWork 'sdk-eform'
New-Item -ItemType Directory -Path $out -Force | Out-Null
$env:PRIORITY_SDK_PASSWORD = $cred.Password
try {
    & node (Join-Path $repo 'src\sdk\run-formprep-eform.mjs') --name ZCLA_PARTLONGDESC --company $cfg.Company --url $cfg.WebBaseUrl --user $cfg.PriorityUser --out $out --language 2
    Write-Host ("node_exit={0}" -f $LASTEXITCODE)
} finally {
    Remove-Item Env:PRIORITY_SDK_PASSWORD -ErrorAction SilentlyContinue
}
Get-ChildItem $out | Select-Object Name, Length | Format-Table
if (Test-Path (Join-Path $out 'eform-meta.json')) { Get-Content (Join-Path $out 'eform-meta.json') -Raw }
if (Test-Path (Join-Path $out 'formstart-error.json')) { Get-Content (Join-Path $out 'formstart-error.json') -Raw }
if (Test-Path (Join-Path $out 'login-error.json')) { Get-Content (Join-Path $out 'login-error.json') -Raw }
