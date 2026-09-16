function Assert-FormPrepEnvironment {
    <#
    .SYNOPSIS
        Fail closed before any park. Exit 2 reasons are returned, never thrown past the caller.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        $Result,
        [switch]$RequirePin,
        [switch]$RequirePriorityRoot,
        [switch]$RequireComputer
    )

    $reasons = @(Test-ConfigMatchesFrozen -Config $Config)
    foreach ($r in $reasons) {
        Add-FormPrepError -Result $Result -Source 'execpreplock' -Text $r -Severity 'Blocker'
    }

    if ($RequireComputer) {
        $hostName = $env:COMPUTERNAME
        $allowed = @($Config.AllowedComputer)
        $okHost = $false
        foreach ($a in $allowed) {
            if ($hostName -and $hostName -eq $a) { $okHost = $true }
        }
        if (-not $okHost) {
            $msg = "Computer '$hostName' is not in AllowedComputer ($($allowed -join ', ')). Refuse live/PRI."
            Add-FormPrepError -Result $Result -Source 'execpreplock' -Text $msg -Severity 'Blocker'
            $Result.reason = 'computer_refused'
        }
    }

    if ($RequirePriorityRoot) {
        foreach ($p in @($Config.PriorityRoot, $Config.Bin, $Config.SystemPrep)) {
            if ($p -and -not (Test-Path -LiteralPath $p)) {
                Add-FormPrepError -Result $Result -Source 'execpreplock' -Text "Missing path $p" -Severity 'Blocker'
                if (-not $Result.reason) { $Result.reason = 'priority_root_missing' }
            }
        }
    }

    if ($RequirePin -and -not $Config.PinComplete) {
        Add-FormPrepError -Result $Result -Source 'execpreplock' -Text 'PinComplete is false. Run recon on DEV1 and pin config/dev.psd1.' -Severity 'Blocker'
        $Result.reason = 'pin_incomplete'
    }

    if ($RequirePin) {
        foreach ($pair in @(
                @{ N = 'SqlDatabase'; V = $Config.SqlDatabase }
                @{ N = 'ExecTable'; V = $Config.ExecTable }
            )) {
            if ([string]::IsNullOrWhiteSpace($pair.V) -or $pair.V -eq '<PIN>') {
                Add-FormPrepError -Result $Result -Source 'execpreplock' -Text "$($pair.N) is not pinned" -Severity 'Blocker'
                $Result.reason = 'pin_incomplete'
            }
        }
    }

    $hasBlocker = @($Result.errors | Where-Object { $_.severity -eq 'Blocker' }).Count -gt 0
    if ($hasBlocker) {
        if (-not $Result.reason) { $Result.reason = 'environment_refused' }
        $Result.exitCode = 2
        $Result.ok = $false
        return $false
    }
    return $true
}
