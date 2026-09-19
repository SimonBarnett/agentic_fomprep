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

function Get-CompileShellOutputPath {
    param(
        $Instance,
        $Pin,
        [string]$Revision
    )
    $rev = $null
    if (-not [string]::IsNullOrWhiteSpace($Revision)) {
        $t = $Revision.Trim()
        if ($t -match '^[0-9]+$' -or $t -match '^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$') { $rev = $t }
    }
    if (-not $rev) {
        return @{ ok = $false; reason = 'revision_missing'; text = 'revision is not a usable token'; path = $null }
    }
    $leaf = "$rev.sh"
    $dir = $null
    if ($Instance -and $Instance.buildSetRoot) {
        $dir = ConvertTo-ShellFullPath ([string]$Instance.buildSetRoot)
    }
    if (-not $dir -and $Pin -and -not [string]::IsNullOrWhiteSpace([string]$Pin.UpgradesDir)) {
        $up = ConvertTo-ShellFullPath ([string]$Pin.UpgradesDir)
        if ($up -and (Test-Path -LiteralPath $up)) { $dir = $up }
    }
    if (-not $dir -and $Instance -and $Instance.agentWork) {
        $dir = Join-Path (ConvertTo-ShellFullPath ([string]$Instance.agentWork)) 'upgrades'
    }
    if (-not $dir) {
        return @{ ok = $false; reason = 'path_refused'; text = 'no buildSetRoot, reachable UpgradesDir, or agentWork for compile output'; path = $null }
    }
    try {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    } catch {
        return @{ ok = $false; reason = 'path_refused'; text = "cannot create compile output dir $dir"; path = $null }
    }
    return @{ ok = $true; path = (Join-Path $dir $leaf); dir = $dir }
}

function Copy-ShellToInstallRoot {
    param(
        [string]$Path,
        $Instance,
        $Pin
    )
    $full = ConvertTo-ShellFullPath $Path
    if (-not $full -or -not (Test-Path -LiteralPath $full)) {
        return @{ ok = $false; reason = 'path_refused'; text = 'shell file not found for staging'; path = $null }
    }
    $destRoots = @()
    if ($Pin -and -not [string]::IsNullOrWhiteSpace([string]$Pin.UpgradesDir)) {
        $up = ConvertTo-ShellFullPath ([string]$Pin.UpgradesDir)
        if ($up -and (Test-Path -LiteralPath $up)) { $destRoots += $up }
    }
    if ($Instance -and $Instance.buildSetRoot) {
        $b = ConvertTo-ShellFullPath ([string]$Instance.buildSetRoot)
        if ($b) { $destRoots += $b }
    }
    foreach ($r in $destRoots) {
        if (Test-PathUnderRoot -FullPath $full -Root $r) {
            return @{ ok = $true; path = $full; staged = $false }
        }
    }
    $destDir = $null
    if ($destRoots.Count -gt 0) { $destDir = $destRoots[0] }
    elseif ($Instance -and $Instance.agentWork) {
        $destDir = Join-Path (ConvertTo-ShellFullPath ([string]$Instance.agentWork)) 'upgrades'
    }
    if (-not $destDir) {
        return @{ ok = $false; reason = 'path_refused'; text = 'no allowlisted dir to stage the shell onto'; path = $null }
    }
    try {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        $dest = Join-Path $destDir ([IO.Path]::GetFileName($full))
        Copy-Item -LiteralPath $full -Destination $dest -Force
        return @{ ok = $true; path = $dest; staged = $true }
    } catch {
        return @{ ok = $false; reason = 'path_refused'; text = "failed to stage shell onto $destDir"; path = $null }
    }
}
