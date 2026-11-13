# MRB #591 pin: harvest-agent-skills Priority-generic customer-setup / FR #4970 lesson.
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$skill = Join-Path $root '.grok\skills\harvest-agent-skills\SKILL.md'
$raw = [System.IO.File]::ReadAllBytes($skill)
if ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF) {
    Write-Error 'SKILL.md has UTF-8 BOM'
}
$text = [System.Text.Encoding]::UTF8.GetString($raw)
$idx = $text.IndexOf('## Harvested lessons')
if ($idx -lt 0) { Write-Error 'missing ## Harvested lessons' }
$section = $text.Substring($idx)
$lines = @(
    $section -split "`n" | Where-Object {
        $_ -like '*Priority-generic customer-setup*' -and $_ -like '*FR #4970*'
    }
)
if ($lines.Count -lt 1) {
    Write-Error 'harvest-agent-skills missing Priority-generic customer-setup FR #4970 lesson'
}
$line = ([string]$lines[0]).TrimStart()
if (-not $line.StartsWith('- ')) { Write-Error ("orphan/splice: {0}" -f $line) }
if ($line -notlike '*catalog/.grok*' -and $line -notlike '*catalog\*' ) {
    if ($line -notlike '*byte mirror*') {
        Write-Error 'lesson must cite catalog/.grok byte mirror'
    }
}
if ($line -notlike '*password-file*') {
    Write-Error 'lesson must cite password-file pointer rules'
}
Write-Host 'PASS Test-Mrb591-HostileCustomerSetupHarvest'
