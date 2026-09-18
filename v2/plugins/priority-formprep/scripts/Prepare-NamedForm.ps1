#requires -Version 5.1
<#
.SYNOPSIS
    Portable named-form prep. Instance from user allowlist. Does not use the CE DEV1 pack.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Name,
    [string]$InstanceId,
    [switch]$ForceUnprepared,
    [string]$Proc,
    [string]$InstancesPath
)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
. (Join-Path $here 'lib\Get-WinrunCredential.ps1')
. (Join-Path $here 'lib\sql.ps1')

if ($Name -notmatch '^[A-Za-z][A-Za-z0-9_]*$') { throw "Bad form name '$Name'" }

function Get-InstancesFile {
    param([string]$Path)
    if ($Path) { return $Path }
    if ($env:PRIORITY_FORMPREP_INSTANCES) { return $env:PRIORITY_FORMPREP_INSTANCES }
    return Join-Path $env:USERPROFILE '.priority-formprep\instances.json'
}

function Read-Allowlist {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        return @{ ok = $false; reason = 'no_instances_file'; path = $Path }
    }
    $raw = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
    $list = @($raw.instances)
    if ($list.Count -lt 1) {
        return @{ ok = $false; reason = 'no_instances'; path = $Path }
    }
    return @{ ok = $true; path = $Path; instances = $list }
}

function Test-LiveRefused {
    param($Instance)
    if ($Instance.allowLive -eq $true) { return $false }
    $bits = @($Instance.id, $Instance.title, $Instance.company) | ForEach-Object { [string]$_ }
    $blob = ($bits -join ' ')
    if ($blob -match '(?i)\blive\b') { return $true }
    if ([string]$Instance.id -match '(?i)(^|-)pri$' -or [string]$Instance.company -match '(?i)^pri$') { return $true }
    return $false
}

function Write-FailJson {
    param($Obj, [int]$Code)
    Write-Output (ConvertTo-Json $Obj -Compress -Depth 6)
    exit $Code
}

$instFile = Get-InstancesFile -Path $InstancesPath
$allow = Read-Allowlist -Path $instFile
if (-not $allow.ok) {
    Write-FailJson @{ ok = $false; reason = $allow.reason; instancesPath = $allow.path } 2
}

$pick = $null
if ($InstanceId) {
    $pick = @($allow.instances | Where-Object { $_.id -eq $InstanceId } | Select-Object -First 1)
    if (-not $pick) {
        Write-FailJson @{ ok = $false; reason = 'instance_unknown'; instanceId = $InstanceId } 2
    }
} elseif ($allow.instances.Count -eq 1) {
    $pick = $allow.instances[0]
} else {
    Write-FailJson @{
        ok          = $false
        reason      = 'instance_required'
        instanceIds = @($allow.instances | ForEach-Object { $_.id })
    } 2
}

if (Test-LiveRefused -Instance $pick) {
    Write-FailJson @{ ok = $false; reason = 'live_refused'; instanceId = [string]$pick.id } 2
}

if (-not $Proc) {
    $Proc = [string]$pick.formPrepProc
    if (-not $Proc) { $Proc = 'FORMPREPDRCT2' }
}

$started = [datetime]::UtcNow
$workRoot = [string]$pick.agentWork
if (-not $workRoot) {
    $workRoot = Join-Path $env:TEMP ("priority-formprep-" + [string]$pick.id)
}
New-Item -ItemType Directory -Path $workRoot -Force | Out-Null

$conn = New-InstanceSqlConnection -Instance $pick
$lockTable = ConvertTo-SqlIdent 'dbo.EXECPREPLOCK'
$execTable = ConvertTo-SqlIdent 'dbo.T$EXEC'
$lId = ConvertTo-SqlIdent 'T$EXEC'
$lUpd = ConvertTo-SqlIdent 'UPD'
$lPrep = ConvertTo-SqlIdent 'LASTPREPDATE'
$eId = ConvertTo-SqlIdent 'T$EXEC'
$eName = ConvertTo-SqlIdent 'ENAME'

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
    $conn.Close(); $conn.Dispose()
    Write-FailJson @{ ok = $false; reason = 'name_missing'; name = $Name; instanceId = [string]$pick.id } 2
}
$origUpd = $before.Upd
if ($ForceUnprepared) {
    [void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = N'Y' WHERE $lId = @id" -Parameters @{ '@id' = $before.ExecId } -NonQuery)
}

$cred = Get-WinrunCredential -Target ([string]$pick.credentialTarget)
if (-not $cred) {
    $conn.Close(); $conn.Dispose()
    Write-FailJson @{ ok = $false; reason = 'no_cred'; name = $Name; instanceId = [string]$pick.id } 2
}

$runDir = Join-Path $workRoot ([guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $runDir -Force | Out-Null
$lang = 2
if ($pick.language) { $lang = [int]$pick.language }
$tabula = [string]$pick.tabulaini
if (-not $tabula) { $tabula = 'tabula.ini' }

$env:PRIORITY_SDK_PASSWORD = $cred.Password
$sdkJson = $null
$nodeExit = 0
try {
    $js = Join-Path $here 'run-formprep.mjs'
    $sdkJson = & node $js --name $Name --company ([string]$pick.company) --url ([string]$pick.webBaseUrl) --user ([string]$pick.priorityUser) --out $runDir --language $lang --proc $Proc --tabulaini $tabula
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
    instanceId      = [string]$pick.id
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
Copy-Item $jsonPath (Join-Path $workRoot 'last-named.json') -Force
Write-Host ("resultJson={0}" -f $jsonPath)
Write-Output ($result | ConvertTo-Json -Depth 8)
if ($ok) { exit 0 }
if ($nodeExit -eq 2) { exit 2 }
exit 3
