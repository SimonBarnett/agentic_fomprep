#requires -Version 5.1
# Pin for FR agentic_fomprep#247: main auto-merge needs branch protection + docs.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}
$agents = Join-Path $repo 'AGENTS.md'
$doc = Join-Path $repo 'docs\merge-on-green.md'
$tool = Join-Path $repo 'tools\Assert-FomprepMainAutoMerge.ps1'
$ag = if (Test-Path -LiteralPath $agents) { [IO.File]::ReadAllText($agents) } else { '' }
$md = if (Test-Path -LiteralPath $doc) { [IO.File]::ReadAllText($doc) } else { '' }
$ps = if (Test-Path -LiteralPath $tool) { [IO.File]::ReadAllText($tool) } else { '' }
Gate 'agents-exists' (Test-Path -LiteralPath $agents) $agents
Gate 'doc-exists' (Test-Path -LiteralPath $doc) $doc
Gate 'tool-exists' (Test-Path -LiteralPath $tool) $tool
Gate 'agents-enablePullRequestAutoMerge' ($ag -match 'enablePullRequestAutoMerge') 'AGENTS names GraphQL error'
Gate 'agents-auto-merge' ($ag -match 'gh pr merge' -and $ag -match '--auto') 'AGENTS MRB --auto'
Gate 'agents-no-validate-required' ($ag -match 'validate' -and $ag -match 'launcher') 'do not require launcher validate'
Gate 'doc-243' ($md -match '243' -and $md -match 'Protected branch rules not configured') 'docs the #243 failure'
Gate 'doc-apply' ($md -match 'Assert-FomprepMainAutoMerge' -and $md -match '-Apply') 'docs apply path'
Gate 'tool-put' ($ps -match 'branches/.+protection' -and $ps -match 'required_approving_review_count') 'tool PUTs classic protection'
if ($failed -gt 0) { Write-Host "Test-Fr247-MainAutoMergeProtection FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr247-MainAutoMergeProtection PASS'
exit 0
