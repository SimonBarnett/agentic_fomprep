#requires -Version 5.1
# FR priority-mcp#567 / FR-002: MSI chooser for Grok, Cursor, OpenCode, Not now.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent (Split-Path -Parent $PSScriptRoot) }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$chooser = Join-Path $repo 'launcher\msi\CliChooser.wxs'
Gate 'chooser-wxs' (Test-Path -LiteralPath $chooser) 'launcher/msi/CliChooser.wxs exists'
if (-not (Test-Path -LiteralPath $chooser)) {
    Write-Host "Test-Fr567-MsiCliChooser FAIL ($failed)"
    exit 1
}

$bytes = [IO.File]::ReadAllBytes($chooser)
$hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
Gate 'no-bom' (-not $hasBom) 'UTF-8 without BOM'
$raw = [Text.Encoding]::UTF8.GetString($bytes)
Gate 'four-choices' (
    $raw -match 'Grok' -and $raw -match 'Cursor' -and $raw -match 'OpenCode' -and
    ($raw -match 'Not now' -or $raw -match 'Not Now')
) 'dialog text names Grok, Cursor, OpenCode, Not now'
Gate 'dialog' ($raw -match 'Dialog\s+Id="CliChooserDlg"') 'CliChooserDlg present'
Gate 'property' ($raw -match 'Property\s+Id="PRIORITYAGENT_CLI"') 'PRIORITYAGENT_CLI records the choice'
Gate 'values' (
    $raw -match 'Value="grok"' -and $raw -match 'Value="cursor"' -and
    $raw -match 'Value="opencode"' -and $raw -match 'Value="none"'
) 'exactly one of grok|cursor|opencode|none'
Gate 'default-none' ($raw -match 'Property\s+Id="PRIORITYAGENT_CLI"[^>]*Value="none"') 'default Not now (none)'
Gate 'cli-action' ($raw -match 'CustomAction\s+Id="InstallChosenCli"') 'InstallChosenCli custom action declared'
Gate 'silent-absent' (
    $raw -match 'UILevel\s*&gt;\s*3' -or $raw -match 'UILevel\s*>\s*3' -or
    $raw -match 'UILevel\s*&gt;\s*"3"' -or $raw -match "UILevel\s*>\s*3"
) 'CLI action conditioned UILevel > 3 (absent under msiexec /qn)'
Gate 'none-skips' (
    ($raw -match 'PRIORITYAGENT_CLI\s*&lt;&gt;\s*"none"' -or $raw -match 'PRIORITYAGENT_CLI\s*<>\s*"none"') -or
    ($raw -match 'NOT\s+PRIORITYAGENT_CLI\s*=\s*"none"' -or $raw -match 'PRIORITYAGENT_CLI\s*~=\s*"none"')
) 'Not now (none) does not schedule InstallChosenCli'
Gate 'no-live-urls' (
    $raw -notmatch 'x\.ai/cli' -and $raw -notmatch 'cursor\.com/install' -and
    $raw -notmatch 'opencode\.ai'
) 'no live installer URLs (FR-003 owns installers)'
Gate 'qn-note' ($raw -match '/qn' -or $raw -match 'silent' -or $raw -match 'UILevel') 'silent /qn path documented in source'

if ($failed -gt 0) { Write-Host "Test-Fr567-MsiCliChooser FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr567-MsiCliChooser PASS'
exit 0
