function ConvertTo-WinrunProcessArg {
    param([string]$Value)
    if ($null -eq $Value) { $Value = '' }
    # Quote only. Do not double backslashes (CommandLineToArgvW is not C-string).
    '"' + ($Value.Replace('"', '\"')) + '"'
}

function Stop-ProcessTree {
    param([int]$Id)
    if ($Id -le 0) { return }
    try {
        Get-CimInstance Win32_Process -Filter "ParentProcessId=$Id" -ErrorAction SilentlyContinue |
            ForEach-Object { Stop-ProcessTree -Id $_.ProcessId }
    } catch { }
    try { Stop-Process -Id $Id -Force -ErrorAction SilentlyContinue } catch { }
}

function Invoke-CliFormPrep {
    <#
    .SYNOPSIS
        WINACTIV -P FORMPREP with NO form name, after park. Kill the process tree on timeout
        so CLI cannot overlap web (plan section 3).
        Success is SQL, not process exit code.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)][string]$RunDir,
        [int]$TimeoutSeconds = 60
    )

    $winrun = $Config.WinrunPath
    $prep = $Config.SystemPrep
    $company = $Config.Company
    $log = Join-Path $RunDir 'cli-stdout.txt'

    if (-not (Test-Path -LiteralPath $winrun)) {
        [System.IO.File]::AppendAllText($log, "CLI skipped: winrun not found at $winrun`r`n")
        return [pscustomobject]@{ Status = 'skipped'; Reason = 'winrun_missing'; Pid = $null }
    }

    $cred = Get-WinrunCredential -Target $Config.CredentialTarget
    if (-not $cred -or [string]::IsNullOrEmpty($cred.Password)) {
        [System.IO.File]::AppendAllText($log, "CLI skipped: credential '$($Config.CredentialTarget)' not in Credential Manager`r`n")
        return [pscustomobject]@{ Status = 'skipped'; Reason = 'no_cred'; Pid = $null }
    }

    # Username is always config PriorityUser (Si). CredMan UserName can marshal as the
    # password blob; that puts the secret in WINRUN's username field and shifts -P
    # into C:\Priority\bin.95\-P.
    $user = [string]$Config.PriorityUser
    if ($user -cne 'Si') {
        throw "Refusing WINRUN user '$user' (must be exact Si)"
    }

    # CE bats: WINRUN "" Si pass prepPath company WINACTIV -P FORMPREP
    $argLine = @('""', (ConvertTo-WinrunProcessArg $user), '***', (ConvertTo-WinrunProcessArg $prep), (ConvertTo-WinrunProcessArg $company), 'WINACTIV', '-P', 'FORMPREP') -join ' '
    [System.IO.File]::AppendAllText($log, "launch (redacted): $winrun $argLine`r`n")

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $winrun
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.CreateNoWindow = $true
    $psi.WorkingDirectory = Split-Path -Parent $winrun
    $psi.Arguments = @(
        '""'
        (ConvertTo-WinrunProcessArg $user)
        (ConvertTo-WinrunProcessArg $cred.Password)
        (ConvertTo-WinrunProcessArg $prep)
        (ConvertTo-WinrunProcessArg $company)
        'WINACTIV'
        '-P'
        'FORMPREP'
    ) -join ' '

    $proc = New-Object System.Diagnostics.Process
    $proc.StartInfo = $psi
    $started = $proc.Start()
    if (-not $started) {
        return [pscustomobject]@{ Status = 'error'; Reason = 'start_failed'; Pid = $null }
    }

    $exited = $proc.WaitForExit($TimeoutSeconds * 1000)
    if (-not $exited) {
        [System.IO.File]::AppendAllText($log, "timeout ${TimeoutSeconds}s - killing process tree pid=$($proc.Id)`r`n")
        Stop-ProcessTree -Id $proc.Id
        try { $proc.WaitForExit(5000) } catch { }
        Protect-CliLog -Path $log -Secret $cred.Password
        return [pscustomobject]@{ Status = 'timeout'; Reason = 'cli_timeout'; Pid = $proc.Id }
    }

    $stdout = $proc.StandardOutput.ReadToEnd()
    $stderr = $proc.StandardError.ReadToEnd()
    [System.IO.File]::AppendAllText($log, "exit=$($proc.ExitCode)`r`n$stdout`r`n$stderr`r`n")
    Protect-CliLog -Path $log -Secret $cred.Password

    return [pscustomobject]@{
        Status = 'exited'
        Reason = "exit_$($proc.ExitCode)"
        Pid    = $proc.Id
    }
}
