#requires -Version 5.1
<#
.SYNOPSIS
  Offline Priority hours client for the bob.ntsa.uk hours contract (bobhours.py FR #3450 / #3673).

.DESCRIPTION
  Builds a create body and evaluates a saved GET /bob/v1/hours list.
  This file does not call the network. Live GET/POST stays out of this script
  while supported reads are blocked. A fixture match is not a receipt.
  Git events stay on POST /bob/v1/git. That route is not the hours store.
#>

$script:BobHoursRejected = @(
    'started_at', 'start_at', 'started', 'from', 'ended_at', 'finish', 'customer_slug', 'project_slug', 'duration_minutes'
)
$script:BobHoursCredential = @(
    'password', 'passwd', 'pwd', 'secret', 'token', 'api_key', 'apikey', 'access_token', 'refresh_token',
    'authorization', 'auth', 'bearer', 'private_key', 'client_secret'
)

function Test-BobHoursProjectFolder {
    param([string]$Name)
    return [bool]($Name -match '^(SC|SO)[0-9]+$')
}

function ConvertTo-BobHoursInstant {
    param([Parameter(Mandatory = $true)][string]$Text)
    $s = $Text.Trim()
    if ($s.EndsWith('Z')) { $s = $s.Substring(0, $s.Length - 1) + '+00:00' }
    if ($s -match '[+-]\d{2}:\d{2}$') {
        return [datetimeoffset]::Parse($s, [cultureinfo]::InvariantCulture)
    }
    $clock = [datetime]::Parse($s, [cultureinfo]::InvariantCulture, [Globalization.DateTimeStyles]::RoundtripKind)
    return [datetimeoffset]::new($clock.Ticks, [timespan]::Zero)
}

function Get-BobHoursLondonDate {
    param([Parameter(Mandatory = $true)][datetimeoffset]$Instant)
    $utc = $Instant.ToUniversalTime()
    $start = Get-BobHoursUkTransition $utc.Year 3
    $end = Get-BobHoursUkTransition $utc.Year 10
    $hours = 0
    if ($utc -ge $start -and $utc -lt $end) { $hours = 1 }
    return $utc.AddHours($hours).ToString('yyyy-MM-dd')
}

function Get-BobHoursUkTransition {
    param([int]$Year, [int]$Month)
    $day = [datetime]::new($Year, $Month, [datetime]::DaysInMonth($Year, $Month))
    while ($day.DayOfWeek -ne [DayOfWeek]::Sunday) { $day = $day.AddDays(-1) }
    return [datetimeoffset]::new($day.Year, $day.Month, $day.Day, 1, 0, 0, [timespan]::Zero)
}

function Get-BobHoursListWindow {
    param([datetimeoffset]$EntryStart, [Parameter(Mandatory = $true)][datetimeoffset]$Now, [switch]$HasStart)
    if (-not $HasStart) { return @{ FromDay = $null; ToDay = $null } }
    $from = Get-BobHoursLondonDate $EntryStart
    $to = Get-BobHoursLondonDate $Now
    if ($from -gt $to) { $to = $from }
    return @{ FromDay = $from; ToDay = $to }
}

function New-BobHoursIdempotencyKey {
    param([Parameter(Mandatory = $true)][string]$SessionId)
    return 'priority-agent-' + $SessionId.Trim()
}

function New-BobHoursCreateBody {
    param(
        [Parameter(Mandatory = $true)][hashtable]$Fields,
        [string[]]$Tickets
    )
    foreach ($key in @($Fields.Keys)) {
        $norm = ([string]$key).Trim().ToLowerInvariant().Replace('-', '_')
        if ($script:BobHoursRejected -contains [string]$key -or $script:BobHoursCredential -contains $norm -or $norm.EndsWith('_password') -or $norm.EndsWith('_token') -or [string]$key -eq 'duration_minutes') {
            return @{ Ok = $false; Detail = "rejected fields: $key"; Json = '' }
        }
    }
    function Local-Req([string]$Name) {
        if (-not $Fields.ContainsKey($Name) -or $null -eq $Fields[$Name]) { return '' }
        return ([string]$Fields[$Name]).Trim()
    }
    $idem = Local-Req 'idempotency_key'
    $agent = Local-Req 'agent'
    $user = Local-Req 'on_behalf_of'
    $startRaw = Local-Req 'start'
    if (-not $idem -or -not $agent -or -not $user -or -not $startRaw) {
        return @{ Ok = $false; Detail = 'missing required idempotency_key, agent, on_behalf_of, or start'; Json = '' }
    }
    if ($idem -notmatch '^[A-Za-z0-9._:@-]{1,128}$') {
        return @{ Ok = $false; Detail = 'bad_idempotency_key'; Json = '' }
    }
    try { $start = ConvertTo-BobHoursInstant $startRaw } catch { return @{ Ok = $false; Detail = 'bad_start'; Json = '' } }
    $endRaw = Local-Req 'end'
    if ($endRaw) {
        try { $end = ConvertTo-BobHoursInstant $endRaw } catch { return @{ Ok = $false; Detail = 'bad_end'; Json = '' } }
        if ($end -lt $start) { return @{ Ok = $false; Detail = 'bad_end_before_start'; Json = '' } }
    }
    $customer = Local-Req 'customer'
    $project = Local-Req 'project'
    if ($customer -and $customer -notmatch '^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$') {
        return @{ Ok = $false; Detail = 'bad_customer'; Json = '' }
    }
    if ($customer -and -not $project) {
        return @{ Ok = $false; Detail = 'customer work needs an SC or SO project folder'; Json = '' }
    }
    if ($project -and -not (Test-BobHoursProjectFolder $project)) {
        return @{ Ok = $false; Detail = 'project must be an SCxxxxxx or SOxxxxxx folder'; Json = '' }
    }
    $payload = [ordered]@{
        idempotency_key = $idem
        agent           = $agent
        on_behalf_of    = $user
        start           = $startRaw
    }
    if ($endRaw) { $payload.end = $endRaw }
    if ($customer) { $payload.customer = $customer }
    if ($project) { $payload.project = $project }
    $repo = Local-Req 'repo_url'
    if ($repo) { $payload.repo_url = $repo }
    $description = Local-Req 'description'
    if ($description) { $payload.description = $description }
    $source = Local-Req 'source'
    if ($source) { $payload.source = $source }
    $bill = Local-Req 'billable_hint'
    if ($bill -and $bill -ne 'Y' -and $bill -ne 'N') {
        return @{ Ok = $false; Detail = 'bad_billable_hint'; Json = '' }
    }
    if ($bill) { $payload.billable_hint = $bill }
    if ($Tickets -and $Tickets.Count -gt 0) { $payload.tickets = @($Tickets) }
    $json = $payload | ConvertTo-Json -Compress -Depth 4
    if ($json -match 'duration_minutes') {
        return @{ Ok = $false; Detail = 'duration_minutes must not be sent'; Json = '' }
    }
    return @{ Ok = $true; Detail = 'create body ok'; Json = $json }
}

function Test-BobHoursReceipt {
    param(
        [Parameter(Mandatory = $true)]$List,
        [Parameter(Mandatory = $true)][string]$IdempotencyKey,
        [Parameter(Mandatory = $true)][string]$EntryId,
        [Parameter(Mandatory = $true)][string]$OnBehalfOf,
        [string]$Customer = '',
        [string]$Project = ''
    )
    if (-not $OnBehalfOf) { return @{ Ok = $false; Detail = 'Priority USERLOGIN missing' } }
    if (-not $EntryId) { return @{ Ok = $false; Detail = 'persisted entry id missing' } }
    if ($EntryId -notmatch '^h_[0-9a-f]{16}$') { return @{ Ok = $false; Detail = 'persisted entry id is not a receiver id' } }
    if (-not $IdempotencyKey -or -not $IdempotencyKey.StartsWith('priority-agent-') -or $IdempotencyKey.Length -le 'priority-agent-'.Length) {
        return @{ Ok = $false; Detail = 'session idempotency_key missing' }
    }
    if (($Customer -or $Project) -and -not (Test-BobHoursProjectFolder $Project)) {
        return @{ Ok = $false; Detail = 'expected project is not an SC or SO folder' }
    }
    $entries = @()
    if ($List -is [string]) {
        $List = $List | ConvertFrom-Json
    }
    if ($List.entries) { $entries = @($List.entries) }
    $byId = @($entries | Where-Object { [string]$_.id -eq $EntryId })
    $byKey = @($entries | Where-Object { [string]$_.idempotency_key -eq $IdempotencyKey })
    if ($byId.Count -eq 0) { return @{ Ok = $false; Detail = 'persisted entry id not in the list' } }
    if ($byId.Count -gt 1) { return @{ Ok = $false; Detail = 'duplicate entry id' } }
    if ($byKey.Count -gt 1) { return @{ Ok = $false; Detail = 'duplicate idempotency_key' } }
    $entry = $byId[0]
    if ([string]$entry.idempotency_key -ne $IdempotencyKey) {
        return @{ Ok = $false; Detail = 'idempotency_key does not match the session key' }
    }
    $status = [string]$entry.status
    if ($status -eq 'open') { return @{ Ok = $false; Detail = 'entry still open' } }
    if ($status -eq 'auto_closed') { return @{ Ok = $false; Detail = 'auto_closed is not a closed report' } }
    if ($status -ne 'closed') { return @{ Ok = $false; Detail = 'status is not closed' } }
    if ([string]$entry.on_behalf_of -ne $OnBehalfOf) {
        return @{ Ok = $false; Detail = 'on_behalf_of does not match Priority USERLOGIN' }
    }
    if ([string]$entry.customer -ne $Customer) { return @{ Ok = $false; Detail = 'customer mismatch' } }
    if ([string]$entry.project -ne $Project) { return @{ Ok = $false; Detail = 'project mismatch' } }
    if (-not $entry.start -or -not $entry.end) { return @{ Ok = $false; Detail = 'closed entry missing start or end' } }
    try {
        $start = ConvertTo-BobHoursInstant ([string]$entry.start)
        $end = ConvertTo-BobHoursInstant ([string]$entry.end)
    } catch { return @{ Ok = $false; Detail = 'start or end is not ISO-8601' } }
    if ($end -lt $start) { return @{ Ok = $false; Detail = 'end before start' } }
    if ($null -eq $entry.duration_minutes) { return @{ Ok = $false; Detail = 'duration_minutes missing on closed entry' } }
    $derived = [int][math]::Floor(($end - $start).TotalSeconds / 60)
    if ($derived -lt 0) { $derived = 0 }
    if ([int]$entry.duration_minutes -ne $derived) {
        return @{ Ok = $false; Detail = 'duration_minutes does not match start and end' }
    }
    return @{ Ok = $true; Detail = "one closed entry $EntryId matched client-side" }
}
