# FR #568: user-context CLI installers. No live network. Pins tests/priority-agent-cli.
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path -LiteralPath (Join-Path $repo 'launcher\CliDetect.cs'))) {
    Write-Error 'launcher/CliDetect.cs missing'
}
$src = Get-Content -LiteralPath (Join-Path $repo 'launcher\CliInstall.cs') -Raw
if ($src -notmatch 'x\.ai/cli/install\.ps1') { Write-Error 'Grok official installer URL missing' }
if ($src -notmatch 'cursor\.com/install') { Write-Error 'Cursor official installer URL missing' }
if ($src -match '(?i)scoop|chocolatey|winget') { Write-Error 'no Scoop/Chocolatey/WinGet' }
if ($src -notmatch 'refuse LocalSystem') { Write-Error 'LocalSystem refuse missing' }
$wxs = Get-ChildItem -Path $repo -Filter '*.wxs' -Recurse -ErrorAction SilentlyContinue
foreach ($f in $wxs) {
    $t = Get-Content -LiteralPath $f.FullName -Raw
    if ($t -match '(?i)Execute=["'']deferred' -and $t -match '(?i)x\.ai/cli|cursor\.com/install|opencode') {
        Write-Error "deferred custom action installer in $($f.FullName)"
    }
}
$tests = Get-Content -LiteralPath (Join-Path $repo 'launcher.Tests\Program.cs') -Raw
if ($tests -notmatch 'TestFr568CursorRejectsGrokAgent') { Write-Error 'cursor reject test missing' }
Write-Host 'PASS FR-568 priority-agent-cli pins'
exit 0
