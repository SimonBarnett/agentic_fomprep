#requires -Version 5.1
# P2-T2: off-DEV fixture. Ignore Duplicate Values must match dangerousDialog and never be an OK-click.
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
$selPath = Join-Path $script:RepoRoot 'src\web\selectors.json'
$sel = Get-Content -LiteralPath $selPath -Raw | ConvertFrom-Json
$re = New-Object System.Text.RegularExpressions.Regex $sel.dangerousDialog, 'IgnoreCase'
foreach ($text in @('Ignore Duplicate Values', 'IGNORE_DUP_KEY', 'index rebuild', 'trigger compile')) {
    if (-not $re.IsMatch($text)) { throw "AT3 fixture: '$text' did not match dangerousDialog" }
}
if ($re.IsMatch('Show Reports')) { throw 'AT3 fixture: Show Reports must not be dangerous' }
if ($re.IsMatch('OK')) { throw 'AT3 fixture: OK must not be dangerous' }
Write-Host 'AT3 PASS fixture Ignore Duplicate Values -> blocked-run (no click)'
exit 0
