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
    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    $out = & powershell.exe @all 2>&1 | ForEach-Object { "$_" } | Out-String
    $ErrorActionPreference = $prevEap
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
    'priority-project-create-smoke',
    'priority-day-works-uat',
    'prepare-all-unprepared-priority-forms',
    'priority-ht-delete-smoke',
    'priority-odata-dev',
    'priority-form-engineering',
    'priority-uat-orchestrator',
    'priority-formprep',
    'priority-shell-compile',
    'priority-shell-install',
    'priority-backup-standard',
    'priority-backup-audit',
    'priority-backup-cutover',
    'priority-sunday-backup-check',
    'priority-instance-health-collect',
    'priority-post-move-health',
    'priority-disk-mount-layout-report',
    'priority-ht-delete-deadlock-triage',
    'priority-form-prep-after-sql-change',
    'priority-hours-handoff-haitch',
    'priority-procedure-style',
    'priority-sql-udate-user',
    'priority-formprep-shadow-tables',
    'priority-recalc-concurrency',
    'priority-version-revision-discipline'
)
$missing = @()
foreach ($n in $expected) {
    $dir = Join-Path $catalog $n
    foreach ($f in @('meta.json', 'SKILL.md')) {
        $p = Join-Path $dir $f
        if (-not (Test-Path -LiteralPath $p)) { $missing += "$n/$f" }
    }
}
Add-Gate 'CAT-T1' ($missing.Count -eq 0) $(if ($missing.Count -eq 0) { 'catalog meta.json + SKILL.md for A-D + programming' } else { $missing -join '; ' })

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
Pop-Location
Add-Gate 'CAT-T5' ([string]::IsNullOrWhiteSpace($v1diff)) 'src\Prepare-NamedForm.ps1 untouched'
. (Join-Path $v2 'lib\pin.ps1')
. (Join-Path $v2 'lib\sql.ps1')
. (Join-Path $v2 'plugins\priority-odata-dev\scripts\lib\formlimited-audit-sql.ps1')
$pinJsonPath = Join-Path $v2 'config\pin.json'
$pinPsd1Path = Join-Path $v2 'config\pin.psd1'
$pinFromJson = Convert-ShellPinObject -Raw (Get-Content -LiteralPath $pinJsonPath -Raw | ConvertFrom-Json)
$pinFromPsd1 = Convert-ShellPinObject -Raw (Import-PowerShellDataFile -Path $pinPsd1Path)
$formLimitedPinKeys = @('FormLimitedTable', 'FormLimitedExecCol')
$sqlGapsJson = @(Get-SqlPinGaps -Pin $pinFromJson | Where-Object { $_ -notin $formLimitedPinKeys })
$sqlGapsPsd1 = @(Get-SqlPinGaps -Pin $pinFromPsd1 | Where-Object { $_ -notin $formLimitedPinKeys })
$formGapsJson = @(Get-FormPrepSqlPinGaps -Pin $pinFromJson | Where-Object { $_ -notin $formLimitedPinKeys })
$flExecUnpinned = (Test-ShellPinTokenEmpty $pinFromJson.FormLimitedExecCol) -and (Test-ShellPinTokenEmpty $pinFromPsd1.FormLimitedExecCol)
$t6ok = ($sqlGapsJson.Count -eq 0) -and ($sqlGapsPsd1.Count -eq 0) -and ($formGapsJson.Count -eq 0) -and $flExecUnpinned -and ([bool]$pinFromJson.PinComplete -eq [bool]$pinFromPsd1.PinComplete)
Add-Gate 'CAT-T6' $t6ok $(if ($t6ok) { 'pin.json + pin.psd1 SQL pins populated; FormLimitedExecCol unpinned' } else { 'SQL pin gaps json=' + ($sqlGapsJson -join ',') + ' psd1=' + ($sqlGapsPsd1 -join ',') + ' flExecUnpinned=' + $flExecUnpinned })

$composePinPath = Join-Path $repo 'tests\fixtures\v2-formlimited-audit-compose-pin.json'
$pinForFormLimitedAudit = Convert-ShellPinObject -Raw (Get-Content -LiteralPath $composePinPath -Raw | ConvertFrom-Json)

$market = Get-Content -LiteralPath (Join-Path $repo '.grok-plugin\marketplace.json') -Raw | ConvertFrom-Json
$plugNames = @($market.plugins | ForEach-Object { $_.name })
Add-Gate 'CAT-T7' ($plugNames -contains 'priority-odata-dev') 'marketplace.json lists priority-odata-dev'

$lib = Join-Path $v2 'plugins\priority-odata-dev\scripts\lib'
. (Join-Path $lib 'sql.ps1')
. (Join-Path $lib 'pin.ps1')
. (Join-Path $lib 'formlimited-audit-sql.ps1')
. (Join-Path $lib 'odata.ps1')
$pinJsonPath = Join-Path $v2 'config\pin.json'
$pinFromJson = (Read-ShellPin -Path $pinJsonPath -StartDir $PSScriptRoot).pin

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
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-footgun.json'),
        '-PinPath', $composePinPath
    )
    Add-Gate 'CAT-T16' ($fg.ExitCode -eq 2 -and $fg.Json.reason -eq 'restflag_without_limitflag') 'formlimited_audit flags RESTFLAG-only footgun'

    $cl = Invoke-ODataRunner @(
        '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev', '-Forms', 'PART',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-clean.json'),
        '-PinPath', $composePinPath
    )
    Add-Gate 'CAT-T17' ($cl.ExitCode -eq 0 -and $cl.Json.ok -eq $true) 'formlimited_audit clean fixture ok'

    $noForms = Invoke-ODataRunner @(
        '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-clean.json'),
        '-PinPath', $composePinPath
    )
    Add-Gate 'CAT-T18' ($noForms.ExitCode -eq 2 -and $noForms.Json.reason -eq 'forms_required') 'formlimited_audit requires a form set'

    $pinIncomplete = Invoke-ODataRunner @(
        '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev', '-Forms', 'PART',
        '-InstancesPath', $instPath, '-FixturePath', (Join-Path $v2 'plugins\priority-odata-dev\fixtures\formlimited-clean.json'),
        '-PinPath', $pinJsonPath
    )
    Add-Gate 'CAT-T6b' ($pinIncomplete.ExitCode -eq 2 -and $pinIncomplete.Json.reason -eq 'pin_incomplete') 'production pin refuses formlimited_audit when FormLimitedExecCol unpinned'
} finally {
    Remove-Item Env:PRIORITY_ODATA_PASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:PRIORITY_ODATA_USER -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
}

$eng = Get-Content -LiteralPath (Join-Path $catalog 'priority-form-engineering\SKILL.md') -Raw -Encoding UTF8
$engOk = ($eng -match 'Prepare-NamedForm\.ps1') -and ($eng -match 'ZCLA_CHKPNT-DEL') -and ($eng -match 'Do \*\*not\*\* edit')
Add-Gate 'CAT-T19' $engOk 'form-engineering points at v1 Prepare-NamedForm; HT PRE-DELETE'

$uat = Get-Content -LiteralPath (Join-Path $catalog 'priority-uat-orchestrator\SKILL.md') -Raw -Encoding UTF8
$uatOk = ($uat -match 'CASE') -and ($uat -match 'DOCNO') -and ($uat -match 'UNPARK') -and ($uat -match 'Jester') -and ($uat -match 'PR25000001') -and ($uat -match 'priority-ht-delete-smoke')
Add-Gate 'CAT-T20' $uatOk 'UAT orchestrator UNPARK/CASE + Jester harvest note'

$create = Get-Content -LiteralPath (Join-Path $catalog 'priority-project-create-smoke\SKILL.md') -Raw -Encoding UTF8
$createOk = ($create -match 'ZGEM_ERR_NOTINTEAM') -and ($create -match 'PV system') -and ($create -match 'EL=5') -and ($create -match 'SNG-ROW') -and ($create -match 'TC-01b')
Add-Gate 'CAT-T22' $createOk 'project-create smoke has Jester TC-01-05 detail'

$dw = Get-Content -LiteralPath (Join-Path $catalog 'priority-day-works-uat\SKILL.md') -Raw -Encoding UTF8
$dwOk = ($dw -match 'ZCLA_DAYWORKS') -and ($dw -match 'DW-B1') -and ($dw -match 'PARTLONGDESC') -and ($dw -match 'PARKED') -and ($dw -match 'UNPARK')
Add-Gate 'CAT-T23' $dwOk 'Day Works A-B fleshed; C-G parked until UNPARK'

$ht = Get-Content -LiteralPath (Join-Path $catalog 'priority-ht-delete-smoke\SKILL.md') -Raw -Encoding UTF8
$htOk = ($ht -match 'ZCLA_HTEDIT') -and ($ht -match '1205') -and ($ht -match 'HOUSETYPEID') -and ($ht -match 'prioritytest')
Add-Gate 'CAT-T24' $htOk 'HT-DL smoke catalog present with TEST company pitfall'

$runnerPs1 = Join-Path $catalog 'priority-odata-dev\runner\Invoke-PriorityOData.ps1'
Add-Gate 'CAT-T21' (Test-Path -LiteralPath $runnerPs1) 'catalog runner files present for get_runner_files'

$fixtureInst = Join-Path $env:TEMP ('cat-compose-inst-' + [guid]::NewGuid().ToString('n') + '.json')
@{
    instances = @(
        @{
            id          = 'fixture-dev'
            title       = 'Fixture DEV'
            webBaseUrl  = 'https://priority.example.com'
            sqlInstance = 'sql.example.com\DEV'
            sqlDatabase = 'system'
            company     = 'base'
            allowLive   = $false
        }
    )
} | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $fixtureInst -Encoding UTF8
$compose = Invoke-ODataRunner @(
    '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev', '-Forms', 'PARTLONGDESC,PART',
    '-InstancesPath', $fixtureInst, '-ComposeSql', '-PinPath', $composePinPath
)
Remove-Item -LiteralPath $fixtureInst -Force -ErrorAction SilentlyContinue
$formsUnderTest = @('PARTLONGDESC', 'PART')
$composedOk = $false
$composedDetail = 'compose runner failed'
if ($compose.ExitCode -eq 0 -and $compose.Json -and $compose.Json.sql) {
    $paramHt = @{}
    foreach ($ph in @($compose.Json.sqlParameters)) {
        $idx = [int]($ph -replace '^@f', '')
        $paramHt[$ph] = $formsUnderTest[$idx]
    }
    $composedOk = Test-FormLimitedAuditComposed -Sql ([string]$compose.Json.sql) -Parameters $paramHt -FormNames $formsUnderTest -Pin $pinForFormLimitedAudit
    $composedDetail = if ($composedOk) { 'formlimited_audit composed SQL + bound @fN placeholders' } else { 'composed SQL failed structural assert' }
}
Add-Gate 'CAT-T25' $composedOk $composedDetail

$builtBase = New-FormLimitedAuditSql -Pin $pinForFormLimitedAudit -FormNames $formsUnderTest
$mutNoBind = Test-FormLimitedAuditComposed -Sql $builtBase.Sql -Parameters @{} -FormNames $formsUnderTest -Pin $pinForFormLimitedAudit
$flExecIdent = ConvertTo-SqlIdent ([string]$pinForFormLimitedAudit.FormLimitedExecCol)
$execIdIdent = ConvertTo-SqlIdent ([string]$pinForFormLimitedAudit.ExecIdCol)
$execNameIdent = ConvertTo-SqlIdent ([string]$pinForFormLimitedAudit.ExecNameCol)
$goodJoin = 'FL.' + $flExecIdent + ' = E.' + $execIdIdent
$badJoinNeedle = 'FL.' + $flExecIdent + ' = E.' + $execNameIdent
$mutBadJoin = $builtBase.Sql -replace [regex]::Escape($goodJoin), $badJoinNeedle
$mutBadJoinFail = -not (Test-FormLimitedAuditComposed -Sql $mutBadJoin -Parameters $builtBase.Parameters -FormNames $formsUnderTest -Pin $pinForFormLimitedAudit)
$mutInline = $builtBase.Sql -replace '@f0', "'PARTLONGDESC'"
$mutInlineFail = -not (Test-FormLimitedAuditComposed -Sql $mutInline -Parameters $builtBase.Parameters -FormNames $formsUnderTest -Pin $pinForFormLimitedAudit)
Add-Gate 'CAT-T26' ((-not $mutNoBind) -and $mutBadJoinFail -and $mutInlineFail) 'formlimited_audit mutation bar: no-bind, bad-join, inline literal turn gate red'

$dbaIds = @(
    'priority-backup-standard',
    'priority-backup-audit',
    'priority-backup-cutover',
    'priority-sunday-backup-check',
    'priority-instance-health-collect',
    'priority-post-move-health',
    'priority-disk-mount-layout-report',
    'priority-ht-delete-deadlock-triage',
    'priority-form-prep-after-sql-change',
    'priority-hours-handoff-haitch'
)
$dbaFrontMissing = @()
foreach ($dbaId in $dbaIds) {
    $skillPath = Join-Path $catalog "$dbaId\SKILL.md"
    if (-not (Test-Path -LiteralPath $skillPath)) { $dbaFrontMissing += $dbaId; continue }
    $raw = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    if ($raw -notmatch '(?m)^name:\s*' + [regex]::Escape($dbaId)) { $dbaFrontMissing += "$dbaId/name" }
    if ($raw -notmatch '(?m)^description:\s*>?') { $dbaFrontMissing += "$dbaId/description" }
}
Add-Gate 'CAT-T27' ($dbaFrontMissing.Count -eq 0) $(if ($dbaFrontMissing.Count -eq 0) { 'DBA skills frontmatter name+description' } else { $dbaFrontMissing -join '; ' })

$std = Get-Content -LiteralPath (Join-Path $catalog 'priority-backup-standard\SKILL.md') -Raw -Encoding UTF8
$stdOk = (($std -match 'integrated auth') -or ($std -match 'Integrated Security')) -and ($std -match 'Do \*\*not\*\* prune')
Add-Gate 'CAT-T28' $stdOk 'backup-standard documents no F: prune without confirm'

$formGate = Get-Content -LiteralPath (Join-Path $catalog 'priority-form-prep-after-sql-change\SKILL.md') -Raw -Encoding UTF8
Add-Gate 'CAT-T29' ($formGate -match 'prepare-all-unprepared-priority-forms') 'form-prep-after-sql-change links batch form prep skill'

$htTri = Get-Content -LiteralPath (Join-Path $catalog 'priority-ht-delete-deadlock-triage\SKILL.md') -Raw -Encoding UTF8
Add-Gate 'CAT-T30' (($htTri -match '1205') -and ($htTri -notmatch 'ALTER INDEX')) 'HT deadlock triage evidence-only'
Add-Gate 'CAT-T30b' (($htTri -match 'priority-ht-delete-smoke') -and ($htTri -notmatch 'ce-priority-ht-delete-smoke') -and ($htTri -match 'priority-recalc-concurrency')) 'HT triage links priority-ht-delete-smoke and recalc-concurrency'

$progIds = @(
    'priority-procedure-style',
    'priority-sql-udate-user',
    'priority-formprep-shadow-tables',
    'priority-recalc-concurrency',
    'priority-version-revision-discipline'
)
$progMissing = @()
foreach ($progId in $progIds) {
    $skillPath = Join-Path $catalog "$progId\SKILL.md"
    $metaPath = Join-Path $catalog "$progId\meta.json"
    if (-not (Test-Path -LiteralPath $skillPath)) { $progMissing += "$progId/SKILL.md"; continue }
    $raw = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    if ($raw -notmatch '(?m)^name:\s*' + [regex]::Escape($progId)) { $progMissing += "$progId/name" }
    if ($raw -notmatch '(?m)^description:\s*>?') { $progMissing += "$progId/description" }
    if (-not (Test-Path -LiteralPath $metaPath)) { $progMissing += "$progId/meta.json"; continue }
    $meta = Get-Content -LiteralPath $metaPath -Raw -Encoding UTF8 | ConvertFrom-Json
    if ([string]$meta.name -ne $progId) { $progMissing += "$progId/meta.name" }
    if ([string]$meta.version -ne '1.0.0') { $progMissing += "$progId/meta.version" }
    if ($meta.PSObject.Properties.Name -notcontains 'title' -or $meta.PSObject.Properties.Name -notcontains 'description') {
        $progMissing += "$progId/meta.shape"
    }
}
$progSrc = @('MANIFEST.md', 'PROCEDURE_STYLE.md', 'SQL_UDATE_USER.md', 'FORMPREP_SHADOW_TABLES.md', 'RECALC_CONCURRENCY.md', 'VERSION_REVISION.md', 'SDK_FEATURE_MAP.md')
$progSrcRoot = Join-Path $repo 'docs\skill-sources\programming'
foreach ($srcName in $progSrc) {
    if (-not (Test-Path -LiteralPath (Join-Path $progSrcRoot $srcName))) { $progMissing += "programming/$srcName" }
}
$progSecretRoots = @($progSrcRoot)
foreach ($progId in $progIds) { $progSecretRoots += (Join-Path $catalog $progId) }
foreach ($root in $progSecretRoots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -Path $root -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if ($text -and ($text -match '(?i)(password\s*=|XAI_API_KEY\s*=)')) { $progMissing += ("secret:" + $_.Name) }
    }
}
Add-Gate 'CAT-T41' ($progMissing.Count -eq 0) $(if ($progMissing.Count -eq 0) { 'programming skills meta version 1.0.0 + skill-sources' } else { $progMissing -join '; ' })

$engLinkMiss = @($progIds | Where-Object { $eng -notmatch [regex]::Escape($_) })
Add-Gate 'CAT-T42' ($engLinkMiss.Count -eq 0) $(if ($engLinkMiss.Count -eq 0) { 'form-engineering links programming suite' } else { $engLinkMiss -join '; ' })

$odataTexec = ($odataSkill -match '\[T\$EXEC\]') -and ($odataSkill -match 'FORMLIMITED\.FORM`? does not exist') -and ($odataSkill -match 'CATALOGA')
Add-Gate 'CAT-T43' $odataTexec 'odata-dev documents FORMLIMITED [T$EXEC] key and CATALOG SQL register'

$scanPaths = @()
foreach ($dbaId in $dbaIds) {
    $scanPaths += Join-Path $catalog $dbaId
}
$scanPaths += Join-Path $repo 'docs\skill-sources\dba'
$secretHits = @()
foreach ($root in $scanPaths) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -Path $root -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if (-not $text) { return }
        if ($text -match '(?i)(password\s*=|XAI_API_KEY\s*=)') { $secretHits += $_.FullName }
    }
}
Add-Gate 'CAT-T31' ($secretHits.Count -eq 0) $(if ($secretHits.Count -eq 0) { 'no password=/XAI_API_KEY= in DBA skills or dba harvest' } else { $secretHits -join '; ' })

$auditRunner = Join-Path $catalog 'priority-backup-audit\runner\Invoke-PriorityBackupAudit.ps1'
Add-Gate 'CAT-T32' (Test-Path -LiteralPath $auditRunner) 'priority-backup-audit runner present'

function Invoke-DbaRunner {
    param([string]$ScriptPath, [string[]]$ArgList)
    $all = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $ScriptPath) + $ArgList
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $out = & powershell.exe @all 2>&1 | Out-String
    $sw.Stop()
    $code = $LASTEXITCODE
    $jsonText = Get-JsonLastLine $out
    $obj = $null
    if ($jsonText) {
        try { $obj = $jsonText | ConvertFrom-Json } catch { $obj = $null }
    }
    return [pscustomobject]@{
        ExitCode   = $code
        StdOut     = $out
        Json       = $obj
        ElapsedSec = $sw.Elapsed.TotalSeconds
    }
}

$sundayRunner = Join-Path $catalog 'priority-sunday-backup-check\runner\Invoke-SundayBackupCheck.ps1'
$sundayDry = Invoke-DbaRunner -ScriptPath $sundayRunner -ArgList @('-DryRun')
$sundayDryOk = $sundayDry.ExitCode -eq 0 -and $sundayDry.Json.ok -eq $true -and $sundayDry.Json.dryRun -eq $true
Add-Gate 'CAT-T33' $sundayDryOk 'Sunday -DryRun checklist without instances.json'

$missingCfg = Join-Path $env:TEMP ('dba-missing-' + [guid]::NewGuid().ToString('n') + '.json')
$auditNoCfg = Invoke-DbaRunner -ScriptPath $auditRunner -ArgList @('-InstancesPath', $missingCfg)
Add-Gate 'CAT-T34' ($auditNoCfg.ExitCode -eq 2 -and $auditNoCfg.Json.reason -eq 'config_error') 'backup-audit missing config exit 2'

$postRunner = Join-Path $catalog 'priority-post-move-health\runner\Invoke-PriorityPostMoveHealth.ps1'
$postNoCfg = Invoke-DbaRunner -ScriptPath $postRunner -ArgList @('-InstancesPath', $missingCfg)
Add-Gate 'CAT-T35' ($postNoCfg.ExitCode -eq 2 -and $postNoCfg.Json.reason -eq 'config_error') 'post-move missing config exit 2'

$healthRunner = Join-Path $catalog 'priority-instance-health-collect\runner\Invoke-InstanceHealthCollect.ps1'
$healthNoCfg = Invoke-DbaRunner -ScriptPath $healthRunner -ArgList @('-InstancesPath', $missingCfg)
Add-Gate 'CAT-T36' ($healthNoCfg.ExitCode -eq 2 -and $healthNoCfg.Json.reason -eq 'config_error') 'health-collect missing config exit 2'

$dbaTmp = Join-Path $env:TEMP ('dba-cat-' + [guid]::NewGuid().ToString('n'))
New-Item -ItemType Directory -Path $dbaTmp -Force | Out-Null
$exampleCfg = Join-Path $catalog 'priority-backup-audit\runner\instances.example.json'
$fixtureCfg = Join-Path $dbaTmp 'instances.json'
$exRaw = Get-Content -LiteralPath $exampleCfg -Raw -Encoding UTF8 | ConvertFrom-Json
$exRaw.instanceIds = @('DEV')
$exRaw | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $fixtureCfg -Encoding UTF8
$postSkip = Invoke-DbaRunner -ScriptPath $postRunner -ArgList @('-InstancesPath', $fixtureCfg)
$postSkipOk = $postSkip.ExitCode -eq 2 -and $postSkip.Json.reason -eq 'live_skip' -and $postSkip.ElapsedSec -lt 30
Add-Gate 'CAT-T37' $postSkipOk $(if ($postSkipOk) { 'post-move example config live_skip without SQL/UNC' } else { "exit=$($postSkip.ExitCode) reason=$($postSkip.Json.reason) sec=$([math]::Round($postSkip.ElapsedSec,2))" })

$ceLiteralHits = @()
$cePatterns = @('10\.220\.0\.5', 'SQL_Backup_Archive_F_20260918', '\bpridev\b', '\bpritest\b', '\bpridata\b')
$dbaPs1Roots = @(
    (Join-Path $repo 'docs\skill-sources\dba')
)
foreach ($dbaId in $dbaIds) {
    $dbaPs1Roots += Join-Path $catalog "$dbaId\runner"
}
foreach ($root in $dbaPs1Roots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -Path $root -Recurse -File -Filter '*.ps1' -ErrorAction SilentlyContinue | ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if (-not $text) { return }
        foreach ($pat in $cePatterns) {
            if ($text -match $pat) { $ceLiteralHits += ($_.FullName + ':' + $pat) }
        }
    }
}
Add-Gate 'CAT-T38' ($ceLiteralHits.Count -eq 0) $(if ($ceLiteralHits.Count -eq 0) { 'DBA .ps1 logic has no CE host/mount/archive constants' } else { $ceLiteralHits -join '; ' })

Remove-Item -LiteralPath $dbaTmp -Recurse -Force -ErrorAction SilentlyContinue

$hardcodedHits = @()
$productScanRoots = @(
    (Join-Path $v2 'lib'),
    (Join-Path $v2 'plugins'),
    (Join-Path $v2 'apps\mcp-catalog\catalog')
)
$productPs1 = @()
foreach ($root in $productScanRoots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    $productPs1 += @(Get-ChildItem -LiteralPath $root -Recurse -Filter '*.ps1' -File -ErrorAction SilentlyContinue)
}
foreach ($f in ($productPs1 | Sort-Object -Property FullName -Unique)) {
    if ($f.FullName -match '\\tools\\' -or $f.FullName -match '\\tests\\') { continue }
    $raw = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    $rel = $f.FullName.Substring($v2.Length).TrimStart('\')
    if ($raw -match "ConvertTo-SqlIdent\s+'dbo\.") { $hardcodedHits += ($rel + ": ConvertTo-SqlIdent 'dbo.*'") }
    if ($raw -match "ConvertTo-SqlIdent\s+'UPGNUM'") { $hardcodedHits += ($rel + ": ConvertTo-SqlIdent 'UPGNUM'") }
    if ($raw -match "'dbo\.'\s*\+") { $hardcodedHits += ($rel + ": 'dbo.' + prefix") }
}
Add-Gate 'CAT-T39' ($hardcodedHits.Count -eq 0) $(if ($hardcodedHits.Count -eq 0) { 'no hardcoded dbo.* / UPGNUM / dbo.+ SQL idents in v2 product scripts' } else { ($hardcodedHits -join '; ') })

$runnerPairs = @(
    @{ Plugin = 'priority-odata-dev'; Script = 'Invoke-PriorityOData.ps1' },
    @{ Plugin = 'priority-formprep'; Script = 'Prepare-NamedForm.ps1' },
    @{ Plugin = 'priority-shell-compile'; Script = 'Compile-Shell.ps1' },
    @{ Plugin = 'priority-shell-install'; Script = 'Install-Shell.ps1' }
)
$runnerMismatch = @()
foreach ($rp in $runnerPairs) {
    $plugPath = Join-Path $v2 ("plugins\{0}\scripts\{1}" -f $rp.Plugin, $rp.Script)
    $catPath = Join-Path $catalog ("{0}\runner\{1}" -f $rp.Plugin, $rp.Script)
    if (-not (Test-Path -LiteralPath $plugPath) -or -not (Test-Path -LiteralPath $catPath)) {
        $runnerMismatch += ($rp.Plugin + ': missing path')
        continue
    }
    $hPlug = (Get-FileHash -LiteralPath $plugPath -Algorithm SHA256).Hash
    $hCat = (Get-FileHash -LiteralPath $catPath -Algorithm SHA256).Hash
    if ($hPlug -ne $hCat) { $runnerMismatch += $rp.Plugin }
}
Add-Gate 'CAT-T40' ($runnerMismatch.Count -eq 0) $(if ($runnerMismatch.Count -eq 0) { 'plugin scripts/ runners byte-identical to catalog runner/ copies' } else { ('runner hash mismatch: ' + ($runnerMismatch -join ', ')) })

$dbaIds = @(
    'priority-backup-standard',
    'priority-backup-audit',
    'priority-backup-cutover',
    'priority-sunday-backup-check',
    'priority-instance-health-collect',
    'priority-post-move-health',
    'priority-disk-mount-layout-report',
    'priority-ht-delete-deadlock-triage',
    'priority-form-prep-after-sql-change',
    'priority-hours-handoff-haitch'
)
$dbaFrontMissing = @()
foreach ($dbaId in $dbaIds) {
    $skillPath = Join-Path $catalog "$dbaId\SKILL.md"
    if (-not (Test-Path -LiteralPath $skillPath)) { $dbaFrontMissing += $dbaId; continue }
    $raw = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    if ($raw -notmatch '(?m)^name:\s*' + [regex]::Escape($dbaId)) { $dbaFrontMissing += "$dbaId/name" }
    if ($raw -notmatch '(?m)^description:\s*>?') { $dbaFrontMissing += "$dbaId/description" }
}
Add-Gate 'CAT-T26' ($dbaFrontMissing.Count -eq 0) $(if ($dbaFrontMissing.Count -eq 0) { 'DBA skills frontmatter name+description' } else { $dbaFrontMissing -join '; ' })

$std = Get-Content -LiteralPath (Join-Path $catalog 'priority-backup-standard\SKILL.md') -Raw -Encoding UTF8
$stdOk = (($std -match 'integrated auth') -or ($std -match 'Integrated Security')) -and ($std -match 'Do \*\*not\*\* prune')
Add-Gate 'CAT-T27' $stdOk 'backup-standard documents no F: prune without confirm'

$formGate = Get-Content -LiteralPath (Join-Path $catalog 'priority-form-prep-after-sql-change\SKILL.md') -Raw -Encoding UTF8
Add-Gate 'CAT-T28' ($formGate -match 'prepare-all-unprepared-priority-forms') 'form-prep-after-sql-change links batch form prep skill'

$htTri = Get-Content -LiteralPath (Join-Path $catalog 'priority-ht-delete-deadlock-triage\SKILL.md') -Raw -Encoding UTF8
Add-Gate 'CAT-T29' (($htTri -match '1205') -and ($htTri -notmatch 'ALTER INDEX')) 'HT deadlock triage evidence-only'

$scanPaths = @()
foreach ($dbaId in $dbaIds) {
    $scanPaths += Join-Path $catalog $dbaId
}
$scanPaths += Join-Path $repo 'docs\skill-sources\dba'
$secretHits = @()
foreach ($root in $scanPaths) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -Path $root -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if (-not $text) { return }
        if ($text -match '(?i)(password\s*=|XAI_API_KEY\s*=)') { $secretHits += $_.FullName }
    }
}
Add-Gate 'CAT-T30' ($secretHits.Count -eq 0) $(if ($secretHits.Count -eq 0) { 'no password=/XAI_API_KEY= in DBA skills or dba harvest' } else { $secretHits -join '; ' })

$auditRunner = Join-Path $catalog 'priority-backup-audit\runner\Invoke-PriorityBackupAudit.ps1'
Add-Gate 'CAT-T31' (Test-Path -LiteralPath $auditRunner) 'priority-backup-audit runner present'

$dbaIds = @(
    'priority-backup-standard',
    'priority-backup-audit',
    'priority-backup-cutover',
    'priority-sunday-backup-check',
    'priority-instance-health-collect',
    'priority-post-move-health',
    'priority-disk-mount-layout-report',
    'priority-ht-delete-deadlock-triage',
    'priority-form-prep-after-sql-change',
    'priority-hours-handoff-haitch'
)
$dbaFrontMissing = @()
foreach ($dbaId in $dbaIds) {
    $skillPath = Join-Path $catalog "$dbaId\SKILL.md"
    if (-not (Test-Path -LiteralPath $skillPath)) { $dbaFrontMissing += $dbaId; continue }
    $raw = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    if ($raw -notmatch '(?m)^name:\s*' + [regex]::Escape($dbaId)) { $dbaFrontMissing += "$dbaId/name" }
    if ($raw -notmatch '(?m)^description:\s*>?') { $dbaFrontMissing += "$dbaId/description" }
}
Add-Gate 'CAT-T26' ($dbaFrontMissing.Count -eq 0) $(if ($dbaFrontMissing.Count -eq 0) { 'DBA skills frontmatter name+description' } else { $dbaFrontMissing -join '; ' })

$std = Get-Content -LiteralPath (Join-Path $catalog 'priority-backup-standard\SKILL.md') -Raw -Encoding UTF8
$stdOk = (($std -match 'integrated auth') -or ($std -match 'Integrated Security')) -and ($std -match 'Do \*\*not\*\* prune')
Add-Gate 'CAT-T27' $stdOk 'backup-standard documents no F: prune without confirm'

$formGate = Get-Content -LiteralPath (Join-Path $catalog 'priority-form-prep-after-sql-change\SKILL.md') -Raw -Encoding UTF8
Add-Gate 'CAT-T28' ($formGate -match 'prepare-all-unprepared-priority-forms') 'form-prep-after-sql-change links batch form prep skill'

$htTri = Get-Content -LiteralPath (Join-Path $catalog 'priority-ht-delete-deadlock-triage\SKILL.md') -Raw -Encoding UTF8
Add-Gate 'CAT-T29' (($htTri -match '1205') -and ($htTri -notmatch 'ALTER INDEX')) 'HT deadlock triage evidence-only'

$scanPaths = @()
foreach ($dbaId in $dbaIds) {
    $scanPaths += Join-Path $catalog $dbaId
}
$scanPaths += Join-Path $repo 'docs\skill-sources\dba'
$secretHits = @()
foreach ($root in $scanPaths) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -Path $root -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if (-not $text) { return }
        if ($text -match '(?i)(password\s*=|XAI_API_KEY\s*=)') { $secretHits += $_.FullName }
    }
}
Add-Gate 'CAT-T30' ($secretHits.Count -eq 0) $(if ($secretHits.Count -eq 0) { 'no password=/XAI_API_KEY= in DBA skills or dba harvest' } else { $secretHits -join '; ' })

$auditRunner = Join-Path $catalog 'priority-backup-audit\runner\Invoke-PriorityBackupAudit.ps1'
Add-Gate 'CAT-T31' (Test-Path -LiteralPath $auditRunner) 'priority-backup-audit runner present'

function Invoke-DbaRunner {
    param([string]$ScriptPath, [string[]]$ArgList)
    $all = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $ScriptPath) + $ArgList
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $out = & powershell.exe @all 2>&1 | Out-String
    $sw.Stop()
    $code = $LASTEXITCODE
    $jsonText = Get-JsonLastLine $out
    $obj = $null
    if ($jsonText) {
        try { $obj = $jsonText | ConvertFrom-Json } catch { $obj = $null }
    }
    return [pscustomobject]@{
        ExitCode   = $code
        StdOut     = $out
        Json       = $obj
        ElapsedSec = $sw.Elapsed.TotalSeconds
    }
}

$sundayRunner = Join-Path $catalog 'priority-sunday-backup-check\runner\Invoke-SundayBackupCheck.ps1'
$sundayDry = Invoke-DbaRunner -ScriptPath $sundayRunner -ArgList @('-DryRun')
$sundayDryOk = $sundayDry.ExitCode -eq 0 -and $sundayDry.Json.ok -eq $true -and $sundayDry.Json.dryRun -eq $true
Add-Gate 'CAT-T32' $sundayDryOk 'Sunday -DryRun checklist without instances.json'

$missingCfg = Join-Path $env:TEMP ('dba-missing-' + [guid]::NewGuid().ToString('n') + '.json')
$auditNoCfg = Invoke-DbaRunner -ScriptPath $auditRunner -ArgList @('-InstancesPath', $missingCfg)
Add-Gate 'CAT-T33' ($auditNoCfg.ExitCode -eq 2 -and $auditNoCfg.Json.reason -eq 'config_error') 'backup-audit missing config exit 2'

$postRunner = Join-Path $catalog 'priority-post-move-health\runner\Invoke-PriorityPostMoveHealth.ps1'
$postNoCfg = Invoke-DbaRunner -ScriptPath $postRunner -ArgList @('-InstancesPath', $missingCfg)
Add-Gate 'CAT-T34' ($postNoCfg.ExitCode -eq 2 -and $postNoCfg.Json.reason -eq 'config_error') 'post-move missing config exit 2'

$healthRunner = Join-Path $catalog 'priority-instance-health-collect\runner\Invoke-InstanceHealthCollect.ps1'
$healthNoCfg = Invoke-DbaRunner -ScriptPath $healthRunner -ArgList @('-InstancesPath', $missingCfg)
Add-Gate 'CAT-T35' ($healthNoCfg.ExitCode -eq 2 -and $healthNoCfg.Json.reason -eq 'config_error') 'health-collect missing config exit 2'

$dbaTmp = Join-Path $env:TEMP ('dba-cat-' + [guid]::NewGuid().ToString('n'))
New-Item -ItemType Directory -Path $dbaTmp -Force | Out-Null
$exampleCfg = Join-Path $catalog 'priority-backup-audit\runner\instances.example.json'
$fixtureCfg = Join-Path $dbaTmp 'instances.json'
$exRaw = Get-Content -LiteralPath $exampleCfg -Raw -Encoding UTF8 | ConvertFrom-Json
$exRaw.instanceIds = @('DEV')
$exRaw | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $fixtureCfg -Encoding UTF8
$postSkip = Invoke-DbaRunner -ScriptPath $postRunner -ArgList @('-InstancesPath', $fixtureCfg)
$postSkipOk = $postSkip.ExitCode -eq 2 -and $postSkip.Json.reason -eq 'live_skip' -and $postSkip.ElapsedSec -lt 30
Add-Gate 'CAT-T36' $postSkipOk $(if ($postSkipOk) { 'post-move example config live_skip without SQL/UNC' } else { "exit=$($postSkip.ExitCode) reason=$($postSkip.Json.reason) sec=$([math]::Round($postSkip.ElapsedSec,2))" })

$ceLiteralHits = @()
$cePatterns = @('10\.220\.0\.5', 'SQL_Backup_Archive_F_20260918', '\bpridev\b', '\bpritest\b', '\bpridata\b')
$dbaPs1Roots = @(
    (Join-Path $repo 'docs\skill-sources\dba')
)
foreach ($dbaId in $dbaIds) {
    $dbaPs1Roots += Join-Path $catalog "$dbaId\runner"
}
foreach ($root in $dbaPs1Roots) {
    if (-not (Test-Path -LiteralPath $root)) { continue }
    Get-ChildItem -Path $root -Recurse -File -Filter '*.ps1' -ErrorAction SilentlyContinue | ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
        if (-not $text) { return }
        foreach ($pat in $cePatterns) {
            if ($text -match $pat) { $ceLiteralHits += ($_.FullName + ':' + $pat) }
        }
    }
}
Add-Gate 'CAT-T37' ($ceLiteralHits.Count -eq 0) $(if ($ceLiteralHits.Count -eq 0) { 'DBA .ps1 logic has no CE host/mount/archive constants' } else { $ceLiteralHits -join '; ' })

Remove-Item -LiteralPath $dbaTmp -Recurse -Force -ErrorAction SilentlyContinue

if ($failed -gt 0) {
    Write-Host "Test-PriorityCatalog FAIL ($failed)"
    exit 1
}
Write-Host 'Test-PriorityCatalog PASS'
exit 0
