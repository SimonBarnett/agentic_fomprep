#requires -Version 5.1
# FR agentic_fomprep#267: stamp Version from launcher-v* tag.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
. (Join-Path $repo 'launcher\Get-LauncherReleaseVersion.ps1')
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

Gate 'tag-101' ((Get-LauncherReleaseVersion -Tag 'launcher-v1.0.1') -eq '1.0.1') 'launcher-v1.0.1 -> 1.0.1'
Gate 'tag-file' ((Get-LauncherFileVersion -Version '1.0.1') -eq '1.0.1.0') 'FileVersion X.Y.Z.0'
Gate 'info-sha' ((Get-LauncherInformationalVersion -Version '1.0.1' -Sha '51d4fdaf782016a20a7b4d05f25fd592dfbc23c9') -eq '1.0.1+51d4fdaf782016a20a7b4d05f25fd592dfbc23c9') 'ProductVersion X.Y.Z+sha'
Gate 'no-tag' ((Get-LauncherReleaseVersion -Tag '' ) -eq '1.0.0') 'local default 1.0.0'
Gate 'bad-tag' ((Get-LauncherReleaseVersion -Tag 'v1.0.1') -eq '1.0.0') 'non-launcher tag falls back'

$build = [IO.File]::ReadAllText((Join-Path $repo 'launcher\build.ps1'))
$wf = [IO.File]::ReadAllText((Join-Path $repo '.github\workflows\launcher-release.yml'))
$prog = [IO.File]::ReadAllText((Join-Path $repo 'launcher\Program.cs'))
Gate 'build-version-param' ($build -match '\[string\]\$Version' -and $build -match 'p:Version=') 'build.ps1 -Version'
Gate 'wf-tag-version' ($wf -match 'Get-LauncherReleaseVersion' -and $wf -match 'p:FileVersion=' -and $wf -match 'p:InformationalVersion=') 'workflow stamps from tag'
Gate 'banner-xyz' ($prog -match 'LauncherBannerVersion' -and $prog -match 'InformationalVersionAttribute' -and $prog -match 'Header\(\$\"Priority Agent launcher \{LauncherBannerVersion\(\)\}') 'banner is X.Y.Z not Assembly 4-part'
Gate 'wf-dispatch-tag' ($wf -match 'INPUT_TAG' -and $wf -match 'GITHUB_REF_TYPE') 'dispatch tag stamps the exe'

if ($failed -gt 0) { Write-Host "Test-Fr267-LauncherVersion FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr267-LauncherVersion PASS'
exit 0
