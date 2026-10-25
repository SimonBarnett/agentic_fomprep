#requires -Version 5.1
# Hostile pin for MRB agentic_fomprep#208: SaaS OIDC harvest + CAT-T51 no BOM.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
function HasBom([string]$Path) {
  $b = [IO.File]::ReadAllBytes($Path)
  return ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF)
}
$src = Join-Path $repo 'docs\skill-sources\programming\SAAS_OIDC_LOGIN.md'
$catSkill = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-oidc-login\SKILL.md'
$catMeta = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-oidc-login\meta.json'
$odataMeta = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-odata-dev\meta.json'
$grok = Join-Path $repo '.grok\skills\priority-saas-oidc-login\SKILL.md'
Gate 'src-exists' (Test-Path $src) $src
Gate 'catalog-skill' (Test-Path $catSkill) $catSkill
Gate 'catalog-meta' (Test-Path $catMeta) $catMeta
Gate 'grok-sync' (Test-Path $grok) $grok
Gate 'saas-meta-no-bom' (-not (HasBom $catMeta)) 'saas meta.json no BOM'
Gate 'odata-meta-no-bom' (-not (HasBom $odataMeta)) 'odata-dev meta.json no BOM (CAT-T51)'
$blob = [IO.File]::ReadAllText($src) + [IO.File]::ReadAllText($catSkill)
Gate 'no-password-eq' ($blob -notmatch '(?i)password\s*=') 'no password= hunter literal'
Gate 'placeholders' ($blob -match '<password>' -or $blob -match '<user>' -or $blob -match '<digits>') 'placeholder secrets only'
Gate 'never-invent-host' ($blob -match 'Never invent host') 'hard rule invent host'
Gate 'tokens-outside-git' ($blob -match 'C:\\passwords' -or $blob -match 'outside git') 'tokens outside git'
Gate 'pkce-priority-web' ($blob -match 'priority-web' -and $blob -match 'PKCE') 'WebUI client + PKCE'
Gate 'generic-not-customer' ($blob -match 'any SaaS' -or $blob -match 'generic') 'Priority-generic naming'
if ($failed -gt 0) { Write-Host "Test-Mrb208-SaasOidcLogin FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb208-SaasOidcLogin PASS'
exit 0
