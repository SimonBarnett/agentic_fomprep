function Get-FormPrepConfig {
    [CmdletBinding()]
    param(
        [string]$Path,
        [string]$Environment = 'DEV'
    )

    if ($Environment -ne 'DEV') {
        throw "Environment '$Environment' is refused. Only DEV is allowed."
    }

    if ([string]::IsNullOrWhiteSpace($Path)) {
        $Path = Join-Path $script:FormPrepRoot 'config\dev.psd1'
    }
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Config file not found: $Path"
    }

    $raw = Import-PowerShellDataFile -Path $Path
    $frozen = Get-FrozenEnvironment

    $webHost = [string]$raw.WebHost
    $sqlInstance = [string]$raw.SqlInstance
    $webBase = [string]$raw.WebBaseUrl

    $uriHost = $null
    if ($webBase) {
        try { $uriHost = ([uri]$webBase).Host } catch { $uriHost = $null }
    }

    $cfg = [pscustomobject]@{
        Path             = (Resolve-Path -LiteralPath $Path).Path
        Environment      = 'DEV'
        PinComplete      = [bool]$raw.PinComplete
        WebHost          = $webHost
        WebBaseUrl       = $webBase
        SqlInstance      = $sqlInstance
        SqlDatabase      = [string]$raw.SqlDatabase
        SqlEncrypt       = [bool]$raw.SqlEncrypt
        ExecTable        = [string]$raw.ExecTable
        ExecNameCol      = [string]$raw.ExecNameCol
        ExecIdCol        = [string]$raw.ExecIdCol
        LockTable        = [string]$raw.LockTable
        LockCols         = $raw.LockCols
        ParkTable        = [string]$raw.ParkTable
        FormKeysTable    = [string]$raw.FormKeysTable
        FormJoinsTable   = [string]$raw.FormJoinsTable
        PriorityUser     = [string]$raw.PriorityUser
        Company          = [string]$raw.Company
        PriorityRoot     = [string]$raw.PriorityRoot
        Bin              = [string]$raw.Bin
        SystemPrep       = [string]$raw.SystemPrep
        WinrunPath       = [string]$raw.WinrunPath
        AgentWork        = [string]$raw.AgentWork
        MutexName        = [string]$raw.MutexName
        MutexWaitMs      = [int]$raw.MutexWaitMs
        AllowedComputer  = @($raw.AllowedComputer)
        CredentialTarget = [string]$raw.CredentialTarget
        StorageState     = [string]$raw.StorageState
        SqlPollSeconds   = [int]$raw.SqlPollSeconds
        Frozen           = $frozen
        UriHost          = $uriHost
    }

    if ($cfg.MutexWaitMs -le 0) { $cfg.MutexWaitMs = 5000 }
    if ($cfg.SqlPollSeconds -le 0) { $cfg.SqlPollSeconds = 5 }
    if (-not $cfg.AllowedComputer -or $cfg.AllowedComputer.Count -eq 0) {
        $cfg.AllowedComputer = @($frozen.AllowedComputer)
    }

    return $cfg
}

function Test-ConfigMatchesFrozen {
    param($Config)

    $f = $Config.Frozen
    $reasons = New-Object System.Collections.Generic.List[string]

    if ($Config.WebHost -ne $f.WebHost) {
        [void]$reasons.Add("WebHost '$($Config.WebHost)' is not frozen '$($f.WebHost)'")
    }
    if ($Config.SqlInstance -ne $f.SqlInstance) {
        [void]$reasons.Add("SqlInstance '$($Config.SqlInstance)' is not frozen '$($f.SqlInstance)'")
    }
    if ($Config.UriHost -and $Config.UriHost -ne $f.WebHost) {
        [void]$reasons.Add("WebBaseUrl host '$($Config.UriHost)' is not frozen '$($f.WebHost)'")
    }
    if ($Config.MutexName -ne $f.MutexName) {
        [void]$reasons.Add("MutexName '$($Config.MutexName)' is not frozen '$($f.MutexName)'")
    }
    if ($Config.PriorityRoot -ne $f.PriorityRoot) {
        [void]$reasons.Add("PriorityRoot '$($Config.PriorityRoot)' is not frozen '$($f.PriorityRoot)'")
    }

    foreach ($name in @($Config.AllowedComputer)) {
        # Token match only. 'PRI' as a substring of 'PRIORITY' is not live/PRI.
        if ($name -match '(?i)(^|[-_])(PRI|LIVE|PROD)([-_]|$)') {
            [void]$reasons.Add("AllowedComputer '$name' looks like live/PRI and is refused")
        }
    }

    return $reasons
}
