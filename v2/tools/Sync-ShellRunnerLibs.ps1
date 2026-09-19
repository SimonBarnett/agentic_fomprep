#requires -Version 5.1
# Copy canonical v2/lib + plugin runners into catalog runner trees and plugin lib copies.
$ErrorActionPreference = 'Stop'
$v2 = Split-Path -Parent $PSScriptRoot
$lib = Join-Path $v2 'lib'
$pinJson = Join-Path $v2 'config\pin.json'
$pinPsd1 = Join-Path $v2 'config\pin.psd1'

$libDest = @(
    (Join-Path $v2 'plugins\priority-shell-compile\scripts\lib'),
    (Join-Path $v2 'plugins\priority-shell-install\scripts\lib'),
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-compile\runner\lib'),
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-install\runner\lib')
)
$libFiles = Get-ChildItem -LiteralPath $lib -File | Where-Object { $_.Extension -in @('.ps1', '.mjs', '.json') }
foreach ($d in $libDest) {
    New-Item -ItemType Directory -Path $d -Force | Out-Null
    foreach ($f in $libFiles) {
        Copy-Item -LiteralPath $f.FullName -Destination (Join-Path $d $f.Name) -Force
    }
}

Copy-Item -LiteralPath (Join-Path $v2 'plugins\priority-shell-compile\scripts\Compile-Shell.ps1') `
    -Destination (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-compile\runner\Compile-Shell.ps1') -Force
Copy-Item -LiteralPath (Join-Path $v2 'plugins\priority-shell-install\scripts\Install-Shell.ps1') `
    -Destination (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-install\runner\Install-Shell.ps1') -Force

$pinDestJson = @(
    (Join-Path $v2 'plugins\priority-shell-compile\pin.json'),
    (Join-Path $v2 'plugins\priority-shell-install\pin.json'),
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-compile\pin.json'),
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-install\pin.json'),
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-compile\runner\pin.json'),
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-install\runner\pin.json')
)
foreach ($p in $pinDestJson) {
    Copy-Item -LiteralPath $pinJson -Destination $p -Force
}
$pinDestPsd1 = @(
    (Join-Path $v2 'plugins\priority-shell-compile\pin.psd1'),
    (Join-Path $v2 'plugins\priority-shell-install\pin.psd1')
)
foreach ($p in $pinDestPsd1) {
    Copy-Item -LiteralPath $pinPsd1 -Destination $p -Force
}

Write-Host 'synced shell runner libs, scripts, and pin copies from v2/lib + v2/config'
