#requires -Version 5.1
# FR #279 / FR-B: agent-rules.md Hours teach bob.ntsa.uk webhook; rules-version >= 5;
# no mandatory origin hours / hours-branch worktree.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$rulesPath = Join-Path $repo 'launcher\agent-rules.md'
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$raw = [IO.File]::ReadAllBytes($rulesPath)
Gate 'rules-no-bom' (-not ($raw.Length -ge 3 -and $raw[0] -eq 0xEF -and $raw[1] -eq 0xBB -and $raw[2] -eq 0xBF)) 'UTF-8 without BOM'
$rl = [Text.Encoding]::UTF8.GetString($raw)
$nonAscii = @($rl.ToCharArray() | Where-Object { [int][char]$_ -gt 127 }).Count
Gate 'rules-ascii' ($nonAscii -eq 0) "ASCII-only prose (non-ascii=$nonAscii)"

$rulesVer = [int]([regex]::Match($rl, 'rules-version:\s*(\d+)').Groups[1].Value)
Gate 'rules-v5' ($rulesVer -ge 5) "rules-version >= 5 (got $rulesVer)"
Gate 'hours-url' ($rl -match 'https://bob\.ntsa\.uk/bob/v1/hours') 'cites bob.ntsa.uk hours webhook'
Gate 'idempotency' ($rl -match 'idempotency_key') 'documents idempotency_key'
Gate 'session-key' ($rl -match 'priority-agent-\{\{SESSION\}\}' -or $rl -match 'priority-agent-\{\{SESSION') 'session idempotency pattern'
Gate 'log-md' ($rl -match 'log\.md') 'keeps project log.md evidence'
Gate 'no-origin-hours-push' ($rl -notmatch 'push to `origin hours`' -and $rl -notmatch 'push to origin hours') 'no mandatory origin hours push'
Gate 'no-hours-worktree' ($rl -notmatch 'worktree add.*"hours"' -and $rl -notmatch "worktree add -b hours") 'no hours-branch worktree recipe'
Gate 'no-hours-ymd-store' ($rl -notmatch 'hours/YYYY-MM-DD\.md') 'hours/YYYY-MM-DD.md is not the store'
Gate 'harvest-intact' ($rl -match 'Harvest rule' -and $rl -match 'agentic_fomprep') 'harvest rule intact'
Gate 'secrets-intact' ($rl -match 'Secrets: hard rule' -and $rl -match 'PASSWORDS_FILE') 'secrets rule intact'

if ($failed -gt 0) { Write-Host "Test-Fr279-AgentRulesWebhookHours FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr279-AgentRulesWebhookHours PASS'
exit 0
