# WCF / Web SDK walker for pinned compile / install procedures.
# ENAMEs and step names come from the pin. Never guess procedure names.

function Find-UpgradeWalkerJs {
    param([string]$StartDir)
    $names = @('run-upgrade-proc.mjs')
    $dirs = @()
    if ($StartDir) { $dirs += $StartDir }
    if ($PSScriptRoot) { $dirs += $PSScriptRoot }
    $cursor = $StartDir
    for ($i = 0; $i -lt 8 -and $cursor; $i++) {
        $dirs += $cursor
        $parent = Split-Path -Parent $cursor
        if (-not $parent -or $parent -eq $cursor) { break }
        $cursor = $parent
        $dirs += (Join-Path $parent 'lib')
        $dirs += (Join-Path $parent 'scripts')
        $dirs += (Join-Path $parent 'scripts\lib')
    }
    foreach ($d in ($dirs | Select-Object -Unique)) {
        foreach ($n in $names) {
            $c = Join-Path $d $n
            if (Test-Path -LiteralPath $c) { return $c }
        }
    }
    return $null
}

function Find-UpgradeWalkerNpmRoot {
    param([string]$JsPath)
    $cursor = Split-Path -Parent $JsPath
    for ($i = 0; $i -lt 8 -and $cursor; $i++) {
        $pkg = Join-Path $cursor 'package.json'
        $nm = Join-Path $cursor 'node_modules\priority-web-sdk'
        if ((Test-Path -LiteralPath $pkg) -or (Test-Path -LiteralPath $nm)) {
            return $cursor
        }
        $parent = Split-Path -Parent $cursor
        if (-not $parent -or $parent -eq $cursor) { break }
        $cursor = $parent
    }
    $formprep = Join-Path (Split-Path -Parent $PSScriptRoot) 'plugins\priority-formprep\scripts'
    if (Test-Path -LiteralPath (Join-Path $formprep 'node_modules\priority-web-sdk')) {
        return $formprep
    }
    $sdk = Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) 'src\sdk'
    if (Test-Path -LiteralPath (Join-Path $sdk 'node_modules\priority-web-sdk')) {
        return $sdk
    }
    return (Split-Path -Parent $JsPath)
}

function Install-UpgradeWalkerDeps {
    param([string]$NpmRoot)
    $nm = Join-Path $NpmRoot 'node_modules\priority-web-sdk'
    if (Test-Path -LiteralPath $nm) { return }
    $pkg = Join-Path $NpmRoot 'package.json'
    if (-not (Test-Path -LiteralPath $pkg)) { return }
    $npm = Get-Command npm.cmd -ErrorAction SilentlyContinue
    if (-not $npm) { $npm = Get-Command npm -ErrorAction SilentlyContinue }
    if (-not $npm) { throw 'npm is missing; cannot load priority-web-sdk' }
    Push-Location $NpmRoot
    try {
        & $npm.Source install --omit=dev --no-fund --no-audit 2>&1 | Out-Null
    } finally {
        Pop-Location
    }
}

function ConvertTo-WcfBoolFlag {
    param($Value)
    if ($null -eq $Value) { return '' }
    if ($Value -eq $true) { return 'true' }
    if ($Value -eq $false) { return 'false' }
    $s = [string]$Value
    if ([string]::IsNullOrWhiteSpace($s)) { return '' }
    return $s.Trim().ToLowerInvariant()
}

function Invoke-UpgradeProcWalker {
    param(
        $Instance,
        $Pin,
        [ValidateSet('compile', 'install')][string]$Role,
        [string]$Revision,
        [string]$FilePath,
        [string]$RunDir,
        $Credential,
        [string]$StartDir
    )
    $js = Find-UpgradeWalkerJs -StartDir $StartDir
    if (-not $js) {
        return [pscustomobject]@{
            ok               = $false
            reason           = 'walker_missing'
            ended            = $false
            fileStepSeen     = $false
            fileStepFilled   = $false
            revisionStepFilled = $false
            lastType         = $null
            errors           = @([pscustomobject]@{ source = 'sdk'; severity = 'Blocker'; text = 'run-upgrade-proc.mjs missing' })
            raw              = $null
            exitCode         = 2
        }
    }
    $node = Get-Command node -ErrorAction SilentlyContinue
    if (-not $node) {
        return [pscustomobject]@{
            ok               = $false
            reason           = 'node_missing'
            ended            = $false
            fileStepSeen     = $false
            fileStepFilled   = $false
            revisionStepFilled = $false
            lastType         = $null
            errors           = @([pscustomobject]@{ source = 'sdk'; severity = 'Blocker'; text = 'node is missing; WCF walker not run' })
            raw              = $null
            exitCode         = 2
        }
    }

    $ename = Get-PinnedProcEname -Pin $Pin -Role $Role
    $ptype = Get-PinnedProcType -Pin $Pin -Role $Role
    if ([string]::IsNullOrWhiteSpace($ptype)) { $ptype = 'P' }

    $npmRoot = Find-UpgradeWalkerNpmRoot -JsPath $js
    try { Install-UpgradeWalkerDeps -NpmRoot $npmRoot } catch { }

    New-Item -ItemType Directory -Path $RunDir -Force | Out-Null
    $args = @(
        $js
        '--ename', $ename
        '--type', $ptype
        '--url', [string]$Instance.webBaseUrl
        '--company', [string]$Instance.company
        '--user', [string]$Instance.priorityUser
        '--out', $RunDir
        '--revisionStep', [string]$Pin.RevisionInputStep
        '--fileStep', [string]$Pin.FilePathInputStep
        '--nameStep', (Get-InstallFileNameStep)
        '--role', $Role
    )
    $tabula = [string]$Instance.tabulaini
    if (-not $tabula) { $tabula = 'tabula.ini' }
    $args += @('--tabulaini', $tabula)
    $lang = 2
    if ($Instance.language) { $lang = [int]$Instance.language }
    $args += @('--language', "$lang")
    if ($Revision) { $args += @('--revision', [string]$Revision) }
    if ($FilePath) { $args += @('--file', [string]$FilePath) }
    $flag = ConvertTo-WcfBoolFlag $Pin.WcfFileStepWorks
    if ($flag) { $args += @('--wcfFileStep', $flag) }
    if ($Role -eq 'install' -and -not (Test-ShellPinTokenEmpty $Pin.InstallErrorForm)) {
        $args += @('--errorForm', [string]$Pin.InstallErrorForm)
    }

    $env:PRIORITY_SDK_PASSWORD = [string]$Credential.Password
    $stdout = $null
    $code = 2
    try {
        $stdout = & $node.Source @args 2>&1 | Out-String
        $code = $LASTEXITCODE
    } finally {
        Remove-Item Env:PRIORITY_SDK_PASSWORD -ErrorAction SilentlyContinue
    }

    $obj = $null
    $jsonPath = Join-Path $RunDir 'walk.json'
    if (Test-Path -LiteralPath $jsonPath) {
        try { $obj = Get-Content -LiteralPath $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json } catch { $obj = $null }
    }
    if (-not $obj -and $stdout) {
        $lines = $stdout -split '\r?\n'
        for ($i = $lines.Length - 1; $i -ge 0; $i--) {
            $t = $lines[$i].Trim()
            if ($t.StartsWith('{')) {
                try { $obj = $t | ConvertFrom-Json; break } catch { }
            }
        }
    }

    $errors = @()
    if ($obj -and $obj.errors) {
        foreach ($e in @($obj.errors)) {
            if ($null -eq $e) { continue }
            $src = 'sdk'
            if ($e.source) { $src = [string]$e.source }
            $sev = 'Warning'
            if ($e.severity) { $sev = [string]$e.severity }
            $text = [string]$e.text
            if (-not $text -and $e.message) { $text = [string]$e.message }
            if ($text) {
                $errors += ,[pscustomobject]@{ source = $src; severity = $sev; text = $text }
            }
        }
    } elseif ($stdout) {
        $clip = $stdout.Trim()
        if ($clip.Length -gt 1500) { $clip = $clip.Substring(0, 1500) }
        $errors += ,[pscustomobject]@{ source = 'sdk'; severity = 'Blocker'; text = 'WCF walker produced no JSON: ' + $clip }
    }

    $ended = $false
    $ok = $false
    $fileSeen = $false
    $fileFilled = $false
    $revFilled = $false
    $lastType = $null
    $reason = 'proc_failed'
    if ($obj) {
        $ok = [bool]$obj.ok
        $ended = [bool]$obj.ended
        $fileSeen = [bool]$obj.fileStepSeen
        $fileFilled = [bool]$obj.fileStepFilled
        $revFilled = [bool]$obj.revisionStepFilled
        if ($obj.lastType) { $lastType = [string]$obj.lastType }
        if ($obj.reason) { $reason = [string]$obj.reason }
    }
    if ($ok -and $ended) { $reason = 'walked' }

    return [pscustomobject]@{
        ok                 = [bool]$ok
        reason             = $reason
        ended              = [bool]$ended
        fileStepSeen       = [bool]$fileSeen
        fileStepFilled     = [bool]$fileFilled
        revisionStepFilled = [bool]$revFilled
        lastType           = $lastType
        errors             = @($errors)
        raw                = $obj
        exitCode           = $code
        stdout             = $stdout
        walkPath           = $jsonPath
        ename              = $ename
    }
}
