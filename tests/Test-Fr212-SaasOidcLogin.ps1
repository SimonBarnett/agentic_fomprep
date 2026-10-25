#requires -Version 5.1
# FR #212: catalog skill priority-saas-oidc-login is listed and hostile-pinned.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$src = Join-Path $repo 'docs\skill-sources\programming\SAAS_OIDC_LOGIN.md'
$catSkill = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-oidc-login\SKILL.md'
$catMeta = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-oidc-login\meta.json'
$odata = Join-Path $repo 'docs\skill-sources\programming\ODATA_REST_CLOUD.md'
$expected = Join-Path $repo 'v2\tools\Test-PriorityCatalog.ps1'
Gate 'src' (Test-Path $src) $src
Gate 'catalog-skill' (Test-Path $catSkill) $catSkill
Gate 'catalog-meta' (Test-Path $catMeta) $catMeta
$sk = [IO.File]::ReadAllText($catSkill)
$md = [IO.File]::ReadAllText($src)
$blob = $sk + $md
Gate 'get-skill-id' ($sk -match 'priority-saas-oidc-login') 'catalog list / get_skill name'
Gate 'foundation' ($sk -match 'Foundation: harvest-priority-skills' -and $sk -match 'SimonBarnett/agentic_fomprep') 'honesty-box foundation line'
Gate 'otp-single-use' ($blob -match 'single-use') 'OTP single-use'
Gate 'prefer-pat' ($blob -match 'Prefer PAT') 'prefer PAT for unattended OData'
Gate 'no-password-eq' ($blob -notmatch '(?i)password\s*=') 'no password= secret literal (FR #3304)'
Gate 'cross-link-odata' ((Test-Path $odata) -and ([IO.File]::ReadAllText($odata) -match 'priority-saas-oidc-login' -or [IO.File]::ReadAllText($odata) -match 'OIDC')) 'ODATA_REST_CLOUD cross-link'
Gate 'catalog-gate-lists' ((Test-Path $expected) -and ([IO.File]::ReadAllText($expected) -match 'priority-saas-oidc-login')) 'Test-PriorityCatalog expected includes skill'
if ($failed -gt 0) { Write-Host "Test-Fr212-SaasOidcLogin FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr212-SaasOidcLogin PASS'
exit 0
