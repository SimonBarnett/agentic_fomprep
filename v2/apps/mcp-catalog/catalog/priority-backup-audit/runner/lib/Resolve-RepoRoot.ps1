function Get-PriorityRepoRoot {
    param([string]$StartDir = $PSScriptRoot)
    $d = $StartDir
    while ($d) {
        $git = Join-Path $d '.git'
        if (Test-Path -LiteralPath $git) { return $d }
        $parent = Split-Path -Parent $d
        if (-not $parent -or $parent -eq $d) { break }
        $d = $parent
    }
    throw 'Priority repo root (.git) not found from runner path.'
}
