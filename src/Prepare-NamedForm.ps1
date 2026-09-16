#requires -Version 5.1
<#
.SYNOPSIS
    Agent entry: prepare one Priority form via Web SDK (no headed browser).
    Success = EXECPREPLOCK.UPD=N AND LASTPREPDATE advanced (bigint).
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Name,
    [string]$Environment = 'DEV',
    [switch]$ForceUnprepared,
    [string]$Proc = 'FORMPREPDRCT2',
    [int]$TimeoutSeconds = 180
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $repo 'src\CE.FormPrep.psd1'))) {
    $repo = Split-Path -Parent $PSScriptRoot
}
Import-Module (Join-Path $PSScriptRoot 'CE.FormPrep.psd1') -Force
. (Join-Path $PSScriptRoot 'Private\Get-WinrunCredential.ps1')

if ($Name -notmatch '^[A-Za-z][A-Za-z0-9_]*$') { throw "Bad form name '$Name'" }
if ($Environment -ne 'DEV') { throw 'Only -Environment DEV' }

$cfg = Get-FormPrepConfig
if ($env:COMPUTERNAME -notin @($cfg.AllowedComputer)) {
    throw "Refuse on $($env:COMPUTERNAME)"
}
if (-not $cfg.PinComplete) { throw 'PinComplete is false' }

$started = [datetime]::UtcNow
$conn = New-FormPrepSqlConnection -Config $cfg
$lockTable = ConvertTo-SqlIdent $cfg.LockTable
$execTable = ConvertTo-SqlIdent $cfg.ExecTable
$lId = ConvertTo-SqlIdent $cfg.LockCols.ExecId
$lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
$lPrep = ConvertTo-SqlIdent $cfg.LockCols.LastPrep
$eId = ConvertTo-SqlIdent $cfg.ExecIdCol
$eName = ConvertTo-SqlIdent $cfg.ExecNameCol

function Get-OneLock($c) {
    $t = Invoke-FormPrepSql -Connection $c -Query @"
SELECT E.$eName AS name, E.$eId AS exec_id, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName = @n
"@ -Parameters @{ '@n' = $Name }
    if ($t.Rows.Count -lt 1) { return $null }
    return [pscustomobject]@{
        Name     = [string]$t.Rows[0].name
        ExecId   = [int64]$t.Rows[0].exec_id
        Upd      = ([string]$t.Rows[0].upd).Trim()
        LastPrep = [int64]$t.Rows[0].last_prep
    }
}

$before = Get-OneLock $conn
if (-not $before) {
    Write-Output (ConvertTo-Json @{ ok = $false; reason = 'name_missing'; name = $Name } -Compress)
    exit 2
}
$origUpd = $before.Upd
if ($ForceUnprepared) {
    [void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = N'Y' WHERE $lId = @id" -Parameters @{ '@id' = $before.ExecId } -NonQuery)
}

$cred = Get-WinrunCredential -Target $cfg.CredentialTarget
if (-not $cred) {
    Write-Output (ConvertTo-Json @{ ok = $false; reason = 'no_cred'; name = $Name } -Compress)
    exit 2
}

$runDir = Join-Path $cfg.AgentWork ([guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$env:PRIORITY_SDK_PASSWORD = $cred.Password
$sdkJson = $null
try {
    $js = Join-Path $PSScriptRoot 'sdk\run-formprep.mjs'
    $sdkJson = & node $js --name $Name --company $cfg.Company --url $cfg.WebBaseUrl --user $cfg.PriorityUser --out $runDir --language 2 --proc $Proc
    $nodeExit = $LASTEXITCODE
} finally {
    Remove-Item Env:PRIORITY_SDK_PASSWORD -ErrorAction SilentlyContinue
}

$after = Get-OneLock $conn
$advancedTmp = $after -and ([int64]$after.LastPrep -gt [int64]$before.LastPrep)
$okTmp = $after -and ([string]$after.Upd -eq 'N') -and $advancedTmp
if ($ForceUnprepared -and -not $okTmp) {
    [void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = @u WHERE $lId = @id" -Parameters @{ '@u' = $origUpd; '@id' = $before.ExecId } -NonQuery)
    $after = Get-OneLock $conn
}
$conn.Close(); $conn.Dispose()

$sdk = $null
try { $sdk = $sdkJson | ConvertFrom-Json } catch { $sdk = @{ raw = [string]$sdkJson } }

$advanced = $false
if ($after) { $advanced = [int64]$after.LastPrep -gt [int64]$before.LastPrep }
$updN = $after -and ([string]$after.Upd -eq 'N')
$ok = [bool]($updN -and $advanced)

$errors = @()
$errFile = Join-Path $runDir 'errors.json'
if (Test-Path -LiteralPath $errFile) {
    $parsed = Get-Content -LiteralPath $errFile -Raw | ConvertFrom-Json
    foreach ($item in @($parsed)) {
        if ($null -eq $item) { continue }
        if ($item.source) { $errors += $item }
        elseif ($item.text) { $errors += $item }
    }
} elseif ($sdk -and $sdk.errors) {
    foreach ($item in @($sdk.errors)) { if ($item -and $item.text) { $errors += $item } }
}

# SQL is the success gate. On fail, always surface FORMPREPERRS rows (TYPE/MESSAGE/CMESSAGE).
$formPrepErrs = @($errors | Where-Object { $_.source -eq 'FORMPREPERRS' -and $_.text -and $_.text -notmatch '(?i)open failed|getRows failed' })
if ($ok) {
    $errors = @($errors | Where-Object { $_.source -ne 'FORMPREPERRS' })
} elseif ($formPrepErrs.Count -eq 0) {
    $errors += [pscustomobject]@{
        source   = 'FORMPREPERRS'
        severity = 'Info'
        formHint = $Name
        text     = 'FORMPREPERRS returned no rows after failed prep'
    }
}

$result = [ordered]@{
    ok              = $ok
    name            = $Name
    execId          = $before.ExecId
    updBefore       = $before.Upd
    updAfter        = $(if ($after) { $after.Upd } else { $null })
    lastPrepBefore  = $before.LastPrep
    lastPrepAfter   = $(if ($after) { $after.LastPrep } else { $null })
    reason          = $(if ($ok) { 'prepared' } elseif ($updN) { 'lastprep_unchanged' } else { 'still_unprepared' })
    sdk             = $sdk
    errors          = $errors
    runDir          = $runDir
    startedAt       = $started.ToString('o')
}
$jsonPath = Join-Path $runDir 'result.json'
[System.IO.File]::WriteAllText($jsonPath, ($result | ConvertTo-Json -Depth 8))
Copy-Item $jsonPath (Join-Path $cfg.AgentWork 'last-named.json') -Force
Write-Host ("resultJson={0}" -f $jsonPath)
Write-Output ($result | ConvertTo-Json -Depth 8)
if ($ok) { exit 0 }
if ($nodeExit -eq 2) { exit 2 }
exit 3
