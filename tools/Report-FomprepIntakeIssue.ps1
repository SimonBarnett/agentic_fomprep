<#
.SYNOPSIS
  POST kind=issue|fr|skill|harvest to Bobiverse intake for SimonBarnett/agentic_fomprep.

.DESCRIPTION
  Repo-local reporter for the Priority Agent home. Defaults -Repo to
  SimonBarnett/agentic_fomprep. Intake needs no secret. On network/HTTP failure,
  writes the payload under report-outbox (repo and ~/.grok/bob) for later retry
  with the same idempotency_key. Self-contained POST works without a bob install;
  when BOB_INSTALL_ROOT (or C:\ai\bob) has Report-BobiverseIntakeIssue.ps1, may
  delegate with the forced default repo unless -NoDelegate.

.EXAMPLE
  .\tools\Report-FomprepIntakeIssue.ps1 -Kind issue -Title 'gap: catalog' -Body 'what/where' -DryRun

.EXAMPLE
  .\tools\Report-FomprepIntakeIssue.ps1 -Kind fr -Title 'FR: add needle' -Body 'Goal...'
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('issue', 'fr', 'skill', 'harvest')]
    [string]$Kind,

    [Parameter(Mandatory = $true)]
    [string]$Title,

    [Parameter(Mandatory = $true)]
    [string]$Body,

    [string]$Repo = 'SimonBarnett/agentic_fomprep',

    [string]$IntakeUrl = 'https://irc.ntsa.uk/bob/v1/intake',

    [string]$IdempotencyKey = '',

    [string]$Machine = '',

    [string]$Agent = 'Report-FomprepIntakeIssue',

    [string]$OutboxDir = '',

    [int]$TimeoutSec = 30,

    [switch]$DryRun,

    [switch]$NoDelegate
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$defaultRepo = 'SimonBarnett/agentic_fomprep'
if (-not $PSBoundParameters.ContainsKey('Repo') -or [string]::IsNullOrWhiteSpace($Repo)) {
    $Repo = $defaultRepo
}

if (-not ($Repo -match '^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$')) {
    throw "Repo must be owner/name (got '$Repo')."
}

$titleTrim = $Title.Trim()
$bodyTrim = $Body.Trim()
if (-not $titleTrim) { throw 'Title is empty after trim.' }
if (-not $bodyTrim) { throw 'Body is empty after trim.' }
if ($titleTrim.Length -gt 200) {
    throw ('Title length {0} exceeds intake max 200.' -f $titleTrim.Length)
}

# Refuse obvious secret material in title/body (never file secrets).
$secretHit = $null
$scanText = $titleTrim + "`n" + $bodyTrim
if ($scanText -match '(?i)\bpassword\s*=\s*\S+') { $secretHit = 'password=' }
elseif ($scanText -match '(?i)\bBearer\s+[A-Za-z0-9\-_\.=]+') { $secretHit = 'Bearer token' }
elseif ($scanText -match '(?i)\b(xai[_-]?api[_-]?key|api[_-]?key)\s*=\s*\S+') { $secretHit = 'api_key=' }
elseif ($scanText -match '(?i)-----BEGIN [A-Z ]*PRIVATE KEY-----') { $secretHit = 'private key PEM' }
if ($secretHit) {
    throw ("Refusing to file: title/body looks like it contains a secret ($secretHit). Remove secrets and retry.")
}

function Get-FomprepRepoRoot {
    $here = $PSScriptRoot
    if (-not $here) { $here = (Get-Location).Path }
    return (Split-Path -Parent $here)
}

function New-FomprepIntakePayload {
    $idem = $IdempotencyKey
    if (-not $idem) {
        $raw = ('{0}|{1}|{2}|{3}' -f $Kind, $Repo, $titleTrim, $bodyTrim)
        $sha = [Security.Cryptography.SHA256]::Create()
        try {
            $hash = $sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($raw))
            $idem = 'fp-' + ([BitConverter]::ToString($hash) -replace '-', '').Substring(0, 24).ToLowerInvariant()
        }
        finally { $sha.Dispose() }
    }
    $mach = $Machine
    if (-not $mach) {
        if ($env:BOB_MACHINE_ID) { $mach = [string]$env:BOB_MACHINE_ID }
        else { $mach = [string]$env:COMPUTERNAME }
    }
    return [ordered]@{
        kind            = $Kind
        repo            = $Repo
        title           = $titleTrim
        body            = $bodyTrim
        idempotency_key = $idem
        source          = [ordered]@{
            machine    = ([string]$mach).Substring(0, [Math]::Min(64, ([string]$mach).Length))
            agent      = ([string]$Agent).Substring(0, [Math]::Min(64, ([string]$Agent).Length))
            skill_book = 'harvest-priority-skills'
            version    = ''
        }
    }
}

function Write-FomprepIntakeOutbox {
    param(
        [Parameter(Mandatory)]$Payload,
        [string[]]$Dirs
    )
    $written = @()
    $idem = [string]$Payload.idempotency_key
    $digest = $idem
    if ($digest.Length -gt 16) { $digest = $digest.Substring(0, 16) }
    $name = 'report-{0}.json' -f $digest
    $json = ($Payload | ConvertTo-Json -Depth 6 -Compress)
    foreach ($dir in $Dirs) {
        if (-not $dir) { continue }
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        $path = Join-Path $dir $name
        [IO.File]::WriteAllText($path, $json + "`n", [Text.UTF8Encoding]::new($false))
        $written += $path
    }
    return $written
}

function Get-IntakeResponseProp {
    param($Response, [Parameter(Mandatory)][string]$Name, $Default = $null)
    if ($null -eq $Response) { return $Default }
    $prop = $Response.PSObject.Properties[$Name]
    if ($null -eq $prop) { return $Default }
    return $prop.Value
}

function Get-FomprepIntakeErrorDetail {
    param($ErrorRecord)
    $detail = ''
    if ($ErrorRecord -and $ErrorRecord.ErrorDetails -and $ErrorRecord.ErrorDetails.Message) {
        $detail = [string]$ErrorRecord.ErrorDetails.Message
    }
    $intakeError = $null
    if ($detail -match '"error"\s*:\s*"([^"]+)"') { $intakeError = $Matches[1] }
    $status = $null
    $ex = if ($ErrorRecord) { $ErrorRecord.Exception } else { $null }
    while ($null -ne $ex) {
        $respProp = $ex.PSObject.Properties['Response']
        if ($null -ne $respProp -and $null -ne $respProp.Value) {
            $resp = $respProp.Value
            $codeProp = $resp.PSObject.Properties['StatusCode']
            if ($null -ne $codeProp -and $null -ne $codeProp.Value) {
                try { $status = [int]$codeProp.Value; break } catch { }
                try { $status = [int]$codeProp.Value.value__; break } catch { }
            }
        }
        $innerProp = $ex.PSObject.Properties['InnerException']
        if ($null -eq $innerProp) { break }
        $ex = $innerProp.Value
    }
    if ($null -eq $status -and $ErrorRecord -and $ErrorRecord.Exception.Message -match '\((\d{3})\)') {
        $status = [int]$Matches[1]
    }
    return [pscustomobject]@{ Status = $status; Body = $detail; IntakeError = $intakeError }
}

$payload = New-FomprepIntakePayload

if ($DryRun) {
    $json = ($payload | ConvertTo-Json -Depth 6 -Compress)
    Write-Output $json
    return [pscustomobject]@{
        ok              = $true
        dry_run         = $true
        repo            = $payload.repo
        kind            = $payload.kind
        idempotency_key = $payload.idempotency_key
        payload_json    = $json
    }
}

# Optional delegate to bob install helper (still forces this product's default when caller omitted -Repo).
if (-not $NoDelegate) {
    $bobRoot = $env:BOB_INSTALL_ROOT
    if (-not $bobRoot) { $bobRoot = 'C:\ai\bob' }
    $bobReport = Join-Path $bobRoot 'scripts\Report-BobiverseIntakeIssue.ps1'
    if (Test-Path -LiteralPath $bobReport) {
        $delegated = & $bobReport -Kind $Kind -Title $titleTrim -Body $bodyTrim -Repo $Repo `
            -IntakeUrl $IntakeUrl -IdempotencyKey $payload.idempotency_key `
            -Machine $payload.source.machine -Agent $Agent -TimeoutSec $TimeoutSec
        return $delegated
    }
}

$repoRoot = Get-FomprepRepoRoot
$outDirs = New-Object System.Collections.Generic.List[string]
if ($OutboxDir) { [void]$outDirs.Add($OutboxDir) }
[void]$outDirs.Add((Join-Path $env:USERPROFILE '.grok\bob\report-outbox'))
[void]$outDirs.Add((Join-Path $repoRoot 'report-outbox'))

$headers = @{ 'Content-Type' = 'application/json; charset=utf-8' }
if ($env:BOB_INTAKE_KEY) {
    $headers['X-Bob-Intake-Key'] = [string]$env:BOB_INTAKE_KEY
}

$bodyJson = ($payload | ConvertTo-Json -Depth 6 -Compress)
$bodyBytes = [Text.Encoding]::UTF8.GetBytes($bodyJson)
try {
    $resp = Invoke-RestMethod -Method Post -Uri $IntakeUrl -Headers $headers `
        -Body $bodyBytes -TimeoutSec $TimeoutSec
    return [pscustomobject]@{
        ok              = $true
        queued_local    = $false
        intake_id       = (Get-IntakeResponseProp -Response $resp -Name 'intake_id' -Default $null)
        url             = (Get-IntakeResponseProp -Response $resp -Name 'url' -Default $null)
        queued          = [bool](Get-IntakeResponseProp -Response $resp -Name 'queued' -Default $false)
        idempotency_key = $payload.idempotency_key
        repo            = $payload.repo
        outbox          = @()
        error           = $null
        http_status     = 202
    }
}
catch {
    $info = Get-FomprepIntakeErrorDetail -ErrorRecord $_
    $paths = Write-FomprepIntakeOutbox -Payload $payload -Dirs ($outDirs | Select-Object -Unique)
    $msg = [string]$_.Exception.Message
    if ($info.IntakeError) {
        $msg = "HTTP {0} intake error={1}" -f $(if ($info.Status) { $info.Status } else { '?' }), $info.IntakeError
    }
    return [pscustomobject]@{
        ok              = $false
        queued_local    = $true
        intake_id       = $null
        url             = $null
        queued          = $true
        idempotency_key = $payload.idempotency_key
        repo            = $payload.repo
        outbox          = $paths
        error           = $msg
        intake_error    = $info.IntakeError
        http_status     = $info.Status
    }
}
