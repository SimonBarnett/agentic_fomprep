$script:RepoRoot = Split-Path -Parent $PSScriptRoot

function Import-FormPrepModule {
    Import-Module (Join-Path $script:RepoRoot 'src\CE.FormPrep.psd1') -Force
}

function Get-DevConfig {
    return Get-FormPrepConfig -Path (Join-Path $script:RepoRoot 'config\dev.psd1') -Environment DEV
}

function Test-FormPrepDevHost {
    $cfgPath = Join-Path $script:RepoRoot 'config\dev.psd1'
    if (-not (Test-Path -LiteralPath $cfgPath)) { return $false }
    $raw = Import-PowerShellDataFile -Path $cfgPath
    $allowed = @($raw.AllowedComputer)
    return [bool]($allowed -contains $env:COMPUTERNAME)
}

function Assert-ExitCode {
    param($Result, [int]$Expected, [string]$Label)
    $actual = 2
    if ($Result -and $null -ne $Result.exitCode) { $actual = [int]$Result.exitCode }
    if ($actual -ne $Expected) {
        throw "$Label expected exit $Expected got $actual reason=$($Result.reason)"
    }
}
