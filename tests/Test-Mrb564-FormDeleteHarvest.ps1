# MRB #564 pin: harvest-agent-skills form.delete verbIsWrite + empty filter skip deleteRow.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$skill = Join-Path $root '.grok\skills\harvest-agent-skills\SKILL.md'
$raw = [System.IO.File]::ReadAllBytes($skill)
if ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF) {
    Write-Error 'SKILL.md has UTF-8 BOM'
}
$text = [System.Text.Encoding]::UTF8.GetString($raw)
$idx = $text.IndexOf('## Harvested lessons')
if ($idx -lt 0) { $idx = 0 }
$section = $text.Substring($idx)
$needle = 'Classify form.delete as verbIsWrite so --dry-run never looks like a read; empty filter matches must not call deleteRow.'
$lines = @($section -split "`n" | Where-Object { $_ -like ('*' + $needle + '*') })
if ($lines.Count -lt 1) { Write-Error 'harvest-agent-skills missing form.delete verbIsWrite lesson' }
$line = ([string]$lines[0]).TrimStart()
if (-not $line.StartsWith('- ')) { Write-Error ("orphan/splice: {0}" -f $line) }
Write-Host 'PASS Test-Mrb564-FormDeleteHarvest'
