function ConvertTo-ShellFullPath {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path)) { return $null }
    $norm = $Path.Trim().Trim('"')
    try {
        return [IO.Path]::GetFullPath($norm)
    } catch {
        return $null
    }
}

function Test-ShellPathHasDotDot {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path)) { return $false }
    $norm = $Path -replace '/', '\'
    $parts = $norm.Split('\')
    return [bool]($parts -contains '..')
}

function Test-ShellPathIsCatalogFixture {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path)) { return $false }
    $norm = ($Path -replace '/', '\').ToLowerInvariant()
    if ($norm -match '\\v2\\apps\\mcp-catalog\\catalog\\.+\\fixtures\\') { return $true }
    if ($norm -match '\\v2\\plugins\\.+\\fixtures\\') { return $true }
    if ($norm -match '\\catalog\\priority-shell-[^\\]+\\fixtures\\') { return $true }
    return $false
}

function Get-ShellAllowedRoots {
    param($Instance, $Pin)
    $acc = @()
    $candidates = @()
    if ($Instance) {
        $candidates += [string]$Instance.agentWork
        $candidates += [string]$Instance.buildSetRoot
    }
    if ($env:PRIORITY_SHELL_BUILDSET) { $candidates += $env:PRIORITY_SHELL_BUILDSET }
    if ($Pin -and $Pin.AllowedBuildSetRoots) {
        foreach ($r in @($Pin.AllowedBuildSetRoots)) { $candidates += [string]$r }
    }
    if ($Pin -and $Pin.UpgradesDir) { $candidates += [string]$Pin.UpgradesDir }
    foreach ($Value in $candidates) {
        if ([string]::IsNullOrWhiteSpace($Value)) { continue }
        $full = ConvertTo-ShellFullPath $Value
        if ($full) { $acc += $full }
    }
    return @($acc | Select-Object -Unique)
}

function Test-PathUnderRoot {
    param([string]$FullPath, [string]$Root)
    if (-not $FullPath -or -not $Root) { return $false }
    $p = $FullPath.TrimEnd('\') + '\'
    $r = $Root.TrimEnd('\') + '\'
    return $p.ToLowerInvariant().StartsWith($r.ToLowerInvariant())
}

function Test-ShellPathAllowed {
    param(
        [string]$ShellPath,
        $Instance,
        $Pin
    )
    if ([string]::IsNullOrWhiteSpace($ShellPath)) {
        return @{ ok = $false; reason = 'path_refused'; text = 'shell path is empty' }
    }
    if (Test-ShellPathHasDotDot -Path $ShellPath) {
        return @{ ok = $false; reason = 'path_refused'; text = 'shell path contains ..' }
    }
    if (Test-ShellPathIsCatalogFixture -Path $ShellPath) {
        return @{ ok = $false; reason = 'path_refused'; text = 'catalog fixtures/ live install refused' }
    }
    $full = ConvertTo-ShellFullPath $ShellPath
    if (-not $full) {
        return @{ ok = $false; reason = 'path_refused'; text = 'shell path could not be resolved' }
    }
    if (Test-ShellPathIsCatalogFixture -Path $full) {
        return @{ ok = $false; reason = 'path_refused'; text = 'catalog fixtures/ live install refused' }
    }
    $roots = Get-ShellAllowedRoots -Instance $Instance -Pin $Pin
    if ($roots.Count -lt 1) {
        return @{ ok = $false; reason = 'path_refused'; text = 'no build-set root or agentWork allowlisted for this instance' }
    }
    $under = $false
    foreach ($r in $roots) {
        if (Test-PathUnderRoot -FullPath $full -Root $r) { $under = $true; break }
    }
    if (-not $under) {
        $kind = if ($full.StartsWith('\\')) { 'foreign UNC' } else { 'path outside allowlisted build-set / agentWork' }
        return @{ ok = $false; reason = 'path_refused'; text = "shell $kind" }
    }
    if (-not (Test-Path -LiteralPath $full)) {
        return @{ ok = $false; reason = 'path_refused'; text = 'shell file not found' }
    }
    return @{ ok = $true; path = $full }
}
