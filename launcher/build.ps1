# Builds launcher\PriorityAgent.exe (self-contained, single-file, win-x64, Priority icon embedded)
# Optional: -Install copies it to D:\tools\PriorityAgent and creates the 'Priority Agent' desktop shortcut.
# Optional: -Version X.Y.Z (default 1.0.0) stamps FileVersion X.Y.Z.0 and InformationalVersion X.Y.Z+<sha>.
param(
    [switch]$Install,
    [string]$Dest = 'D:\tools\PriorityAgent',
    [string]$Version = ''
)
$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Get-LauncherReleaseVersion.ps1')
if (-not $Version) { $Version = Get-LauncherReleaseVersion -Tag '' -Fallback '1.0.0' }
$fileVer = Get-LauncherFileVersion -Version $Version
$sha = ''
try { $sha = (git -C $PSScriptRoot rev-parse HEAD 2>$null) } catch { $sha = '' }
$info = Get-LauncherInformationalVersion -Version $Version -Sha $sha
Push-Location $PSScriptRoot
try {
    dotnet publish PriorityAgent.csproj -c Release -o out `
        "-p:Version=$Version" "-p:FileVersion=$fileVer" "-p:InformationalVersion=$info"
    if ($LASTEXITCODE -ne 0) { throw "dotnet publish failed" }
    Write-Host "Built $PSScriptRoot\out\PriorityAgent.exe ($Version / $fileVer / $info)"
    if ($Install) {
        New-Item -ItemType Directory -Force -Path $Dest | Out-Null
        Copy-Item out\PriorityAgent.exe, priority.ico -Destination $Dest -Force
        $lnk = Join-Path ([Environment]::GetFolderPath('Desktop')) 'Priority Agent.lnk'
        $sh = (New-Object -ComObject WScript.Shell).CreateShortcut($lnk)
        $sh.TargetPath = Join-Path $Dest 'PriorityAgent.exe'
        $sh.WorkingDirectory = $Dest
        $sh.IconLocation = (Join-Path $Dest 'PriorityAgent.exe') + ',0'
        $sh.Description = 'Priority ERP coding agent (Grok) with agentic_fomprep skills'
        $sh.Save()
        Write-Host "Installed to $Dest; shortcut $lnk"
    }
} finally { Pop-Location }
