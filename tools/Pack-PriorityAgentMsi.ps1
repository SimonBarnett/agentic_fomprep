#Requires -Version 5.1
<#
.SYNOPSIS
  Pack PriorityAgent.exe into a per-machine WiX v3 MSI + .sha256 (priority-mcp#566 / FR-001).
.NOTES
  Harvests the published exe only. No CLI dialog and no CLI custom action.
#>
[CmdletBinding()]
param(
    [string]$RepoRoot = '',
    [string]$OutDir = '',
    [string]$Version = '',
    [string]$ExePath = '',
    [string]$WixCacheDir = '',
    [switch]$KeepStage,
    [switch]$Publish
)

$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) {
    if ($PSScriptRoot) {
        $RepoRoot = Split-Path -Parent $PSScriptRoot
    } else {
        $RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
    }
}
if (-not $OutDir) { $OutDir = Join-Path $RepoRoot 'dist' }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

if (-not $Version) {
    $verHelper = Join-Path $RepoRoot 'launcher\Get-LauncherReleaseVersion.ps1'
    if (Test-Path -LiteralPath $verHelper) {
        . $verHelper
        $Version = Get-LauncherReleaseVersion -Tag '' -Fallback '1.0.0'
    } else {
        $Version = '1.0.0'
    }
}
$msiVersion = $Version.Trim().TrimStart('v', 'V')
if ($msiVersion -match '^(\d+)\.(\d+)$') {
    $msiVersion = "$msiVersion.0"
}
elseif ($msiVersion -match '^(\d+)\.(\d+)\.(\d+)\.(\d+)$') {
    $msiVersion = '{0}.{1}.{2}' -f [int]$Matches[1], [int]$Matches[2], ([int]$Matches[3] + [int]$Matches[4])
}
elseif ($msiVersion -notmatch '^\d+\.\d+\.\d+$') {
    throw "VERSION '$Version' is not major.minor.patch for MSI"
}

if (-not $ExePath) {
    $defaultOut = Join-Path $RepoRoot 'launcher\out\PriorityAgent.exe'
    if ($Publish -or -not (Test-Path -LiteralPath $defaultOut)) {
        $dotnet = if (Test-Path -LiteralPath 'D:\dotnet\dotnet.exe') { 'D:\dotnet\dotnet.exe' } else { 'dotnet' }
        $publishOut = Join-Path $RepoRoot 'launcher\out'
        & $dotnet publish (Join-Path $RepoRoot 'launcher\PriorityAgent.csproj') `
            -c Release -r win-x64 --self-contained true `
            -p:PublishSingleFile=true `
            -p:Version=$msiVersion `
            -o $publishOut
        if ($LASTEXITCODE -ne 0) { throw "dotnet publish failed: $LASTEXITCODE" }
        $ExePath = Join-Path $publishOut 'PriorityAgent.exe'
    } else {
        $ExePath = $defaultOut
    }
}
if (-not (Test-Path -LiteralPath $ExePath)) { throw "PriorityAgent.exe missing: $ExePath" }
if ([IO.Path]::GetFileName($ExePath) -ne 'PriorityAgent.exe') {
    throw "ExePath must be named PriorityAgent.exe (got $ExePath)"
}

$stage = Join-Path $OutDir ("priority-agent-$Version")
if (Test-Path -LiteralPath $stage) { Remove-Item -Recurse -Force $stage }
New-Item -ItemType Directory -Force -Path $stage | Out-Null
Copy-Item -LiteralPath $ExePath -Destination (Join-Path $stage 'PriorityAgent.exe') -Force

$fetchWix = Join-Path $RepoRoot 'tools\Fetch-Wix.ps1'
if (-not (Test-Path -LiteralPath $fetchWix)) { throw "missing $fetchWix" }
$fetchArgs = @{}
if ($WixCacheDir) { $fetchArgs['CacheDir'] = $WixCacheDir }
$wixBin = & $fetchWix @fetchArgs
if (-not $wixBin) { throw 'Fetch-Wix returned empty bin path' }
$candle = Join-Path $wixBin 'candle.exe'
$light = Join-Path $wixBin 'light.exe'
$heat = Join-Path $wixBin 'heat.exe'
foreach ($tool in @($candle, $light, $heat)) {
    if (-not (Test-Path -LiteralPath $tool)) { throw "WiX tool missing: $tool" }
}

$wixWork = Join-Path $OutDir ("wix-priority-agent-$Version")
if (Test-Path -LiteralPath $wixWork) { Remove-Item -Recurse -Force $wixWork }
New-Item -ItemType Directory -Force -Path $wixWork | Out-Null

$harvested = Join-Path $wixWork 'HarvestedFiles.wxs'
& $heat dir $stage `
    -cg PriorityAgentFiles `
    -gg -sfrag -srd -sreg -scom `
    -dr INSTALLDIR `
    -var var.StageDir `
    -out $harvested
if ($LASTEXITCODE -ne 0) { throw "heat.exe failed: $LASTEXITCODE" }

$productWxs = Join-Path $RepoRoot 'packaging\priority-agent\Product.wxs'
if (-not (Test-Path -LiteralPath $productWxs)) { throw "missing $productWxs" }
Copy-Item -LiteralPath $productWxs -Destination (Join-Path $wixWork 'Product.wxs') -Force

Push-Location $wixWork
try {
    & $candle -nologo -arch x64 `
        "-dProductVersion=$msiVersion" `
        "-dStageDir=$stage" `
        Product.wxs HarvestedFiles.wxs
    if ($LASTEXITCODE -ne 0) { throw "candle.exe failed: $LASTEXITCODE" }

    $msiName = "priority-agent-$Version.msi"
    $msi = Join-Path $OutDir $msiName
    if (Test-Path -LiteralPath $msi) { Remove-Item -Force $msi }
    # ICE57: common Start Menu / Desktop shortcuts with HKCU KeyPath (required by ICE38/43).
    & $light -nologo `
        -cultures:en-us `
        -sice:ICE57 `
        -out $msi `
        Product.wixobj HarvestedFiles.wixobj
    if ($LASTEXITCODE -ne 0) { throw "light.exe failed: $LASTEXITCODE" }
} finally {
    Pop-Location
}

if (-not (Test-Path -LiteralPath $msi)) { throw "MSI not produced: $msi" }
$hash = (Get-FileHash -LiteralPath $msi -Algorithm SHA256).Hash.ToLower()
Set-Content -LiteralPath ($msi + '.sha256') -Value ("$hash  $msiName") -Encoding ascii
Write-Host "INFO packed $msi"
Write-Host "INFO sha256 $hash"

if (-not $KeepStage) {
    Remove-Item -Recurse -Force $stage -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force $wixWork -ErrorAction SilentlyContinue
}

Get-Item $msi, ($msi + '.sha256') | Format-Table Name, Length -AutoSize
