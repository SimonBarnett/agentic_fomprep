#requires -Version 5.1
<#
.SYNOPSIS
    Public CLI for unattended Form Prep on CE Priority DEV.
.EXAMPLE
    powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -WhatIf
#>
[CmdletBinding(DefaultParameterSetName = 'Prepare')]
param(
    [Parameter(ParameterSetName = 'Prepare', Position = 0)]
    [string[]]$Names,

    [ValidateSet('DEV')]
    [string]$Environment = 'DEV',

    [int]$TimeoutMinutes = 15,
    [int]$CliTimeoutSeconds = 60,
    [switch]$RestoreQueue,
    [string[]]$PostHooks,
    [string]$ResultJson,
    [switch]$WhatIf,
    [switch]$SkipCli,
    [switch]$SkipWeb,
    [switch]$Force,
    [ValidateSet('Named', 'AllUnprepared')]
    [string]$Scope = 'Named',
    [string]$ChangeTicket,

    [Parameter(ParameterSetName = 'Repair')]
    [switch]$RepairOpenParks,

    [guid]$RunId,
    [switch]$ResetLastPrepDate,
    [string]$ConfigPath,
    [switch]$SkipPark,
    [int]$HoldParkSeconds = 0,
    [switch]$AllowSameDayPrep
)

$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
Import-Module (Join-Path $here 'CE.FormPrep.psd1') -Force

$invoke = @{
    Environment       = $Environment
    TimeoutMinutes    = $TimeoutMinutes
    CliTimeoutSeconds = $CliTimeoutSeconds
    RestoreQueue      = $RestoreQueue
    WhatIf            = $WhatIf
    SkipCli           = $SkipCli
    SkipWeb           = $SkipWeb
    Force             = $Force
    Scope             = $Scope
    ResetLastPrepDate = $ResetLastPrepDate
    HoldParkSeconds   = $HoldParkSeconds
    SkipPark          = $SkipPark
    AllowSameDayPrep  = $AllowSameDayPrep
}
if ($Names) { $invoke.Names = $Names }
if ($PostHooks) { $invoke.PostHooks = $PostHooks }
if ($ResultJson) { $invoke.ResultJson = $ResultJson }
if ($ChangeTicket) { $invoke.ChangeTicket = $ChangeTicket }
if ($RepairOpenParks) { $invoke.RepairOpenParks = $RepairOpenParks }
if ($PSBoundParameters.ContainsKey('RunId')) { $invoke.RunId = $RunId }
if ($ConfigPath) { $invoke.ConfigPath = $ConfigPath }

# P1-C1 / v3: CLI is a documented no-op on CE DEV. Default SkipCli unless the caller passed it.
if ($PSCmdlet.ParameterSetName -eq 'Prepare' -and -not $PSBoundParameters.ContainsKey('SkipCli')) {
    $invoke.SkipCli = $true
}

$result = Prepare-Forms @invoke
$code = 2
if ($result -and $null -ne $result.exitCode) { $code = [int]$result.exitCode }
exit $code
