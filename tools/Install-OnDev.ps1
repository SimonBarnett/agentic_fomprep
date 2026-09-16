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
if ($ApplyParkTable) {
    Write-Host 'Skipping npm (ApplyParkTable only).'
} elseif (Get-Command npm -ErrorAction SilentlyContinue) {
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
    $conn = New-FormPrepSqlConnection -Config $cfg
    try {
        $exists = Invoke-FormPrepSql -Connection $conn -Query "SELECT OBJECT_ID(N'dbo.AGENT_FORMPREP_PARK')" -Scalar
        if ($exists) {
            $openN = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL" -Scalar)
            if ($openN -gt 0) {
                throw "Refusing park DDL: $openN OPEN park row(s) (restored_at IS NULL). RepairOpenParks first."
            }
            $prepType = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT ty.name AS type_name
FROM sys.columns c
JOIN sys.types ty ON ty.user_type_id = c.user_type_id AND ty.system_type_id = c.system_type_id
WHERE c.object_id = OBJECT_ID(N'dbo.AGENT_FORMPREP_PARK') AND c.name = N'prev_lastprep'
"@ -Scalar
            $idType = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT ty.name AS type_name
FROM sys.columns c
JOIN sys.types ty ON ty.user_type_id = c.user_type_id AND ty.system_type_id = c.system_type_id
WHERE c.object_id = OBJECT_ID(N'dbo.AGENT_FORMPREP_PARK') AND c.name = N'exec_id'
"@ -Scalar
            if ($prepType -ne 'bigint' -or $idType -ne 'bigint') {
                Write-Host "Park table types are '$idType'/'$prepType'; dropping empty wrong-type table on DEV."
                [void](Invoke-FormPrepSql -Connection $conn -Query "DROP TABLE dbo.AGENT_FORMPREP_PARK" -NonQuery)
            } else {
                $expCol = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT c.name
FROM sys.columns c
WHERE c.object_id = OBJECT_ID(N'dbo.AGENT_FORMPREP_PARK') AND c.name = N'prev_lockexpiry'
"@ -Scalar
                if (-not $expCol) {
                    Write-Host 'P1-R1: adding prev_lockexpiry bigint (OPEN count is 0).'
                    [void](Invoke-FormPrepSql -Connection $conn -Query "ALTER TABLE dbo.AGENT_FORMPREP_PARK ADD prev_lockexpiry BIGINT NULL" -NonQuery)
                }
            }
        }
        $sql = Get-Content -LiteralPath (Join-Path $repo 'sql\001_agent_formprep_park.sql') -Raw
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
  1. powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC,ZCLA_PARTLONGDHIST,ZCLA_PARTLONGDREV -Environment DEV -WhatIf
  2. powershell -File tests\AT4-abort-restores.ps1
  3. Log into https://prioritydev.clarksonevans.co.uk once; save Playwright storageState
     to C:\Priority\tmp\agent-formprep\si-web-state.json (ACL: agent account only)
  4. powershell -File tools\Set-WinrunCredential.ps1
  5. powershell -File tests\AT6-refuse-non-dev.ps1
'@
