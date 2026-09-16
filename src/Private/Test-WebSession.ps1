function Invoke-WebSessionProbe {
    <#
    .SYNOPSIS
        P0-A1 live probe: storageState is necessary, not sufficient. 10s Playwright goto.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config
    )

    $cheap = Test-WebSession -Config $Config
    if ($cheap.Auth -ne 'ok') { return $cheap }

    $node = Get-Command node -ErrorAction SilentlyContinue
    if (-not $node) {
        return [pscustomobject]@{
            Auth   = 'expired'
            Reason = 'node_missing'
            Path   = $Config.StorageState
        }
    }

    $probe = Join-Path $script:FormPrepRoot 'src\web\session-probe.mjs'
    if (-not (Test-Path -LiteralPath $probe)) {
        return [pscustomobject]@{
            Auth   = 'expired'
            Reason = 'session_probe_missing'
            Path   = $Config.StorageState
        }
    }

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $node.Source
    $psi.UseShellExecute = $false
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.CreateNoWindow = $true
    $psi.WorkingDirectory = (Split-Path -Parent $probe)
    $psi.Arguments = ('"{0}" --baseUrl {1} --storageState "{2}" --timeoutMs 10000' -f $probe, $Config.WebBaseUrl, $Config.StorageState)
    $proc = New-Object System.Diagnostics.Process
    $proc.StartInfo = $psi
    [void]$proc.Start()
    $exited = $proc.WaitForExit(15000)
    if (-not $exited) {
        try { $proc.Kill() } catch { }
        return [pscustomobject]@{ Auth = 'expired'; Reason = 'probe_timeout'; Path = $Config.StorageState }
    }
    $stdout = $proc.StandardOutput.ReadToEnd()
    if ($proc.ExitCode -ne 0) {
        return [pscustomobject]@{
            Auth   = 'expired'
            Reason = ('live_probe_failed: {0}' -f $stdout.Trim())
            Path   = $Config.StorageState
        }
    }
    return [pscustomobject]@{
        Auth   = 'ok'
        Reason = 'live_probe'
        Path   = $Config.StorageState
    }
}

function Test-WebSession {
    <#
    .SYNOPSIS
        Cheap session check before park: storageState exists and is JSON with cookies.
        Full login-page detection is done by Invoke-WebFormPrep (Playwright).
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config
    )

    $path = $Config.StorageState
    if ([string]::IsNullOrWhiteSpace($path) -or -not (Test-Path -LiteralPath $path)) {
        return [pscustomobject]@{
            Auth    = 'expired'
            Reason  = 'storage_state_missing'
            Path    = $path
        }
    }

    try {
        $raw = [System.IO.File]::ReadAllText($path)
        $obj = $raw | ConvertFrom-Json
        $cookies = @($obj.cookies)
        if ($cookies.Count -eq 0 -and -not $obj.origins) {
            return [pscustomobject]@{
                Auth   = 'expired'
                Reason = 'storage_state_empty'
                Path   = $path
            }
        }
        return [pscustomobject]@{
            Auth   = 'ok'
            Reason = 'storage_state_present'
            Path   = $path
        }
    } catch {
        return [pscustomobject]@{
            Auth   = 'unknown'
            Reason = "storage_state_unreadable: $($_.Exception.Message)"
            Path   = $path
        }
    }
}
