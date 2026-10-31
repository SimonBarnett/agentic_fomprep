#requires -Version 5.1
<#
.SYNOPSIS
  FR #247: assert (or apply) main branch protection so gh pr merge --auto works.
#>
[CmdletBinding()]
param(
    [switch]$Apply,
    [string]$Owner = 'SimonBarnett',
    [string]$Repo = 'agentic_fomprep',
    [string]$Branch = 'main'
)
$ErrorActionPreference = 'Stop'
$repoSlug = "$Owner/$Repo"
$prot = $null
$exists = $false
try {
    $prot = gh api "repos/$repoSlug/branches/$Branch/protection" | ConvertFrom-Json
    $exists = $true
} catch {
    $exists = $false
}
if (-not $exists -and $Apply) {
    $json = @'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 0
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": false
}
'@
    $tmp = Join-Path ([IO.Path]::GetTempPath()) 'fomprep-main-protection.json'
    [IO.File]::WriteAllText($tmp, $json)
    $prot = gh api --method PUT "repos/$repoSlug/branches/$Branch/protection" --input $tmp | ConvertFrom-Json
    $exists = $true
    Write-Host "APPLIED protection on $repoSlug $Branch"
}
if (-not $exists) {
    Write-Error "FR #247: $Branch is not protected; gh pr merge --auto will GraphQL-fail enablePullRequestAutoMerge. Re-run with -Apply (admin) or see docs/merge-on-green.md."
    exit 2
}
$reviews = $prot.required_pull_request_reviews
if (-not $reviews) {
    Write-Error "FR #247: protection exists but required_pull_request_reviews is missing."
    exit 3
}
Write-Host "OK $repoSlug $Branch protected (reviews=$($reviews.required_approving_review_count); enablePullRequestAutoMerge can be used)"
exit 0
