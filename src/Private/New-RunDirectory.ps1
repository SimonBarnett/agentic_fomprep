function New-RunDirectory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)][string]$RunId
    )

    $root = $Config.AgentWork
    if ([string]::IsNullOrWhiteSpace($root)) {
        $root = $Config.Frozen.AgentWork
    }
    $runDir = Join-Path $root $RunId
    $capture = Join-Path $runDir 'capture'
    foreach ($d in @($root, $runDir, $capture)) {
        if (-not (Test-Path -LiteralPath $d)) {
            [void][System.IO.Directory]::CreateDirectory($d)
        }
    }
    return [pscustomobject]@{
        Root    = $root
        RunDir  = $runDir
        Capture = $capture
    }
}
