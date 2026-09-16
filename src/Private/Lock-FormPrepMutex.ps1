function Lock-FormPrepMutex {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [int]$WaitMs = 5000
    )

    if ($Name -ne 'Global\CE-DEV-FORMPREP') {
        throw "Refusing mutex name '$Name' (frozen name is Global\CE-DEV-FORMPREP)"
    }

    $created = $false
    $mutex = New-Object System.Threading.Mutex($false, $Name, [ref]$created)
    $held = $false
    $abandoned = $false
    try {
        $held = $mutex.WaitOne($WaitMs)
    } catch [System.Threading.AbandonedMutexException] {
        $held = $true
        $abandoned = $true
    }

    return [pscustomobject]@{
        Mutex     = $mutex
        Held      = [bool]$held
        Abandoned = [bool]$abandoned
        Created   = [bool]$created
        Name      = $Name
    }
}

function Unlock-FormPrepMutex {
    [CmdletBinding()]
    param($Lock)

    if (-not $Lock) { return }
    try {
        if ($Lock.Held -and $Lock.Mutex) {
            [void]$Lock.Mutex.ReleaseMutex()
            $Lock.Held = $false
        }
    } catch {
        Write-Warning "Mutex release failed: $($_.Exception.Message)"
    }
    try {
        if ($Lock.Mutex) { $Lock.Mutex.Dispose() }
    } catch {
    }
}
