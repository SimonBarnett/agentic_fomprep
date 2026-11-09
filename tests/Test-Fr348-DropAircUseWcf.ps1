# FR #348: Priority Agent drops airc remote-shell; uses WCF client config (direct/relay).
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path $PSScriptRoot -Parent }
$failed = 0
function Gate([string]$Name, [bool]$Ok, [string]$Detail) {
  if ($Ok) { Write-Host "PASS $Name" }
  else { Write-Host "FAIL $Name : $Detail"; $script:failed++ }
}

$launcher = Join-Path $repo 'launcher'
Gate 'airc-support-gone' (-not (Test-Path (Join-Path $launcher 'AircSupport.cs'))) 'AircSupport.cs still present'
Gate 'airc-discovery-gone' (-not (Test-Path (Join-Path $launcher 'AircConsoleDiscovery.cs'))) 'AircConsoleDiscovery.cs still present'
Gate 'airc-dcc-gone' (-not (Test-Path (Join-Path $launcher 'airc-dcc.md'))) 'airc-dcc.md still present'
Gate 'wcf-support' (Test-Path (Join-Path $launcher 'WcfSupport.cs')) 'WcfSupport.cs missing'
Gate 'launcher-support' (Test-Path (Join-Path $launcher 'LauncherSupport.cs')) 'LauncherSupport.cs missing'

$prog = Get-Content -LiteralPath (Join-Path $launcher 'Program.cs') -Raw
Gate 'reject-airc-flag' ($prog -match '--airc-console' -and $prog -match 'RemovedAircMessage') 'Program.cs must reject --airc-console'
Gate 'no-dcc-write' ($prog -notmatch 'WriteSessionFiles' -and $prog -notmatch 'DCCLISTEN') 'Program.cs must not write DCC session files'
Gate 'loads-wcf' ($prog -match 'WcfSupport\.LoadConfig' -and $prog -match 'RenderSessionRules') 'Program.cs must load WCF config'

$rules = Get-Content -LiteralPath (Join-Path $launcher 'agent-rules.md') -Raw
Gate 'wcf-section' ($rules -match '\{\{WCF_SECTION\}\}') 'agent-rules need {{WCF_SECTION}}'
Gate 'no-airc-section' ($rules -notmatch '\{\{AIRC_SECTION\}\}') 'agent-rules still have {{AIRC_SECTION}}'
$m = [regex]::Match($rules, 'rules-version:\s*(\d+)')
Gate 'rules-version-ge-7' ($m.Success -and [int]$m.Groups[1].Value -ge 7) "rules-version=$($m.Groups[1].Value)"

$readme = Get-Content -LiteralPath (Join-Path $launcher 'README.md') -Raw
Gate 'readme-wcf' ($readme -match 'serverUrl' -and $readme -match '"mode": "direct"' -and $readme -match '"mode": "relay"') 'README missing WCF examples'
Gate 'readme-no-airc-opt' ($readme -notmatch 'airc_consoles' -and $readme -notmatch 'Does this session need airc' -and $readme -notmatch 'bobiverse-airc-commands') 'README still documents old airc discovery path'

$wcf = Get-Content -LiteralPath (Join-Path $launcher 'WcfSupport.cs') -Raw
Gate 'legacy-warn' ($wcf -match 'airc_console' -and $wcf -match 'ignored') 'WcfSupport must warn on legacy airc fields'
Gate 'no-creds-in-json' (($wcf -match 'Never' -or $wcf -match 'never') -and ($wcf -match 'CredMan' -or $wcf -match 'credentials')) 'WcfSupport must say credentials stay out of JSON'

$csproj = Get-Content -LiteralPath (Join-Path $launcher 'PriorityAgent.csproj') -Raw
Gate 'csproj-no-airc-embed' ($csproj -notmatch 'airc-dcc') 'csproj still embeds airc-dcc.md'

if ($failed -gt 0) { Write-Host "Test-Fr348-DropAircUseWcf FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr348-DropAircUseWcf PASS'
exit 0
