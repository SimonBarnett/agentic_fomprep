#requires -Version 5.1
<#
.SYNOPSIS
    First-time install on CE-PRIORITY-DEV1. Does not park. Does not embed secrets.
#>
[CmdletBinding()]
param(
    [switch]$ApplyParkTable
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force
$cfg = Get-FormPrepConfig -Path (Join-Path $repo 'config\dev.psd1') -Environment DEV

Write-Host "Computer: $env:COMPUTERNAME"
Write-Host "Allowed:  $($cfg.AllowedComputer -join ', ')"
if ($env:COMPUTERNAME -notin @($cfg.AllowedComputer)) {
    throw "This host is not AllowedComputer. Do not install on live/PRI."
}

foreach ($d in @($cfg.AgentWork, (Join-Path $cfg.AgentWork 'placeholder'))) {
    if ($d -and -not (Test-Path -LiteralPath $cfg.AgentWork)) {
        [void][System.IO.Directory]::CreateDirectory($cfg.AgentWork)
        Write-Host "Created $($cfg.AgentWork)"
        break
    }
}
if (-not (Test-Path -LiteralPath $cfg.AgentWork)) {
    [void][System.IO.Directory]::CreateDirectory($cfg.AgentWork)
}

$web = Join-Path $repo 'src\web'
if (Get-Command npm -ErrorAction SilentlyContinue) {
    Push-Location $web
    try {
        npm install
        npx playwright install chromium
    } finally {
        Pop-Location
    }
} else {
    Write-Warning 'npm not found. Install Node.js LTS, then: cd src\web; npm install; npx playwright install chromium'
}

if ($ApplyParkTable) {
    if (-not $cfg.PinComplete -or $cfg.SqlDatabase -eq '<PIN>') {
        throw 'Refusing to create AGENT_FORMPREP_PARK until PinComplete and SqlDatabase are set.'
    }
    $sql = Get-Content -LiteralPath (Join-Path $repo 'sql\001_agent_formprep_park.sql') -Raw
    $conn = New-FormPrepSqlConnection -Config $cfg
    try {
        foreach ($batch in ($sql -split '(?m)^\s*GO\s*$')) {
            if ([string]::IsNullOrWhiteSpace($batch)) { continue }
            [void](Invoke-FormPrepSql -Connection $conn -Query $batch -NonQuery)
        }
        Write-Host "Park table applied on $($cfg.SqlDatabase)"
    } finally {
        $conn.Close(); $conn.Dispose()
    }
}

Write-Host @'
Next:
  1. powershell -File tools\Invoke-Recon.ps1
  2. Edit config/dev.psd1 - pin table names, set PinComplete = $true
  3. powershell -File tools\Install-OnDev.ps1 -ApplyParkTable
  4. Log into https://prioritydev.clarksonevans.co.uk once; save Playwright storageState
     to C:\Priority\tmp\agent-formprep\si-web-state.json (ACL: agent account only)
  5. powershell -File tools\Set-WinrunCredential.ps1
  6. powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -WhatIf
  7. powershell -File tests\AT6-refuse-non-dev.ps1
     powershell -File tests\AT4-abort-restores.ps1
'@
