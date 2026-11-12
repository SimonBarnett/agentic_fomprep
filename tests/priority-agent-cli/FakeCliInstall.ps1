#requires -Version 5.1
# FR #571 / FR-006: in-memory fake CLI installers. Never hits the network.
function New-FakeCliInstallLog {
    [pscustomobject]@{
        Started     = New-Object System.Collections.Generic.List[string]
        MsiExit     = 0
        DialogShown = $false
        Token       = 'interactive-user'
        VersionExit = @{}
    }
}

function Invoke-FakeCliYes {
    param($Log, [string]$Choice)
    [void]$Log.Started.Add($Choice)
    $Log.VersionExit[$Choice] = 0
}

function Invoke-FakeCliNotNow {
    param($Log)
    $Log.MsiExit = 0
}

function Invoke-FakeMsiQn {
    param($Log)
    $Log.DialogShown = $false
    $Log.MsiExit = 0
}

function Test-Fr571IsForbiddenInstallerCall {
    param([string]$Line)
    if ([string]::IsNullOrWhiteSpace($Line)) { return $false }
    $t = $Line.Trim()
    if ($t.StartsWith('#')) { return $false }
    if ($t -match '-notmatch') { return $false }
    $hostHit = $t -match 'x\.ai|cursor\.com/install|opencode\.ai'
    if (-not $hostHit) { return $false }
    return $t -match 'irm\b|iex\b|Invoke-WebRequest|Invoke-RestMethod|\bcurl\b|\bwget\b|Start-Process'
}
