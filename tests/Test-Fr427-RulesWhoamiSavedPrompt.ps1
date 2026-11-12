#requires -Version 5.1
# FR #427 / FR-045: WcfSupport.RenderSessionRules uses whoami + --request;
# empty Priority USERLOGIN accepts saved login; no "No default login is used".
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path $PSScriptRoot -Parent }
$failed = 0
function Gate([string]$Name, [bool]$Ok, [string]$Detail) {
  if ($Ok) { Write-Host "PASS $Name" }
  else { Write-Host "FAIL $Name : $Detail"; $script:failed++ }
}

$wcfPath = Join-Path $repo 'launcher\WcfSupport.cs'
Gate 'wcf-support' (Test-Path -LiteralPath $wcfPath) 'WcfSupport.cs missing'
$wcf = Get-Content -LiteralPath $wcfPath -Raw
Gate 'example-whoami' ($wcf -match 'whoami') 'RenderSessionRules must show whoami example'
Gate 'example-request' ($wcf -match '--request') 'RenderSessionRules must show --request example'
Gate 'saved-prompt' (
  $wcf -match 'Priority USERLOGIN' -and
  $wcf -match 'saved login' -and
  ($wcf -match 'empty answer' -or $wcf -match 'An empty answer')
) 'must state empty Priority USERLOGIN answer accepts saved login'
Gate 'no-default-login-sentence' ($wcf -notmatch 'No default login is used') 'must not say No default login is used in RenderSessionRules'

$testsPath = Join-Path $repo 'launcher.Tests\Program.cs'
Gate 'launcher-tests' (Test-Path -LiteralPath $testsPath) 'launcher.Tests/Program.cs missing'
$tests = Get-Content -LiteralPath $testsPath -Raw
Gate 'tests-fr045' ($tests -match 'TestFr045RulesWhoamiAndSavedPrompt' -and $tests -match 'No default login is used') 'launcher.Tests must pin FR-045 whoami/saved-prompt gates'

$dotnet = Get-Command dotnet -ErrorAction SilentlyContinue
if ($dotnet) {
  Push-Location (Join-Path $repo 'launcher.Tests')
  try {
    & dotnet run --project PriorityAgent.Tests.csproj -c Release
    Gate 'dotnet-launcher-tests' ($LASTEXITCODE -eq 0) "dotnet exit $LASTEXITCODE"
  } finally { Pop-Location }
} else {
  Write-Host 'SKIP dotnet-launcher-tests (dotnet not installed)'
}

if ($failed -gt 0) { Write-Host "Test-Fr427-RulesWhoamiSavedPrompt FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr427-RulesWhoamiSavedPrompt PASS'
exit 0
