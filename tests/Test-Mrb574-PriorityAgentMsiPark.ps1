#requires -Version 5.1
# Hostile MRB #574: MSI vision park; Closes only #573; implementation issues stay open.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$dir = Join-Path $root 'docs\fr\priority-agent-msi'
$vision = Join-Path $root 'docs\feature-request-priority-agent-msi-2026-11-12.md'
$spec = Join-Path $root 'docs\functional-spec-priority-agent-msi.md'
$issued = Join-Path $dir 'ISSUED.tsv'
$cs = Join-Path $root 'launcher\Program.cs'
$fails = 0
function Fail([string]$m) { $script:fails++; Write-Host "FAIL $m" }

foreach ($p in @($vision, $spec, $issued)) {
    $raw = [System.IO.File]::ReadAllBytes($p)
    if ($raw.Length -ge 3 -and $raw[0] -eq 0xEF) { Fail "$p has UTF-8 BOM" }
}

$vtext = [System.IO.File]::ReadAllText($vision)
if ($vtext -notmatch 'S7') { Fail 'vision missing S7 launcher choice' }
if ($vtext -notmatch 'Not now') { Fail 'vision missing Not now' }
if ($vtext -notmatch 'C:\\Program Files\\Priority Agent') { Fail 'vision missing install dir' }
if ($vtext -match '(?im)^Closes\s') { Fail 'vision pack must not Closes implementation issues' }

$files = Get-ChildItem $dir -Filter 'FR-*.md'
if ($files.Count -ne 8) { Fail "expected 8 FR mirrors, got $($files.Count)" }

$tsv = @(Get-Content $issued | Select-Object -Skip 1 | Where-Object { $_ -match '\S' })
if ($tsv.Count -ne 8) { Fail "ISSUED.tsv rows $($tsv.Count) not 8" }
$map = @{}
foreach ($line in $tsv) {
    $parts = $line -split "`t"
    $map[$parts[0]] = $parts[1]
}
if ($map['FR-001'] -ne '566') { Fail 'FR-001 must map to 566' }
if ($map['FR-004'] -ne '569') { Fail 'FR-004 must map to 569' }
if ($map['FR-008'] -ne '573') { Fail 'FR-008 must map to 573' }

1..7 | ForEach-Object {
    $id = 'FR-{0:D3}' -f $_
    $p = Get-ChildItem $dir -Filter ("FR-{0:D3}-*.md" -f $_) | Select-Object -First 1
    if (-not $p) { Fail "missing $id"; return }
    $t = [System.IO.File]::ReadAllText($p.FullName)
    if ($t -match '(?im)^Closes\s') { Fail "$id must not Closes (Refs only)" }
}

$fr8 = Join-Path $dir 'FR-008-docs-park-pointer.md'
$t8 = [System.IO.File]::ReadAllText($fr8)
if ($t8 -notmatch '573') { Fail 'FR-008 must name park issue 573' }

$mocks = Join-Path $root 'docs\mocks\priority-agent-msi'
foreach ($n in @('home', 'empty', 'error')) {
    if (-not (Test-Path (Join-Path $mocks "$n.html"))) { Fail "missing mock $n.html" }
}
$empty = [System.IO.File]::ReadAllText((Join-Path $mocks 'empty.html'))
if ($empty -notmatch 'Grok' -or $empty -notmatch 'Cursor' -or $empty -notmatch 'OpenCode' -or $empty -notmatch 'Not now') {
    Fail 'empty.html must offer Grok, Cursor, OpenCode, and Not now'
}

$src = [System.IO.File]::ReadAllText($cs)
if ($src -notmatch 'grok CLI not found') { Fail 'this docs park must still show grok-only launcher on the tip' }

if ($fails -eq 0) { Write-Host 'PASS Test-Mrb574-PriorityAgentMsiPark'; exit 0 }
exit 1
