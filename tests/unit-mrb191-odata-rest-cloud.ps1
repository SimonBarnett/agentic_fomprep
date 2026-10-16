# Hostile pin for MRB #191 - cloud OData REST patterns in priority-odata-dev
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$skill = Join-Path $root '.grok\skills\priority-odata-dev\SKILL.md'
$src = Join-Path $root 'docs\skill-sources\programming\ODATA_REST_CLOUD.md'
$cat = Join-Path $root 'v2\apps\mcp-catalog\catalog\priority-odata-dev\SKILL.md'
$meta = Join-Path $root '.grok\skills\priority-odata-dev\meta.json'

foreach ($p in @($skill, $src, $cat, $meta)) {
  if (-not (Test-Path $p)) { throw "missing $p" }
}

$skillText = [IO.File]::ReadAllText($skill)
$srcText = [IO.File]::ReadAllText($src)
$catText = [IO.File]::ReadAllText($cat)
$metaObj = Get-Content $meta -Raw | ConvertFrom-Json

$skillPins = @(
  'Never log passwords or REST tokens',
  'password=`PAT` (literal)',
  'Path segment `LIVE` is **not** a substitute for DNAME',
  'RESTFLAG` null often yields HTTP **400**',
  'FTRIG_SUBFORM',
  'FTRIGTEXT_SUBFORM',
  'Typed DOCSTATS'
)
foreach ($pin in $skillPins) {
  if ($skillText.IndexOf($pin) -lt 0) { throw "SKILL.md missing pin: $pin" }
  if ($catText.IndexOf($pin) -lt 0) { throw "catalog SKILL.md missing pin: $pin" }
}

$srcPins = @(
  'password=PAT',
  'Priority **DNAME**',
  '**HTTP 400**',
  'FTRIGTEXT_SUBFORM.TEXT',
  'ZDOCSTATS',
  '**no** OData entity'
)
foreach ($pin in $srcPins) {
  if ($srcText.IndexOf($pin) -lt 0) { throw "ODATA_REST_CLOUD.md missing pin: $pin" }
}

if ($metaObj.version -ne '1.1.0') { throw "meta.json version expected 1.1.0 got $($metaObj.version)" }

Write-Host 'unit-mrb191-odata-rest-cloud: PASS'
exit 0