<#
.SYNOPSIS
  Session-close harvest for SimonBarnett/agentic_fomprep (kind=harvest to Bobiverse intake).

.DESCRIPTION
  Builds one harvest payload from -Summary / -Lesson and POSTs to
  https://irc.ntsa.uk/bob/v1/intake with default -Repo SimonBarnett/agentic_fomprep.
  Offline or failing POSTs land under harvest-outbox (repo + ~/.grok/bob) and are
  resent by -Flush (same idempotency_key). Refuses credential-looking text.

  Use tools\Report-FomprepIntakeIssue.ps1 for individual bugs / FRs / skill filings.
  Use this script to close a session (Summary + Lesson, then -Flush).

.EXAMPLE
  .\tools\Invoke-FomprepHarvest.ps1 -Summary 'FR-005 landed' -Lesson 'session harvest defaults product repo' -DryRun

.EXAMPLE
  .\tools\Invoke-FomprepHarvest.ps1 -Flush
#>
[CmdletBinding()]
param(
    [string]$Summary = '',
    [string[]]$Lesson = @(),
    [string]$Repo = 'SimonBarnett/agentic_fomprep',
    [string]$Book = 'harvest-priority-skills',
    [string]$IntakeUrl = 'https://irc.ntsa.uk/bob/v1/intake',
    [string]$Machine = '',
    [string]$Agent = 'Invoke-FomprepHarvest',
    [string]$OutboxDir = '',
    [switch]$Flush,
    [switch]$NoDefaultOutboxes,
    [switch]$DryRun,
    [switch]$NoDelegate,
    [int]$TimeoutSec = 30
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

$secretRx = '(ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|xox[abpr]-[A-Za-z0-9-]{10,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|(?i:(password|passwd|secret|token|apikey|api_key)\s*[:=]\s*[A-Za-z0-9/+_.-]{8,}))'
$home1 = if ($env:USERPROFILE) { $env:USERPROFILE } else { $HOME }
$repoRoot = Split-Path -Parent $PSScriptRoot
if (-not $OutboxDir) { $OutboxDir = Join-Path $home1 '.grok\bob\harvest-outbox' }

$headers = @{ 'Content-Type' = 'application/json; charset=utf-8' }
if ($env:BOB_INTAKE_KEY) { $headers['X-Bob-Intake-Key'] = [string]$env:BOB_INTAKE_KEY }

$permanentErrors = @(
    'malformed', 'bad_kind', 'missing_repo', 'bad_repo', 'repo_not_allowed',
    'bad_title', 'bad_files', 'too_many_files', 'bad_file_path', 'file_too_large',
    'payload_too_large', 'empty_harvest', 'bad_idempotency_key', 'unauthorized',
    'worker_receipt_not_issue'
)

function Test-FomprepSecretText([string]$Text) {
    if (-not $Text) { return $false }
    return [bool]($Text -match $secretRx)
}

function Get-IntakeResponseProp {
    param($Response, [Parameter(Mandatory)][string]$Name, $Default = $null)
    if ($null -eq $Response) { return $Default }
    $prop = $Response.PSObject.Properties[$Name]
    if ($null -eq $prop) { return $Default }
    return $prop.Value
}

function Get-IntakeErrorName {
    param($ErrorRecord)
    $detail = ''
    if ($ErrorRecord -and $ErrorRecord.ErrorDetails -and $ErrorRecord.ErrorDetails.Message) {
        $detail = [string]$ErrorRecord.ErrorDetails.Message
    }
    if ($detail -match '"error"\s*:\s*"([^"]+)"') { return $Matches[1] }
    return $null
}

function Send-FomprepJson([string]$Json) {
    if (Test-FomprepSecretText $Json) {
        throw 'refusing to send: text looks like it contains a secret/token/password. Remove it and retry.'
    }
    $bytes = [Text.Encoding]::UTF8.GetBytes($Json)
    return Invoke-RestMethod -Method Post -Uri $IntakeUrl -Headers $headers -Body $bytes -TimeoutSec $TimeoutSec
}

function Write-HarvestOutbox {
    param([Parameter(Mandatory)]$Payload, [string[]]$Dirs)
    $written = @()
    $idem = [string]$Payload.idempotency_key
    $digest = $idem
    if ($digest.Length -gt 16) { $digest = $digest.Substring(0, 16) }
    $name = 'harvest-{0}.json' -f $digest
    $json = ($Payload | ConvertTo-Json -Depth 8 -Compress)
    foreach ($dir in $Dirs) {
        if (-not $dir) { continue }
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
        $path = Join-Path $dir $name
        [IO.File]::WriteAllText($path, $json + "`n", [Text.UTF8Encoding]::new($false))
        $written += $path
    }
    return $written
}

function Move-DroppedPayload {
    param([Parameter(Mandatory)][string]$Path, [Parameter(Mandatory)][string]$Reason)
    if (-not (Test-Path -LiteralPath $Path)) {
        Write-Host "DROPPED $Path (already gone; $Reason)"
        return
    }
    $dir = Split-Path -Parent $Path
    $dropDir = Join-Path $dir 'dropped'
    New-Item -ItemType Directory -Force -Path $dropDir | Out-Null
    $dest = Join-Path $dropDir (Split-Path -Leaf $Path)
    if (Test-Path -LiteralPath $dest) {
        $suffix = [guid]::NewGuid().ToString('N').Substring(0, 8)
        $dest = Join-Path $dropDir ('{0}-{1}' -f $suffix, (Split-Path -Leaf $Path))
    }
    Move-Item -LiteralPath $Path -Destination $dest -Force
    Write-Host "DROPPED $Path -> $dest ($Reason)"
}

# --- Flush path (no Summary/Lesson required) ---
if ($Flush) {
    if ($NoDefaultOutboxes) {
        if (-not $OutboxDir) { throw '-NoDefaultOutboxes requires -OutboxDir' }
        $dirs = @($OutboxDir)
    }
    else {
        $dirs = @(
            $OutboxDir,
            (Join-Path $repoRoot 'harvest-outbox'),
            (Join-Path $repoRoot 'report-outbox'),
            (Join-Path $home1 '.grok\bob\report-outbox'),
            (Join-Path $home1 '.grok\bob\harvest-outbox')
        ) | Select-Object -Unique
    }
    $sent = 0; $kept = 0; $dropped = 0
    foreach ($d in $dirs) {
        if (-not (Test-Path -LiteralPath $d)) { continue }
        foreach ($f in @(Get-ChildItem -LiteralPath $d -File -Filter '*.json' -ErrorAction SilentlyContinue)) {
            try {
                $raw = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
                if (Test-FomprepSecretText $raw) {
                    Move-DroppedPayload -Path $f.FullName -Reason 'secret-looking payload'
                    $dropped++
                    continue
                }
                $payload = $raw | ConvertFrom-Json
                if (-not $payload.repo) {
                    Move-DroppedPayload -Path $f.FullName -Reason 'missing repo'
                    $dropped++
                    continue
                }
                if ($DryRun) {
                    Write-Host ("DRYRUN would send {0} repo={1}" -f $f.Name, $payload.repo)
                    $kept++
                    continue
                }
                $r = Send-FomprepJson -Json $raw
                if (Test-Path -LiteralPath $f.FullName) {
                    Remove-Item -LiteralPath $f.FullName -Force -ErrorAction Stop
                }
                $sent++
                Write-Host ("SENT {0} intake_id={1}" -f $f.Name, (Get-IntakeResponseProp -Response $r -Name 'intake_id' -Default ''))
            }
            catch {
                $intakeErr = Get-IntakeErrorName -ErrorRecord $_
                if ($intakeErr -and ($permanentErrors -contains $intakeErr)) {
                    Move-DroppedPayload -Path $f.FullName -Reason ("permanent $intakeErr")
                    $dropped++
                }
                else {
                    $kept++
                    Write-Host ("KEEP {0}: {1}" -f $f.Name, $_.Exception.Message)
                }
            }
        }
    }
    Write-Host "flush: sent=$sent kept=$kept dropped=$dropped"
    return [pscustomobject]@{ ok = $true; flush = $true; sent = $sent; kept = $kept; dropped = $dropped }
}

# --- Harvest path ---
if (-not $Summary.Trim()) {
    throw 'Empty harvest: -Summary is required unless -Flush (what broke / what you fixed / "nothing new").'
}

$lessonLines = @()
if ($Lesson -and $Lesson.Count) {
    foreach ($L in $Lesson) {
        if ($null -eq $L) { continue }
        $t = ([string]$L).Trim()
        if ($t) { $lessonLines += $t }
    }
}
$lessonBlock = if ($lessonLines.Count) {
    ($lessonLines | ForEach-Object { '- ' + $_ }) -join "`n"
}
else {
    '- (no new playbook line)'
}

$body = @"
## Session summary
$($Summary.Trim())

## Lessons
$lessonBlock

Use Report-FomprepIntakeIssue.ps1 for individual bugs/FRs; this harvest closes the session.
"@

$title = ('harvest: {0}' -f ($Summary.Trim().Substring(0, [Math]::Min(80, $Summary.Trim().Length))))
if (Test-FomprepSecretText ($title + "`n" + $body)) {
    throw 'refusing to send: text looks like it contains a secret/token/password. Remove it and retry.'
}

$bookName = if ($Book -and $Book.Trim()) { $Book.Trim() } else { 'harvest-priority-skills' }
$bookName = $bookName.Substring(0, [Math]::Min(64, $bookName.Length))

$mach = $Machine
if (-not $mach) {
    if ($env:BOB_MACHINE_ID) { $mach = [string]$env:BOB_MACHINE_ID }
    else { $mach = [string]$env:COMPUTERNAME }
}

$rawKey = ('harvest|{0}|{1}|{2}' -f $Repo, $Summary.Trim(), $lessonBlock)
$sha = [Security.Cryptography.SHA256]::Create()
try {
    $hash = $sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($rawKey))
    $idem = 'fh-' + ([BitConverter]::ToString($hash) -replace '-', '').Substring(0, 24).ToLowerInvariant()
}
finally { $sha.Dispose() }

$payload = [ordered]@{
    kind            = 'harvest'
    repo            = $Repo
    title           = $title
    body            = $body
    idempotency_key = $idem
    source          = [ordered]@{
        machine    = ([string]$mach).Substring(0, [Math]::Min(64, ([string]$mach).Length))
        agent      = ([string]$Agent).Substring(0, [Math]::Min(64, ([string]$Agent).Length))
        skill_book = $bookName
        version    = ''
    }
}

if ($DryRun) {
    $json = ($payload | ConvertTo-Json -Depth 8 -Compress)
    Write-Output $json
    return [pscustomobject]@{
        ok              = $true
        dry_run         = $true
        repo            = $payload.repo
        kind            = 'harvest'
        idempotency_key = $payload.idempotency_key
        payload_json    = $json
    }
}

# Optional delegate to bob install harvest (forced product repo).
if (-not $NoDelegate) {
    $bobRoot = $env:BOB_INSTALL_ROOT
    if (-not $bobRoot) { $bobRoot = 'C:\ai\bob' }
    $bobHarvest = Join-Path $bobRoot 'scripts\Invoke-BobiverseHarvest.ps1'
    if (Test-Path -LiteralPath $bobHarvest) {
        $lessonArg = if ($lessonLines.Count) { $lessonLines } else { @() }
        & $bobHarvest -Summary $Summary.Trim() -Lesson $lessonArg -Repo $Repo -Book $bookName `
            -IntakeUrl $IntakeUrl -TimeoutSec $TimeoutSec
        return
    }
}

$outDirs = @(
    $OutboxDir,
    (Join-Path $repoRoot 'harvest-outbox')
) | Select-Object -Unique

$json = ($payload | ConvertTo-Json -Depth 8 -Compress)
try {
    $resp = Send-FomprepJson -Json $json
    $receipt = [pscustomobject]@{
        ok              = $true
        queued_local    = $false
        intake_id       = (Get-IntakeResponseProp -Response $resp -Name 'intake_id' -Default $null)
        url             = (Get-IntakeResponseProp -Response $resp -Name 'url' -Default $null)
        idempotency_key = $payload.idempotency_key
        repo            = $payload.repo
        outbox          = @()
    }
    Write-Host ("HARVESTED intake_id={0} url={1}" -f $receipt.intake_id, $receipt.url)
    return $receipt
}
catch {
    $paths = Write-HarvestOutbox -Payload $payload -Dirs $outDirs
    Write-Host ("QUEUED {0} ({1}); resend with: .\tools\Invoke-FomprepHarvest.ps1 -Flush" -f $paths[0], $_.Exception.Message)
    return [pscustomobject]@{
        ok              = $false
        queued_local    = $true
        intake_id       = $null
        url             = $null
        idempotency_key = $payload.idempotency_key
        repo            = $payload.repo
        outbox          = $paths
        error           = [string]$_.Exception.Message
    }
}
