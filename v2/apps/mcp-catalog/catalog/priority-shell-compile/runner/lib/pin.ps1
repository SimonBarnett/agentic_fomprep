# Shell compile/install WP0 pin loader. Empty values are required until a human
# sets PinComplete after recon. Never treat UNKNOWN / <PIN> as a real ENAME.

$script:ShellPinGuessTokens = @(
    '',
    'UNKNOWN',
    '<PIN>',
    'TODO',
    'FIXME',
    'TBC',
    'CHANGEME',
    'PREPUPG',
    'INSTUPG',
    'PREPAREUPGRADE',
    'INSTALLUPGRADE',
    'PREPUPGRADE',
    'INSTUPGRADE'
)

# Required when PinComplete=true. WcfFileStepWorks=null and DbiMarker="" are
# recon-valid unknowns (docs/wp0-recon.md) — not gaps.
$script:ShellPinRequiredKeys = @(
    'PrepareUpgradeEname',
    'PrepareUpgradeType',
    'InstallUpgradeEname',
    'InstallUpgradeType',
    'VersionRevisionsEname',
    'RevisionInputStep',
    'FilePathInputStep',
    'InstallLogTable',
    'InstallLogRevisionCol'
)

$script:ShellPinUnknownOkKeys = @(
    'WcfFileStepWorks',
    'DbiMarker'
)

function Test-ShellPinTokenEmpty {
    param($Value)
    if ($null -eq $Value) { return $true }
    $s = [string]$Value
    if ([string]::IsNullOrWhiteSpace($s)) { return $true }
    foreach ($g in $script:ShellPinGuessTokens) {
        if ($g -and $s.Trim().Equals($g, [StringComparison]::OrdinalIgnoreCase)) { return $true }
    }
    return $false
}

function Convert-ShellPinObject {
    param($Raw)
    if ($null -eq $Raw) { return $null }
    $ht = [ordered]@{}
    if ($Raw -is [hashtable] -or $Raw -is [System.Collections.Specialized.OrderedDictionary]) {
        foreach ($k in $Raw.Keys) { $ht[[string]$k] = $Raw[$k] }
    } else {
        foreach ($p in $Raw.PSObject.Properties) { $ht[$p.Name] = $p.Value }
    }
    $complete = $false
    if ($ht.Contains('PinComplete')) { $complete = [bool]$ht['PinComplete'] }
    $roots = @()
    if ($ht.Contains('AllowedBuildSetRoots') -and $null -ne $ht['AllowedBuildSetRoots']) {
        $roots = @($ht['AllowedBuildSetRoots'] | ForEach-Object { [string]$_ } | Where-Object { $_ })
    }
    $lockCols = $null
    if ($ht.Contains('LockCols') -and $null -ne $ht['LockCols']) {
        $lcRaw = $ht['LockCols']
        $lcHt = [ordered]@{}
        if ($lcRaw -is [hashtable] -or $lcRaw -is [System.Collections.Specialized.OrderedDictionary]) {
            foreach ($lk in $lcRaw.Keys) { $lcHt[[string]$lk] = [string]$lcRaw[$lk] }
        } else {
            foreach ($lp in $lcRaw.PSObject.Properties) { $lcHt[$lp.Name] = [string]$lp.Value }
        }
        $lockCols = [pscustomobject]$lcHt
    }
    return [pscustomobject]@{
        PinComplete            = $complete
        PrepareUpgradeEname    = [string]$ht['PrepareUpgradeEname']
        PrepareUpgradeType     = [string]$ht['PrepareUpgradeType']
        InstallUpgradeEname    = [string]$ht['InstallUpgradeEname']
        InstallUpgradeType     = [string]$ht['InstallUpgradeType']
        VersionRevisionsEname  = [string]$ht['VersionRevisionsEname']
        RevisionInputStep      = [string]$ht['RevisionInputStep']
        FilePathInputStep      = [string]$ht['FilePathInputStep']
        WcfFileStepWorks       = $ht['WcfFileStepWorks']
        InstallLogTable        = [string]$ht['InstallLogTable']
        InstallLogRevisionCol  = [string]$ht['InstallLogRevisionCol']
        InstallLogDateCol      = [string]$ht['InstallLogDateCol']
        DbiMarker              = [string]$ht['DbiMarker']
        InstallErrorForm       = [string]$ht['InstallErrorForm']
        ExecTitleColumn        = [string]$ht['ExecTitleColumn']
        UpgradesDir            = [string]$ht['UpgradesDir']
        ProofInstanceId        = [string]$ht['ProofInstanceId']
        AllowedBuildSetRoots   = $roots
        ExecTable              = [string]$ht['ExecTable']
        ExecNameCol            = [string]$ht['ExecNameCol']
        ExecIdCol              = [string]$ht['ExecIdCol']
        LockTable              = [string]$ht['LockTable']
        LockCols               = $lockCols
        FormLimitedTable       = [string]$ht['FormLimitedTable']
        FormLimitedExecCol     = [string]$ht['FormLimitedExecCol']
        Path                   = $null
    }
}

function Find-ShellPinFile {
    param([string]$Path, [string]$StartDir)
    if ($Path -and (Test-Path -LiteralPath $Path)) { return $Path }
    if ($env:PRIORITY_SHELL_PIN -and (Test-Path -LiteralPath $env:PRIORITY_SHELL_PIN)) {
        return $env:PRIORITY_SHELL_PIN
    }
    $names = @('pin.json', 'pin.psd1')
    $dirs = @()
    if ($StartDir) { $dirs += $StartDir }
    $cursor = $StartDir
    for ($i = 0; $i -lt 8 -and $cursor; $i++) {
        $parent = Split-Path -Parent $cursor
        if (-not $parent -or $parent -eq $cursor) { break }
        $dirs += $parent
        $cursor = $parent
        $v2cfg = Join-Path $parent 'config'
        if (Test-Path -LiteralPath $v2cfg) { $dirs += $v2cfg }
    }
    foreach ($d in $dirs) {
        foreach ($n in $names) {
            $c = Join-Path $d $n
            if (Test-Path -LiteralPath $c) { return $c }
        }
    }
    return $null
}

function Read-ShellPin {
    param([string]$Path, [string]$StartDir)
    $found = Find-ShellPinFile -Path $Path -StartDir $StartDir
    if (-not $found) {
        return @{ ok = $false; reason = 'pin_missing'; path = $Path }
    }
    $raw = $null
    if ($found -match '\.psd1$') {
        $raw = Import-PowerShellDataFile -Path $found
    } else {
        $raw = Get-Content -LiteralPath $found -Raw -Encoding UTF8 | ConvertFrom-Json
    }
    $pin = Convert-ShellPinObject -Raw $raw
    $pin.Path = $found
    return @{ ok = $true; pin = $pin; path = $found }
}

function Test-ShellPinReady {
    param($Pin, [ValidateSet('compile', 'install')][string]$Role)
    if ($null -eq $Pin -or -not $Pin.PinComplete) { return $false }
    if ($Role -eq 'compile') {
        if (Test-ShellPinTokenEmpty $Pin.PrepareUpgradeEname) { return $false }
        if (Test-ShellPinTokenEmpty $Pin.PrepareUpgradeType) { return $false }
        if (Test-ShellPinTokenEmpty $Pin.RevisionInputStep) { return $false }
        if (Test-ShellPinTokenEmpty $Pin.VersionRevisionsEname) { return $false }
    } else {
        if (Test-ShellPinTokenEmpty $Pin.InstallUpgradeEname) { return $false }
        if (Test-ShellPinTokenEmpty $Pin.InstallUpgradeType) { return $false }
        if (Test-ShellPinTokenEmpty $Pin.InstallLogTable) { return $false }
        if (Test-ShellPinTokenEmpty $Pin.InstallLogRevisionCol) { return $false }
    }
    return $true
}

function Get-ShellPinGaps {
    param($Pin)
    $gaps = @()
    if ($null -eq $Pin) {
        return @('pin object is null')
    }
    foreach ($k in $script:ShellPinRequiredKeys) {
        $v = $Pin.$k
        if (Test-ShellPinTokenEmpty $v) { $gaps += $k }
    }
    return @($gaps)
}

function Get-PinnedProcEname {
    param($Pin, [ValidateSet('compile', 'install')][string]$Role)
    if ($null -eq $Pin) { return '' }
    if ($Role -eq 'compile') { return [string]$Pin.PrepareUpgradeEname }
    return [string]$Pin.InstallUpgradeEname
}

function Get-PinnedProcType {
    param($Pin, [ValidateSet('compile', 'install')][string]$Role)
    if ($null -eq $Pin) { return '' }
    if ($Role -eq 'compile') { return [string]$Pin.PrepareUpgradeType }
    return [string]$Pin.InstallUpgradeType
}

function Get-InstallFileNameStep {
    # Recon: install walks NAM (File Name) on the pinned install procedure.
    # FilePathInputStep is the prepare full-path step. Do not invent a second pin key.
    return 'NAM'
}

function Test-WcfFileStepPinFalse {
    param($Pin)
    if ($null -eq $Pin) { return $false }
    $v = $Pin.WcfFileStepWorks
    if ($v -eq $false) { return $true }
    if ($v -is [string] -and $v.Trim().Equals('false', [StringComparison]::OrdinalIgnoreCase)) { return $true }
    return $false
}

function Test-WcfFileStepPinTrue {
    param($Pin)
    if ($null -eq $Pin) { return $false }
    $v = $Pin.WcfFileStepWorks
    if ($v -eq $true) { return $true }
    if ($v -is [string] -and $v.Trim().Equals('true', [StringComparison]::OrdinalIgnoreCase)) { return $true }
    return $false
}
