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
