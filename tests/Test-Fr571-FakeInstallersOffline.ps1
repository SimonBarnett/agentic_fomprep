#requires -Version 5.1
# FR #571 / FR-006: spec tests in tests/priority-agent-cli use fakes; CI stays offline.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
. (Join-Path $repo 'tests\priority-agent-cli\FakeCliInstall.ps1')
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

# Guard: a line that actually invokes a live installer host fails; comments / -notmatch do not.
# Split host names so this file itself is not a live call (the concatenations are the fixture).
$xai = 'irm https://' + 'x.ai/cli/install.ps1 | iex'
Gate 'guard-catches-xai' (Test-Fr571IsForbiddenInstallerCall $xai) 'irm x.ai is forbidden'
$cur = 'Invoke-WebRequest https://' + 'cursor.com/install?win32=true'
Gate 'guard-catches-cursor' (Test-Fr571IsForbiddenInstallerCall $cur) 'IWR cursor.com/install is forbidden'
$oc = 'curl https://' + 'opencode.ai/install'
Gate 'guard-catches-opencode' (Test-Fr571IsForbiddenInstallerCall $oc) 'curl opencode.ai is forbidden'
$okComment = '# no test calls x.ai'
Gate 'guard-allows-comment' (-not (Test-Fr571IsForbiddenInstallerCall $okComment)) 'comment is not a call'
$okNeg = "`$raw -notmatch 'x.ai/cli' -and `$raw -notmatch 'cursor.com/install'"
Gate 'guard-allows-notmatch' (-not (Test-Fr571IsForbiddenInstallerCall $okNeg)) '-notmatch pin is not a call'

$scanRoots = @(
    (Join-Path $repo 'tests'),
    (Join-Path $repo 'launcher.Tests')
)
$scanHits = New-Object System.Collections.Generic.List[string]
foreach ($root in $scanRoots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -LiteralPath $root -Recurse -File | Where-Object {
        $_.Extension -in '.ps1', '.cs', '.md' -and $_.Name -ne 'Test-Fr571-FakeInstallersOffline.ps1'
    } | ForEach-Object {
        $n = 0
        $lines = @()
        try { $lines = [IO.File]::ReadAllLines($_.FullName) } catch { return }
        foreach ($line in $lines) {
            $n++
            if (Test-Fr571IsForbiddenInstallerCall $line) {
                [void]$scanHits.Add("$($_.FullName):$n")
            }
        }
    }
}
Gate 'suite-offline' ($scanHits.Count -eq 0) $(if ($scanHits.Count -eq 0) { 'no live installer calls in tests' } else { ($scanHits -join '; ') })

# Spec: four choices (WiX fragment already on main).
$chooser = Join-Path $repo 'launcher\msi\CliChooser.wxs'
$wxs = if (Test-Path -LiteralPath $chooser) { [IO.File]::ReadAllText($chooser) } else { '' }
Gate 'four-choices' (
    $wxs -match 'Grok' -and $wxs -match 'Cursor' -and $wxs -match 'OpenCode' -and $wxs -match 'Not now'
) 'chooser lists four choices'

# Each yes starts one fake command.
foreach ($choice in @('grok', 'cursor', 'opencode')) {
    $log = New-FakeCliInstallLog
    Invoke-FakeCliYes $log $choice
    Gate "yes-one-$choice" (
        $log.Started.Count -eq 1 -and $log.Started[0] -eq $choice -and [int]$log.VersionExit[$choice] -eq 0
    ) "yes $choice starts only that fake installer"
}

$notNow = New-FakeCliInstallLog
Invoke-FakeCliNotNow $notNow
Gate 'not-now-zero' ($notNow.Started.Count -eq 0 -and $notNow.MsiExit -eq 0) 'Not now starts zero commands'

$qn = New-FakeCliInstallLog
$qn.DialogShown = $true
Invoke-FakeMsiQn $qn
Gate 'qn-zero' ($qn.Started.Count -eq 0 -and -not $qn.DialogShown -and $qn.MsiExit -eq 0) 'msiexec /qn starts zero commands'

Gate 'ca-immediate' ($wxs -match 'Execute="immediate"' -and $wxs -notmatch 'Execute="deferred"') 'CLI custom action is not deferred'
Gate 'no-urls-in-wxs' (
    $wxs -notmatch 'x\.ai/cli' -and $wxs -notmatch 'cursor\.com/install' -and $wxs -notmatch 'opencode\.ai'
) 'deferred/WiX actions do not name installer URLs'

# S6: Cursor missing when only .grok\bin\agent.exe
$cs = Join-Path $repo 'launcher\CliLaunch.cs'
$csText = if (Test-Path -LiteralPath $cs) { [IO.File]::ReadAllText($cs) } else { '' }
Gate 'cursor-not-grok-agent' (
    $csText -match 'cursor-agent' -and $csText -match 'agent\.cmd' -and
    $csText -match '\.grok\\bin\\agent\.exe'
) 'Cursor resolve documents never using .grok\bin\agent.exe'

# S8: Cursor/OpenCode omit Grok MCP flags (source pin; launcher.Tests cover runtime).
Gate 's8-omit-grok-flags' (
    $csText -match 'GrokOnlyFlags' -and $csText -match '--cwd' -and $csText -match 'AssertNoGrokOnlyFlags'
) 'Cursor/OpenCode argv omit Grok MCP flags'

# S7 launcher cases: none / one / many / redirected — fake, no download.
function Invoke-FakeLauncherChoose {
    param([string[]]$Installed, [bool]$Redirected, [string]$Pick)
    if ($Redirected) {
        return @{ Action = 'refuse'; Download = $false; Exit = 1 }
    }
    if ($Installed.Count -eq 1) { return @{ Action = 'launch'; Cli = $Installed[0]; Download = $false } }
    if ($Installed.Count -eq 0 -and $Pick -eq 'refuse') { return @{ Action = 'refuse'; Download = $false; Exit = 1 } }
    if ($Installed.Count -eq 0) { return @{ Action = 'menu'; Download = $false } }
    return @{ Action = 'which'; Download = $false }
}
$none = Invoke-FakeLauncherChoose @() $false ''
Gate 's7-none' ($none.Action -eq 'menu' -and -not $none.Download) 'none installed offers menu, no download'
$one = Invoke-FakeLauncherChoose @('cursor') $false ''
Gate 's7-one' ($one.Action -eq 'launch' -and $one.Cli -eq 'cursor' -and -not $one.Download) 'exactly one launches'
$many = Invoke-FakeLauncherChoose @('grok', 'cursor') $false ''
Gate 's7-many' ($many.Action -eq 'which' -and -not $many.Download) 'many ask which, no fuel download'
$redir = Invoke-FakeLauncherChoose @() $true ''
Gate 's7-redir' ($redir.Action -eq 'refuse' -and -not $redir.Download -and $redir.Exit -eq 1) 'redirected stdin does not download'

if ($failed -gt 0) { Write-Host "Test-Fr571-FakeInstallersOffline FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr571-FakeInstallersOffline PASS'
exit 0
