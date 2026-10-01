#requires -Version 5.1
<#
.SYNOPSIS
    Prepare one Priority procedure/report (TYPE=P or R) via Web SDK.
    Path: EXEC form → activateStart(REPPREPDIRECT2).
    Success = EXECPREPLOCK.UPD=N AND system\prep\d{T$EXEC}.prp mtime advanced.
.NOTES
    Named Form Prep (EFORM + FORMPREPDRCT2) does not see TYPE=P. Use this instead.
    Never log PRIORITY_SDK_PASSWORD. Never SQL-flip UPD=N to fake success.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Name,
    [string]$Environment = 'DEV',
    [switch]$ForceUnprepared,
    [string]$Proc = 'REPPREPDIRECT2',
    [string]$PrepDir = 'C:\Priority\system\prep',
    [ValidateSet('P', 'R')][string]$ExecType = 'P'
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $PSScriptRoot 'CE.FormPrep.psd1') -Force
. (Join-Path $PSScriptRoot 'Private\Get-WinrunCredential.ps1')

if ($Name -notmatch '^[A-Za-z][A-Za-z0-9_]*$') { throw "Bad procedure name '$Name'" }
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
SELECT E.$eName AS name, E.$eId AS exec_id, E.[TYPE] AS exec_type, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName = @n AND E.[TYPE] = @t
"@ -Parameters @{ '@n' = $Name; '@t' = $ExecType }
    if ($t.Rows.Count -lt 1) { return $null }
    return [pscustomobject]@{
        Name     = [string]$t.Rows[0].name
        ExecId   = [int64]$t.Rows[0].exec_id
        ExecType = ([string]$t.Rows[0].exec_type).Trim()
        Upd      = ([string]$t.Rows[0].upd).Trim()
        LastPrep = [int64]$t.Rows[0].last_prep
    }
}

function Get-PrpMeta([int64]$execId) {
    $path = Join-Path $PrepDir ("d{0}.prp" -f $execId)
    if (-not (Test-Path -LiteralPath $path)) {
        return [pscustomobject]@{ Path = $path; Exists = $false; MtimeUtc = $null; Bytes = 0 }
    }
    $item = Get-Item -LiteralPath $path
    return [pscustomobject]@{
        Path     = $path
        Exists   = $true
        MtimeUtc = $item.LastWriteTimeUtc
        Bytes    = [int64]$item.Length
    }
}

$before = Get-OneLock $conn
if (-not $before) {
    Write-Output (ConvertTo-Json @{ ok = $false; reason = 'name_missing'; name = $Name; execType = $ExecType } -Compress)
    exit 2
}
$origUpd = $before.Upd
$prpBefore = Get-PrpMeta $before.ExecId

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
$nodeExit = 0
try {
    Start-Sleep -Seconds 1
    $js = Join-Path $PSScriptRoot 'sdk\run-repprep-via-exec.mjs'
    $sdkJson = & node $js --name $Name --company $cfg.Company --url $cfg.WebBaseUrl --user $cfg.PriorityUser --out $runDir --language 2 --proc $Proc
    $nodeExit = $LASTEXITCODE
} finally {
    Remove-Item Env:PRIORITY_SDK_PASSWORD -ErrorAction SilentlyContinue
}

$after = Get-OneLock $conn
$prpAfter = Get-PrpMeta $before.ExecId
$prpAdvanced = $false
if ($prpBefore.Exists -and $prpAfter.Exists) {
    $prpAdvanced = $prpAfter.MtimeUtc -gt $prpBefore.MtimeUtc
} elseif ($prpAfter.Exists -and -not $prpBefore.Exists) {
    $prpAdvanced = $true
}

$updN = $after -and ([string]$after.Upd -eq 'N')
$lastAdvanced = $after -and ([int64]$after.LastPrep -gt [int64]$before.LastPrep)
# TYPE=P often keeps LASTPREPDATE=0; .prp mtime is the durable compile signal.
$ok = [bool]($updN -and $prpAdvanced)

if ($ForceUnprepared -and -not $ok) {
    [void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = @u WHERE $lId = @id" -Parameters @{ '@u' = $origUpd; '@id' = $before.ExecId } -NonQuery)
    $after = Get-OneLock $conn
    $updN = $after -and ([string]$after.Upd -eq 'N')
}
$conn.Close(); $conn.Dispose()

$sdk = $null
try { $sdk = $sdkJson | ConvertFrom-Json } catch { $sdk = @{ raw = [string]$sdkJson } }

$reason = 'still_unprepared'
if ($ok) { $reason = 'prepared' }
elseif ($updN -and -not $prpAdvanced) { $reason = 'prp_unchanged' }
elseif ($updN -and $lastAdvanced -and -not $prpAdvanced) { $reason = 'lastprep_only' }
elseif ($sdk -and $sdk.ended -eq $false) { $reason = 'walk_incomplete' }

$errors = @()
if ($sdk -and $sdk.errors) {
    foreach ($item in @($sdk.errors)) { if ($item -and $item.text) { $errors += $item } }
}

$result = [ordered]@{
    ok             = $ok
    name           = $Name
    execId         = $before.ExecId
    execType       = $before.ExecType
    updBefore      = $before.Upd
    updAfter       = $(if ($after) { $after.Upd } else { $null })
    lastPrepBefore = $before.LastPrep
    lastPrepAfter  = $(if ($after) { $after.LastPrep } else { $null })
    prpBeforeUtc   = $(if ($prpBefore.MtimeUtc) { $prpBefore.MtimeUtc.ToString('o') } else { $null })
    prpAfterUtc    = $(if ($prpAfter.MtimeUtc) { $prpAfter.MtimeUtc.ToString('o') } else { $null })
    prpBytes       = $prpAfter.Bytes
    prpPath        = $prpAfter.Path
    prpAdvanced    = $prpAdvanced
    reason         = $reason
    sdk            = $sdk
    errors         = $errors
    runDir         = $runDir
    startedAt      = $started.ToString('o')
}
$jsonPath = Join-Path $runDir 'result.json'
[System.IO.File]::WriteAllText($jsonPath, ($result | ConvertTo-Json -Depth 8))
Copy-Item $jsonPath (Join-Path $cfg.AgentWork 'last-named-procedure.json') -Force
Write-Host ("resultJson={0}" -f $jsonPath)
Write-Output ($result | ConvertTo-Json -Depth 8)
if ($ok) { exit 0 }
if ($nodeExit -eq 2) { exit 2 }
exit 3
