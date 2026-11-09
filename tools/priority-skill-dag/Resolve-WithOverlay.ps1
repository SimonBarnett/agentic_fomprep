# FR #362: merge public resolve_skills with a local customer overlay (never POST overlay to MCP).
[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$Task,
  [string]$OverlayRoot = $env:PRIORITY_CUSTOMER_ROOT,
  [string]$ProjectFolder = $env:PRIORITY_PROJECT_FOLDER,
  [string]$McpUrl = $(if ($env:PRIORITY_MCP_URL) { $env:PRIORITY_MCP_URL } else { 'https://mcp.ntsa.uk' }),
  [string]$PublicJson = '',
  [switch]$PublicEmpty,
  [int]$MaxLessons = 8,
  [int]$MaxSkills = 5,
  [int]$MaxBytes = 24000
)
$ErrorActionPreference = 'Stop'
$repo = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$script = Join-Path $PSScriptRoot 'resolve-with-overlay.mjs'
$args = @($script, '--task', $Task, '--max-lessons', "$MaxLessons", '--max-skills', "$MaxSkills", '--max-bytes', "$MaxBytes")
if ($OverlayRoot) { $args += @('--overlay', $OverlayRoot) }
if ($ProjectFolder) { $args += @('--project', $ProjectFolder) }
if ($PublicJson) { $args += @('--public-json', $PublicJson) }
elseif ($PublicEmpty) { $args += '--public-empty' }
else { $args += @('--mcp-url', $McpUrl) }
& node @args
if ($LASTEXITCODE -ne 0) { throw "resolve-with-overlay.mjs failed ($LASTEXITCODE)" }
