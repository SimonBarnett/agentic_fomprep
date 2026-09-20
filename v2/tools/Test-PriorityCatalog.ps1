#requires -Version 5.1
<#
.SYNOPSIS
    Offline gates for Priority skills catalog A-D + OData plugin. No live OData/SQL.
#>
[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$v2 = Split-Path -Parent $PSScriptRoot
$repo = Split-Path -Parent $v2
$failed = 0

function Add-Gate {
    param([string]$Id, [bool]$Pass, [string]$Detail)
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

function Get-JsonLastLine {
    param([string]$Text)
    if ([string]::IsNullOrWhiteSpace($Text)) { return $null }
    $lines = $Text -split '\r?\n'
    for ($i = $lines.Length - 1; $i -ge 0; $i--) {
        $t = $lines[$i].Trim()
        if ($t.StartsWith('{')) { return $t }
    }
    return $null
}

function Invoke-ODataRunner {
    param([string[]]$ArgList)
    $file = Join-Path $v2 'plugins\priority-odata-dev\scripts\Invoke-PriorityOData.ps1'
    $all = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $file) + $ArgList
    $out = & powershell.exe @all 2>&1 | Out-String
    $code = $LASTEXITCODE
    $jsonText = Get-JsonLastLine $out
    $obj = $null
    if ($jsonText) {
        try { $obj = $jsonText | ConvertFrom-Json } catch { $obj = $null }
    }
    return [pscustomobject]@{
        ExitCode = $code
        StdOut   = $out
        Json     = $obj
    }
}

$catalog = Join-Path $v2 'apps\mcp-catalog\catalog'
$expected = @(
    'ce-priority-project-create-smoke',
    'ce-priority-day-works-uat',
    'prepare-all-unprepared-priority-forms',
    'ce-priority-ht-delete-smoke',
    'priority-odata-dev',
    'priority-form-engineering',
    'priority-uat-orchestrator',
    'priority-formprep',
    'priority-shell-compile',
    'priority-shell-install'
)
$missing = @()
foreach ($n in $expected) {
    $dir = Join-Path $catalog $n
    foreach ($f in @('meta.json', 'SKILL.md')) {
        $p = Join-Path $dir $f
        if (-not (Test-Path -LiteralPath $p)) { $missing += "$n/$f" }
    }
}
Add-Gate 'CAT-T1' ($missing.Count -eq 0) $(if ($missing.Count -eq 0) { 'catalog meta.json + SKILL.md for A-D' } else { $missing -join '; ' })

$odataSkill = Get-Content -LiteralPath (Join-Path $catalog 'priority-odata-dev\SKILL.md') -Raw -Encoding UTF8
$footgunOk = ($odataSkill -match 'FORMLIMITED') -and ($odataSkill -match 'RESTFLAG') -and ($odataSkill -match 'LIMITFLAG') -and ($odataSkill -match 'sibling-tab')
Add-Gate 'CAT-T2' $footgunOk 'priority-odata-dev SKILL.md documents FORMLIMITED/RESTFLAG footgun'

$pluginSkill = Join-Path $v2 'plugins\priority-odata-dev\skills\priority-odata-dev\SKILL.md'
Add-Gate 'CAT-T3' (Test-Path -LiteralPath $pluginSkill) 'plugin SKILL.md present'

$mcpTs = Get-Content -LiteralPath (Join-Path $v2 'apps\mcp-catalog\lib\mcp.ts') -Raw -Encoding UTF8
$grabOnly = ($mcpTs -notmatch 'odata_get') -and ($mcpTs -notmatch 'odata_dump_procedure') -and ($mcpTs -notmatch 'formlimited_audit') -and ($mcpTs -match 'list_catalog')
Add-Gate 'CAT-T4' $grabOnly 'catalog MCP handlers stay grab-only (no odata_get)'

Push-Location $repo
$v1diff = & git diff -- src/Prepare-NamedForm.ps1 2>$null | Out-String
$pindiff = & git diff -- v2/config/pin.json v2/config/pin.psd1 2>$null | Out-String
Pop-Location
Add-Gate 'CAT-T5' ([string]::IsNullOrWhiteSpace($v1diff)) 'src\Prepare-NamedForm.ps1 untouched'
Add-Gate 'CAT-T6' ([string]::IsNullOrWhiteSpace($pindiff)) 'pin.json / pin.psd1 untouched (no guessed ENAMEs)'

$market = Get-Content -LiteralPath (Join-Path $repo '.grok-plugin\marketplace.json') -Raw | ConvertFrom-Json
$plugNames = @($market.plugins | ForEach-Object { $_.name })
Add-Gate 'CAT-T7' ($plugNames -contains 'priority-odata-dev') 'marketplace.json lists priority-odata-dev'

$lib = Join-Path $v2 'plugins\priority-odata-dev\scripts\lib'
. (Join-Path $lib 'odata.ps1')

$ex = [pscustomobject]@{
    webBaseUrl = 'https://prioritydev.clarksonevans.co.uk'
    tabulaini  = 'tabula.ini'
    company    = 'base'
}
$derived = Get-ODataBaseUrl -Instance $ex
Add-Gate 'CAT-T8' ($derived -eq 'https://prioritydev.clarksonevans.co.uk/odata/Priority/tabula.ini/base') "derived OData base $derived"

$joinedOk = Join-ODataUrl -Base $derived -RelPath 'EPROG'
$joinedBad = Join-ODataUrl -Base $derived -RelPath '../secret'
$joinedUrl = Join-ODataUrl -Base $derived -RelPath 'https://evil.example/odata'
Add-Gate 'CAT-T9' ($joinedOk.ok -and -not $joinedBad.ok -and -not $joinedUrl.ok) 'OData path stays under instance base'

$riskBad = Get-FormLimitedRiskClass -LimitFlag '' -RestFlag 'Y'
$riskOk = Get-FormLimitedRiskClass -LimitFlag 'Y' -RestFlag 'Y'
$riskNone = Get-FormLimitedRiskClass -LimitFlag '' -RestFlag ''
Add-Gate 'CAT-T10' ($riskBad -eq 'restflag_without_limitflag' -and $riskOk -eq 'restflag_with_limitflag_unconfirmed' -and $riskNone -eq 'none') 'RESTFLAG/LIMITFLAG classifier'

$fxDump = Get-Content -LiteralPath (Join-Path $v2 'plugins\priority-odata-dev\fixtures\eprog-dump.json') -Raw | ConvertFrom-Json
$steps = @(Get-ProgTextSteps -ODataValue $fxDump)
$texts = @($steps | ForEach-Object { [string]$_.text })
$stepOk = ($texts -contains 'SELECT :ELEMENT FROM PROJACT WHERE PROJACT < 0') -and ($texts -contains ':ELEMENT = - :ELEMENT') -and (@($steps | Where-Object { $_.source -eq 'PROCTABLETEXT' }).Count -eq 0)
Add-Gate 'CAT-T11' $stepOk ('PROGTEXT_SUBFORM preferred over empty PROCTABLETEXT (steps=' + $steps.Count + ')')

$tmp = Join-Path $env:TEMP ('odata-cat-' + [guid]::NewGuid().ToString('n'))
New-Item -ItemType Directory -Path $tmp -Force | Out-Null
$instPath = Join-Path $tmp 'instances.json'
$livePath = Join-Path $tmp 'live.json'
@{
    instances = @(
        @{
            id               = 'fixture-dev'
            title            = 'Fixture DEV'
            webBaseUrl       = 'https://priority.example.com'
            sqlInstance      = 'sql.example.com\DEV'
            sqlDatabase      = 'system'
            company          = 'base'
            priorityUser     = 'Si'
            credentialTarget = 'Priority/FormPrep/fixture'
            tabulaini        = 'tabula.ini'
            allowLive        = $false
            agentWork        = $tmp
        }
    )
} | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $instPath -Encoding UTF8
@{
    instances = @(
        @{
            id               = 'ce-live'
            title            = 'Clarkson Evans Live'
            webBaseUrl       = 'https://priority.example.com'
            sqlInstance      = 'sql.example.com\LIVE'
            sqlDatabase      = 'system'
            company          = 'pri'
            priorityUser     = 'Si'
            credentialTarget = 'Priority/FormPrep/fixture'
            allowLive        = $false
            agentWork        = $tmp
        }
    )
} | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $livePath -Encoding UTF8

$env:PRIORITY_ODATA_PASSWORD = 'fixture-secret-do-not-emit'
$env:PRIORITY_ODATA_USER = 'Si'
try {
    $unknown = Invoke-ODataRunner @(
        '-Action', 'get', '-InstanceId', 'no-such', '-Path', 'EPROG',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\odata-get.json')
    )
    Add-Gate 'CAT-T12' ($unknown.ExitCode -eq 2 -and $unknown.Json.reason -eq 'instance_unknown') 'unknown instance refused'

    $live = Invoke-ODataRunner @(
        '-Action', 'get', '-InstanceId', 'ce-live', '-Path', 'EPROG',
        '-InstancesPath', $livePath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\odata-get.json')
    )
    Add-Gate 'CAT-T13' ($live.ExitCode -eq 2 -and $live.Json.reason -eq 'live_refused') 'live/PRI refused'

    $pathBad = Invoke-ODataRunner @(
        '-Action', 'get', '-InstanceId', 'fixture-dev', '-Path', '../secret',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\odata-get.json')
    )
    Add-Gate 'CAT-T14' ($pathBad.ExitCode -eq 2 -and $pathBad.Json.reason -eq 'path_refused') 'escaped OData path refused'

    $dump = Invoke-ODataRunner @(
        '-Action', 'dump_procedure', '-InstanceId', 'fixture-dev', '-EName', 'SAMPLEPROG',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\eprog-dump.json')
    )
    $dumpOk = $dump.ExitCode -eq 0 -and $dump.Json.ok -eq $true -and $dump.Json.dumpPath -and (Test-Path -LiteralPath ([string]$dump.Json.dumpPath))
    $noSecret = $dump.StdOut -notmatch 'fixture-secret-do-not-emit'
    if ($dump.Json.dumpPath -and (Test-Path -LiteralPath ([string]$dump.Json.dumpPath))) {
        $dumpBody = Get-Content -LiteralPath ([string]$dump.Json.dumpPath) -Raw
        if ($dumpBody -match 'fixture-secret-do-not-emit') { $noSecret = $false }
    }
    $hasSteps = $false
    if ($dump.Json.steps) { $hasSteps = @($dump.Json.steps).Count -ge 2 }
    Add-Gate 'CAT-T15' ($dumpOk -and $noSecret -and $hasSteps) $(if ($dumpOk -and $noSecret -and $hasSteps) { 'dump_procedure fixture writes work dir, no secret' } else { "exit=$($dump.ExitCode) reason=$($dump.Json.reason) secret=$noSecret steps=$hasSteps" })

    $fg = Invoke-ODataRunner @(
        '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev', '-Forms', 'PARTLONGDESC,PART',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-footgun.json')
    )
    Add-Gate 'CAT-T16' ($fg.ExitCode -eq 2 -and $fg.Json.reason -eq 'restflag_without_limitflag') 'formlimited_audit flags RESTFLAG-only footgun'

    $cl = Invoke-ODataRunner @(
        '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev', '-Forms', 'PART',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-clean.json')
    )
    Add-Gate 'CAT-T17' ($cl.ExitCode -eq 0 -and $cl.Json.ok -eq $true) 'formlimited_audit clean fixture ok'

    $noForms = Invoke-ODataRunner @(
        '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-clean.json')
    )
    Add-Gate 'CAT-T18' ($noForms.ExitCode -eq 2 -and $noForms.Json.reason -eq 'forms_required') 'formlimited_audit requires a form set'
} finally {
    Remove-Item Env:PRIORITY_ODATA_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:PRIORITY_ODATA_USER -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
}

$eng = Get-Content -LiteralPath (Join-Path $catalog 'priority-form-engineering\SKILL.md') -Raw -Encoding UTF8
$engOk = ($eng -match 'Prepare-NamedForm\.ps1') -and ($eng -match 'ZCLA_CHKPNT-DEL') -and ($eng -match 'Do \*\*not\*\* edit')
Add-Gate 'CAT-T19' $engOk 'form-engineering points at v1 Prepare-NamedForm; HT PRE-DELETE'

$uat = Get-Content -LiteralPath (Join-Path $catalog 'priority-uat-orchestrator\SKILL.md') -Raw -Encoding UTF8
$uatOk = ($uat -match 'CASE') -and ($uat -match 'DOCNO') -and ($uat -match 'UNPARK') -and ($uat -match 'Jester') -and ($uat -match 'PR25000001') -and ($uat -match 'ce-priority-ht-delete-smoke')
Add-Gate 'CAT-T20' $uatOk 'UAT orchestrator UNPARK/CASE + Jester harvest note'

$create = Get-Content -LiteralPath (Join-Path $catalog 'ce-priority-project-create-smoke\SKILL.md') -Raw -Encoding UTF8
$createOk = ($create -match 'ZGEM_ERR_NOTINTEAM') -and ($create -match 'PV system') -and ($create -match 'EL=5') -and ($create -match 'SNG-ROW') -and ($create -match 'TC-01b')
Add-Gate 'CAT-T22' $createOk 'project-create smoke has Jester TC-01-05 detail'

$dw = Get-Content -LiteralPath (Join-Path $catalog 'ce-priority-day-works-uat\SKILL.md') -Raw -Encoding UTF8
$dwOk = ($dw -match 'ZCLA_DAYWORKS') -and ($dw -match 'DW-B1') -and ($dw -match 'PARTLONGDESC') -and ($dw -match 'PARKED') -and ($dw -match 'UNPARK')
Add-Gate 'CAT-T23' $dwOk 'Day Works A-B fleshed; C-G parked until UNPARK'

$ht = Get-Content -LiteralPath (Join-Path $catalog 'ce-priority-ht-delete-smoke\SKILL.md') -Raw -Encoding UTF8
$htOk = ($ht -match 'ZCLA_HTEDIT') -and ($ht -match '1205') -and ($ht -match 'HOUSETYPEID') -and ($ht -match 'prioritytest')
Add-Gate 'CAT-T24' $htOk 'HT-DL smoke catalog present with TEST company pitfall'

$runnerPs1 = Join-Path $catalog 'priority-odata-dev\runner\Invoke-PriorityOData.ps1'
Add-Gate 'CAT-T21' (Test-Path -LiteralPath $runnerPs1) 'catalog runner files present for get_runner_files'

$odataRunner = Join-Path $v2 'plugins\priority-odata-dev\scripts\Invoke-PriorityOData.ps1'
$odataSrc = Get-Content -LiteralPath $odataRunner -Raw -Encoding UTF8
$runnerOdataSrc = Get-Content -LiteralPath $runnerPs1 -Raw -Encoding UTF8
function Test-FormlimitedAuditSqlShape {
    param([string]$Src)
    ($Src -match 'ConvertTo-SqlIdent ''dbo\.FORMLIMITED''') -and
        ($Src -match 'ConvertTo-SqlIdent ''dbo\.T\$EXEC''') -and
        ($Src -match 'WHERE E\.\$eName IN \(\$\(\$ph -join ') -and
        ($Src -notmatch '\("\s*\+\s*\(\$ph -join') -and
        ($Src -notmatch 'FORMLIMITED WHERE FORM')
}
$sqlShapeOk = (Test-FormlimitedAuditSqlShape $odataSrc) -and (Test-FormlimitedAuditSqlShape $runnerOdataSrc)
Add-Gate 'CAT-T25' $sqlShapeOk 'formlimited_audit SQL: T$EXEC join + IN list expanded in here-string (not plus-concat)'

if ($failed -gt 0) {
    Write-Host "Test-PriorityCatalog FAIL ($failed)"
    exit 1
}
Write-Host 'Test-PriorityCatalog PASS'
exit 0
