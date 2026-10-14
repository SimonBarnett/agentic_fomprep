[CmdletBinding()]
param([string]$RepoRoot = '')
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path }
python (Join-Path $PSScriptRoot 'build_dag.py') $RepoRoot
if ($LASTEXITCODE -ne 0) { throw "build_dag.py failed" }
