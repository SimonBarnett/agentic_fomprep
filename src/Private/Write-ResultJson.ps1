function ConvertTo-FormPrepJson {
    param($Result)
    return ($Result | ConvertTo-Json -Depth 10 -Compress:$false)
}

function Write-ResultJson {
    [CmdletBinding()]
    param(
        $Result,
        [string]$Path,
        [string]$RunDir,
        [string]$AgentWork
    )

    $json = ConvertTo-FormPrepJson -Result $Result

    $targets = @()
    if ($Path) { $targets += $Path }
    if ($RunDir) { $targets += (Join-Path $RunDir 'result.json') }
    if ($AgentWork) { $targets += (Join-Path $AgentWork 'last.json') }

    $written = @()
    foreach ($p in $targets) {
        if ([string]::IsNullOrWhiteSpace($p)) { continue }
        $dir = Split-Path -Parent $p
        if ($dir -and -not (Test-Path -LiteralPath $dir)) {
            [void][System.IO.Directory]::CreateDirectory($dir)
        }
        try {
            [System.IO.File]::WriteAllText($p, $json)
            $written += $p
        } catch {
            Write-Warning "Could not write result JSON to $p : $($_.Exception.Message)"
        }
    }
    return $written
}

function Test-ResultHasPassword {
    param([string]$Json)
    # Never write a result that echoes a password-like key.
    if ($Json -match '(?i)"(password|siPass|connectionstring)"\s*:') { return $true }
    return $false
}
