# MRB #432: client polish vision pack parks 47 FR mirrors; does not Closes them.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$dir = Join-Path $root 'docs\fr\client-polish'
$vision = Join-Path $root 'docs\priority-client-polish\vision.md'
$pack = Join-Path $root 'docs\feature-request-priority-client-polish-2026-11-12.md'
$issued = Join-Path $dir 'ISSUED.tsv'
$fails = 0
function Fail([string]$m) { $script:fails++; Write-Host "FAIL $m" }

$raw = [System.IO.File]::ReadAllBytes($vision)
if ($raw.Length -ge 3 -and $raw[0] -eq 0xEF) { Fail 'vision.md has UTF-8 BOM' }
$vtext = [System.Text.Encoding]::UTF8.GetString($raw)
if ($vtext -notmatch 'last-user') { Fail 'vision.md missing last-user' }
if ($vtext -notmatch 'USERLOGIN') { Fail 'vision.md missing USERLOGIN' }
if ($vtext -notmatch 'LASTPREPDATE') { Fail 'vision.md missing LASTPREPDATE' }
if ($vtext -match 'access_token') { Fail 'vision.md contains access_token' }

$files = Get-ChildItem $dir -Filter 'FR-*.md'
if ($files.Count -ne 47) { Fail "expected 47 FR mirrors, got $($files.Count)" }
1..47 | ForEach-Object {
    $n = '{0:D3}' -f $_
    $p = Join-Path $dir ("FR-{0}-*.md" -f $n)
    if (-not (Get-ChildItem $dir -Filter ("FR-{0}-*.md" -f $n))) { Fail "missing FR-$n mirror" }
}

$tsv = Get-Content $issued | Select-Object -Skip 1 | Where-Object { $_ -match '\S' }
if ($tsv.Count -ne 47) { Fail "ISSUED.tsv rows $($tsv.Count) not 47" }
$nums = $tsv | ForEach-Object { ($_ -split "`t")[1] }
if (($nums | Measure-Object -Minimum).Minimum -ne '383') { Fail 'ISSUED min not 383' }
if (($nums | Measure-Object -Maximum).Maximum -ne '429') { Fail 'ISSUED max not 429' }

$packText = [System.IO.File]::ReadAllText($pack)
if ($packText -match '(?im)^Closes\s') { Fail 'pack must not Closes implementation issues' }

$mocks = Join-Path $root 'docs\priority-client-polish\mocks'
foreach ($n in @('home','empty','error')) {
    if (-not (Test-Path (Join-Path $mocks "$n.html"))) { Fail "missing mock $n.html" }
}

if ($fails -eq 0) { Write-Host 'PASS Test-Mrb432-ClientPolishPack'; exit 0 }
exit 1
