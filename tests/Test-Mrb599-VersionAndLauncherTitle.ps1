#requires -Version 5.1
# MRB #599 / FR #598 hostile pin: root VERSION + Priority Agent launcher release title.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$verPath = Join-Path $repo 'VERSION'
Gate 'version-file' (Test-Path -LiteralPath $verPath) 'root VERSION exists'
$verText = ''
if (Test-Path -LiteralPath $verPath) {
    $verText = ([IO.File]::ReadAllText($verPath)).Trim()
}
Gate 'version-semver' ($verText -match '^\d+\.\d+\.\d+$') "VERSION is X.Y.Z (got '$verText')"
# Must be at least the baseline landed by #599 (1.0.74); later UAT bumps may raise it.
Gate 'version-floor' (
    $verText -match '^(\d+)\.(\d+)\.(\d+)$' -and (
        ([int]$Matches[1] -gt 1) -or
        ([int]$Matches[1] -eq 1 -and [int]$Matches[2] -gt 0) -or
        ([int]$Matches[1] -eq 1 -and [int]$Matches[2] -eq 0 -and [int]$Matches[3] -ge 74)
    )
) "VERSION >= 1.0.74 (got '$verText')"

$wfPath = Join-Path $repo '.github\workflows\launcher-release.yml'
Gate 'wf-exists' (Test-Path -LiteralPath $wfPath) 'launcher-release.yml exists'
$wf = if (Test-Path -LiteralPath $wfPath) { [IO.File]::ReadAllText($wfPath) } else { '' }
Gate 'wf-title-priority-agent' (
    $wf -match 'Priority Agent launcher v\$ver' -or
    $wf -match 'Priority Agent launcher v\$\{'
) 'release create title uses Priority Agent launcher vX.Y.Z'
Gate 'wf-strip-prefix' ($wf -match "\-replace\s+'?\^launcher-v'?" -or $wf -match 'replace ''\^launcher-v''') 'strips launcher-v prefix for title version'
Gate 'wf-not-raw-tag-title' ($wf -notmatch '--title \$tag') 'does not title release with raw \$tag'

if ($failed -gt 0) { Write-Host "Test-Mrb599-VersionAndLauncherTitle FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb599-VersionAndLauncherTitle PASS'
exit 0
