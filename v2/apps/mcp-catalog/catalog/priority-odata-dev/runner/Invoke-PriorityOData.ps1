#requires -Version 5.1
<#
.SYNOPSIS
    Local Priority OData tools. Instance from user allowlist. Never logs passwords.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('get', 'query', 'dump_procedure', 'formlimited_audit')]
    [string]$Action,

    [string]$InstanceId,
    [string]$Path,
    [string]$Filter,
    [string]$Expand,
    [string]$Select,
    [string]$OrderBy,
    [string]$EName,
    [string[]]$Forms,
    [string]$Database,
    [string]$InstancesPath,
    [string]$FixturePath,
    [string]$PinPath,
    [switch]$ComposeSql,
    $Top
)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$lib = Join-Path $here 'lib'
. (Join-Path $lib 'allowlist.ps1')
. (Join-Path $lib 'Get-WinrunCredential.ps1')
. (Join-Path $lib 'sql.ps1')
. (Join-Path $lib 'odata.ps1')
. (Join-Path $lib 'pin.ps1')
. (Join-Path $lib 'formlimited-audit-sql.ps1')

$started = [datetime]::UtcNow
$tool = $Action
if ($Action -eq 'dump_procedure') { $tool = 'odata_dump_procedure' }
elseif ($Action -eq 'formlimited_audit') { $tool = 'formlimited_audit' }
elseif ($Action -eq 'get') { $tool = 'odata_get' }
elseif ($Action -eq 'query') { $tool = 'odata_query' }

$result = New-ODataResult -Tool $tool -InstanceId $InstanceId -StartedAt $started
$pick = $null
$script:auth = $null

function Emit-OData {
    param($Result, [int]$Code, $Instance)
    $Result.exitCode = $Code
    Complete-ODataResult -Result $Result -StartedAt $started
    $work = $null
    if ($Instance) { $work = Get-ODataWorkRoot -Instance $Instance }
    $secrets = @()
    if ($script:auth) { $secrets += [string]$script:auth.Password }
    if ($env:PRIORITY_ODATA_PASSWORD) { $secrets += [string]$env:PRIORITY_ODATA_PASSWORD }
    if (Test-SecretLeak -Obj $Result -Secrets $secrets) {
        $Result.body = $null
        $Result.raw = $null
        Add-ODataError -Result $Result -Source 'policy' -Severity 'Blocker' -Text 'refusing to emit result that contained a secret'
        $Result.ok = $false
        $Result.reason = 'secret_leak'
        $Code = 2
        $Result.exitCode = $Code
    }
    Write-ODataJson -Result $Result -WorkRoot $work
    exit $Code
}

$instFile = Get-InstancesFile -Path $InstancesPath
$allow = Read-Allowlist -Path $instFile
if (-not $allow.ok) {
    $result.reason = $allow.reason
    Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ("allowlist missing or empty: {0} ({1})" -f $allow.reason, $allow.path)
    Emit-OData $result 2 $null
}

$sel = Select-AllowlistedInstance -Allow $allow -InstanceId $InstanceId
if (-not $sel.ok) {
    $result.reason = $sel.reason
    if ($sel.reason -eq 'instance_required') {
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('instance_id required; have: ' + ($sel.instanceIds -join ', '))
    } else {
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('instance not in allowlist: ' + [string]$InstanceId)
    }
    Emit-OData $result 2 $null
}

$pick = $sel.instance
$result.instanceId = [string]$pick.id

if (Test-LiveRefused -Instance $pick) {
    $result.reason = 'live_refused'
    Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('live/PRI instance refused: ' + [string]$pick.id)
    Emit-OData $result 2 $pick
}

$useFixture = -not [string]::IsNullOrWhiteSpace($FixturePath)
if ($useFixture -and -not (Test-Path -LiteralPath $FixturePath)) {
    $result.reason = 'fixture_missing'
    Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('fixture not found: ' + $FixturePath)
    Emit-OData $result 2 $pick
}

if ($Action -eq 'formlimited_audit') {
    $formList = @($Forms | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if ($formList.Count -lt 1) {
        $result.reason = 'forms_required'
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'formlimited_audit needs a form set'
        Emit-OData $result 2 $pick
    }
    foreach ($f in $formList) {
        if ($f -notmatch '^[A-Za-z][A-Za-z0-9_]*$') {
            $result.reason = 'bad_form'
            Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ("bad form name '$f'")
            Emit-OData $result 2 $pick
        }
    }

    $pinRead = Read-ShellPin -Path $PinPath -StartDir $here
    if (-not $pinRead.ok) {
        $result.reason = 'pin_missing'
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('pin file missing for SQL identifiers: ' + [string]$pinRead.reason)
        Emit-OData $result 2 $pick
    }
    $sqlPin = $pinRead.pin
    $needSqlPin = $ComposeSql -or -not $useFixture
    if ($needSqlPin) {
        $sqlGaps = @(Get-SqlPinGaps -Pin $sqlPin)
        if ($sqlGaps.Count -gt 0) {
            $result.reason = 'pin_incomplete'
            Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ('SQL identifiers unpinned. Gaps: ' + ($sqlGaps -join ', '))
            Emit-OData $result 2 $pick
        }
    }

    if ($ComposeSql) {
        try {
            $built = New-FormLimitedAuditSql -Pin $sqlPin -FormNames $formList
            $result.ok = $true
            $result.reason = 'composed'
            $result.sql = $built.Sql
            $result.sqlParameters = @($built.Placeholders)
            $result.formCount = $formList.Count
            Emit-OData $result 0 $pick
        } catch {
            $result.reason = 'compose_failed'
            Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ([string]$_.Exception.Message)
            Emit-OData $result 2 $pick
        }
    }

    $rawRows = @()
    if ($useFixture) {
        $fx = ConvertFrom-ODataFixture -Path $FixturePath
        if ($fx.PSObject.Properties['rows']) {
            $rawRows = @(Get-ODataCollection $fx.rows)
        } else {
            $rawRows = @(Get-ODataCollection $fx)
        }
        $result.reason = 'fixture'
    } else {
        $db = $Database
        if ([string]::IsNullOrWhiteSpace($db)) { $db = [string]$pick.sqlDatabase }
        if ([string]::IsNullOrWhiteSpace($db)) { $db = [string]$pick.company }
        if ([string]::IsNullOrWhiteSpace($db)) { $db = 'system' }
        $conn = $null
        try {
            $conn = New-InstanceSqlConnection -Instance $pick -Database $db
            $built = New-FormLimitedAuditSql -Pin $sqlPin -FormNames $formList
            $table = Invoke-FormPrepSql -Connection $conn -Query $built.Sql -Parameters $built.Parameters
            foreach ($row in $table.Rows) {
                $ht = @{}
                foreach ($col in $table.Columns) { $ht[$col.ColumnName] = $row[$col.ColumnName] }
                $rawRows += [pscustomobject]$ht
            }
            $result.reason = 'audited'
        } catch {
            $result.reason = 'sql_failed'
            Add-ODataError -Result $result -Source 'sql' -Severity 'Blocker' -Text ([string]$_.Exception.Message)
            Emit-OData $result 2 $pick
        } finally {
            if ($conn) { try { $conn.Close(); $conn.Dispose() } catch { } }
        }
    }

    $mapped = @()
    $footgun = $false
    foreach ($r in $rawRows) {
        $m = ConvertTo-FormLimitedRow -Raw $r
        $mapped += $m
        if ($m.footgun) { $footgun = $true }
    }
    $result.risks = @($mapped)
    $result.formCount = $formList.Count
    $result.rowCount = $mapped.Count
    if ($footgun) {
        $result.ok = $false
        $result.reason = 'restflag_without_limitflag'
        Add-ODataError -Result $result -Source 'FORMLIMITED' -Severity 'Blocker' -Text 'RESTFLAG=Y with LIMITFLAG not Y can hide UI sibling-tab strips (PART long-desc 2026-09-15). Do not leave RESTFLAG-only FORMLIMITED on UI-tested forms. Audit is read-only.'
        Emit-OData $result 2 $pick
    }
    $result.ok = $true
    if (-not $result.reason) { $result.reason = 'audited' }
    Emit-OData $result 0 $pick
}

$rel = $Path
$queryFilter = $Filter
$queryExpand = $Expand
$querySelect = $Select
$queryOrder = $OrderBy
$queryTop = $Top

if ($Action -eq 'dump_procedure') {
    if ([string]::IsNullOrWhiteSpace($EName)) {
        $result.reason = 'ename_required'
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'dump_procedure needs EName'
        Emit-OData $result 2 $pick
    }
    if ($EName -notmatch '^[A-Za-z][A-Za-z0-9_-]*$') {
        $result.reason = 'bad_ename'
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ("bad procedure name '$EName'")
        Emit-OData $result 2 $pick
    }
    $escaped = $EName.Replace("'", "''")
    $rel = 'EPROG'
    $queryFilter = "ENAME eq '$escaped'"
    $queryExpand = 'PROG_SUBFORM($expand=PROGTEXT_SUBFORM)'
    $result.ename = $EName
}

if ([string]::IsNullOrWhiteSpace($rel)) {
    $result.reason = 'path_required'
    Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'path is required'
    Emit-OData $result 2 $pick
}

try {
    $base = Get-ODataBaseUrl -Instance $pick
} catch {
    $result.reason = 'bad_base'
    Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text ([string]$_.Exception.Message)
    Emit-OData $result 2 $pick
}

$joined = Join-ODataUrl -Base $base -RelPath $rel
if (-not $joined.ok) {
    $result.reason = $joined.reason
    Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text $joined.text
    Emit-OData $result 2 $pick
}

$qs = ConvertTo-ODataQueryString -Filter $queryFilter -Expand $queryExpand -Select $querySelect -OrderBy $queryOrder -Top $queryTop
$url = $joined.url
if ($qs) { $url = $url + '?' + $qs }
$result.url = $url

$body = $null
if ($useFixture) {
    $body = ConvertFrom-ODataFixture -Path $FixturePath
    $result.reason = 'fixture'
    $result.status = 200
} else {
    $script:auth = Get-ODataAuth -Instance $pick
    if (-not $script:auth) {
        $result.reason = 'no_cred'
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'CredMan/env missing for this instance; no HTTP'
        Emit-OData $result 2 $pick
    }
    $http = Invoke-ODataHttp -Url $url -Auth $script:auth
    $result.status = $http.status
    if (-not $http.ok) {
        $result.reason = $(if ($http.reason) { $http.reason } else { 'odata_http' })
        $hint = [string]$http.text
        if ($result.reason -eq 'odata_401') {
            $hint = 'HTTP 401. Do not retry with a logged password. SQL structural assert is allowed on DEV when OData is unlicensed.'
        }
        Add-ODataError -Result $result -Source 'odata' -Severity 'Blocker' -Text $hint
        Emit-OData $result 2 $pick
    }
    $body = $http.body
    $result.reason = 'ok'
}

$result.body = $body

if ($Action -eq 'dump_procedure') {
    $steps = @(Get-ProgTextSteps -ODataValue $body)
    $result.steps = $steps
    $work = Get-ODataWorkRoot -Instance $pick
    $dumpName = 'eprog-' + $EName + '-' + $result.runId + '.json'
    $dumpPath = Join-Path $work $dumpName
    $dumpObj = [ordered]@{
        ename    = $EName
        url      = $url
        dumpedAt = [datetime]::UtcNow.ToString('o')
        steps    = $steps
        body     = $body
    }
    if (Test-SecretLeak -Obj $dumpObj -Secrets @($(if ($script:auth) { $script:auth.Password }), $env:PRIORITY_ODATA_PASSWORD)) {
        $result.reason = 'secret_leak'
        Add-ODataError -Result $result -Source 'policy' -Severity 'Blocker' -Text 'dump contained a secret; refusing to write'
        Emit-OData $result 2 $pick
    }
    [System.IO.File]::WriteAllText($dumpPath, ($dumpObj | ConvertTo-Json -Depth 16))
    $result.dumpPath = $dumpPath
    $result.dumpBytes = ([System.IO.FileInfo]$dumpPath).Length
    $result.reason = $(if ($useFixture) { 'fixture' } else { 'dumped' })
}

$result.ok = $true
Emit-OData $result 0 $pick
