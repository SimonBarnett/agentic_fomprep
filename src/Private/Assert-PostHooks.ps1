function Assert-PostHooks {
    <#
    .SYNOPSIS
        MVP: assert-only. Do not INSERT until a human pastes a known-good dump into hooks/formkeys.psd1.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)]$Result,
        [string[]]$HookNames
    )

    if (-not $HookNames -or $HookNames.Count -eq 0) { return $true }

    $hookRoot = Join-Path $script:FormPrepRoot 'hooks'
    $apply = Join-Path $hookRoot 'Apply-FormKeysRepair.ps1'
    if (-not (Test-Path -LiteralPath $apply)) {
        Add-FormPrepError -Result $Result -Source 'hook' -Text 'Apply-FormKeysRepair.ps1 missing' -Severity 'Warning'
        return $true
    }

    . $apply
    $ok = Assert-FormKeysPresent -Connection $Connection -Config $Config -Result $Result
    return $ok
}
