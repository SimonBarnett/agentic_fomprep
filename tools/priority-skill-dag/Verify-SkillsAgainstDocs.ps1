[CmdletBinding()]
param([string]$RepoRoot = '')
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path }
python (Join-Path $PSScriptRoot 'verify_skills.py') $RepoRoot
if ($LASTEXITCODE -ne 0) { throw "verify_skills.py failed" }
