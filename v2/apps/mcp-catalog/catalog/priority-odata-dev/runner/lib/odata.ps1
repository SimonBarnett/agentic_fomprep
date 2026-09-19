function Get-ODataBaseUrl {
    param($Instance)
    $override = [string]$Instance.odataBaseUrl
    if (-not [string]::IsNullOrWhiteSpace($override)) {
        return $override.TrimEnd('/')
    }
    $web = [string]$Instance.webBaseUrl
    if ([string]::IsNullOrWhiteSpace($web)) {
        throw 'webBaseUrl is empty'
    }
    $tabula = [string]$Instance.tabulaini
    if ([string]::IsNullOrWhiteSpace($tabula)) { $tabula = 'tabula.ini' }
    $company = [string]$Instance.company
    if ([string]::IsNullOrWhiteSpace($company)) {
        throw 'company is empty'
    }
    return ($web.TrimEnd('/') + '/odata/Priority/' + $tabula + '/' + $company)
}

function Join-ODataUrl {
    param(
        [Parameter(Mandatory = $true)][string]$Base,
        [string]$RelPath
    )
    $root = $Base.TrimEnd('/')
    $rel = if ($null -eq $RelPath) { '' } else { $RelPath.Trim() }
    if ([string]::IsNullOrWhiteSpace($rel) -or $rel -eq '/') {
        return @{ ok = $true; url = $root }
    }
    $rel = $rel.TrimStart('/')
    if ($rel -match '\.\.' -or $rel -match '://' -or $rel -match '(?i)^https?:' -or $rel.Contains('\')) {
        return @{ ok = $false; reason = 'path_refused'; text = 'OData path must stay under the instance base URL' }
    }
    $url = $root + '/' + $rel
    if ($url -ne $root -and -not $url.StartsWith($root + '/', [System.StringComparison]::OrdinalIgnoreCase)) {
        return @{ ok = $false; reason = 'path_refused'; text = 'OData path escaped the instance base URL' }
    }
    return @{ ok = $true; url = $url }
}

function ConvertTo-ODataQueryString {
    param(
        [string]$Filter,
        [string]$Expand,
        [string]$Select,
        [string]$OrderBy,
        [string]$Format,
        $Top
    )
    $parts = New-Object System.Collections.Generic.List[string]
    if (-not [string]::IsNullOrWhiteSpace($Filter)) {
        [void]$parts.Add('$filter=' + [uri]::EscapeDataString($Filter))
    }
    if (-not [string]::IsNullOrWhiteSpace($Expand)) {
        [void]$parts.Add('$expand=' + [uri]::EscapeDataString($Expand))
    }
    if (-not [string]::IsNullOrWhiteSpace($Select)) {
        [void]$parts.Add('$select=' + [uri]::EscapeDataString($Select))
    }
    if (-not [string]::IsNullOrWhiteSpace($OrderBy)) {
        [void]$parts.Add('$orderby=' + [uri]::EscapeDataString($OrderBy))
    }
    if ($null -ne $Top -and [string]$Top -ne '') {
        $n = 0
        if (-not [int]::TryParse([string]$Top, [ref]$n) -or $n -lt 0) {
            throw "Bad `$top '$Top'"
        }
        [void]$parts.Add('$top=' + $n)
    }
    if (-not [string]::IsNullOrWhiteSpace($Format)) {
        [void]$parts.Add('$format=' + [uri]::EscapeDataString($Format))
    }
    if ($parts.Count -lt 1) { return '' }
    return ($parts -join '&')
}

function Get-ODataAuth {
    param($Instance)
    $user = [string]$Instance.priorityUser
    $pass = $null
    $target = [string]$Instance.credentialTarget
    if (-not [string]::IsNullOrWhiteSpace($target)) {
        $cred = Get-WinrunCredential -Target $target
        if ($cred) {
            if ([string]::IsNullOrWhiteSpace($user)) { $user = [string]$cred.UserName }
            $pass = [string]$cred.Password
        }
    }
    if ([string]::IsNullOrWhiteSpace($pass) -and $env:PRIORITY_ODATA_PASSWORD) {
        $pass = [string]$env:PRIORITY_ODATA_PASSWORD
    }
    if ([string]::IsNullOrWhiteSpace($user) -and $env:PRIORITY_ODATA_USER) {
        $user = [string]$env:PRIORITY_ODATA_USER
    }
    if ([string]::IsNullOrWhiteSpace($user) -or [string]::IsNullOrWhiteSpace($pass)) {
        return $null
    }
    return @{ UserName = $user; Password = $pass }
}

function New-ODataBasicHeaders {
    param($Auth)
    $pair = $Auth.UserName + ':' + $Auth.Password
    $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($pair))
    return @{
        Authorization = 'Basic ' + $b64
        Accept        = 'application/json'
    }
}

function Test-SecretLeak {
    param($Obj, [string[]]$Secrets)
    $json = [string]($Obj | ConvertTo-Json -Depth 12 -Compress)
    foreach ($s in @($Secrets)) {
        if ([string]::IsNullOrWhiteSpace($s)) { continue }
        if ($s.Length -lt 4) { continue }
        if ($json.Contains($s)) { return $true }
    }
    return $false
}

function Get-FormLimitedRiskClass {
    param($LimitFlag, $RestFlag)
    $r = ([string]$RestFlag).Trim().ToUpperInvariant()
    $l = ([string]$LimitFlag).Trim().ToUpperInvariant()
    if ($r -eq 'Y' -and $l -ne 'Y') { return 'restflag_without_limitflag' }
    if ($r -eq 'Y' -and $l -eq 'Y') { return 'restflag_with_limitflag_unconfirmed' }
    return 'none'
}

function Get-PropIgnoreCase {
    param($Obj, [string[]]$Names)
    if ($null -eq $Obj) { return $null }
    foreach ($n in $Names) {
        if ($Obj -is [hashtable]) {
            foreach ($k in $Obj.Keys) {
                if ([string]$k -ieq $n) { return $Obj[$k] }
            }
        }
        $p = $Obj.PSObject.Properties | Where-Object { [string]$_.Name -ieq $n } | Select-Object -First 1
        if ($p) { return $p.Value }
    }
    return $null
}

function ConvertTo-FormLimitedRow {
    param($Raw)
    $form = Get-PropIgnoreCase $Raw @('FORM', 'form', 'FormName', 'ENAME')
    $users = Get-PropIgnoreCase $Raw @('USERS', 'USER', 'USERLOGIN', 'INIT')
    $limit = Get-PropIgnoreCase $Raw @('LIMITFLAG', 'limitFlag')
    $rest = Get-PropIgnoreCase $Raw @('RESTFLAG', 'restFlag')
    $risk = Get-FormLimitedRiskClass -LimitFlag $limit -RestFlag $rest
    return [pscustomobject]@{
        form      = [string]$form
        users     = [string]$users
        limitFlag = [string]$limit
        restFlag  = [string]$rest
        risk      = $risk
        footgun   = ($risk -eq 'restflag_without_limitflag')
    }
}

function Get-ODataCollection {
    param($Node)
    if ($null -eq $Node) { return @() }
    if ($Node -is [string]) { return @($Node) }
    $val = Get-PropIgnoreCase $Node @('value', 'results', 'rows')
    if ($null -ne $val) {
        if ($val -is [string]) { return @($val) }
        return @($val)
    }
    if ($Node -is [System.Array]) { return @($Node) }
    return @($Node)
}

function Get-ProgTextSteps {
    param($ODataValue)
    $out = @()
    if ($null -eq $ODataValue) { return $out }
    $entities = @()
    $val = Get-PropIgnoreCase $ODataValue @('value')
    if ($null -ne $val) { $entities = @($val) } else { $entities = @($ODataValue) }
    foreach ($ent in $entities) {
        $subs = @()
        $prog = Get-PropIgnoreCase $ent @('PROG_SUBFORM')
        if ($null -ne $prog) { $subs = @($prog) }
        foreach ($sub in $subs) {
            $pos = 0
            $posVal = Get-PropIgnoreCase $sub @('POS', 'NUM', 'LINE')
            if ($null -ne $posVal -and [string]$posVal -match '^\d+$') { $pos = [int]$posVal }
            $texts = @()
            $subText = Get-PropIgnoreCase $sub @('PROGTEXT_SUBFORM')
            if ($null -ne $subText) { $texts = @($subText) }
            if ($texts.Count -gt 0) {
                foreach ($t in $texts) {
                    $text = ''
                    if ($t -is [string]) { $text = [string]$t }
                    else { $text = [string](Get-PropIgnoreCase $t @('TEXT', 'T$TEXT', 'PROGTEXT')) }
                    if (-not [string]::IsNullOrWhiteSpace($text)) {
                        $out += [pscustomobject]@{ pos = $pos; source = 'PROGTEXT_SUBFORM'; text = $text }
                    }
                }
            }
            else {
                $fallback = [string](Get-PropIgnoreCase $sub @('PROCTABLETEXT'))
                if (-not [string]::IsNullOrWhiteSpace($fallback)) {
                    $out += [pscustomobject]@{ pos = $pos; source = 'PROCTABLETEXT'; text = $fallback }
                }
            }
        }
    }
    $hasProg = @($out | Where-Object { $_.source -eq 'PROGTEXT_SUBFORM' }).Count -gt 0
    if ($hasProg) { return @($out | Where-Object { $_.source -ne 'PROCTABLETEXT' }) }
    return @($out)
}

function Get-ODataWorkRoot {
    param($Instance)
    $work = $null
    if ($Instance -and $Instance.agentWork) { $work = [string]$Instance.agentWork }
    if (-not $work) {
        $id = 'default'
        if ($Instance -and $Instance.id) { $id = [string]$Instance.id }
        $work = Join-Path $env:TEMP ("priority-odata-" + $id)
    }
    New-Item -ItemType Directory -Path $work -Force | Out-Null
    return $work
}

function New-ODataResult {
    param(
        [string]$Tool,
        [string]$InstanceId,
        [datetime]$StartedAt = [datetime]::UtcNow
    )
    return [ordered]@{
        ok          = $false
        runId       = [guid]::NewGuid().ToString().ToLowerInvariant()
        instanceId  = $(if ($InstanceId) { $InstanceId } else { $null })
        skill       = 'priority-odata-dev'
        tool        = $Tool
        startedAt   = $StartedAt.ToString('o')
        endedAt     = $null
        durationSec = 0
        reason      = $null
        exitCode    = 2
        errors      = @()
        url         = $null
        dumpPath    = $null
        risks       = @()
        steps       = @()
    }
}

function Add-ODataError {
    param($Result, [string]$Source, [string]$Severity, [string]$Text)
    $Result.errors = @($Result.errors) + @([pscustomobject]@{
            source   = $Source
            severity = $Severity
            text     = $Text
        })
}

function Complete-ODataResult {
    param($Result, [datetime]$StartedAt)
    $ended = [datetime]::UtcNow
    $Result.endedAt = $ended.ToString('o')
    $Result.durationSec = [int][Math]::Max(0, ($ended - $StartedAt).TotalSeconds)
    if (-not $Result.ok -and @($Result.errors).Count -lt 1) {
        Add-ODataError -Result $Result -Source 'policy' -Severity 'Blocker' -Text 'errors[] was empty on fail'
    }
}

function Write-ODataJson {
    param($Result, [string]$WorkRoot)
    $json = $Result | ConvertTo-Json -Depth 10 -Compress
    if ($WorkRoot) {
        New-Item -ItemType Directory -Path $WorkRoot -Force | Out-Null
        [System.IO.File]::WriteAllText((Join-Path $WorkRoot 'last-odata.json'), $json)
        if ($Result.runId) {
            $runDir = Join-Path $WorkRoot $Result.runId
            New-Item -ItemType Directory -Path $runDir -Force | Out-Null
            [System.IO.File]::WriteAllText((Join-Path $runDir 'result.json'), $json)
        }
    }
    Write-Output $json
}

function ConvertFrom-ODataFixture {
    param([string]$Path)
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    return $raw | ConvertFrom-Json
}

function Invoke-ODataHttp {
    param(
        [string]$Url,
        $Auth,
        [int]$TimeoutSec = 60
    )
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    } catch { }
    $headers = New-ODataBasicHeaders -Auth $Auth
    try {
        $resp = Invoke-WebRequest -Uri $Url -Headers $headers -Method GET -TimeoutSec $TimeoutSec -UseBasicParsing -ErrorAction Stop
        $code = [int]$resp.StatusCode
        $body = $null
        if ($resp.Content) {
            try { $body = $resp.Content | ConvertFrom-Json } catch { $body = @{ raw = [string]$resp.Content } }
        }
        return @{ ok = ($code -ge 200 -and $code -lt 300); status = $code; body = $body }
    } catch {
        $ex = $_.Exception
        $status = 0
        $resp = $null
        if ($ex.Response) {
            try { $status = [int]$ex.Response.StatusCode } catch { }
        }
        $reason = 'odata_http'
        if ($status -eq 401) { $reason = 'odata_401' }
        elseif ($status -eq 404) { $reason = 'odata_404' }
        return @{
            ok     = $false
            status = $status
            body   = $resp
            reason = $reason
            text   = [string]$ex.Message
        }
    }
}
