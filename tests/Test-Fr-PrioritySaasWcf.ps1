#requires -Version 5.1
# Pin: Phase 1 Priority SaaS WCF client package + skill + refuse-without-allowlist.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$root = Join-Path $repo 'v2\apps\priority-saas-wcf'
$skill = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-saas-wcf\SKILL.md'
$docs = Join-Path $repo 'docs\skill-sources\programming\SAAS_WCF_CLIENT.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
Gate 'pkg-dir' (Test-Path -LiteralPath $root) $root
Gate 'bin' (Test-Path -LiteralPath (Join-Path $root 'bin\priority-wcf.mjs')) 'priority-wcf.mjs'
Gate 'allowlist-lib' (Test-Path -LiteralPath (Join-Path $root 'lib\allowlist.mjs')) 'allowlist.mjs'
Gate 'token-lib' (Test-Path -LiteralPath (Join-Path $root 'lib\token.mjs')) 'token.mjs'
Gate 'session-lib' (Test-Path -LiteralPath (Join-Path $root 'lib\session.mjs')) 'session.mjs'
Gate 'readme' (Test-Path -LiteralPath (Join-Path $root 'README.md')) 'README'
Gate 'example' (Test-Path -LiteralPath (Join-Path $root 'instances.example.json')) 'instances.example.json'
Gate 'skill' (Test-Path -LiteralPath $skill) $skill
Gate 'docs' (Test-Path -LiteralPath $docs) $docs
$bin = if (Test-Path (Join-Path $root 'bin\priority-wcf.mjs')) { [IO.File]::ReadAllText((Join-Path $root 'bin\priority-wcf.mjs')) } else { '' }
$al = if (Test-Path (Join-Path $root 'lib\allowlist.mjs')) { [IO.File]::ReadAllText((Join-Path $root 'lib\allowlist.mjs')) } else { '' }
$rd = if (Test-Path (Join-Path $root 'README.md')) { [IO.File]::ReadAllText((Join-Path $root 'README.md')) } else { '' }
$sk = if (Test-Path $skill) { [IO.File]::ReadAllText($skill) } else { '' }
Gate 'accessToken' ($bin -match 'accessToken' -or (Test-Path (Join-Path $root 'lib\session.mjs')) -and ([IO.File]::ReadAllText((Join-Path $root 'lib\session.mjs')) -match 'accessToken')) 'login uses accessToken'
Gate 'refuse-no-file' ($al -match 'no_instances_file') 'allowlist refuses missing file'
Gate 'no-invent' ($rd -match '(?i)never invent' -or $sk -match '(?i)never invent') 'docs say never invent host/tenant'
Gate 'oidc-first' ($rd -match 'priority-saas-oidc-login' -and $sk -match 'priority-saas-oidc-login') 'points at OIDC skill'
Gate 'no-hardcoded-d-ai' ($bin -notmatch 'D:\\ai' -and $al -notmatch 'D:\\ai') 'no hardcoded D:\ai'
# Phase 2 FR #339
$prepLib = Join-Path $root 'lib\prepare.mjs'
$procLib = Join-Path $root 'lib\proc.mjs'
$gateLib = Join-Path $root 'lib\gate.mjs'
$walkLib = Join-Path $root 'lib\proc-walk.mjs'
Gate 'prepare-lib' (Test-Path -LiteralPath $prepLib) 'prepare.mjs'
Gate 'proc-lib' (Test-Path -LiteralPath $procLib) 'proc.mjs'
Gate 'gate-lib' (Test-Path -LiteralPath $gateLib) 'gate.mjs'
Gate 'walk-lib' (Test-Path -LiteralPath $walkLib) 'proc-walk.mjs'
Gate 'prepare-cli' ($bin -match 'cmdPrepare' -and $bin -match 'prepare form') 'CLI prepare form'
Gate 'proc-cli' ($bin -match 'cmdProc' -and $bin -match 'proc start') 'CLI proc start'
Gate 'no-phase2-stub' ($bin -notmatch 'not_implemented') 'prepare/proc implemented'
Gate 'formprep-errs' ((Test-Path $prepLib) -and ([IO.File]::ReadAllText($prepLib) -match 'FORMPREPERRS')) 'FORMPREPERRS scrape'
Gate 'prepared-claim' ((Test-Path $prepLib) -and ([IO.File]::ReadAllText($prepLib) -match 'preparedClaim')) 'preparedClaim gate'
$docsTxt = if (Test-Path $docs) { [IO.File]::ReadAllText($docs) } else { '' }
Gate 'phase2-docs' ($rd -match 'Phase 2' -and $docsTxt -match 'prepare form') 'README/docs Phase 2'
$dagIndex = Join-Path $repo 'docs\skill-sources\medatech-network\_dag\dag-index.json'
Gate 'dag-index' (Test-Path -LiteralPath $dagIndex) $dagIndex
if (Test-Path -LiteralPath $dagIndex) {
  $dagTxt = [IO.File]::ReadAllText($dagIndex)
  Gate 'dag-skill-node' ($dagTxt -match 'skill:priority-saas-wcf') 'dag-index lists skill:priority-saas-wcf'
  Gate 'dag-oidc-node' ($dagTxt -match 'skill:priority-saas-oidc-login') 'dag-index lists skill:priority-saas-oidc-login'
}
# CLI refuse without allowlist (node present)
$node = Get-Command node -ErrorAction SilentlyContinue
if ($node) {
  $env:PRIORITY_SAAS_WCF_INSTANCES = Join-Path $env:TEMP ("no-saas-wcf-{0}.json" -f [guid]::NewGuid())
  $out = & node (Join-Path $root 'bin\priority-wcf.mjs') probe --instance x 2>&1 | Out-String
  $code = $LASTEXITCODE
  Remove-Item Env:PRIORITY_SAAS_WCF_INSTANCES -ErrorAction SilentlyContinue
  Gate 'cli-refuse' ($code -ne 0 -and $out -match 'no_instances_file') "exit=$code refuse missing allowlist"
} else {
  Gate 'cli-refuse' $true 'skipped (no node)'
}
if ($failed -gt 0) { Write-Host "Test-Fr-PrioritySaasWcf FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr-PrioritySaasWcf PASS'
exit 0
