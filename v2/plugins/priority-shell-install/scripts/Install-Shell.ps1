#requires -Version 5.1
<#
.SYNOPSIS
    Install one caller-supplied Priority upgrade shell. Instance from user allowlist.
    WP0 skeleton: parse, path allowlist, DBI refuse, WhatIf. Does not guess a procedure ENAME.
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

$started = [datetime]::UtcNow
$skill = 'priority-shell-install'
$wcfAttempted = $false

function Emit-Install {
    param($Result, [int]$Code, $Instance)
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
$result.postInstall = @{ formsUnprepared = $forms }

if ($parsed.dbi -and -not $AllowDbi) {
    $result.reason = 'dbi_refused'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'shell contains DBI and allow_dbi is false; no WCF'
    Emit-Install $result 2 $pick
}

if ($WhatIf) {
    $result.reason = 'whatIf'
    $result.whatIf = $true
    Add-ShellError -Result $result -Source 'policy' -Severity 'Info' -Text 'WhatIf: parsed shell; would install after WP0 pins; no WCF'
    Emit-Install $result 0 $pick
}

if (-not $pinRead.ok -or -not (Test-ShellPinReady -Pin $pin -Role install)) {
    $result.reason = 'pin_incomplete'
    $gaps = @()
    if (-not $pinRead.ok) { $gaps = @('pin file missing') }
    elseif ($pin) { $gaps = @(Get-ShellPinGaps -Pin $pin) }
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('PinComplete is false or Install Upgrade ENAME / gate table unpinned. No WCF. Gaps: ' + (($gaps | Select-Object -First 8) -join ', '))
    Emit-Install $result 2 $pick
}

$credTarget = [string]$pick.credentialTarget
if ([string]::IsNullOrWhiteSpace($credTarget) -or -not (Get-WinrunCredential -Target $credTarget)) {
    $result.reason = 'no_cred'
    Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'CredMan missing for this instance; no WCF'
    Emit-Install $result 2 $pick
}

# Red before WCF: this WP0 skeleton has no procedure invocation.
$result.reason = 'pin_incomplete'
Add-ShellError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'WP0 skeleton does not invoke WCF; refusing rather than guessing a procedure name'
Emit-Install $result 2 $pick
