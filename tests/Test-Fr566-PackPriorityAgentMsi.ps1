#requires -Version 5.1
# FR agentic_fomprep#566 / FR-001: Pack the Priority Agent MSI (WiX v3, per-machine, no CLI).
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$wxsPath = Join-Path $repo 'packaging\priority-agent\Product.wxs'
$packPath = Join-Path $repo 'tools\Pack-PriorityAgentMsi.ps1'
$fetchPath = Join-Path $repo 'tools\Fetch-Wix.ps1'
Gate 'wxs-exists' (Test-Path -LiteralPath $wxsPath) $wxsPath
Gate 'pack-exists' (Test-Path -LiteralPath $packPath) $packPath
Gate 'fetch-wix-exists' (Test-Path -LiteralPath $fetchPath) $fetchPath

if (Test-Path -LiteralPath $wxsPath) {
    $wxs = [IO.File]::ReadAllText($wxsPath)
    Gate 'per-machine' ($wxs -match 'InstallScope\s*=\s*"perMachine"') 'InstallScope perMachine'
    Gate 'install-dir-name' ($wxs -match 'Name\s*=\s*"Priority Agent"' -and ($wxs -match 'ProgramFiles64Folder' -or $wxs -match 'ProgramFilesFolder' -or $wxs -match 'C:\\Program Files\\Priority Agent')) 'Program Files\Priority Agent'
    Gate 'major-upgrade' ($wxs -match '<MajorUpgrade\b') 'MajorUpgrade'
    Gate 'start-menu' ($wxs -match 'ProgramMenuFolder' -and $wxs -match 'Shortcut') 'Start menu shortcut'
    Gate 'desktop' ($wxs -match 'DesktopFolder' -and $wxs -match 'Shortcut') 'Desktop shortcut'
    Gate 'no-cli-custom-action' (
        $wxs -notmatch 'CAQuietExec' -and
        $wxs -notmatch 'QtExecCmdLine' -and
        $wxs -notmatch 'CustomAction'
    ) 'no CLI CustomAction in Product.wxs'
}

$banned = @(
    'https://x.ai/cli/install.ps1',
    'https://cursor.com/install',
    'opencode.ai',
    'x.ai/cli',
    'cursor.com/install'
)
$scanRoots = @(
    (Join-Path $repo 'packaging\priority-agent'),
    (Join-Path $repo 'tools\Pack-PriorityAgentMsi.ps1'),
    (Join-Path $repo 'tools\Fetch-Wix.ps1')
)
$hits = @()
foreach ($root in $scanRoots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    $files = if (Test-Path -LiteralPath $root -PathType Container) {
        Get-ChildItem -LiteralPath $root -Recurse -File
    } else {
        @(Get-Item -LiteralPath $root)
    }
    foreach ($f in $files) {
        $text = [IO.File]::ReadAllText($f.FullName)
        foreach ($b in $banned) {
            if ($text.IndexOf($b, [StringComparison]::OrdinalIgnoreCase) -ge 0) {
                $hits += "$($f.Name):$b"
            }
        }
    }
}
Gate 'no-cli-installer-urls' ($hits.Count -eq 0) ($(if ($hits.Count) { $hits -join '; ' } else { 'clean' }))

# Live pack smoke (stub exe): writes MSI + .sha256 under dist/
$skipPack = ($env:FOMPREP_SKIP_MSI_PACK -eq '1')
if (-not $skipPack -and (Test-Path -LiteralPath $packPath)) {
    $out = Join-Path $repo 'dist\fr566-test'
    if (Test-Path -LiteralPath $out) { Remove-Item -Recurse -Force $out }
    New-Item -ItemType Directory -Force -Path $out | Out-Null
    $stageExeDir = Join-Path $out 'stage-exe'
    New-Item -ItemType Directory -Force -Path $stageExeDir | Out-Null
    $stub = Join-Path $stageExeDir 'PriorityAgent.exe'
    # Minimal PE-like stub is unnecessary for heat; any non-empty file works for harvest.
    [IO.File]::WriteAllBytes($stub, [byte[]](0x4D, 0x5A) + [byte[]]::new(64))
    $cache = Join-Path $repo 'third_party\wix'
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $packPath `
        -RepoRoot $repo `
        -ExePath $stub `
        -OutDir $out `
        -Version '0.0.566' `
        -WixCacheDir $cache
    $packRc = $LASTEXITCODE
    Gate 'pack-exit-0' ($packRc -eq 0) "pack exit $packRc"
    $msi = Get-ChildItem -LiteralPath $out -Filter '*.msi' -File -ErrorAction SilentlyContinue | Select-Object -First 1
    $sha = if ($msi) { Get-Item -LiteralPath ($msi.FullName + '.sha256') -ErrorAction SilentlyContinue }
    Gate 'msi-written' ($null -ne $msi -and $msi.Length -gt 0) ($(if ($msi) { $msi.Name } else { 'missing' }))
    Gate 'sha256-written' ($null -ne $sha -and $sha.Length -gt 0) ($(if ($sha) { $sha.Name } else { 'missing' }))
    if ($sha) {
        $line = ([IO.File]::ReadAllText($sha.FullName)).Trim()
        Gate 'sha256-format' ($line -match '^[0-9a-fA-F]{64}\s+\S+\.msi$') $line
    }
} elseif ($skipPack) {
    Write-Host 'SKIP pack-smoke FOMPREP_SKIP_MSI_PACK=1'
}

if ($failed -gt 0) { Write-Host "Test-Fr566-PackPriorityAgentMsi FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr566-PackPriorityAgentMsi PASS'
exit 0
