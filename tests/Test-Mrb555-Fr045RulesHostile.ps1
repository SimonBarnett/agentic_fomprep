#requires -Version 5.1
# MRB #555 hostile pins for FR-045 / #427 RenderSessionRules.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path $PSScriptRoot -Parent }
$failed = 0
function Gate([string]$Name, [bool]$Ok, [string]$Detail) {
  if ($Ok) { Write-Host "PASS $Name" }
  else { Write-Host "FAIL $Name : $Detail"; $script:failed++ }
}

$wcfPath = Join-Path $repo 'launcher\WcfSupport.cs'
$wcf = Get-Content -LiteralPath $wcfPath -Raw
# Isolate RenderSessionRules body so Program.cs "No default login is used" is out of scope.
$m = [regex]::Match($wcf, 'public static string RenderSessionRules[\s\S]*?return template')
Gate 'method-found' $m.Success 'RenderSessionRules not found'
$body = if ($m.Success) { $m.Value } else { '' }
Gate 'whoami-example' ($body -match 'whoami --instance') 'whoami example line'
Gate 'request-example' ($body -match 'batch --request') 'batch --request example line'
Gate 'no-prepare-form-example' ($body -notmatch 'prepare form --instance') 'must not keep prepare form as the example'
Gate 'empty-accepts-saved' ($body -match 'empty answer' -and $body -match 'Priority USERLOGIN' -and $body -match 'saved login') 'empty USERLOGIN accepts saved'
Gate 'no-default-sentence-in-method' ($body -notmatch 'No default login is used') 'RenderSessionRules must not contain that sentence'

$tests = Get-Content -LiteralPath (Join-Path $repo 'launcher.Tests\Program.cs') -Raw
Gate 'tests-call-render' ($tests -match 'WcfSupport.RenderSessionRules' -and $tests -match 'TestFr045RulesWhoamiAndSavedPrompt') 'launcher.Tests renders the section'

if ($failed -gt 0) { Write-Host "Test-Mrb555-Fr045RulesHostile FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb555-Fr045RulesHostile PASS'
exit 0
