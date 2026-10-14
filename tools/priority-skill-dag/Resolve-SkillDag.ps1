[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Query,
  [int]$MaxLessons = 8,
  [int]$MaxSkills = 5,
  [int]$MaxBytes = 24000,
  [switch]$AllowLarge,
  [int]$SingleFileCeiling = 20000,
  [string]$RepoRoot = ''
)
$ErrorActionPreference = 'Stop'
if (-not $RepoRoot) { $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path }
$allow = if ($AllowLarge) { 'true' } else { 'false' }
python (Join-Path $PSScriptRoot 'resolve_dag.py') $RepoRoot $Query $MaxLessons $MaxSkills $MaxBytes $allow $SingleFileCeiling
if ($LASTEXITCODE -ne 0) { throw "resolve_dag.py failed" }
