# FR #348: Priority Agent drops airc remote-shell; uses fom-prep priority-wcf.mjs allowlist.
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
Gate 'brief-mjs' ($prog -match 'priority-wcf.mjs' -and $prog -match 'priority-saas-wcf') 'Program brief must cite priority-wcf.mjs'

$rules = Get-Content -LiteralPath (Join-Path $launcher 'agent-rules.md') -Raw
Gate 'wcf-section' ($rules -match '\{\{WCF_SECTION\}\}') 'agent-rules need {{WCF_SECTION}}'
Gate 'no-airc-section' ($rules -notmatch '\{\{AIRC_SECTION\}\}') 'agent-rules still have {{AIRC_SECTION}}'
$m = [regex]::Match($rules, 'rules-version:\s*(\d+)')
Gate 'rules-version-ge-7' ($m.Success -and [int]$m.Groups[1].Value -ge 7) "rules-version=$($m.Groups[1].Value)"

$readme = Get-Content -LiteralPath (Join-Path $launcher 'README.md') -Raw
Gate 'readme-wcf' ($readme -match 'priority-wcf.mjs' -and $readme -match 'tokenFile' -and $readme -match 'priority-saas-wcf') 'README missing fom-prep WCF allowlist'
Gate 'readme-no-airc-opt' ($readme -notmatch 'airc_consoles' -and $readme -notmatch 'Does this session need airc' -and $readme -notmatch 'bobiverse-airc-commands') 'README still documents old airc discovery path'
Gate 'readme-no-6026-route' ($readme -notmatch '"mode": "direct"' -and $readme -notmatch '"mode": "relay"') 'README still shows bobiverse direct/relay as the route'

$wcf = Get-Content -LiteralPath (Join-Path $launcher 'WcfSupport.cs') -Raw
Gate 'client-path-const' ($wcf -match 'ClientPath = "v2/apps/priority-saas-wcf/bin/priority-wcf.mjs"') 'ClientPath const missing'
Gate 'rules-forbid-6026-py' ($wcf -match 'priority_wcf\.py' -and $wcf -match '#6026') 'rules must explicitly forbid bobiverse priority_wcf.py'
Gate 'harvest-rules' ($wcf -match 'bob.ntsa.uk/bob/v1/intake' -and $wcf -match 'Report-FomprepIntakeIssue' -and $wcf -match 'Invoke-FomprepHarvest') 'WcfSupport rules must include harvest-on-client'
Gate 'legacy-warn' ($wcf -match 'airc_console' -and $wcf -match 'ignored') 'WcfSupport must warn on legacy airc fields'
Gate 'no-creds-in-json' (($wcf -match 'Never' -or $wcf -match 'never') -and ($wcf -match 'tokenFile' -or $wcf -match 'PRIORITY_SAAS_TOKEN')) 'WcfSupport must say tokens stay out of JSON'
Gate 'reject-6026-shape' ($wcf -match 'serverUrl' -and $wcf -match '#6026') 'WcfSupport must reject serverUrl/mode rows'

$csproj = Get-Content -LiteralPath (Join-Path $launcher 'PriorityAgent.csproj') -Raw
Gate 'csproj-no-airc-embed' ($csproj -notmatch 'airc-dcc') 'csproj still embeds airc-dcc.md'

if ($failed -gt 0) { Write-Host "Test-Fr348-DropAircUseWcf FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr348-DropAircUseWcf PASS'
exit 0
