#requires -Version 5.1
# FR #572 / FR-007: README and release note for the MSI extra asset.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$readme = [IO.File]::ReadAllText((Join-Path $repo 'launcher\README.md'))
$wf = [IO.File]::ReadAllText((Join-Path $repo '.github\workflows\launcher-release.yml'))
Gate 'install-dir' ($readme -match [regex]::Escape('C:\Program Files\Priority Agent')) 'README names install directory'
Gate 'four-choices' (
    $readme -match 'Grok' -and $readme -match 'Cursor' -and $readme -match 'OpenCode' -and $readme -match 'Not now'
) 'README names Grok, Cursor, OpenCode, Not now'
Gate 'qn-no-download' ($readme -match '/qn' -and $readme -match 'download') 'README says /qn does not download a CLI'
Gate 'msi-named' ($readme -match '\bMSI\b') 'README names the MSI'
Gate 'exe-stays-readme' ($readme -match 'pre-release' -and $readme -match 'PriorityAgent\.exe') 'README keeps the exe pre-release'
Gate 'wf-additional' (
    $wf -match 'additional asset' -or $wf -match 'MSI is an additional' -or $wf -match 'MSI as an additional'
) 'release workflow text says the MSI is an additional asset'
Gate 'wf-exe-stays' ($wf -match 'PriorityAgent\.exe' -and ($wf -match 'loose exe' -or $wf -match 'exe stays' -or $wf -match 'exe pre-release')) 'loose exe stays in the release note'

if ($failed -gt 0) { Write-Host "Test-Fr572-MsiReadmeRelease FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr572-MsiReadmeRelease PASS'
exit 0
