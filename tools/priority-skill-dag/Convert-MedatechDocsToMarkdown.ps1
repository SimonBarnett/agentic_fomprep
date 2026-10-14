<#
.SYNOPSIS
  Convert Priority-Agent docs tree into markdown lessons under
  docs/skill-sources/medatech-network/ for the skill DAG.
#>
[CmdletBinding()]
param(
  [string]$SourceRoot = 'd:\Priority-Agent\docs',
  [string]$DestRoot = '',
  [int]$MaxFiles = 0
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
if (-not $DestRoot) { $DestRoot = Join-Path $repo 'docs\skill-sources\medatech-network' }

$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' +
            [System.Environment]::GetEnvironmentVariable('Path','User')

New-Item -ItemType Directory -Path $DestRoot -Force | Out-Null
$manifestPath = Join-Path $DestRoot '_convert-manifest.jsonl'
$logPath = Join-Path $DestRoot '_convert-log.txt'
"Convert start $(Get-Date -Format o) source=$SourceRoot" | Set-Content $logPath -Encoding UTF8
if (Test-Path $manifestPath) { Remove-Item $manifestPath -Force }

function Log([string]$m) { Add-Content $logPath $m; Write-Host $m }

function Sanitize-Rel([string]$rel) {
  $r = $rel -replace '[<>:"|?*]', '_'
  $r = $r -replace '\\{2,}', '\'
  return $r
}

function Write-Stub([string]$destMd, [string]$title, [string]$sourceRel, [string]$note) {
  $dir = Split-Path $destMd -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
  @"
# $title

- **Source:** ``$sourceRel``
- **Note:** $note
- **Converted:** $(Get-Date -Format 'yyyy-MM-dd')

This lesson is a stub. Open the source file on the Medatech docs tree for the original artifact.
"@ | Set-Content -LiteralPath $destMd -Encoding UTF8
}

$pyDocx = @'
import sys, pathlib
from docx import Document
src, dest = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
doc = Document(str(src))
parts = []
for p in doc.paragraphs:
    t = (p.text or "").strip()
    if t:
        parts.append(t)
for table in doc.tables:
    for row in table.rows:
        cells = [((c.text or "").strip().replace("\n", " ")) for c in row.cells]
        if any(cells):
            parts.append(" | ".join(cells))
text = "\n\n".join(parts).strip()
dest.parent.mkdir(parents=True, exist_ok=True)
title = src.stem
body = f"# {title}\n\n- **Source:** `{src.name}`\n\n{text if text else '_No extractable text._'}\n"
dest.write_text(body, encoding="utf-8")
print(len(text))
'@

$pyPdf = @'
import sys, pathlib
from pypdf import PdfReader
src, dest = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
reader = PdfReader(str(src))
parts = []
for page in reader.pages:
    try:
        t = page.extract_text() or ""
    except Exception:
        t = ""
    t = t.strip()
    if t:
        parts.append(t)
text = "\n\n".join(parts).strip()
dest.parent.mkdir(parents=True, exist_ok=True)
title = src.stem
body = f"# {title}\n\n- **Source:** `{src.name}`\n\n{text if text else '_No extractable text (may be scanned)._'}\n"
dest.write_text(body, encoding="utf-8")
print(len(text))
'@

$pyHtml = @'
import sys, pathlib, re, html
src, dest = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
raw = src.read_text(encoding="utf-8", errors="ignore")
raw = re.sub(r"(?is)<script[^>]*>.*?</script>", " ", raw)
raw = re.sub(r"(?is)<style[^>]*>.*?</style>", " ", raw)
# keep headings roughly
raw = re.sub(r"(?is)<h1[^>]*>(.*?)</h1>", r"\n# \1\n", raw)
raw = re.sub(r"(?is)<h2[^>]*>(.*?)</h2>", r"\n## \1\n", raw)
raw = re.sub(r"(?is)<h3[^>]*>(.*?)</h3>", r"\n### \1\n", raw)
raw = re.sub(r"(?is)<br\s*/?>", "\n", raw)
raw = re.sub(r"(?is)<p[^>]*>", "\n\n", raw)
raw = re.sub(r"(?is)<li[^>]*>", "\n- ", raw)
raw = re.sub(r"(?is)<[^>]+>", " ", raw)
raw = html.unescape(raw)
raw = re.sub(r"[ \t]+", " ", raw)
raw = re.sub(r"\n{3,}", "\n\n", raw).strip()
dest.parent.mkdir(parents=True, exist_ok=True)
title = src.stem
body = f"# {title}\n\n- **Source:** `{src.name}`\n\n{raw if raw else '_Empty HTML._'}\n"
dest.write_text(body, encoding="utf-8")
print(len(raw))
'@

$tmp = Join-Path $env:TEMP 'medatech-convert'
New-Item -ItemType Directory -Path $tmp -Force | Out-Null
$docxPy = Join-Path $tmp 'docx_to_md.py'
$pdfPy = Join-Path $tmp 'pdf_to_md.py'
$htmlPy = Join-Path $tmp 'html_to_md.py'
Set-Content $docxPy $pyDocx -Encoding UTF8
Set-Content $pdfPy $pyPdf -Encoding UTF8
Set-Content $htmlPy $pyHtml -Encoding UTF8

$skipExt = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
@('.dll','.exe','.lic','.tmp','.lnk','.db','.ds_store','.bmp','.png','.jpg','.jpeg','.gif','.url') | ForEach-Object { [void]$skipExt.Add($_) }

$codeExt = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
@('.sh','.rv','.q','.priform','.loaded','.sql','.dotx','.chm','.hlp','.cnt','.xlsx','.xls','.pptx','.mp4') | ForEach-Object { [void]$codeExt.Add($_) }

$files = @(Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -EA SilentlyContinue | Where-Object {
  $_.Name -notin @('README.md','desktop.ini','Thumbs.db') -and
  $_.Name -notlike '~$*' -and
  $_.FullName -notmatch '\\_archives\\' -and
  -not $skipExt.Contains($_.Extension)
})

if ($MaxFiles -gt 0) { $files = $files | Select-Object -First $MaxFiles }
Log "Files to process: $($files.Count)"

$ok = 0; $fail = 0; $stub = 0; $i = 0
foreach ($f in $files) {
  $i++
  if ($i % 100 -eq 0) { Log "  progress $i / $($files.Count) ok=$ok stub=$stub fail=$fail" }
  $rel = $f.FullName.Substring($SourceRoot.Length).TrimStart('\')
  $relSafe = Sanitize-Rel $rel
  $destMd = Join-Path $DestRoot ([IO.Path]::ChangeExtension($relSafe, '.md'))
  # Avoid collisions when source already .md
  if ($f.Extension -eq '.md') { $destMd = Join-Path $DestRoot $relSafe }

  $status = 'ok'
  $chars = 0
  try {
    $ext = $f.Extension.ToLowerInvariant()
    $dir = Split-Path $destMd -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

    if ($codeExt.Contains($ext) -or $ext -in @('.zip','.rar')) {
      Write-Stub $destMd $f.BaseName $rel "Binary/office artifact ($ext); not fully text-converted. Keep original under Priority-Agent docs."
      $status = 'stub'; $stub++; $chars = 0
    }
    elseif ($ext -eq '.md') {
      Copy-Item -LiteralPath $f.FullName -Destination $destMd -Force
      $chars = (Get-Item $destMd).Length
      $ok++
    }
    elseif ($ext -in @('.htm','.html','.mht')) {
      # mht often multipart; try html path first
      if ($ext -eq '.mht') {
        Write-Stub $destMd $f.BaseName $rel 'MHT web-archive; stub only (multipart).'
        $status = 'stub'; $stub++
      } else {
        $out = & python $htmlPy $f.FullName $destMd 2>&1
        if ($LASTEXITCODE -ne 0) { throw "$out" }
        $chars = [int]("$out".Trim() -replace '[^\d]','' | Select-Object -First 1)
        if (-not $chars) { $chars = (Get-Item $destMd).Length }
        $ok++
      }
    }
    elseif ($ext -in @('.docx','.doc')) {
      if ($ext -eq '.doc') {
        Write-Stub $destMd $f.BaseName $rel 'Legacy .doc; convert manually if needed.'
        $status = 'stub'; $stub++
      } else {
        $out = & python $docxPy $f.FullName $destMd 2>&1
        if ($LASTEXITCODE -ne 0) { throw "$out" }
        $chars = 0
        [int]::TryParse(("$out".Trim() -split "`n" | Select-Object -Last 1), [ref]$chars) | Out-Null
        $ok++
      }
    }
    elseif ($ext -eq '.pdf') {
      # Prefer pandoc; fallback pypdf
      $pandocOk = $false
      try {
        & pandoc $f.FullName -t markdown -o $destMd --wrap=none 2>$null
        if ((Test-Path $destMd) -and (Get-Item $destMd).Length -gt 40) {
          $hdr = @"
# $($f.BaseName)

- **Source:** ``$($f.Name)``

"@
          $body = Get-Content -LiteralPath $destMd -Raw -Encoding UTF8
          if ($body -notmatch '^\s*#') {
            Set-Content -LiteralPath $destMd -Value ($hdr + $body) -Encoding UTF8
          }
          $pandocOk = $true
          $chars = (Get-Item $destMd).Length
          $ok++
        }
      } catch { $pandocOk = $false }
      if (-not $pandocOk) {
        $out = & python $pdfPy $f.FullName $destMd 2>&1
        if ($LASTEXITCODE -ne 0) { throw "$out" }
        $chars = 0
        [int]::TryParse(("$out".Trim() -split "`n" | Select-Object -Last 1), [ref]$chars) | Out-Null
        $ok++
      }
    }
    elseif ($ext -eq '.txt' -or $ext -eq '.csv') {
      $text = Get-Content -LiteralPath $f.FullName -Raw -Encoding Default -EA SilentlyContinue
      @"
# $($f.BaseName)

- **Source:** ``$($f.Name)``

~~~
$text
~~~
"@ | Set-Content -LiteralPath $destMd -Encoding UTF8
      $chars = if ($text) { $text.Length } else { 0 }
      $ok++
    }
    else {
      Write-Stub $destMd $f.BaseName $rel "Unhandled extension $ext"
      $status = 'stub'; $stub++
    }
  }
  catch {
    $status = 'fail'
    $fail++
    Write-Stub $destMd $f.BaseName $rel "Conversion failed: $($_.Exception.Message)"
    Log "FAIL $rel : $($_.Exception.Message)"
  }

  $topic = ($rel -split '\\')[0]
  $rec = [ordered]@{
    source = $rel
    dest = $destMd.Substring($DestRoot.Length).TrimStart('\')
    topic = $topic
    status = $status
    bytes = $f.Length
    chars = $chars
  }
  ($rec | ConvertTo-Json -Compress) | Add-Content $manifestPath -Encoding UTF8
}

Log "DONE ok=$ok stub=$stub fail=$fail total=$($files.Count)"
Log "Dest=$DestRoot"
