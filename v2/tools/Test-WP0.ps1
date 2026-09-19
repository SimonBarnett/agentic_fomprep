#requires -Version 5.1
<#
.SYNOPSIS
    WP0 fail-fast for v2 shell compile/install. Exit 0 only if every T* gate passes.
    Exit 2 = pack not ready. Exit 3 = recon ran and found a contradiction.
    Red before WCF on refuse paths. Live compile/install only when pins are complete
    and PRIORITY_WP0_INSTANCE is reachable.
#>
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$v2 = Split-Path -Parent $PSScriptRoot
$repo = Split-Path -Parent $v2
$failed = 0
$gates = @()

function Add-Gate {
    param([string]$Id, [bool]$Pass, [string]$Detail)
    $script:gates += ,[pscustomobject]@{ id = $Id; pass = $Pass; detail = $Detail }
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

function Test-ParseFile([string]$Path) {
    $tok = $null
    $err = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$tok, [ref]$err)
    if ($err -and $err.Count -gt 0) {
        return "PARSE FAIL ${Path}: $($err[0].Message)"
    }
    return $null
}

function Get-JsonLastLine {
    param([string]$Text)
    if ([string]::IsNullOrWhiteSpace($Text)) { return $null }
    $lines = $Text -split '\r?\n'
    for ($i = $lines.Length - 1; $i -ge 0; $i--) {
        $t = $lines[$i].Trim()
        if ($t.StartsWith('{') -and $t.EndsWith('}')) { return $t }
        if ($t.StartsWith('{')) { return $t }
    }
    $start = $Text.IndexOf('{')
    $end = $Text.LastIndexOf('}')
    if ($start -ge 0 -and $end -gt $start) {
        return $Text.Substring($start, $end - $start + 1)
    }
    return $null
}

function Invoke-ShellRunner {
    param(
        [string]$File,
        [string[]]$ArgList
    )
    $all = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $File) + $ArgList
    $out = & powershell.exe @all 2>&1 | Out-String
    $jsonText = Get-JsonLastLine $out
    $obj = $null
    if ($jsonText) {
        try { $obj = $jsonText | ConvertFrom-Json } catch { $obj = $null }
    }
    return [pscustomobject]@{
        ExitCode = $LASTEXITCODE
        StdOut   = $out
        Json     = $obj
    }
}

# --- WP0-T1 catalog ---
$compileDir = Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-compile'
$installDir = Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-install'
$t1ok = $true
$t1d = @()
foreach ($pair in @(
        @{ d = $compileDir; n = 'priority-shell-compile' },
        @{ d = $installDir; n = 'priority-shell-install' }
    )) {
    foreach ($f in @('meta.json', 'SKILL.md')) {
        $p = Join-Path $pair.d $f
        if (-not (Test-Path -LiteralPath $p)) { $t1ok = $false; $t1d += "missing $($pair.n)/$f" }
    }
}
Add-Gate 'WP0-T1' $t1ok $(if ($t1ok) { 'catalog meta.json + SKILL.md present' } else { $t1d -join '; ' })

# --- WP0-T2 schema ---
$compileSchema = Join-Path $compileDir 'result-schema.json'
$installSchema = Join-Path $installDir 'result-schema.json'
$t2ok = $true
$t2d = @()
foreach ($s in @($compileSchema, $installSchema)) {
    if (-not (Test-Path -LiteralPath $s)) { $t2ok = $false; $t2d += "missing $s"; continue }
    try {
        $sch = Get-Content -LiteralPath $s -Raw | ConvertFrom-Json
        if ($sch.type -ne 'object') { $t2ok = $false; $t2d += "$s type not object" }
        $req = @($sch.required)
        foreach ($k in @('ok', 'runId', 'errors', 'reason', 'exitCode')) {
            if ($req -notcontains $k) { $t2ok = $false; $t2d += "$s missing required $k" }
        }
    } catch {
        $t2ok = $false; $t2d += "invalid JSON $s"
    }
}
Add-Gate 'WP0-T2' $t2ok $(if ($t2ok) { 'compile/install result schemas ok' } else { $t2d -join '; ' })

# --- WP0-T3 pin file ---
$pinJson = Join-Path $v2 'config\pin.json'
$pinPsd1 = Join-Path $v2 'config\pin.psd1'
$t3ok = (Test-Path -LiteralPath $pinJson) -and (Test-Path -LiteralPath $pinPsd1)
Add-Gate 'WP0-T3' $t3ok $(if ($t3ok) { 'v2/config/pin.json and pin.psd1 present' } else { 'pin.json / pin.psd1 missing' })

# --- WP0-T4 pin complete vs empty/guessed ---
. (Join-Path $v2 'lib\pin.ps1')
$pinObj = $null
$t4ok = $true
$t4d = 'PinComplete=false; empty pins allowed'
if ($t3ok) {
    $pj = Get-Content -LiteralPath $pinJson -Raw | ConvertFrom-Json
    $pp = Import-PowerShellDataFile -Path $pinPsd1
    $pinObj = (Convert-ShellPinObject -Raw $pj)
    if ([bool]$pj.PinComplete -ne [bool]$pp.PinComplete) {
        $t4ok = $false
        $t4d = 'pin.json PinComplete disagrees with pin.psd1'
    } elseif ($pinObj.PinComplete) {
        $gaps = @(Get-ShellPinGaps -Pin $pinObj)
        if ($gaps.Count -gt 0) {
            $t4ok = $false
            $t4d = 'PinComplete=true with empty/UNKNOWN/guessed: ' + ($gaps -join ', ')
        } else {
            $t4d = 'PinComplete=true and required pins populated'
        }
    } else {
        $t4d = 'PinComplete=false (skeleton); empty pins ok'
    }
} else {
    $t4ok = $false
    $t4d = 'cannot read pin files'
}
Add-Gate 'WP0-T4' $t4ok $t4d

# Materialize runner copies (lib + scripts) if missing - tests use catalog runner and plugin scripts.
$libSrc = Join-Path $v2 'lib'
$compileRunner = Join-Path $compileDir 'runner'
$installRunner = Join-Path $installDir 'runner'
$compilePluginScripts = Join-Path $v2 'plugins\priority-shell-compile\scripts'
$installPluginScripts = Join-Path $v2 'plugins\priority-shell-install\scripts'

# --- WP0-T6 no guessed product ENAME ---
$t6ok = $true
$t6d = @()
$forbidden = @(
    'PREPAREUPGRADE', 'PREPUPGRADE', 'PREPUPG',
    'INSTALLUPGRADE', 'INSTUPGRADE', 'INSTUPG',
    'UPGPREPARE', 'UPGINSTALL'
)
$scanFiles = @(
    (Join-Path $compileRunner 'Compile-Shell.ps1'),
    (Join-Path $installRunner 'Install-Shell.ps1'),
    (Join-Path $compilePluginScripts 'Compile-Shell.ps1'),
    (Join-Path $installPluginScripts 'Install-Shell.ps1'),
    (Join-Path $v2 'plugins\priority-shell-compile\mcp\server.mjs'),
    (Join-Path $v2 'plugins\priority-shell-install\mcp\server.mjs'),
    (Join-Path $v2 'lib\wcf.ps1'),
    (Join-Path $v2 'lib\gate.ps1'),
    (Join-Path $v2 'lib\run-upgrade-proc.mjs')
)
foreach ($sf in $scanFiles) {
    if (-not (Test-Path -LiteralPath $sf)) { $t6ok = $false; $t6d += "missing $sf"; continue }
    $text = Get-Content -LiteralPath $sf -Raw
    foreach ($tok in $forbidden) {
        if ($text -match [regex]::Escape($tok)) {
            $t6ok = $false
            $t6d += "${sf} contains guessed token $tok"
        }
    }
}
Add-Gate 'WP0-T6' $t6ok $(if ($t6ok) { 'no guessed procedure ENAME in product scripts' } else { $t6d -join '; ' })

# --- WP0-T7 parse fixture ---
. (Join-Path $v2 'lib\parse-sh.ps1')
$fixDir = Join-Path $v2 'plugins\priority-shell-install\fixtures'
$fixOk = Join-Path $fixDir '1042-sanitized.sh'
$fixExp = Join-Path $fixDir 'expected-1042.json'
$t7ok = $true
$t7d = ''
if (-not (Test-Path -LiteralPath $fixOk) -or -not (Test-Path -LiteralPath $fixExp)) {
    $t7ok = $false
    $t7d = 'sanitized fixture .sh or expected-1042.json missing'
} else {
    $got = Read-PriorityShell -Path $fixOk
    $exp = Get-Content -LiteralPath $fixExp -Raw | ConvertFrom-Json
    if (-not $got.ok) {
        $t7ok = $false
        $t7d = 'parser failed fixture: ' + $got.text
    } elseif ([string]$got.revision -ne [string]$exp.revision) {
        $t7ok = $false
        $t7d = "revision $($got.revision) != $($exp.revision)"
    } elseif (@($got.codes).Count -lt 1) {
        $t7ok = $false
        $t7d = 'parser returned no codes'
    } else {
        foreach ($c in @($exp.codes)) {
            if (@($got.codes) -notcontains $c) { $t7ok = $false; $t7d += "missing code $c; " }
        }
        $t7d = "revision=$($got.revision) codes=$($got.codes -join ',')"
    }
}
Add-Gate 'WP0-T7' $t7ok $t7d

# --- WP0-T9 v1 frozen ---
$v1 = Join-Path $repo 'src\Prepare-NamedForm.ps1'
$t9ok = $true
$t9d = 'src\Prepare-NamedForm.ps1 present and unpatched'
if (-not (Test-Path -LiteralPath $v1)) {
    $t9ok = $false
    $t9d = 'repo-root src\Prepare-NamedForm.ps1 missing'
} else {
    Push-Location $repo
    try {
        $diff = & git diff -- src/Prepare-NamedForm.ps1 2>$null
        $staged = & git diff --cached -- src/Prepare-NamedForm.ps1 2>$null
        if ($diff -or $staged) {
            $t9ok = $false
            $t9d = 'src\Prepare-NamedForm.ps1 has local diff; v1 must stay frozen'
        }
    } finally { Pop-Location }
}
Add-Gate 'WP0-T9' $t9ok $t9d

# Parse-check new ps1 files
$parseTargets = Get-ChildItem -LiteralPath $v2 -Recurse -File -Filter *.ps1 |
    Where-Object { $_.FullName -notmatch '\\node_modules\\' }
$parseFail = @()
foreach ($f in $parseTargets) {
    $msg = Test-ParseFile $f.FullName
    if ($msg) { $parseFail += $msg }
}
if ($parseFail.Count -gt 0) {
    Add-Gate 'WP0-PARSE' $false ($parseFail -join '; ')
} else {
    Add-Gate 'WP0-PARSE' $true ("parsed $($parseTargets.Count) v2 *.ps1")
}

# --- helpers for T5 / T8 ---
. (Join-Path $v2 'lib\allowlist.ps1')
. (Join-Path $v2 'lib\paths.ps1')
. (Join-Path $v2 'lib\result.ps1')

$compilePs1 = Join-Path $compileRunner 'Compile-Shell.ps1'
$installPs1 = Join-Path $installRunner 'Install-Shell.ps1'
$scratch = Join-Path $env:TEMP ("wp0-shell-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $scratch -Force | Out-Null
$build = Join-Path $scratch 'buildset'
$work = Join-Path $scratch 'work'
New-Item -ItemType Directory -Path $build -Force | Out-Null
New-Item -ItemType Directory -Path $work -Force | Out-Null
$okSh = Join-Path $build '1042.sh'
Copy-Item -LiteralPath $fixOk -Destination $okSh -Force
$dbiSh = Join-Path $build '1043.sh'
Copy-Item -LiteralPath (Join-Path $fixDir '1043-dbi-sanitized.sh') -Destination $dbiSh -Force
$missingSh = Join-Path $build 'no-such.sh'

$allowPath = Join-Path $scratch 'instances.json'
$allowDoc = @{
    instances = @(
        @{
            id               = 'wp0-dev'
            title            = 'WP0 sandbox'
            webBaseUrl       = 'https://priority.example.com'
            sqlInstance      = 'localhost'
            sqlDatabase      = 'system'
            company          = 'base'
            priorityUser     = 'webuser'
            credentialTarget = 'Priority/FormPrep/wp0-none'
            allowLive        = $false
            agentWork        = $work
            buildSetRoot     = $build
        },
        @{
            id               = 'demo-live'
            title            = 'Looks live'
            webBaseUrl       = 'https://priority.example.com'
            sqlInstance      = 'localhost'
            sqlDatabase      = 'system'
            company          = 'base'
            priorityUser     = 'webuser'
            credentialTarget = 'Priority/FormPrep/wp0-none'
            allowLive        = $false
            agentWork        = $work
            buildSetRoot     = $build
        }
    )
}
[System.IO.File]::WriteAllText($allowPath, ($allowDoc | ConvertTo-Json -Depth 6))

function Assert-Refuse {
    param($Run, [string]$ExpectReason, [int]$ExpectExit = 2)
    $ok = $true
    $bits = @()
    if ($Run.ExitCode -ne $ExpectExit) { $ok = $false; $bits += "exit $($Run.ExitCode) want $ExpectExit" }
    if (-not $Run.Json) { $ok = $false; $bits += 'no JSON'; return @{ ok = $ok; detail = ($bits -join '; ') } }
    if ($Run.Json.reason -ne $ExpectReason) { $ok = $false; $bits += "reason=$($Run.Json.reason) want $ExpectReason" }
    if ($Run.Json.ok -eq $true) { $ok = $false; $bits += 'ok=true' }
    if ($Run.Json.wcfAttempted -eq $true) { $ok = $false; $bits += 'wcfAttempted=true' }
    $errCount = @($Run.Json.errors).Count
    if ($errCount -lt 1) { $ok = $false; $bits += 'errors[] empty' }
    if ($ok) { $bits = @("reason=$ExpectReason exit=$ExpectExit wcfAttempted=false") }
    return @{ ok = $ok; detail = ($bits -join '; ') }
}

# --- WP0-T5 incomplete pin still refuses WCF (scratch pin, not v2/config) ---
$t5ok = $true
$t5d = @()
$incPin = Join-Path $scratch 'pin-incomplete.json'
$incObj = [ordered]@{
    PinComplete           = $false
    PrepareUpgradeEname   = ''
    PrepareUpgradeType    = ''
    InstallUpgradeEname   = ''
    InstallUpgradeType    = ''
    VersionRevisionsEname = ''
    RevisionInputStep     = ''
    FilePathInputStep     = ''
    WcfFileStepWorks      = $null
    InstallLogTable       = ''
    InstallLogRevisionCol = ''
    InstallLogDateCol     = ''
    DbiMarker             = ''
}
[System.IO.File]::WriteAllText($incPin, ($incObj | ConvertTo-Json -Depth 4))
if (-not (Test-Path $compilePs1) -or -not (Test-Path $installPs1)) {
    $t5ok = $false
    $t5d += 'Compile-Shell.ps1 / Install-Shell.ps1 missing'
} else {
    $c5 = Invoke-ShellRunner -File $compilePs1 -ArgList @('-InstanceId', 'wp0-dev', '-Revision', '1042', '-InstancesPath', $allowPath, '-PinPath', $incPin)
    $a5 = Assert-Refuse -Run $c5 -ExpectReason 'pin_incomplete'
    if (-not $a5.ok) { $t5ok = $false; $t5d += "compile $($a5.detail)" }
    $i5 = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $okSh, '-InstancesPath', $allowPath, '-PinPath', $incPin)
    $b5 = Assert-Refuse -Run $i5 -ExpectReason 'pin_incomplete'
    if (-not $b5.ok) { $t5ok = $false; $t5d += "install $($b5.detail)" }
}
Add-Gate 'WP0-T5' $t5ok $(if ($t5ok) { 'scratch PinComplete=false => pin_incomplete, no WCF' } else { $t5d -join '; ' })

# --- WP0-T5b complete pin is not skeleton-refused (no_cred before WCF on sandbox) ---
$t5b = $true
$t5bd = @()
if (Test-Path $compilePs1) {
    $cReady = Invoke-ShellRunner -File $compilePs1 -ArgList @('-InstanceId', 'wp0-dev', '-Revision', '1042', '-InstancesPath', $allowPath, '-PinPath', $pinJson)
    if ($cReady.ExitCode -ne 2 -or -not $cReady.Json) {
        $t5b = $false
        $t5bd += "compile exit=$($cReady.ExitCode) no JSON"
    } elseif ($cReady.Json.reason -eq 'pin_incomplete') {
        $t5b = $false
        $t5bd += 'compile still pin_incomplete with PinComplete=true'
    } elseif ($cReady.Json.reason -ne 'no_cred') {
        $t5b = $false
        $t5bd += "compile reason=$($cReady.Json.reason) want no_cred"
    } elseif ($cReady.Json.wcfAttempted -eq $true) {
        $t5b = $false
        $t5bd += 'compile wcfAttempted=true on missing cred'
    }
    $iReady = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $okSh, '-InstancesPath', $allowPath, '-PinPath', $pinJson)
    if ($iReady.ExitCode -ne 2 -or -not $iReady.Json) {
        $t5b = $false
        $t5bd += "install exit=$($iReady.ExitCode) no JSON"
    } elseif ($iReady.Json.reason -eq 'pin_incomplete') {
        $t5b = $false
        $t5bd += 'install still pin_incomplete with PinComplete=true'
    } elseif ($iReady.Json.reason -ne 'no_cred') {
        $t5b = $false
        $t5bd += "install reason=$($iReady.Json.reason) want no_cred"
    } elseif ($iReady.Json.wcfAttempted -eq $true) {
        $t5b = $false
        $t5bd += 'install wcfAttempted=true on missing cred'
    }
} else {
    $t5b = $false
    $t5bd += 'runner missing'
}
Add-Gate 'WP0-T5b' $t5b $(if ($t5b) { 'PinComplete=true => no_cred (not pin_incomplete); no WCF without cred' } else { $t5bd -join '; ' })

# --- WP0-T8 refuse paths ---
$t8ok = $true
$t8d = @()
# unknown instance
$u = Invoke-ShellRunner -File $compilePs1 -ArgList @('-InstanceId', 'no-such', '-Revision', '1', '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$au = Assert-Refuse -Run $u -ExpectReason 'instance_unknown'
if (-not $au.ok) { $t8ok = $false; $t8d += "unknown $($au.detail)" }
# live refuse
$lv = Invoke-ShellRunner -File $compilePs1 -ArgList @('-InstanceId', 'demo-live', '-Revision', '1', '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$alv = Assert-Refuse -Run $lv -ExpectReason 'live_refused'
if (-not $alv.ok) { $t8ok = $false; $t8d += "live $($alv.detail)" }
# missing shell
$ms = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $missingSh, '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$ams = Assert-Refuse -Run $ms -ExpectReason 'path_refused'
if (-not $ams.ok) { $t8ok = $false; $t8d += "missing $($ams.detail)" }
# DBI without flag
$dbi = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $dbiSh, '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$adbi = Assert-Refuse -Run $dbi -ExpectReason 'dbi_refused'
if (-not $adbi.ok) { $t8ok = $false; $t8d += "dbi $($adbi.detail)" }
# path ..
$dot = Join-Path $build '..\..\..\windows\system32\cmd.exe'
$dotRun = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $dot, '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$adot = Assert-Refuse -Run $dotRun -ExpectReason 'path_refused'
if (-not $adot.ok) { $t8ok = $false; $t8d += "dotdot $($adot.detail)" }
# catalog fixture live install
$fixInstall = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $fixOk, '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$afix = Assert-Refuse -Run $fixInstall -ExpectReason 'path_refused'
if (-not $afix.ok) { $t8ok = $false; $t8d += "fixture $($afix.detail)" }
# WhatIf no WCF
$w = Invoke-ShellRunner -File $compilePs1 -ArgList @('-InstanceId', 'wp0-dev', '-Revision', '1042', '-WhatIf', '-InstancesPath', $allowPath, '-PinPath', $pinJson)
if ($w.ExitCode -ne 0 -or -not $w.Json -or $w.Json.reason -ne 'whatIf' -or $w.Json.wcfAttempted -eq $true) {
    $t8ok = $false
    $t8d += "whatIf compile exit=$($w.ExitCode) reason=$($w.Json.reason)"
}
$wi = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $okSh, '-WhatIf', '-InstancesPath', $allowPath, '-PinPath', $pinJson)
if ($wi.ExitCode -ne 0 -or -not $wi.Json -or $wi.Json.reason -ne 'whatIf' -or $wi.Json.wcfAttempted -eq $true) {
    $t8ok = $false
    $t8d += "whatIf install exit=$($wi.ExitCode) reason=$($wi.Json.reason)"
}
Add-Gate 'WP0-T8' $t8ok $(if ($t8ok) { 'unknown/live/missing/dbi/dotdot/fixture refuse exit 2; WhatIf exit 0; no WCF' } else { $t8d -join '; ' })

# --- WP0-T10 install must not auto-prep ---
$t10ok = $true
$t10d = @()
$autoTok = @('Prepare-NamedForm.ps1', 'FORMPREPDRCT', 'Invoke-WebFormPrep', 'Invoke-CliFormPrep')
$installScan = @(
    (Join-Path $installRunner 'Install-Shell.ps1'),
    (Join-Path $installPluginScripts 'Install-Shell.ps1'),
    (Join-Path $v2 'lib\wcf.ps1'),
    (Join-Path $v2 'lib\gate.ps1')
)
foreach ($sf in $installScan) {
    if (-not (Test-Path -LiteralPath $sf)) { $t10ok = $false; $t10d += "missing $sf"; continue }
    $text = Get-Content -LiteralPath $sf -Raw
    foreach ($tok in $autoTok) {
        if ($text -match [regex]::Escape($tok)) {
            $t10ok = $false
            $t10d += "${sf} auto-prep token $tok"
        }
    }
}
Add-Gate 'WP0-T10' $t10ok $(if ($t10ok) { 'install runner does not call prepare_form / FormPrep' } else { $t10d -join '; ' })

# --- WP0-T11 WhatIf handoff formsUnprepared[] ---
$t11ok = $true
$t11d = ''
if (-not $wi.Json) {
    $t11ok = $false
    $t11d = 'WhatIf install JSON missing'
} else {
    $fu = @($wi.Json.postInstall.formsUnprepared)
    if ($fu -notcontains 'ZCLA_FIXTURE_FORM') {
        $t11ok = $false
        $t11d = 'WhatIf postInstall.formsUnprepared missing ZCLA_FIXTURE_FORM; got: ' + ($fu -join ',')
    } else {
        $t11d = 'WhatIf formsUnprepared=' + ($fu -join ',')
    }
}
Add-Gate 'WP0-T11' $t11ok $t11d

# --- WP0-T12 SQL gate unit (offline) ---
. (Join-Path $v2 'lib\gate.ps1')
$t12ok = $true
$t12d = @()
$before = [pscustomobject]@{ count = 1; lastDate = [datetime]'2020-01-01' }
$afterSame = [pscustomobject]@{ count = 1; lastDate = [datetime]'2020-01-01' }
$afterMore = [pscustomobject]@{ count = 2; lastDate = [datetime]'2026-09-19' }
if (Test-InstallLogAdvanced -Before $before -After $afterSame) {
    $t12ok = $false; $t12d += 'unchanged snapshot reported advanced'
}
if (-not (Test-InstallLogAdvanced -Before $before -After $afterMore)) {
    $t12ok = $false; $t12d += 'count increase not advanced'
}
$g = New-InstallGateObject -Before $before -After $afterMore -StartedAt ([datetime]::UtcNow) -Takesingleent @('FORM_A') -MissingEnames @('FORM_A')
if ($g.entitiesPresent) { $t12ok = $false; $t12d += 'missing ENAME marked present' }
if (-not $g.logAdvanced) { $t12ok = $false; $t12d += 'gate logAdvanced false on count increase' }
$walkFake = [pscustomobject]@{ fileStepSeen = $false }
$cx = Test-WcfWalkContradiction -Pin $pinObj -Walk $walkFake
if ($cx.contradict) { $t12ok = $false; $t12d += 'null WcfFileStepWorks contradicted empty walk' }
Add-Gate 'WP0-T12' $t12ok $(if ($t12ok) { 'offline SQL gate + WcfFileStepWorks null contradiction skip' } else { $t12d -join '; ' })

# --- WP0-T13 truncated / non-shell ---
$t13ok = $true
$t13d = ''
$trunc = Join-Path $build 'truncated.sh'
[System.IO.File]::WriteAllText($trunc, "PRIORITY_SHELL 1`r`n")
$tr = Invoke-ShellRunner -File $installPs1 -ArgList @('-InstanceId', 'wp0-dev', '-Shell', $trunc, '-InstancesPath', $allowPath, '-PinPath', $pinJson)
$atr = Assert-Refuse -Run $tr -ExpectReason 'parse_failed'
if (-not $atr.ok) {
    $t13ok = $false
    $t13d = $atr.detail
} else {
    $t13d = 'truncated shell parse_failed, no WCF'
}
Add-Gate 'WP0-T13' $t13ok $t13d

# --- WP0-R* only if PRIORITY_WP0_INSTANCE is set ---
$proofId = $env:PRIORITY_WP0_INSTANCE
if ([string]::IsNullOrWhiteSpace($proofId)) {
    Add-Gate 'WP0-R-SKIP' $true 'PRIORITY_WP0_INSTANCE unset; R* skipped (no proof instance)'
} else {
    . (Join-Path $v2 'lib\sql.ps1')
    . (Join-Path $v2 'lib\Get-WinrunCredential.ps1')
    $alPath = Get-InstancesFile
    $al = Read-Allowlist -Path $alPath
    $r1ok = $true
    $r1d = ''
    $proof = $null
    if (-not $al.ok) {
        $r1ok = $false
        $r1d = 'allowlist missing'
    } else {
        $proof = @($al.instances | Where-Object { $_.id -eq $proofId } | Select-Object -First 1)
        if (-not $proof) {
            $r1ok = $false
            $r1d = "proof instance_id $proofId not in instances.json"
        } else {
            $cred = $null
            try { $cred = Get-WinrunCredential -Target ([string]$proof.credentialTarget) } catch { $cred = $null }
            if (-not $cred) {
                $r1ok = $false
                $r1d = "CredMan missing for $proofId"
            } else {
                $r1d = "proof $proofId in allowlist"
            }
        }
    }
    Add-Gate 'WP0-R1' $r1ok $r1d

    $r2ok = $false
    $r2d = 'skipped'
    $conn = $null
    if ($proof) {
        try {
            $conn = New-InstanceSqlConnection -Instance $proof
            $execTable = ConvertTo-SqlIdent 'dbo.T$EXEC'
            $n = Invoke-FormPrepSql -Connection $conn -Query "SELECT TOP 1 1 AS x FROM $execTable" -Scalar
            $r2ok = $true
            $r2d = 'SELECT TOP 1 from T$EXEC ok'
        } catch {
            $r2ok = $false
            $r2d = $_.Exception.Message
        }
    }
    Add-Gate 'WP0-R2' $r2ok $r2d

    $r3ok = $false
    $r3d = 'ExecTitleColumn unpinned; cannot search Prepare Upgrade / Install Upgrade titles'
    $candidates = @()
    if ($conn -and $pinObj -and -not (Test-ShellPinTokenEmpty $pinObj.ExecTitleColumn)) {
        try {
            $col = ConvertTo-SqlIdent $pinObj.ExecTitleColumn
            $enameCol = ConvertTo-SqlIdent 'ENAME'
            $q = @"
SELECT TOP 50 $enameCol AS ename, $col AS title
FROM $execTable
WHERE $col LIKE N'%Upgrade%' OR $col LIKE N'%Revision%'
"@
            $tbl = Invoke-FormPrepSql -Connection $conn -Query $q
            foreach ($row in $tbl.Rows) {
                $candidates += [ordered]@{ ename = [string]$row.ename; title = [string]$row.title }
            }
            if ($candidates.Count -lt 1) {
                $r3d = 'zero T$EXEC candidates for Prepare Upgrade / Install Upgrade / Version Revisions'
            } else {
                $r3ok = $true
                $r3d = "candidates=$($candidates.Count)"
                $candPath = Join-Path $repo 'v2\tests\wp0-r3-candidates.json'
                $candDoc = [pscustomobject]@{
                    instanceId = $proofId
                    when       = [datetime]::UtcNow.ToString('o')
                    candidates = @($candidates)
                    note       = 'Does not overwrite docs/wp0-recon.md (human pin recon).'
                }
                [System.IO.File]::WriteAllText($candPath, ($candDoc | ConvertTo-Json -Depth 6))
            }
        } catch {
            $r3d = $_.Exception.Message
        }
    }
    Add-Gate 'WP0-R3' $r3ok $r3d

    $r4ok = $true
    $r4d = 'PinComplete=false; pin match skipped'
    if ($pinObj -and $pinObj.PinComplete) {
        $r4ok = $false
        $r4d = 'PinComplete=true but pinned ENAME not verified on this instance'
        if ($conn) {
            try {
                $enameCol = ConvertTo-SqlIdent 'ENAME'
                $need = @(
                    [string]$pinObj.PrepareUpgradeEname,
                    [string]$pinObj.InstallUpgradeEname,
                    [string]$pinObj.VersionRevisionsEname
                ) | Where-Object { -not (Test-ShellPinTokenEmpty $_) }
                $missingE = @()
                foreach ($n in $need) {
                    $hit = Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM $execTable WHERE $enameCol = @n" -Parameters @{ '@n' = $n } -Scalar
                    if ([int]$hit -lt 1) { $missingE += $n }
                }
                if ($missingE.Count -eq 0 -and $need.Count -gt 0) {
                    $r4ok = $true
                    $r4d = 'pinned ENAMEs present in T$EXEC: ' + ($need -join ', ')
                } else {
                    $r4d = 'pinned ENAME not in T$EXEC: ' + ($missingE -join ', ')
                }
            } catch { $r4d = $_.Exception.Message }
        }
    }
    Add-Gate 'WP0-R4' $r4ok $r4d

    $r5ok = $true
    $r5d = 'no upgrades/agentWork configured'
    $probePath = $null
    if ($proof -and $proof.agentWork) { $probePath = [string]$proof.agentWork }
    if ($pinObj -and $pinObj.UpgradesDir) { $probePath = [string]$pinObj.UpgradesDir }
    if ($proof -and $proof.buildSetRoot) { $probePath = [string]$proof.buildSetRoot }
    if ($probePath) {
        $r5ok = Test-Path -LiteralPath $probePath
        $r5d = $(if ($r5ok) { "reachable $probePath" } else { "not reachable $probePath" })
    }
    Add-Gate 'WP0-R5' $r5ok $r5d

    $r6ok = $true
    $r6d = 'no webBaseUrl'
    if ($proof -and $proof.webBaseUrl) {
        try {
            $resp = Invoke-WebRequest -Uri ([string]$proof.webBaseUrl) -UseBasicParsing -TimeoutSec 15 -MaximumRedirection 0 -ErrorAction Stop
            $r6ok = $true
            $r6d = "webBaseUrl HTTP $($resp.StatusCode)"
        } catch {
            $ex = $_.Exception
            if ($ex.Response) {
                $r6ok = $true
                $r6d = 'webBaseUrl responded (non-success HTTP still a host)'
            } else {
                $r6ok = $false
                $r6d = 'login/host probe failed: ' + $ex.Message
            }
        }
    }
    Add-Gate 'WP0-R6' $r6ok $r6d

    $r7ok = $true
    $r7d = 'WcfFileStepWorks null; no contradiction without a walk transcript'
    if ($pinObj) {
        $walkPath = $null
        if ($proof -and $proof.agentWork) {
            $candWalk = Join-Path ([string]$proof.agentWork) 'last-wcf-walk.json'
            if (Test-Path -LiteralPath $candWalk) { $walkPath = $candWalk }
        }
        $walkObj = $null
        if ($walkPath) {
            try { $walkObj = Get-Content -LiteralPath $walkPath -Raw | ConvertFrom-Json } catch { $walkObj = $null }
        }
        . (Join-Path $v2 'lib\gate.ps1')
        $cx = Test-WcfWalkContradiction -Pin $pinObj -Walk $walkObj
        if ($cx.contradict) {
            $r7ok = $false
            $r7d = $cx.detail
        } else {
            $r7d = $cx.detail
        }
    }
    Add-Gate 'WP0-R7' $r7ok $r7d

    if ($conn) { try { $conn.Close(); $conn.Dispose() } catch { } }
}

# evidence
$evidenceDir = Join-Path $v2 'tests'
New-Item -ItemType Directory -Path $evidenceDir -Force | Out-Null
$evidence = [pscustomobject]@{
    when        = [datetime]::UtcNow.ToString('o')
    failed      = $failed
    pinComplete = [bool]$(if ($pinObj) { [bool]$pinObj.PinComplete } else { $false })
    gates       = @($gates)
    candidates  = @()
}
$evPath = Join-Path $evidenceDir 'wp0-last.json'
[System.IO.File]::WriteAllText($evPath, ($evidence | ConvertTo-Json -Depth 8))
Write-Host "wrote $evPath"

try { Remove-Item -LiteralPath $scratch -Recurse -Force -ErrorAction SilentlyContinue } catch { }

if ($failed -gt 0) {
    Write-Host "WP0 FAIL $failed gate(s)"
    exit 2
}
Write-Host 'WP0 PASS'
exit 0
