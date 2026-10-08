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
    'priority-uat-wcf',
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
    'priority-version-revision-discipline',
    'priority-dictionary-sql',
    'priority-mcp-setup',
    'priority-mcp-discovery',
    'priority-mcp-forms',
    'priority-mcp-procedures',
    'priority-mcp-search',
    'priority-mcp-help-and-skills'
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

# FR #51: Priority Cloud MCP skills - frontmatter + cloud-only + no secret assignments
$mcpIds = @(
    'priority-mcp-setup',
    'priority-mcp-discovery',
    'priority-mcp-forms',
    'priority-mcp-procedures',
    'priority-mcp-search',
    'priority-mcp-help-and-skills'
)
$mcpFrontMissing = @()
$mcpCloudMissing = @()
$mcpSecretHits = @()
foreach ($mcpId in $mcpIds) {
    $skillPath = Join-Path $catalog "$mcpId\SKILL.md"
    if (-not (Test-Path -LiteralPath $skillPath)) { $mcpFrontMissing += $mcpId; continue }
    $mraw = Get-Content -LiteralPath $skillPath -Raw -Encoding UTF8
    if ($mraw -notmatch '(?m)^name:\s*' + [regex]::Escape($mcpId)) { $mcpFrontMissing += "$mcpId/name" }
    if ($mraw -notmatch '(?m)^description:\s*>?') { $mcpFrontMissing += "$mcpId/description" }
    if ($mraw -notmatch '(?i)cloud-only|Priority Cloud') { $mcpCloudMissing += $mcpId }
    if ($mraw -match '(?i)(password\s*=|XAI_API_KEY\s*=)') { $mcpSecretHits += $mcpId }
}
Add-Gate 'CAT-T45' ($mcpFrontMissing.Count -eq 0) $(if ($mcpFrontMissing.Count -eq 0) { 'MCP skills frontmatter name+description' } else { $mcpFrontMissing -join '; ' })
Add-Gate 'CAT-T46' ($mcpCloudMissing.Count -eq 0) $(if ($mcpCloudMissing.Count -eq 0) { 'MCP skills document cloud-only / Priority Cloud' } else { $mcpCloudMissing -join '; ' })
Add-Gate 'CAT-T47' ($mcpSecretHits.Count -eq 0) $(if ($mcpSecretHits.Count -eq 0) { 'MCP skills have no password=/XAI_API_KEY= assignments' } else { $mcpSecretHits -join '; ' })

# FR #58: exactly one Foundation line on every priority-* catalog leaflet
$foundationMissing = @()
Get-ChildItem -LiteralPath $catalog -Directory -ErrorAction SilentlyContinue | Where-Object { $_.Name -like 'priority-*' } | ForEach-Object {
    $skillMd = Join-Path $_.FullName 'SKILL.md'
    if (-not (Test-Path -LiteralPath $skillMd)) { $foundationMissing += "$($_.Name)/SKILL.md"; return }
    $fraw = Get-Content -LiteralPath $skillMd -Raw -Encoding UTF8
    $fc = ([regex]::Matches($fraw, 'Foundation:\s*harvest-priority-skills')).Count
    if ($fc -ne 1) { $foundationMissing += ($_.Name + ':' + $fc) }
}
Add-Gate 'CAT-T50' ($foundationMissing.Count -eq 0) $(if ($foundationMissing.Count -eq 0) { 'all priority-* leaflets have exactly one Foundation harvest line' } else { $foundationMissing -join '; ' })

# FR #4: Priority-generic catalog - no ce-priority-* skill folders / skill ids.
$ceDirs = @(Get-ChildItem -LiteralPath $catalog -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -like 'ce-priority-*' } |
        ForEach-Object { $_.Name })
$ceSkillIdHits = @()
Get-ChildItem -LiteralPath $catalog -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $skillMd = Join-Path $_.FullName 'SKILL.md'
    $metaJs = Join-Path $_.FullName 'meta.json'
    if (Test-Path -LiteralPath $skillMd) {
        $raw = Get-Content -LiteralPath $skillMd -Raw -Encoding UTF8
        if ($raw -match '(?m)^name:\s*ce-priority-') {
            $ceSkillIdHits += "$($_.Name)/SKILL.md:name"
        }
        # Old folder-style skill path references (not historical dump filenames / ProofInstanceId).
        if ($raw -match 'ce-priority-(day-works-uat|ht-delete-smoke|project-create-smoke)\b') {
            $ceSkillIdHits += "$($_.Name)/SKILL.md:legacy-id"
        }
    }
    if (Test-Path -LiteralPath $metaJs) {
        try {
            $meta = Get-Content -LiteralPath $metaJs -Raw -Encoding UTF8 | ConvertFrom-Json
            if ([string]$meta.name -like 'ce-priority-*') {
                $ceSkillIdHits += "$($_.Name)/meta.json:name"
            }
        }
        catch { $ceSkillIdHits += "$($_.Name)/meta.json:parse" }
    }
}
$ceGateOk = ($ceDirs.Count -eq 0) -and ($ceSkillIdHits.Count -eq 0)
Add-Gate 'CAT-T44' $ceGateOk $(if ($ceGateOk) {
        'no ce-priority-* catalog folders or skill ids (FR #4)'
    }
    else {
        @($ceDirs + $ceSkillIdHits) -join '; '
    })

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
$uatOk = ($uat -match 'CASE') -and ($uat -match 'DOCNO') -and ($uat -match 'UNPARK') -and ($uat -match 'skill-sources/uat/priority-uat-orchestrator') -and ($uat -match 'PR25000001') -and ($uat -match 'priority-ht-delete-smoke') -and ($uat -match 'uat-video-pack') -and ($uat -match 'fast') -and ($uat -notmatch 'Silent pass without video is not formal UAT')
Add-Gate 'CAT-T20' $uatOk 'UAT orchestrator UNPARK/CASE + skill-sources/uat'

$create = Get-Content -LiteralPath (Join-Path $catalog 'priority-project-create-smoke\SKILL.md') -Raw -Encoding UTF8
$createOk = ($create -match 'ZGEM_ERR_NOTINTEAM') -and ($create -match 'PV system') -and ($create -match 'EL=5') -and ($create -match 'SNG-ROW') -and ($create -match 'Internal Project Team')
Add-Gate 'CAT-T22' $createOk 'project-create smoke has TC-01-05 detail'

$dw = Get-Content -LiteralPath (Join-Path $catalog 'priority-day-works-uat\SKILL.md') -Raw -Encoding UTF8
$dwOk = ($dw -match 'ZCLA_DAYWORKS') -and ($dw -match 'DW-B1') -and ($dw -match 'Long Description') -and ($dw -match 'PARKED') -and ($dw -match 'UNPARK')
Add-Gate 'CAT-T23' $dwOk 'Day Works A-B fleshed; C-G parked until UNPARK'
$dwKeysOk = ($dw -match 'FORMJOINS') -and ($dw -match 'FORMKEYS') -and ($dw -match 'REVISIONID') -and ($dw -match 'not.*PART')
Add-Gate 'CAT-T23b' $dwKeysOk 'Day Works Gate A FORMJOINS vs FORMKEYS (issue #52)'

$ht = Get-Content -LiteralPath (Join-Path $catalog 'priority-ht-delete-smoke\SKILL.md') -Raw -Encoding UTF8
$htOk = ($ht -match 'ZCLA_HTEDIT') -and ($ht -match '1205') -and ($ht -match 'HOUSETYPEID') -and ($ht -match 'DNAME')
Add-Gate 'CAT-T24' $htOk 'HT-DL smoke catalog present with TEST company pitfall'

$fastCreate = ($create -match 'no mandatory video|No mandatory video|\*\*No\*\* mandatory video') -and ($create -notmatch 'PASS: screen-record')
$fastDw = ($dw -match 'no mandatory video|No mandatory video') -and ($dw -notmatch 'PASS: screen-record')
$fastHt = ($ht -match 'no mandatory video|No mandatory video|\*\*No\*\* mandatory video') -and ($ht -notmatch 'with video')
Add-Gate 'CAT-T48' ($fastCreate -and $fastDw -and $fastHt) $(if ($fastCreate -and $fastDw -and $fastHt) { 'UAT smokes: fast path, no mandatory video' } else { "create=$fastCreate dw=$fastDw ht=$fastHt" })
Add-Gate 'CAT-T49' (Test-Path -LiteralPath (Join-Path $catalog 'priority-uat-wcf\SKILL.md')) 'priority-uat-wcf shared kernel present'

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
$refuseCompose = Invoke-ODataRunner @(
    '-Action', 'formlimited_audit', '-InstanceId', 'fixture-dev', '-Forms', 'PARTLONGDESC,PART',
    '-InstancesPath', $fixtureInst, '-ComposeSql', '-PinPath', $composePinPath
)
$refuseOk = ($refuseCompose.ExitCode -eq 2 -and $refuseCompose.Json.reason -eq 'pin_incomplete')
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
    'priority-version-revision-discipline',
    'priority-dictionary-sql'
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
    if ([string]$meta.version -notmatch '^\d+\.\d+\.\d+$') { $progMissing += "$progId/meta.version" }
    if ($meta.PSObject.Properties.Name -notcontains 'title' -or $meta.PSObject.Properties.Name -notcontains 'description') {
        $progMissing += "$progId/meta.shape"
    }
}
$progSrc = @('MANIFEST.md', 'PROCEDURE_STYLE.md', 'SQL_UDATE_USER.md', 'FORMPREP_SHADOW_TABLES.md', 'RECALC_CONCURRENCY.md', 'VERSION_REVISION.md', 'DICTIONARY_SQL.md', 'SDK_FEATURE_MAP.md')
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
Add-Gate 'CAT-T41' ($progMissing.Count -eq 0) $(if ($progMissing.Count -eq 0) { 'programming skills meta semver + skill-sources' } else { $progMissing -join '; ' })

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

# MRB #99: catalog meta.json must be UTF-8 without BOM (ConvertFrom-Json tolerates BOM; Node/MCP often does not)
$metaBomHits = @()
Get-ChildItem -LiteralPath $catalog -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $metaPath = Join-Path $_.FullName 'meta.json'
    if (-not (Test-Path -LiteralPath $metaPath)) { return }
    $mb = [IO.File]::ReadAllBytes($metaPath)
    if ($mb.Length -ge 3 -and $mb[0] -eq 0xEF -and $mb[1] -eq 0xBB -and $mb[2] -eq 0xBF) {
        $metaBomHits += $_.Name
    }
}
Add-Gate 'CAT-T51' ($metaBomHits.Count -eq 0) $(if ($metaBomHits.Count -eq 0) { 'all catalog meta.json UTF-8 without BOM' } else { 'BOM: ' + ($metaBomHits -join ', ') })

# MRB #99: priority-uat-wcf 1.2.0 harvest - parent warningConfirm + PARTNAME filters
$wcfMetaPath = Join-Path $catalog 'priority-uat-wcf\meta.json'
$wcfSkillPath = Join-Path $catalog 'priority-uat-wcf\SKILL.md'
$wcfSrcPath = Join-Path $repo 'docs\skill-sources\uat\priority-uat-wcf.md'
$wcfGrokPath = Join-Path $repo '.grok\skills\priority-uat-wcf\SKILL.md'
$wcfMeta = Get-Content -LiteralPath $wcfMetaPath -Raw -Encoding UTF8 | ConvertFrom-Json
$wcfSkill = Get-Content -LiteralPath $wcfSkillPath -Raw -Encoding UTF8
$wcfSrc = Get-Content -LiteralPath $wcfSrcPath -Raw -Encoding UTF8
$wcfMetaOk = ([string]$wcfMeta.version -eq '1.2.0') -and ([string]$wcfMeta.description -match 'warningConfirm') -and ([string]$wcfMeta.description -match 'PARTNAME')
Add-Gate 'CAT-T52' $wcfMetaOk $(if ($wcfMetaOk) { 'priority-uat-wcf meta 1.2.0 documents warningConfirm + PARTNAME' } else { "version=$($wcfMeta.version) desc=$($wcfMeta.description)" })
$wcfBodyOk = ($wcfSrc -match 'warningConfirm') -and ($wcfSrc -match 'parent') -and ($wcfSrc -match 'PARTNAME') -and ($wcfSrc -match 'Invalid filter') -and ($wcfSrc -match 'sibling') -and ($wcfSkill -match 'warningConfirm') -and ($wcfSkill -match 'PARTNAME') -and ($wcfSkill -match 'sibling')
Add-Gate 'CAT-T53' $wcfBodyOk $(if ($wcfBodyOk) { 'uat-wcf skill-source + catalog cover parent confirm, PARTNAME, siblings' } else { 'missing harvest phrases in source or catalog leaflet' })
$wcfMirrorOk = (Test-Path -LiteralPath $wcfGrokPath) -and ((Get-FileHash -LiteralPath $wcfGrokPath -Algorithm SHA256).Hash -eq (Get-FileHash -LiteralPath $wcfSkillPath -Algorithm SHA256).Hash)
Add-Gate 'CAT-T54' $wcfMirrorOk $(if ($wcfMirrorOk) { '.grok/skills/priority-uat-wcf mirrors catalog SKILL.md' } else { 'grok mirror missing or hash mismatch' })

# FR #101 / MRB #102: root VISION.md for MRB vision-first reviews
# Lock the FR fix bullets: Priority-generic mission, UPD+LASTPREPDATE success gate,
# DEV-only bounds, honesty-box harvest - plus no UTF-8 BOM.
$visionPath = Join-Path $repo 'VISION.md'
$visionOk = $false
$visionWhy = 'VISION.md missing'
$visionText = ''
if (Test-Path -LiteralPath $visionPath) {
    $visionText = Get-Content -LiteralPath $visionPath -Raw -Encoding UTF8
    $vb = [IO.File]::ReadAllBytes($visionPath)
    $visionBom = ($vb.Length -ge 3 -and $vb[0] -eq 0xEF -and $vb[1] -eq 0xBB -and $vb[2] -eq 0xBF)
    $visionOk = (-not $visionBom) `
        -and ($visionText -match 'EXECPREPLOCK') `
        -and ($visionText -match 'UPD') `
        -and ($visionText -match 'LASTPREPDATE') `
        -and ($visionText -match 'DEV') `
        -and ($visionText -match 'catalog') `
        -and ($visionText -match 'Priority-generic') `
        -and ($visionText -match 'honesty-box|Honesty-box|harvest')
    $visionWhy = if ($visionOk) {
        'root VISION.md locks Form Prep success + DEV + Priority-generic + harvest (no BOM)'
    } elseif ($visionBom) {
        'VISION.md has UTF-8 BOM'
    } else {
        'VISION.md missing required FR #101 phrases'
    }
}
Add-Gate 'CAT-T55' $visionOk $visionWhy
# MRB #102: refuse live/PRI must stay in vision Bounds / Non-goals
$visionLiveOk = $visionOk -and ($visionText -match 'live/PRI|Live/PRI')
Add-Gate 'CAT-T56' $visionLiveOk $(if ($visionLiveOk) { 'VISION.md refuses live/PRI' } else { 'VISION.md missing live/PRI refuse' })

# FR #104 / MRB #105: this runner's source must stay ASCII (no mojibake / smart dashes).
# CAT-T56 is already VISION live/PRI (#103); ASCII gate is CAT-T57.
$catalogPs1 = $PSCommandPath
if (-not $catalogPs1) { $catalogPs1 = Join-Path $repo 'v2\tools\Test-PriorityCatalog.ps1' }
$asciiHits = @()
$ci = 0
Get-Content -LiteralPath $catalogPs1 -Encoding UTF8 | ForEach-Object {
    $ci++
    $line = $_
    foreach ($ch in $line.ToCharArray()) {
        if ([int]$ch -gt 127) {
            $asciiHits += ('L{0}:U+{1:X4}' -f $ci, [int]$ch)
            break
        }
    }
}
Add-Gate 'CAT-T57' ($asciiHits.Count -eq 0) $(if ($asciiHits.Count -eq 0) { 'Test-PriorityCatalog.ps1 source ASCII-only' } else { 'non-ASCII: ' + ($asciiHits -join ', ') })

# MRB #105: Add-Gate ids must be unique (duplicate CAT-T56 would hide a fail in logs)
$gateIdHits = @{}
$gateDupes = @()
$gi = 0
Get-Content -LiteralPath $catalogPs1 -Encoding UTF8 | ForEach-Object {
    $gi++
    if ($_ -match "Add-Gate\s+'([^']+)'") {
        $gid = $Matches[1]
        if ($gateIdHits.ContainsKey($gid)) {
            $gateDupes += ('{0}@{1}+{2}' -f $gid, $gateIdHits[$gid], $gi)
        } else {
            $gateIdHits[$gid] = $gi
        }
    }
}
Add-Gate 'CAT-T58' ($gateDupes.Count -eq 0) $(if ($gateDupes.Count -eq 0) { 'Add-Gate ids unique in Test-PriorityCatalog.ps1' } else { 'duplicate gates: ' + ($gateDupes -join ', ') })

# MRB #107: priority-create-table harvest (IGNORE_DUP_KEY + COLUMNS.SIZE never 0)
$createSkill = Join-Path $catalog 'priority-create-table\SKILL.md'
$createMeta = Join-Path $catalog 'priority-create-table\meta.json'
$createSrc = Join-Path $repo 'docs\skill-sources\programming\CREATE_TABLE.md'
$createGrok = Join-Path $repo '.grok\skills\priority-create-table\SKILL.md'
$createOk = $false
$createWhy = 'priority-create-table missing'
if ((Test-Path -LiteralPath $createSkill) -and (Test-Path -LiteralPath $createMeta) -and (Test-Path -LiteralPath $createSrc)) {
    $createBody = (Get-Content -LiteralPath $createSkill -Raw -Encoding UTF8) + "`n" + (Get-Content -LiteralPath $createSrc -Raw -Encoding UTF8)
    if (Test-Path -LiteralPath $createGrok) { $createBody += "`n" + (Get-Content -LiteralPath $createGrok -Raw -Encoding UTF8) }
    $hasIgnore = $createBody -match 'IGNORE_DUP_KEY\s*=\s*ON'
    $hasSize = ($createBody -match 'SIZE\s+never\s+0|never\s+be\s+0') -and ($createBody -match 'SIZE\s*=\s*WIDTH|SIZE = WIDTH') -and ($createBody -match 'SIZE\s*=\s*8|SIZE = 8')
    $createAsciiHits = @()
    foreach ($cf in @($createSkill, $createSrc, $createGrok)) {
        if (-not (Test-Path -LiteralPath $cf)) { continue }
        $ci2 = 0
        Get-Content -LiteralPath $cf -Encoding UTF8 | ForEach-Object {
            $ci2++
            foreach ($ch in $_.ToCharArray()) {
                if ([int]$ch -gt 127) {
                    $createAsciiHits += ('{0}:L{1}:U+{2:X4}' -f (Split-Path $cf -Leaf), $ci2, [int]$ch)
                    break
                }
            }
        }
    }
    $metaRaw = [System.IO.File]::ReadAllBytes((Resolve-Path -LiteralPath $createMeta))
    $metaBom = ($metaRaw.Length -ge 3 -and $metaRaw[0] -eq 0xEF -and $metaRaw[1] -eq 0xBB -and $metaRaw[2] -eq 0xBF)
    if ($hasIgnore -and $hasSize -and ($createAsciiHits.Count -eq 0) -and (-not $metaBom)) {
        $createOk = $true
        $createWhy = 'priority-create-table IGNORE_DUP_KEY + SIZE + ASCII + meta no BOM'
    } else {
        $createWhy = "ignore=$hasIgnore size=$hasSize asciiHits=$($createAsciiHits.Count) metaBom=$metaBom"
        if ($createAsciiHits.Count -gt 0) { $createWhy += ' ' + ($createAsciiHits -join ',') }
    }
}
Add-Gate 'CAT-T59' $createOk $createWhy

# MRB #108: Priority Agent home - AGENTS.md + Sync-PriorityGrokSkills default set
$agentsMd = Join-Path $repo 'AGENTS.md'
$syncPs1 = Join-Path $repo 'tools\Sync-PriorityGrokSkills.ps1'
$agentHomeOk = $false
$agentHomeWhy = 'Priority Agent home missing'
if ((Test-Path -LiteralPath $agentsMd) -and (Test-Path -LiteralPath $syncPs1)) {
    $agentsText = Get-Content -LiteralPath $agentsMd -Raw -Encoding UTF8
    $syncText = Get-Content -LiteralPath $syncPs1 -Raw -Encoding UTF8
    $hasPriorityAgent = $agentsText -match 'Priority Agent'
    $hasNotOwn = ($agentsText -match 'ce-dayworks') -and ($agentsText -match 'ce-priority')
    $hasSyncMentions = ($agentsText -match 'Sync-PriorityGrokSkills') -and ($syncText -match 'ExcludeCustomer') -and ($syncText -match 'priority-day-works-uat') -and ($syncText -match 'ExcludeDba')
    $agentsAscii = @()
    $ai = 0
    Get-Content -LiteralPath $agentsMd -Encoding UTF8 | ForEach-Object {
        $ai++
        foreach ($ch in $_.ToCharArray()) {
            if ([int]$ch -gt 127) { $agentsAscii += ('L{0}:U+{1:X4}' -f $ai, [int]$ch); break }
        }
    }
    $syncAscii = @()
    $si = 0
    Get-Content -LiteralPath $syncPs1 -Encoding UTF8 | ForEach-Object {
        $si++
        foreach ($ch in $_.ToCharArray()) {
            if ([int]$ch -gt 127) { $syncAscii += ('L{0}:U+{1:X4}' -f $si, [int]$ch); break }
        }
    }
    $writerNoBom = $syncText -match 'UTF8Encoding\s+\$false' -or $syncText -match 'UTF8Encoding \$false'
    if ($hasPriorityAgent -and $hasNotOwn -and $hasSyncMentions -and ($agentsAscii.Count -eq 0) -and ($syncAscii.Count -eq 0) -and $writerNoBom) {
        $agentHomeOk = $true
        $agentHomeWhy = 'AGENTS.md Priority Agent + sync excludes customer/DBA + ASCII + manifest no-BOM writer'
    } else {
        $agentHomeWhy = "agent=$hasPriorityAgent notOwn=$hasNotOwn syncMentions=$hasSyncMentions agentsAscii=$($agentsAscii.Count) syncAscii=$($syncAscii.Count) writerNoBom=$writerNoBom"
    }
}
Add-Gate 'CAT-T60' $agentHomeOk $agentHomeWhy


# MRB #120: harvest-agent-skills Bobiverse intake dual-mode lesson (moved from bobiverse#3349)
$harvestSkill = Join-Path $repo '.grok\skills\harvest-agent-skills\SKILL.md'
$harvestOk = $false
$harvestWhy = 'harvest-agent-skills intake lesson missing'
if (Test-Path -LiteralPath $harvestSkill) {
    $hs = Get-Content -LiteralPath $harvestSkill -Raw -Encoding UTF8
    $hasSection = $hs -match 'Harvested lessons \(intake\)'
    $hasRepo = $hs -match 'SimonBarnett/agentic_fomprep'
    $hasReport = $hs -match 'Report-FomprepIntakeIssue'
    $hasInvoke = $hs -match 'Invoke-FomprepHarvest'
    $hasReferral = $hs -match 'skillbook-referral'
    $hasBacklog = ($hs -match '#109') -and ($hs -match '#118')
    $bom = $false
    $bytes = [System.IO.File]::ReadAllBytes($harvestSkill)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) { $bom = $true }
    if ($hasSection -and $hasRepo -and $hasReport -and $hasInvoke -and $hasReferral -and $hasBacklog -and -not $bom) {
        $harvestOk = $true
        $harvestWhy = 'harvest-agent-skills CAST IRON intake lesson + wrappers + referral + #109-#118 + no BOM'
    } else {
        $harvestWhy = "section=$hasSection repo=$hasRepo report=$hasReport invoke=$hasInvoke referral=$hasReferral backlog=$hasBacklog bom=$bom"
    }
}
Add-Gate 'CAT-T61' $harvestOk $harvestWhy

# MRB #134 / FR-002: durable CAST IRON Bobiverse intake subsection (not only Harvested lessons bullet)
$agentsIntakeSkill = Join-Path $repo '.grok\skills\harvest-agent-skills\SKILL.md'
$t64Ok = $false
$t64Why = 'CAT-T64 harvest-agent-skills CAST IRON Bobiverse intake subsection missing'
if (Test-Path -LiteralPath $agentsIntakeSkill) {
    $t64 = Get-Content -LiteralPath $agentsIntakeSkill -Raw -Encoding UTF8
    $hasHeading = $t64 -match 'CAST IRON - Bobiverse intake'
    $hasUrl = $t64 -match 'https://irc\.ntsa\.uk/bob/v1/intake'
    $hasRepo = $t64 -match 'SimonBarnett/agentic_fomprep'
    $hasReport = $t64 -match 'Report-FomprepIntakeIssue'
    $hasInvoke = $t64 -match 'Invoke-FomprepHarvest'
    $bom64 = $false
    $b64 = [System.IO.File]::ReadAllBytes($agentsIntakeSkill)
    if ($b64.Length -ge 3 -and $b64[0] -eq 0xEF -and $b64[1] -eq 0xBB -and $b64[2] -eq 0xBF) { $bom64 = $true }
    if ($hasHeading -and $hasUrl -and $hasRepo -and $hasReport -and $hasInvoke -and -not $bom64) {
        $t64Ok = $true
        $t64Why = 'CAST IRON Bobiverse intake subsection + URL + repo + Report/Invoke wrappers + no BOM'
    } else {
        $t64Why = "heading=$hasHeading url=$hasUrl repo=$hasRepo report=$hasReport invoke=$hasInvoke bom=$bom64"
    }
}
Add-Gate 'CAT-T64' $t64Ok $t64Why

# MRB #137 / FR-003: harvest-priority-skills CAST IRON Bobiverse intake subsection
$prioHarvestSkill = Join-Path $repo '.grok\skills\harvest-priority-skills\SKILL.md'
$t65Ok = $false
$t65Why = 'CAT-T65 harvest-priority-skills CAST IRON Bobiverse intake subsection missing'
if (Test-Path -LiteralPath $prioHarvestSkill) {
    $t65 = Get-Content -LiteralPath $prioHarvestSkill -Raw -Encoding UTF8
    $hasHeading = $t65 -match 'CAST IRON - Bobiverse intake'
    $hasUrl = $t65 -match 'https://irc\.ntsa\.uk/bob/v1/intake'
    $hasRepo = $t65 -match 'SimonBarnett/agentic_fomprep'
    $hasReport = $t65 -match 'Report-FomprepIntakeIssue'
    $hasInvoke = $t65 -match 'Invoke-FomprepHarvest'
    $hasCeDay = $t65 -match 'ce-dayworks'
    $hasCePri = $t65 -match 'ce-priority'
    $hasSync = $t65 -match 'Sync-PriorityGrokSkills\.ps1'
    $bom65 = $false
    $b65 = [System.IO.File]::ReadAllBytes($prioHarvestSkill)
    if ($b65.Length -ge 3 -and $b65[0] -eq 0xEF -and $b65[1] -eq 0xBB -and $b65[2] -eq 0xBF) { $bom65 = $true }
    if ($hasHeading -and $hasUrl -and $hasRepo -and $hasReport -and $hasInvoke -and $hasCeDay -and $hasCePri -and $hasSync -and -not $bom65) {
        $t65Ok = $true
        $t65Why = 'CAST IRON Bobiverse intake + wrappers + ce-dayworks/ce-priority routing + Sync-PriorityGrokSkills + no BOM'
    } else {
        $t65Why = "heading=$hasHeading url=$hasUrl repo=$hasRepo report=$hasReport invoke=$hasInvoke day=$hasCeDay pri=$hasCePri sync=$hasSync bom=$bom65"
    }
}
Add-Gate 'CAT-T65' $t65Ok $t65Why

# MRB #142 / FR-004: tools/Report-FomprepIntakeIssue.ps1 shipped with default repo
$reportTool = Join-Path $repo 'tools\Report-FomprepIntakeIssue.ps1'
$t66Ok = $false
$t66Why = 'CAT-T66 Report-FomprepIntakeIssue.ps1 missing'
if (Test-Path -LiteralPath $reportTool) {
    $rt = Get-Content -LiteralPath $reportTool -Raw -Encoding UTF8
    $hasDefault = $rt -match "Repo\s*=\s*'SimonBarnett/agentic_fomprep'" -or $rt -match 'defaultRepo\s*=\s*''SimonBarnett/agentic_fomprep'''
    $hasUrl = $rt -match 'https://irc\.ntsa\.uk/bob/v1/intake'
    $hasDry = $rt -match '\[switch\]\$DryRun'
    $hasNoDel = $rt -match '\[switch\]\$NoDelegate'
    $hasValidate = $rt -match "ValidateSet\('issue',\s*'fr',\s*'skill',\s*'harvest'\)"
    $bom66 = $false
    $b66 = [System.IO.File]::ReadAllBytes($reportTool)
    if ($b66.Length -ge 3 -and $b66[0] -eq 0xEF -and $b66[1] -eq 0xBB -and $b66[2] -eq 0xBF) { $bom66 = $true }
    $giPath = Join-Path $repo '.gitignore'
    $giHasOutbox = $false
    if (Test-Path -LiteralPath $giPath) {
        $giRaw = Get-Content -LiteralPath $giPath -Raw -Encoding UTF8
        $giHasOutbox = $giRaw -match '(?m)^report-outbox/'
    }
    if ($hasDefault -and $hasUrl -and $hasDry -and $hasNoDel -and $hasValidate -and $giHasOutbox -and -not $bom66) {
        $t66Ok = $true
        $t66Why = 'Report-FomprepIntakeIssue default repo + DryRun/NoDelegate + ValidateSet + report-outbox gitignore + no BOM'
    } else {
        $t66Why = "default=$hasDefault url=$hasUrl dry=$hasDry nodel=$hasNoDel validate=$hasValidate gitignore=$giHasOutbox bom=$bom66"
    }
}
Add-Gate 'CAT-T66' $t66Ok $t66Why

# MRB #150 / FR-005: tools/Invoke-FomprepHarvest.ps1 session harvest
$harvestTool = Join-Path $repo 'tools\Invoke-FomprepHarvest.ps1'
$t67Ok = $false
$t67Why = 'CAT-T67 Invoke-FomprepHarvest.ps1 missing'
if (Test-Path -LiteralPath $harvestTool) {
    $ht = Get-Content -LiteralPath $harvestTool -Raw -Encoding UTF8
    $hasDefault = $ht -match "Repo\s*=\s*'SimonBarnett/agentic_fomprep'" -or $ht -match 'defaultRepo\s*=\s*''SimonBarnett/agentic_fomprep'''
    $hasUrl = $ht -match 'https://irc\.ntsa\.uk/bob/v1/intake'
    $hasFlush = $ht -match '\[switch\]\$Flush'
    $hasDry = $ht -match '\[switch\]\$DryRun'
    $hasNoDel = $ht -match '\[switch\]\$NoDelegate'
    $hasKind = $ht -match "kind\s*=\s*'harvest'" -or $ht -match 'kind\s*=\s*"harvest"'
    $hasReportRel = $ht -match 'Report-FomprepIntakeIssue'
    $bom67 = $false
    $b67 = [System.IO.File]::ReadAllBytes($harvestTool)
    if ($b67.Length -ge 3 -and $b67[0] -eq 0xEF -and $b67[1] -eq 0xBB -and $b67[2] -eq 0xBF) { $bom67 = $true }
    $giPath = Join-Path $repo '.gitignore'
    $giHasHarvest = $false
    if (Test-Path -LiteralPath $giPath) {
        $giRaw = Get-Content -LiteralPath $giPath -Raw -Encoding UTF8
        $giHasHarvest = $giRaw -match '(?m)^harvest-outbox/'
    }
    if ($hasDefault -and $hasUrl -and $hasFlush -and $hasDry -and $hasNoDel -and $hasKind -and $hasReportRel -and $giHasHarvest -and -not $bom67) {
        $t67Ok = $true
        $t67Why = 'Invoke-FomprepHarvest default repo + Flush/DryRun/NoDelegate + kind=harvest + Report sibling + harvest-outbox gitignore + no BOM'
    } else {
        $t67Why = "default=$hasDefault url=$hasUrl flush=$hasFlush dry=$hasDry nodel=$hasNoDel kind=$hasKind report=$hasReportRel gitignore=$giHasHarvest bom=$bom67"
    }
}
Add-Gate 'CAT-T67' $t67Ok $t67Why

# FR-010 / #118: DryRun fixture for intake tools default repo (offline; no live POST)
$fr010 = Join-Path $repo 'v2\tests\test-fr010-intake-tools-dryrun-default-repo.ps1'
$t69Ok = $false
$t69Why = 'CAT-T69 missing v2/tests/test-fr010-intake-tools-dryrun-default-repo.ps1'
if (Test-Path -LiteralPath $fr010) {
    $p010 = Start-Process -FilePath powershell.exe -ArgumentList @('-NoProfile','-File',$fr010) -Wait -PassThru -NoNewWindow
    if ($p010.ExitCode -eq 0) {
        $t69Ok = $true
        $t69Why = 'FR-010 DryRun Report+Harvest default repo SimonBarnett/agentic_fomprep offline PASS'
    } else {
        $t69Why = ('FR-010 DryRun fixture exit=' + $p010.ExitCode)
    }
}
Add-Gate 'CAT-T69' $t69Ok $t69Why


# FR #121 / hours webhook agent skills
$hoursIds = @(
    'hours-log-work-session',
    'hours-classify',
    'hours-describe',
    'hours-evidence',
    'hours-correct',
    'hours-repo-metadata',
    'hours-draft'
)
$hoursOk = $true
$hoursWhyParts = New-Object System.Collections.Generic.List[string]
$manifestPath = Join-Path $repo '.grok\skills\PRIORITY-AGENT-SKILLS.md'
$manifestText = ''
if (Test-Path -LiteralPath $manifestPath) {
    $manifestText = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8
}
foreach ($hid in $hoursIds) {
    $hp = Join-Path $repo ('.grok\skills\' + $hid + '\SKILL.md')
    if (-not (Test-Path -LiteralPath $hp)) {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('missing:' + $hid)
        continue
    }
    $ht = Get-Content -LiteralPath $hp -Raw -Encoding UTF8
    $hb = [System.IO.File]::ReadAllBytes($hp)
    if ($hb.Length -ge 3 -and $hb[0] -eq 0xEF -and $hb[1] -eq 0xBB -and $hb[2] -eq 0xBF) {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('bom:' + $hid)
    }
    if ($ht -match '(?i)password\s*=\s*\S+' -or $ht -match '(?i)PRIORITY_ODATA_PASSWORD\s*=\s*\S+') {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('secret:' + $hid)
    }
    if ($manifestText -and ($manifestText -notmatch [regex]::Escape($hid))) {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('manifest:' + $hid)
    }
}
$classifyPath = Join-Path $repo '.grok\skills\hours-classify\SKILL.md'
if (Test-Path -LiteralPath $classifyPath) {
    $ctext = Get-Content -LiteralPath $classifyPath -Raw -Encoding UTF8
    if ($ctext -notmatch 'project\.md' -or $ctext -notmatch 'wbs-fallback-map') {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('classify-order')
    }
}
$describePath = Join-Path $repo '.grok\skills\hours-describe\SKILL.md'
if (Test-Path -LiteralPath $describePath) {
    $dtext = Get-Content -LiteralPath $describePath -Raw -Encoding UTF8
    if ($dtext -notmatch '60' -or $dtext -notmatch 'WP') {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('describe-pdes')
    }
}
$draftPath = Join-Path $repo '.grok\skills\hours-draft\SKILL.md'
if (Test-Path -LiteralPath $draftPath) {
    $dr = Get-Content -LiteralPath $draftPath -Raw -Encoding UTF8
    if ($dr -notmatch 'Never' -or $dr -notmatch 'approval' -or $dr -notmatch 'hours-repo-metadata') {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('draft-gates')
    }
}
$repoMeta = Join-Path $repo '.grok\skills\hours-repo-metadata\SKILL.md'
if (Test-Path -LiteralPath $repoMeta) {
    $rm = Get-Content -LiteralPath $repoMeta -Raw -Encoding UTF8
    if ($rm -notmatch 'Never push to `main`' -and $rm -notmatch 'Never push to main') {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('repo-meta-main')
    }
}

# MRB #124 strengthen: log-work-session / evidence / correct contracts
$logPath = Join-Path $repo '.grok\skills\hours-log-work-session\SKILL.md'
if (Test-Path -LiteralPath $logPath) {
    $lt = Get-Content -LiteralPath $logPath -Raw -Encoding UTF8
    if ($lt -notmatch 'idempotency_key' -or $lt -notmatch 'heartbeat' -or ($lt -notmatch 'hours-start' -and $lt -notmatch 'create')) {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('log-session-gates')
    }
}
$evPath = Join-Path $repo '.grok\skills\hours-evidence\SKILL.md'
if (Test-Path -LiteralPath $evPath) {
    $et = Get-Content -LiteralPath $evPath -Raw -Encoding UTF8
    if ($et -notmatch 'evidence' -or ($et -notmatch 'none' -and $et -notmatch 'no proof')) {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('evidence-gates')
    }
}
$corrPath = Join-Path $repo '.grok\skills\hours-correct\SKILL.md'
if (Test-Path -LiteralPath $corrPath) {
    $ct = Get-Content -LiteralPath $corrPath -Raw -Encoding UTF8
    if ($ct -notmatch 'withdraw' -or ($ct -notmatch 'supersede' -and $ct -notmatch 'double')) {
        $hoursOk = $false
        [void]$hoursWhyParts.Add('correct-gates')
    }
}
$mapPath = Join-Path $repo 'docs\skill-sources\hours\wbs-fallback-map.md'
if (-not (Test-Path -LiteralPath $mapPath)) {
    $hoursOk = $false
    [void]$hoursWhyParts.Add('missing-wbs-map')
}
$hoursWhy = if ($hoursOk) { 'seven hours-* skills + manifest + classify/describe/draft/log/evidence/correct gates + no secrets' } else { ($hoursWhyParts -join ',') }
Add-Gate 'CAT-T62' $hoursOk $hoursWhy

# MRB #132 / FR-001 hostile: AGENTS.md Bobiverse intake needles (FR-007 partial; tools/skills/referral gates remain #115)
$agentsIntakeOk = $true
$agentsIntakeWhy = 'AGENTS.md intake URL + SimonBarnett/agentic_fomprep + Report/Invoke-Fomprep wrappers + no bobiverse default'
$agentsPath = Join-Path $repo 'AGENTS.md'
if (-not (Test-Path -LiteralPath $agentsPath)) {
    $agentsIntakeOk = $false
    $agentsIntakeWhy = 'missing AGENTS.md'
} else {
    $at = Get-Content -LiteralPath $agentsPath -Raw -Encoding UTF8
    $ab = [System.IO.File]::ReadAllBytes($agentsPath)
    if ($ab.Length -ge 3 -and $ab[0] -eq 0xEF -and $ab[1] -eq 0xBB -and $ab[2] -eq 0xBF) {
        $agentsIntakeOk = $false
        $agentsIntakeWhy = 'AGENTS.md BOM'
    }
    if ($at -notmatch 'https://irc\.ntsa\.uk/bob/v1/intake') { $agentsIntakeOk = $false; $agentsIntakeWhy = 'missing intake URL' }
    if ($at -notmatch 'SimonBarnett/agentic_fomprep') { $agentsIntakeOk = $false; $agentsIntakeWhy = 'missing home repo' }
    if ($at -notmatch 'Report-FomprepIntakeIssue\.ps1') { $agentsIntakeOk = $false; $agentsIntakeWhy = 'missing Report-FomprepIntakeIssue' }
    if ($at -notmatch 'Invoke-FomprepHarvest\.ps1') { $agentsIntakeOk = $false; $agentsIntakeWhy = 'missing Invoke-FomprepHarvest' }
    if ($at -match '(?i)default\s+-Repo\s+SimonBarnett/bobiverse') { $agentsIntakeOk = $false; $agentsIntakeWhy = 'defaults -Repo bobiverse' }
}
Add-Gate 'CAT-T63' $agentsIntakeOk $agentsIntakeWhy





if ($failed -gt 0) {
    Write-Host "Test-PriorityCatalog FAIL ($failed)"
    exit 1
}
Write-Host 'Test-PriorityCatalog PASS'
exit 0
