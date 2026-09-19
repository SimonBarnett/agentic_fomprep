#requires -Version 5.1
<#
.SYNOPSIS
    Install one caller-supplied Priority upgrade shell. Instance from user allowlist.
    WCF walker uses pinned Install Upgrade ENAME only. SQL gate + formsUnprepared handoff.
    Does not call prepare_form / FormPrep.
#>
[CmdletBinding()]
param(
    [string]$Shell,
    [string]$InstanceId,
    [switch]$AllowDbi,
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
. (Join-Path $lib 'parse-sh.ps1')
. (Join-Path $lib 'paths.ps1')
. (Join-Path $lib 'Get-WinrunCredential.ps1')
. (Join-Path $lib 'sql.ps1')
. (Join-Path $lib 'gate.ps1')
. (Join-Path $lib 'wcf.ps1')

$started = [datetime]::UtcNow
$skill = 'priority-shell-install'
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
        $hint = $null
        if ($e.entityHint) { $hint = [string]$e.entityHint }
        if ($text) { Add-ShellError -Result $Result -Source $src -Severity $sev -Text $text -EntityHint $hint }
    }
}

function Emit-Install {
    param($Result, [int]$Code, $Instance)
    if ($conn) { try { $conn.Close(); $conn.Dispose() } catch { } }
    $Result.exitCode = $Code
    $Result.wcfAttempted = [bool]$wcfAttempted
    if ($WhatIf) { $Result.whatIf = $true }
    if ($null -eq $Result.installed) { $Result.installed = $false }
    if ($null -eq $Result.dbi) { $Result.dbi = $false }
    if ($null -eq $Result.codes) { $Result.codes = @() }
    if ($null -eq $Result.postInstall) { $Result.postInstall = @{ formsUnprepared = @() } }
    Complete-ShellResult -Result $Result -StartedAt $started
    $work = $null
    if ($Instance) { $work = Get-ShellWorkRoot -Instance $Instance -Skill $skill }
    Write-ShellJson -Result $Result -WorkRoot $work -LastName 'last-install.json'
    exit $Code
}

$result = New-ShellResult -Skill $skill -InstanceId $InstanceId -StartedAt $started
$result.path = $(if ($Shell) { [string]$Shell } else { $null })
$result.stagedPath = $null
$result.revision = $null
$result.codes = @()
$result.dbi = $false
$result.installed = $false
$result.gate = $null
$result.postInstall = @{ formsUnprepared = @() }

if (-not (Test-IsWindowsShellRunner)) {
    $result.reason = 'windows_only'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'Windows runner only'
    Emit-Install $result 2 $null
}

$pinRead = Read-ShellPin -Path $PinPath -StartDir $here
$pin = $null
if ($pinRead.ok) { $pin = $pinRead.pin }

$instFile = Get-InstancesFile -Path $InstancesPath
$allow = Read-Allowlist -Path $instFile
if (-not $allow.ok) {
    $result.reason = 'instance_unknown'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ("allowlist missing or empty: {0} ({1})" -f $allow.reason, $allow.path)
    Emit-Install $result 2 $null
}

$sel = Select-AllowlistedInstance -Allow $allow -InstanceId $InstanceId
if (-not $sel.ok) {
    $result.reason = $sel.reason
    if ($sel.reason -eq 'instance_required') {
        Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('instance_id required; have: ' + ($sel.instanceIds -join ', '))
    } else {
        Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('instance not in allowlist: ' + [string]$InstanceId)
    }
    Emit-Install $result 2 $null
}

$pick = $sel.instance
$result.instanceId = [string]$pick.id

if (Test-LiveRefused -Instance $pick) {
    $result.reason = 'live_refused'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('live/PRI instance refused: ' + [string]$pick.id)
    Emit-Install $result 2 $pick
}

$pathCheck = Test-ShellPathAllowed -ShellPath $Shell -Instance $pick -Pin $pin
if (-not $pathCheck.ok) {
    $result.reason = 'path_refused'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text $pathCheck.text
    Emit-Install $result 2 $pick
}

$full = [string]$pathCheck.path
$result.path = $full

$dbiMarker = $null
if ($pin -and -not [string]::IsNullOrWhiteSpace([string]$pin.DbiMarker)) { $dbiMarker = [string]$pin.DbiMarker }
$parsed = Read-PriorityShell -Path $full -DbiMarker $dbiMarker
if (-not $parsed.ok) {
    $result.reason = 'parse_failed'
    Add-ShellError -Result $result -Source 'parse' -Severity 'Blocker' -Text $parsed.text
    Emit-Install $result 2 $pick
}

$result.revision = $parsed.revision
$result.codes = @($parsed.codes)
$result.dbi = [bool]$parsed.dbi
$forms = @($parsed.takesingleent)
$result.postInstall = @{ formsUnprepared = @($forms) }

if ($parsed.dbi -and -not $AllowDbi) {
    $result.reason = 'dbi_refused'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'shell contains DBI and allow_dbi is false; no WCF'
    Emit-Install $result 2 $pick
}

if ($WhatIf) {
    $result.reason = 'whatIf'
    $result.whatIf = $true
    Add-ShellError -Result $result -Source 'policy' -Severity 'Info' -Text 'WhatIf: parsed shell; would install via pinned install procedure; no WCF; formsUnprepared is a handoff (not auto-prepped)'
    Emit-Install $result 0 $pick
}

if (-not $pinRead.ok -or -not (Test-ShellPinReady -Pin $pin -Role install)) {
    $result.reason = 'pin_incomplete'
    $gaps = @()
    if (-not $pinRead.ok) { $gaps = @('pin file missing') }
    elseif ($pin) { $gaps = @(Get-ShellPinGaps -Pin $pin) }
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('PinComplete is false or install procedure ENAME / gate table unpinned. No WCF. Gaps: ' + (($gaps | Select-Object -First 8) -join ', '))
    Emit-Install $result 2 $pick
}

$credTarget = [string]$pick.credentialTarget
$cred = $null
if (-not [string]::IsNullOrWhiteSpace($credTarget)) {
    $cred = Get-WinrunCredential -Target $credTarget
}
if (-not $cred) {
    $result.reason = 'no_cred'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'CredMan missing for this instance; no WCF'
    Emit-Install $result 2 $pick
}

if (Test-WcfFileStepPinFalse $pin) {
    $result.reason = 'winrun_required'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'WcfFileStepWorks is false; WINRUN fallback is not implemented. No guessed executor.'
    Emit-Install $result 2 $pick
}

try {
    $conn = New-InstanceSqlConnection -Instance $pick
} catch {
    $result.reason = 'sql_failed'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('SQL connect failed: ' + $_.Exception.Message)
    Emit-Install $result 2 $pick
}

try {
    if (-not (Test-PinnedEnameInExec -Connection $conn -Ename (Get-PinnedProcEname -Pin $pin -Role install))) {
        $result.reason = 'pin_incomplete'
        Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('pinned install procedure ENAME not in T$EXEC: ' + (Get-PinnedProcEname -Pin $pin -Role install))
        Emit-Install $result 2 $pick
    }
} catch {
    $result.reason = 'sql_failed'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('ENAME lookup failed: ' + $_.Exception.Message)
    Emit-Install $result 2 $pick
}

$stage = Copy-ShellToInstallRoot -Path $full -Instance $pick -Pin $pin
if (-not $stage.ok) {
    $result.reason = 'path_refused'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text $stage.text
    Emit-Install $result 2 $pick
}
$result.stagedPath = [string]$stage.path

$before = $null
try {
    $before = Get-InstallLogSnapshot -Connection $conn -Pin $pin -Revision $result.revision
} catch {
    $result.reason = 'sql_failed'
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('install-log snapshot failed: ' + $_.Exception.Message)
    Emit-Install $result 2 $pick
}

$workRoot = Get-ShellWorkRoot -Instance $pick -Skill $skill
$runDir = Join-Path $workRoot ([guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $runDir -Force | Out-Null

$wcfAttempted = $true
$result.executor = 'wcf'
$walk = Invoke-UpgradeProcWalker -Instance $pick -Pin $pin -Role install -Revision $result.revision -FilePath $result.stagedPath -RunDir $runDir -Credential $cred -StartDir $here
Add-WalkErrors -Result $result -Walk $walk

$contradict = Test-WcfWalkContradiction -Pin $pin -Walk $walk
if ($contradict.contradict) {
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text $contradict.detail
}

$after = $null
$missing = @()
try {
    $after = Get-InstallLogSnapshot -Connection $conn -Pin $pin -Revision $result.revision
    $missing = @(Get-MissingExecEnames -Connection $conn -Names $forms)
} catch {
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('post-install gate query failed: ' + $_.Exception.Message)
    $missing = @($forms)
}

$gate = New-InstallGateObject -Before $before -After $after -StartedAt $started -Takesingleent $forms -MissingEnames $missing
$result.gate = $gate
$result.postInstall = @{ formsUnprepared = @($forms) }

if (-not $gate.logAdvanced) {
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('install-log row for revision ' + [string]$result.revision + ' did not advance')
}
foreach ($m in $missing) {
    Add-ShellError -Result $result -Source 'gate' -Severity 'Blocker' -Text ('TAKESINGLEENT name missing from T$EXEC: ' + $m) -EntityHint $m
}

$hasBlocker = @($result.errors | Where-Object { $_.severity -eq 'Blocker' }).Count -gt 0
$walkOk = [bool]($walk.ended -and $walk.ok -and -not $hasBlocker)

if ($walk.ended -and $gate.logAdvanced -and $gate.entitiesPresent -and -not $hasBlocker) {
    $result.ok = $true
    $result.installed = $true
    $result.reason = 'installed'
    $result.errors = @($result.errors | Where-Object { $_.severity -eq 'Blocker' })
    Emit-Install $result 0 $pick
}

if ($missing.Count -gt 0) {
    $result.reason = 'partial_entities'
    $result.installed = $false
    Emit-Install $result 3 $pick
}

if (-not $gate.logAdvanced) {
    $result.reason = 'gate_unchanged'
    $result.installed = $false
    Emit-Install $result 3 $pick
}

$result.reason = 'proc_failed'
$result.installed = $false
if (@($result.errors).Count -lt 1) {
    Add-ShellError -Result $result -Source 'sdk' -Severity 'Blocker' -Text 'pinned install procedure WCF walk failed'
}
Emit-Install $result 3 $pick
