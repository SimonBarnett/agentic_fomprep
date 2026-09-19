#requires -Version 5.1
<#
.SYNOPSIS
    Compile one Version Revision into NN.sh. Instance from user allowlist.
    WP0 skeleton: parser/allowlist/WhatIf/refuse only. Does not guess a procedure ENAME.
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
. (Join-Path $lib 'Get-WinrunCredential.ps1')

$started = [datetime]::UtcNow
$skill = 'priority-shell-compile'
$wcfAttempted = $false

function Emit-Compile {
    param($Result, [int]$Code, $Instance)
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
    Add-ShellError -Result $result -Source 'policy' -Severity 'Info' -Text 'WhatIf: would compile revision after WP0 pins; no WCF'
    Emit-Compile $result 0 $pick
}

if (-not $pinRead.ok -or -not (Test-ShellPinReady -Pin $pin -Role compile)) {
    $result.reason = 'pin_incomplete'
    $gaps = @()
    if (-not $pinRead.ok) { $gaps = @('pin file missing') }
    elseif ($pin) { $gaps = @(Get-ShellPinGaps -Pin $pin) }
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('PinComplete is false or Prepare Upgrade ENAME unpinned. No WCF. Gaps: ' + (($gaps | Select-Object -First 8) -join ', '))
    Emit-Compile $result 2 $pick
}

$credTarget = [string]$pick.credentialTarget
if ([string]::IsNullOrWhiteSpace($credTarget) -or -not (Get-WinrunCredential -Target $credTarget)) {
    $result.reason = 'no_cred'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'CredMan missing for this instance; no WCF'
    Emit-Compile $result 2 $pick
}

# Red before WCF: this WP0 skeleton has no procedure invocation.
$result.reason = 'pin_incomplete'
Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'WP0 skeleton does not invoke WCF; refusing rather than guessing a procedure name'
Emit-Compile $result 2 $pick
