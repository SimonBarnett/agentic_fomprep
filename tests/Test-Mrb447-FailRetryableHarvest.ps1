# MRB #447 / #450 pin: harvest-agent-skills fail() retryable lesson is contiguous UTF-8 no BOM.
# Hostile: full BOM check; product classifier true only for login_connect.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$skill = Join-Path $root '.grok\skills\harvest-agent-skills\SKILL.md'
$raw = [System.IO.File]::ReadAllBytes($skill)
if ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF) {
    Write-Error 'SKILL.md has UTF-8 BOM'
}
$text = [System.Text.Encoding]::UTF8.GetString($raw)
$needle = 'fail() must emit boolean retryable; true only for login_connect; api_licence and token_expired keep a hint and retryable false.'
if ($text -notlike ('*' + $needle + '*')) { Write-Error 'harvest-agent-skills missing contiguous fail() retryable lesson' }
if ($text -match 'retryable true for api_licence') { Write-Error 'lesson must not mark api_licence retryable' }

$js = Join-Path $root 'v2\apps\priority-saas-wcf\lib\json-out.mjs'
$jst = [System.IO.File]::ReadAllText($js)
if ($jst -notmatch 'login_connect:[\s\S]{0,80}retryable:\s*true') {
    Write-Error 'json-out.mjs login_connect must be retryable true'
}
if ($jst -notmatch 'api_licence:[\s\S]{0,80}retryable:\s*false') {
    Write-Error 'json-out.mjs api_licence must be retryable false'
}
if ($jst -notmatch 'token_expired:[\s\S]{0,80}retryable:\s*false') {
    Write-Error 'json-out.mjs token_expired must be retryable false'
}
Write-Host 'PASS Test-Mrb447-FailRetryableHarvest'
