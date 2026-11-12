# MRB #447 pin: harvest-agent-skills fail() retryable lesson is contiguous UTF-8 no BOM.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$skill = Join-Path $root '.grok\skills\harvest-agent-skills\SKILL.md'
$raw = [System.IO.File]::ReadAllBytes($skill)
if ($raw.Length -ge 3 -and $raw[0] -eq 0xEF) { Write-Error 'SKILL.md has UTF-8 BOM' }
$text = [System.Text.Encoding]::UTF8.GetString($raw)
$needle = 'fail() must emit boolean retryable; true only for login_connect; api_licence and token_expired keep a hint and retryable false.'
if ($text -notlike ('*' + $needle + '*')) { Write-Error 'harvest-agent-skills missing contiguous fail() retryable lesson' }
Write-Host 'PASS Test-Mrb447-FailRetryableHarvest'
