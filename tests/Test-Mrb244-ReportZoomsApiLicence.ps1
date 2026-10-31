#requires -Version 5.1
# MRB #244: catalog harvest pins for report ZOOMCOLUMNS2 + API Licence REST.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
  if ($Pass) { Write-Host "PASS $Id $Detail" }
  else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$ids = @(
  @{ Id = 'priority-report-form-zooms'; Src = 'docs\skill-sources\programming\REPORT_FORM_ZOOMS.md'; Need = @('ZOOMCOLUMNS2', 'JOINCOL', 'FORMEXEC') },
  @{ Id = 'priority-api-licence-wcf'; Src = 'docs\skill-sources\programming\API_LICENCE_WCF.md'; Need = @('USERSB', 'REST', 'API Licence') }
)

foreach ($row in $ids) {
  $src = Join-Path $repo $row.Src
  $catSkill = Join-Path $repo ("v2\apps\mcp-catalog\catalog\{0}\SKILL.md" -f $row.Id)
  $catMeta = Join-Path $repo ("v2\apps\mcp-catalog\catalog\{0}\meta.json" -f $row.Id)
  $grokSkill = Join-Path $repo (".grok\skills\{0}\SKILL.md" -f $row.Id)
  Gate "$($row.Id)-src" (Test-Path $src) $src
  Gate "$($row.Id)-catalog-skill" (Test-Path $catSkill) $catSkill
  Gate "$($row.Id)-catalog-meta" (Test-Path $catMeta) $catMeta
  Gate "$($row.Id)-grok-sync" (Test-Path $grokSkill) $grokSkill
  $sk = if (Test-Path $catSkill) { [IO.File]::ReadAllText($catSkill) } else { '' }
  $md = if (Test-Path $src) { [IO.File]::ReadAllText($src) } else { '' }
  $blob = $sk + $md
  Gate "$($row.Id)-name" ($sk -match [regex]::Escape($row.Id)) 'get_skill name'
  Gate "$($row.Id)-foundation" ($sk -match 'Foundation: harvest-priority-skills' -and $sk -match 'SimonBarnett/agentic_fomprep') 'honesty-box'
  foreach ($n in $row.Need) {
    Gate "$($row.Id)-need-$n" ($blob -match [regex]::Escape($n)) $n
  }
  Gate "$($row.Id)-no-password-eq" ($blob -notmatch '(?i)password\s*=') 'no password= literal'
  if (Test-Path $catMeta) {
    $raw = [IO.File]::ReadAllBytes($catMeta)
    Gate "$($row.Id)-meta-nobom" (-not ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF)) 'UTF-8 no BOM'
    $meta = Get-Content -LiteralPath $catMeta -Raw -Encoding UTF8 | ConvertFrom-Json
    Gate "$($row.Id)-meta-name" ($meta.name -eq $row.Id) $meta.name
  }
}

$prep = Join-Path $repo 'docs\skill-sources\programming\PREPARE_PROCEDURE.md'
$prepSkill = Join-Path $repo 'v2\apps\mcp-catalog\catalog\priority-procedure-prep\SKILL.md'
$prepTxt = if (Test-Path $prep) { [IO.File]::ReadAllText($prep) } else { '' }
$prepSk = if (Test-Path $prepSkill) { [IO.File]::ReadAllText($prepSkill) } else { '' }
Gate 'prep-portable' ($prepTxt -match 'run-repprep-via-exec.mjs') 'portable mjs path'
Gate 'prep-api-link' ($prepTxt -match 'API_LICENCE_WCF' -and $prepSk -match 'priority-api-licence-wcf') 'API Licence cross-link'
Gate 'prep-no-password-eq' (($prepTxt + $prepSk) -notmatch '(?i)password\s*=') 'prep no password='

$index = Join-Path $repo '.grok\skills\PRIORITY-AGENT-SKILLS.md'
$idx = if (Test-Path $index) { [IO.File]::ReadAllText($index) } else { '' }
Gate 'index-zooms' ($idx -match 'priority-report-form-zooms') 'sync index zooms'
Gate 'index-api' ($idx -match 'priority-api-licence-wcf') 'sync index api licence'

if ($failed -gt 0) { Write-Host "Test-Mrb244-ReportZoomsApiLicence FAIL ($failed)"; exit 1 }
Write-Host 'Test-Mrb244-ReportZoomsApiLicence PASS'
exit 0
