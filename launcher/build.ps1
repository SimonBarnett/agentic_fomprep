# Builds launcher\PriorityAgent.exe (self-contained, single-file, win-x64, Priority icon embedded)
# Optional: -Install copies it to D:\tools\PriorityAgent and creates the 'Priority Agent' desktop shortcut.
param([switch]$Install, [string]$Dest = 'D:\tools\PriorityAgent')
$ErrorActionPreference = 'Stop'
Push-Location $PSScriptRoot
try {
    dotnet publish PriorityAgent.csproj -c Release -o out
    if ($LASTEXITCODE -ne 0) { throw "dotnet publish failed" }
    Write-Host "Built $PSScriptRoot\out\PriorityAgent.exe"
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
