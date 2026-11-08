#requires -Version 5.1
# Issue #278: HoursCheck matches one closed webhook entry. Offline fixtures only.
$ErrorActionPreference = 'Stop'
$repo = if ($env:FOMPREP_MRB_ROOT) { $env:FOMPREP_MRB_ROOT } else { Split-Path -Parent $PSScriptRoot }
$failed = 0
function Gate([string]$Id, [bool]$Pass, [string]$Detail) {
    if ($Pass) { Write-Host "PASS $Id $Detail" }
    else { Write-Host "FAIL $Id $Detail"; $script:failed++ }
}

$cs = [IO.File]::ReadAllText((Join-Path $repo 'launcher\Program.cs'))
$bob = [IO.File]::ReadAllText((Join-Path $repo 'launcher\BobHours.cs'))
$client = Join-Path $repo 'tools\BobHoursClient.ps1'
Gate 'no-origin-hours' ($cs -notmatch 'origin/hours') 'Program.cs does not fetch origin/hours'
Gate 'fixture-env' ($cs -match 'PRIORITY_AGENT_HOURS_JSON') 'fixture override env'
Gate 'client-side-key' ($bob -match 'idempotency_key' -and $bob -match 'BuildListQuery' -and $bob -notmatch 'idempotency_key=') 'query has no key filter'
Gate 'no-live-in-selftest' ($bob -match 'self-test sent no HTTP request' -and $bob -notmatch 'HttpClient') 'BobHours.cs does not open HTTP'
Gate 'ps-client-offline' ((Get-Content -LiteralPath $client -Raw) -notmatch 'Invoke-RestMethod|Invoke-WebRequest|HttpClient') 'PS client has no HTTP call'

. (Join-Path $repo 'tools\BobHoursClient.ps1')
$key = New-BobHoursIdempotencyKey '11111111-1111-1111-1111-111111111111'
$id = 'h_0123456789abcdef'
function New-Entry([string]$Status, [string]$EntryKey, [string]$User, [string]$Project, [string]$End, $Duration) {
    return [pscustomobject]@{
        id = $id
        idempotency_key = $EntryKey
        on_behalf_of = $User
        customer = 'example-customer'
        project = $Project
        status = $Status
        start = '2026-11-08T09:00:00+00:00'
        end = $(if ($End) { $End } else { $null })
        duration_minutes = $Duration
    }
}
function Wrap($entry) { return [pscustomobject]@{ entries = @($entry) } }

$closed = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' $key 'SimonB' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-closed' ([bool]$closed.Ok) $closed.Detail
$missing = Test-BobHoursReceipt -List ([pscustomobject]@{ entries = @() }) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-missing' (-not $missing.Ok) $missing.Detail
$open = Test-BobHoursReceipt -List (Wrap (New-Entry 'open' $key 'SimonB' 'SC100001' '' $null)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-open' ((-not $open.Ok) -and $open.Detail -match 'open') $open.Detail
$wrong = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' 'priority-agent-other' 'SimonB' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-wrong-key' ((-not $wrong.Ok) -and $wrong.Detail -match 'idempotency_key') $wrong.Detail
$auto = Test-BobHoursReceipt -List (Wrap (New-Entry 'auto_closed' $key 'SimonB' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-auto-closed' ((-not $auto.Ok) -and $auto.Detail -match 'auto_closed') $auto.Detail
$body = New-BobHoursCreateBody -Fields @{
    idempotency_key = $key; agent = 'Haitch'; on_behalf_of = 'SimonB'
    start = '2026-11-08T09:00:00+00:00'; end = '2026-11-08T10:00:00+00:00'
    customer = 'example-customer'; project = 'SC100001'; description = 'fixture'
}
Gate 'ps-create-body' ([bool]$body.Ok -and $body.Json -notmatch 'duration_minutes' -and $body.Json -match 'SC100001') $body.Detail
$alias = New-BobHoursCreateBody -Fields @{ started_at = '2026-11-08T09:00:00+00:00'; idempotency_key = $key; agent = 'Haitch'; on_behalf_of = 'SimonB' }
Gate 'ps-reject-alias' (-not $alias.Ok) $alias.Detail
$ordinal = New-BobHoursCreateBody -Fields @{
    idempotency_key = $key; agent = 'Haitch'; on_behalf_of = 'SimonB'; start = '2026-11-08T09:00:00+00:00'
    customer = 'example-customer'; project = 'ordinal2'
}
Gate 'ps-reject-ordinal' (-not $ordinal.Ok) $ordinal.Detail
$naive = ConvertTo-BobHoursInstant '2026-07-01T00:30:00'
Gate 'ps-naive-utc' ($naive.Offset -eq [timespan]::Zero -and $naive.Hour -eq 0 -and $naive.Minute -eq 30) $naive.ToString('o')
$shortId = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' $key 'SimonB' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId 'h_0123456789abcde' -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-id-16hex' (-not $shortId.Ok) $shortId.Detail
$mixedEntry = [pscustomobject]@{
    id = $id; idempotency_key = $key; on_behalf_of = 'SimonB'; customer = 'example-customer'; project = 'SC100001'
    status = 'closed'; start = '2026-07-01T00:30:00'; end = '2026-07-01T01:30:00Z'; duration_minutes = 60
}
$mixedReceipt = Test-BobHoursReceipt -List (Wrap $mixedEntry) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'SimonB' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-naive-duration' ([bool]$mixedReceipt.Ok) $mixedReceipt.Detail
$bst = Get-BobHoursLondonDate ([datetimeoffset]::Parse('2026-06-30T23:30:00Z'))
Gate 'ps-bst-midnight' ($bst -eq '2026-07-01') $bst
$older = Get-BobHoursListWindow -HasStart -EntryStart ([datetimeoffset]::Parse('2026-11-02T09:00:00Z')) -Now ([datetimeoffset]::Parse('2026-11-08T12:00:00Z'))
Gate 'ps-older-window' ($older.FromDay -eq '2026-11-02' -and $older.ToDay -eq '2026-11-08') "$($older.FromDay)..$($older.ToDay)"

$dotnet = Get-Command dotnet -ErrorAction SilentlyContinue
if ($dotnet) {
    $proj = Join-Path $repo 'tests\bobhours-selftest\BobHoursSelfTest.csproj'
    $previousTz = $env:TZ
    $env:TZ = 'Europe/London'
    & dotnet run --project $proj -c Release
    $dotnetExit = $LASTEXITCODE
    if ($null -eq $previousTz) { Remove-Item Env:TZ -ErrorAction SilentlyContinue } else { $env:TZ = $previousTz }
    Gate 'dotnet-selftest' ($dotnetExit -eq 0) "dotnet exit $dotnetExit (TZ=Europe/London)"
} else {
    Write-Host 'SKIP dotnet-selftest (dotnet not installed)'
}

if ($failed -gt 0) { Write-Host "Test-Fr278-HoursCheckWebhook FAIL ($failed)"; exit 1 }
Write-Host 'Test-Fr278-HoursCheckWebhook PASS'
exit 0
