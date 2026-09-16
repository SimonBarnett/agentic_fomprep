function Invoke-WebFormPrep {
    <#
    .SYNOPSIS
        Playwright Form Prep after park. Does not click Ignore / Yes on index or duplicate dialogs.
        Login page after park is the caller's problem (restore + exit 3).
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)][string]$RunDir,
        [int]$TimeoutMinutes = 15
    )

    $webDir = Join-Path $script:FormPrepRoot 'src\web'
    $scriptPath = Join-Path $webDir 'formprep.mjs'
    $resultPath = Join-Path $RunDir 'web-result.json'
    $tracePath = Join-Path $RunDir 'web-trace.ndjson'

    if (-not (Test-Path -LiteralPath $scriptPath)) {
        return [pscustomobject]@{
            Status  = 'error'
            Auth    = 'unknown'
            Reason  = 'web_script_missing'
            Dialogs = @()
            Path    = $resultPath
        }
    }

    $node = Get-Command node -ErrorAction SilentlyContinue
    if (-not $node) {
        return [pscustomobject]@{
            Status  = 'skipped'
            Auth    = 'unknown'
            Reason  = 'node_missing'
            Dialogs = @()
            Path    = $resultPath
        }
    }

    $timeoutMs = [int]($TimeoutMinutes * 60 * 1000)
    $args = @(
        $scriptPath
        '--baseUrl', $Config.WebBaseUrl
        '--storageState', $Config.StorageState
        '--runDir', $RunDir
        '--selectors', (Join-Path $webDir 'selectors.json')
        '--timeoutMs', "$timeoutMs"
    )

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $node.Source
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.CreateNoWindow = $true
    $psi.WorkingDirectory = $webDir
    $psi.Arguments = ($args | ForEach-Object {
            if ($_ -match '\s') { '"' + $_ + '"' } else { $_ }
        }) -join ' '

    $proc = New-Object System.Diagnostics.Process
    $proc.StartInfo = $psi
    [void]$proc.Start()
    $waitMs = $timeoutMs + 30000
    $exited = $proc.WaitForExit($waitMs)
    if (-not $exited) {
        Stop-ProcessTree -Id $proc.Id
        return [pscustomobject]@{
            Status  = 'timeout'
            Auth    = 'unknown'
            Reason  = 'web_timeout'
            Dialogs = @()
            Path    = $resultPath
        }
    }

    $stdout = $proc.StandardOutput.ReadToEnd()
    $stderr = $proc.StandardError.ReadToEnd()
    [System.IO.File]::AppendAllText($tracePath, "exit=$($proc.ExitCode)`r`n$stdout`r`n$stderr`r`n")

    $payload = $null
    if (Test-Path -LiteralPath $resultPath) {
        try { $payload = Get-Content -LiteralPath $resultPath -Raw | ConvertFrom-Json } catch { $payload = $null }
    }

    $auth = 'unknown'
    $dialogs = @()
    $status = 'exited'
    $reason = "exit_$($proc.ExitCode)"
    if ($payload) {
        if ($payload.auth) { $auth = [string]$payload.auth }
        if ($payload.exitReason) { $reason = [string]$payload.exitReason }
        if ($payload.dialogs) { $dialogs = @($payload.dialogs) }
        if ($payload.auth -eq 'expired') { $status = 'auth_expired' }
        if ($reason -eq 'blocked-run') { $status = 'blocked-run' }
        if ($reason -eq 'other_session') { $status = 'other_session' }
    } elseif ($proc.ExitCode -eq 2) {
        $status = 'auth_expired'
        $auth = 'expired'
    }

    return [pscustomobject]@{
        Status  = $status
        Auth    = $auth
        Reason  = $reason
        Dialogs = $dialogs
        Path    = $resultPath
        Exit    = $proc.ExitCode
    }
}
