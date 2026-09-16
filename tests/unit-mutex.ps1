#requires -Version 5.1
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
. (Join-Path $script:RepoRoot 'src\Private\Lock-FormPrepMutex.ps1')

$first = Lock-FormPrepMutex -Name 'Global\CE-DEV-FORMPREP' -WaitMs 5000
if (-not $first.Held) { throw 'unit-mutex: first acquire failed' }
try {
    $job = Start-Job -ScriptBlock {
        param($Root)
        . (Join-Path $Root 'src\Private\Lock-FormPrepMutex.ps1')
        $second = Lock-FormPrepMutex -Name 'Global\CE-DEV-FORMPREP' -WaitMs 5000
        $held = [bool]$second.Held
        if ($second.Held) { Unlock-FormPrepMutex -Lock $second }
        return $held
    } -ArgumentList $script:RepoRoot
    $held = Wait-Job $job | Receive-Job
    if ($held) { throw 'unit-mutex: second waiter acquired the mutex' }
    Write-Host 'unit-mutex PASS'
} finally {
    Unlock-FormPrepMutex -Lock $first
    Get-Job | Where-Object { $_.State -ne 'Running' } | Remove-Job -Force -ErrorAction SilentlyContinue
}
exit 0
