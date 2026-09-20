#requires -Version 5.1
<#
.SYNOPSIS
    Compile one Version Revision into NN.sh. Instance from user allowlist.
    WCF walker uses the pinned compile procedure ENAME only (docs/wp0-recon.md).
#>
[CmdletBinding()]
param(
    [string]$Revision,
    [string]$InstanceId,
    [switch]$WhatIf,
    [string]$InstancesPath,
    [string]$PinPath
)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$lib = Join-Path $here 'lib'
. (Join-Path $lib 'allowlist.ps1')
. (Join-Path $lib 'pin.ps1')
. (Join-Path $lib 'result.ps1')
. (Join-Path $lib 'paths.ps1')
. (Join-Path $lib 'Get-WinrunCredential.ps1')
. (Join-Path $lib 'sql.ps1')
. (Join-Path $lib 'gate.ps1')
. (Join-Path $lib 'wcf.ps1')

$started = [datetime]::UtcNow
$skill = 'priority-shell-compile'
$wcfAttempted = $false
$conn = $null

function Add-WalkErrors {
    param($Result, $Walk)
    foreach ($e in @($Walk.errors)) {
        if ($null -eq $e) { continue }
        $src = 'sdk'
        if ($e.source) { $src = [string]$e.source }
        $sev = 'Warning'
        if ($e.severity) { $sev = [string]$e.severity }
        $text = [string]$e.text
        if ($text) { Add-ShellError -Result $Result -Source $src -Severity $sev -Text $text }
    }
}

function Emit-Compile {
    param($Result, [int]$Code, $Instance)
    if ($conn) { try { $conn.Close(); $conn.Dispose() } catch { } }
    $Result.exitCode = $Code
    $Result.wcfAttempted = [bool]$wcfAttempted
    if ($WhatIf) { $Result.whatIf = $true }
    Complete-ShellResult -Result $Result -StartedAt $started
    $work = $null
    if ($Instance) { $work = Get-ShellWorkRoot -Instance $Instance -Skill $skill }
    Write-ShellJson -Result $Result -WorkRoot $work -LastName 'last-compile.json'
    exit $Code
}

$result = New-ShellResult -Skill $skill -InstanceId $InstanceId -StartedAt $started
$result.revision = $(if ($Revision) { [string]$Revision } else { $null })
$result.path = $null
$result.bytes = $null

if (-not (Test-IsWindowsShellRunner)) {
    $result.reason = 'windows_only'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'Windows runner only'
    Emit-Compile $result 2 $null
}

$pinRead = Read-ShellPin -Path $PinPath -StartDir $here
$pin = $null
if ($pinRead.ok) { $pin = $pinRead.pin }

$instFile = Get-InstancesFile -Path $InstancesPath
$allow = Read-Allowlist -Path $instFile
if (-not $allow.ok) {
    $result.reason = 'instance_unknown'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ("allowlist missing or empty: {0} ({1})" -f $allow.reason, $allow.path)
    Emit-Compile $result 2 $null
}

$sel = Select-AllowlistedInstance -Allow $allow -InstanceId $InstanceId
if (-not $sel.ok) {
    $result.reason = $sel.reason
    if ($sel.reason -eq 'instance_required') {
        Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('instance_id required; have: ' + ($sel.instanceIds -join ', '))
    } else {
        Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('instance not in allowlist: ' + [string]$InstanceId)
    }
    Emit-Compile $result 2 $null
}

$pick = $sel.instance
$result.instanceId = [string]$pick.id

if (Test-LiveRefused -Instance $pick) {
    $result.reason = 'live_refused'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('live/PRI instance refused: ' + [string]$pick.id)
    Emit-Compile $result 2 $pick
}

if ([string]::IsNullOrWhiteSpace($Revision)) {
    $result.reason = 'revision_missing'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'revision is required'
    Emit-Compile $result 2 $pick
}

if ($WhatIf) {
    $result.reason = 'whatIf'
    $result.whatIf = $true
    Add-ShellError -Result $result -Source 'policy' -Severity 'Info' -Text 'WhatIf: would compile revision via pinned compile procedure; no WCF'
    Emit-Compile $result 0 $pick
}

if (-not $pinRead.ok -or -not (Test-ShellPinReady -Pin $pin -Role compile)) {
    $result.reason = 'pin_incomplete'
    $gaps = @()
    if (-not $pinRead.ok) { $gaps = @('pin file missing') }
    elseif ($pin) { $gaps = @(Get-ShellPinGaps -Pin $pin) }
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('PinComplete is false or compile procedure ENAME unpinned. No WCF. Gaps: ' + (($gaps | Select-Object -First 8) -join ', '))
    Emit-Compile $result 2 $pick
}

$credTarget = [string]$pick.credentialTarget
$cred = $null
if (-not [string]::IsNullOrWhiteSpace($credTarget)) {
    $cred = Get-WinrunCredential -Target $credTarget
}
if (-not $cred) {
    $result.reason = 'no_cred'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'CredMan missing for this instance; no WCF'
    Emit-Compile $result 2 $pick
}

if (Test-WcfFileStepPinFalse $pin) {
    $result.reason = 'winrun_required'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'WcfFileStepWorks is false; WINRUN fallback is not implemented. No guessed executor.'
    Emit-Compile $result 2 $pick
}

try {
    $conn = New-InstanceSqlConnection -Instance $pick
} catch {
    $result.reason = 'sql_failed'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('SQL connect failed: ' + $_.Exception.Message)
    Emit-Compile $result 2 $pick
}

try {
    if (-not (Test-PinnedEnameInExec -Connection $conn -Pin $pin -Ename (Get-PinnedProcEname -Pin $pin -Role compile))) {
        $result.reason = 'pin_incomplete'
        Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('pinned compile procedure ENAME not in T$EXEC: ' + (Get-PinnedProcEname -Pin $pin -Role compile))
        Emit-Compile $result 2 $pick
    }
    $revExists = Test-VersionRevisionExists -Connection $conn -Pin $pin -Revision $Revision
    if (-not $revExists) {
        $result.reason = 'revision_missing'
        Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ("revision $Revision not on $($pin.VersionRevisionsEname).UPGNUM")
        Emit-Compile $result 2 $pick
    }
} catch {
    $result.reason = 'sql_failed'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('revision lookup failed: ' + $_.Exception.Message)
    Emit-Compile $result 2 $pick
}

$out = Get-CompileShellOutputPath -Instance $pick -Pin $pin -Revision $Revision
if (-not $out.ok) {
    $result.reason = $out.reason
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text $out.text
    Emit-Compile $result 2 $pick
}

$workRoot = Get-ShellWorkRoot -Instance $pick -Skill $skill
$runDir = Join-Path $workRoot ([guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null

$wcfAttempted = $true
$result.executor = 'wcf'
$walk = Invoke-UpgradeProcWalker -Instance $pick -Pin $pin -Role compile -Revision $Revision -FilePath $out.path -RunDir $runDir -Credential $cred -StartDir $here
Add-WalkErrors -Result $result -Walk $walk

$contradict = Test-WcfWalkContradiction -Pin $pin -Walk $walk
if ($contradict.contradict) {
    $result.reason = 'proc_failed'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text $contradict.detail
    Emit-Compile $result 3 $pick
}

$item = $null
if (Test-Path -LiteralPath $out.path) { $item = Get-Item -LiteralPath $out.path }
$bytes = 0
if ($item) { $bytes = [int64]$item.Length }
$result.path = $out.path
$result.bytes = $bytes

$hasBlocker = @($result.errors | Where-Object { $_.severity -eq 'Blocker' }).Count -gt 0
if ($walk.ended -and -not $hasBlocker -and $item -and $bytes -gt 0) {
    $result.ok = $true
    $result.reason = 'compiled'
    $result.errors = @($result.errors | Where-Object { $_.source -ne 'sdk' -or $_.severity -eq 'Blocker' })
    Emit-Compile $result 0 $pick
}

if ($walk.ended -and (-not $item -or $bytes -lt 1)) {
    $result.reason = 'shell_not_created'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('procedure ended but shell missing or empty: ' + $out.path)
    Emit-Compile $result 3 $pick
}

$result.reason = 'proc_failed'
if (@($result.errors).Count -lt 1) {
    Add-ShellError -Result $result -Source 'sdk' -Severity 'Blocker' -Text 'pinned compile procedure WCF walk failed'
}
Emit-Compile $result 3 $pick
