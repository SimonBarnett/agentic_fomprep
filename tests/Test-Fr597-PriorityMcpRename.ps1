#requires -Version 5.1
# FR #597: self-references are SimonBarnett/priority-mcp; only documented aliases keep agentic_fomprep.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$readme = Join-Path $repo 'README.md'
$agents = Join-Path $repo 'AGENTS.md'
$prog = Join-Path $repo 'launcher\Program.cs'
Gate 'readme-exists' (Test-Path -LiteralPath $readme) 'README.md'
Gate 'agents-exists' (Test-Path -LiteralPath $agents) 'AGENTS.md'
Gate 'launcher-exists' (Test-Path -LiteralPath $prog) 'launcher/Program.cs'

$rt = if (Test-Path -LiteralPath $readme) { [IO.File]::ReadAllText($readme) } else { '' }
$at = if (Test-Path -LiteralPath $agents) { [IO.File]::ReadAllText($agents) } else { '' }
$pt = if (Test-Path -LiteralPath $prog) { [IO.File]::ReadAllText($prog) } else { '' }

Gate 'readme-title-priority' ($rt -match '(?m)^#\s*priority-mcp\b') 'README title is priority-mcp'
Gate 'readme-formerly' ($rt -match 'agentic_fomprep' -and $rt -match 'used to be called|formerly|renamed') 'README documents former name agentic_fomprep'
Gate 'readme-home-repo' ($rt -match 'SimonBarnett/priority-mcp' -or $at -match 'SimonBarnett/priority-mcp') 'home repo is priority-mcp'
Gate 'agents-intake-repo' ($at -match 'SimonBarnett/priority-mcp') 'AGENTS.md intake repo priority-mcp'
Gate 'launcher-primary-leaf' ($pt -match 'FomprepRepo\s*=\s*"priority-mcp"') 'launcher primary folder priority-mcp'
Gate 'launcher-alias-leaf' ($pt -match 'FomprepRepoAlias\s*=\s*"agentic_fomprep"') 'launcher keeps agentic_fomprep alias'
Gate 'launcher-origin-both' ($pt -match 'OriginMatchesRepo' -and $pt -match 'agentic_fomprep') 'launcher accepts legacy origin'

# git grep must only hit documented alias surfaces (README/AGENTS/VISION/Program.cs alias).
Push-Location $repo
try {
    $grep = & git grep -i -n 'agentic[_-]fomprep' 2>$null
    $lines = @($grep | Where-Object { $_ -and $_.Trim() -ne '' })
    $allowed = {
        param($line)
        $line -match '^(README\.md|AGENTS\.md|VISION\.md|launcher/Program\.cs|launcher\\Program\.cs|tests/Test-Fr597|tests\\Test-Fr597)' 
    }
    $bad = @($lines | Where-Object { -not (& $allowed $_) })
    Gate 'grep-only-aliases' ($bad.Count -eq 0) ("git grep leftovers=$($bad.Count); sample=$($bad | Select-Object -First 3 | Out-String)".Trim())
    Gate 'grep-has-readme' ($lines | Where-Object { $_ -match '^README\.md:' } | Measure-Object).Count -ge 1 'README still names former agentic_fomprep'
}
finally { Pop-Location }

if ($failed -gt 0) { Write-Host "Test-Fr597-PriorityMcpRename FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr597-PriorityMcpRename PASS'
exit 0
