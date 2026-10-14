[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Query,
  [int]$MaxLessons = 8,
  [int]$MaxSkills = 5,
  [string]$RepoRoot = ''
)
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path }
python (Join-Path $PSScriptRoot 'resolve_dag.py') $RepoRoot $Query $MaxLessons $MaxSkills
if ($LASTEXITCODE -ne 0) { throw "resolve_dag.py failed" }
