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
        description = 'Updated the agreed rates so new orders price correctly. Consultant-equivalent effort: 1.5 hours.'
    }
}
function Wrap($entry) { return [pscustomobject]@{ entries = @($entry) } }

$closed = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' $key 'UserOne' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-closed' ([bool]$closed.Ok) $closed.Detail
$missing = Test-BobHoursReceipt -List ([pscustomobject]@{ entries = @() }) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-missing' (-not $missing.Ok) $missing.Detail
$open = Test-BobHoursReceipt -List (Wrap (New-Entry 'open' $key 'UserOne' 'SC100001' '' $null)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-open' ((-not $open.Ok) -and $open.Detail -match 'open') $open.Detail
$wrong = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' 'priority-agent-other' 'UserOne' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-wrong-key' ((-not $wrong.Ok) -and $wrong.Detail -match 'idempotency_key') $wrong.Detail
$auto = Test-BobHoursReceipt -List (Wrap (New-Entry 'auto_closed' $key 'UserOne' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-auto-closed' ((-not $auto.Ok) -and $auto.Detail -match 'auto_closed') $auto.Detail
$body = New-BobHoursCreateBody -Fields @{
    idempotency_key = $key; agent = 'Haitch'; on_behalf_of = 'UserOne'
    start = '2026-11-08T09:00:00+00:00'; end = '2026-11-08T10:00:00+00:00'
    customer = 'example-customer'; project = 'SC100001'
    description = 'Updated the agreed rates so new orders price correctly. Consultant-equivalent effort: 1.5 hours.'
}
Gate 'ps-create-body' ([bool]$body.Ok -and $body.Json -notmatch 'duration_minutes' -and $body.Json -match 'SC100001') $body.Detail
$alias = New-BobHoursCreateBody -Fields @{ started_at = '2026-11-08T09:00:00+00:00'; idempotency_key = $key; agent = 'Haitch'; on_behalf_of = 'UserOne' }
Gate 'ps-reject-alias' (-not $alias.Ok) $alias.Detail
$ordinal = New-BobHoursCreateBody -Fields @{
    idempotency_key = $key; agent = 'Haitch'; on_behalf_of = 'UserOne'; start = '2026-11-08T09:00:00+00:00'
    customer = 'example-customer'; project = 'ordinal2'
}
Gate 'ps-reject-ordinal' (-not $ordinal.Ok) $ordinal.Detail
$naive = ConvertTo-BobHoursInstant '2026-07-01T00:30:00'
Gate 'ps-naive-utc' ($naive.Offset -eq [timespan]::Zero -and $naive.Hour -eq 0 -and $naive.Minute -eq 30) $naive.ToString('o')
$shortId = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' $key 'UserOne' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId 'h_0123456789abcde' -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-id-16hex' (-not $shortId.Ok) $shortId.Detail
$mixedEntry = [pscustomobject]@{
    id = $id; idempotency_key = $key; on_behalf_of = 'UserOne'; customer = 'example-customer'; project = 'SC100001'
    status = 'closed'; start = '2026-07-01T00:30:00'; end = '2026-07-01T01:30:00Z'; duration_minutes = 60
    description = 'Updated the agreed rates so new orders price correctly. Consultant-equivalent effort: 1.5 hours.'
}
$mixedReceipt = Test-BobHoursReceipt -List (Wrap $mixedEntry) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-naive-duration' ([bool]$mixedReceipt.Ok) $mixedReceipt.Detail
$bst = Get-BobHoursLondonDate ([datetimeoffset]::Parse('2026-06-30T23:30:00Z'))
Gate 'ps-bst-midnight' ($bst -eq '2026-07-01') $bst
$older = Get-BobHoursListWindow -HasStart -EntryStart ([datetimeoffset]::Parse('2026-11-02T09:00:00Z')) -Now ([datetimeoffset]::Parse('2026-11-08T12:00:00Z'))
Gate 'ps-older-window' ($older.FromDay -eq '2026-11-02' -and $older.ToDay -eq '2026-11-08') "$($older.FromDay)..$($older.ToDay)"
$ownerOne = Resolve-BobHoursSessionOwner -RequestedOwner 'UserOne'
$ownerTwo = Resolve-BobHoursSessionOwner -RequestedOwner 'UserTwo'
$kept = Resolve-BobHoursSessionOwner -PersistedOwner 'UserOne' -RequestedOwner 'UserTwo'
$absent = Resolve-BobHoursSessionOwner
Gate 'ps-two-owners' ($ownerOne.Ok -and $ownerOne.UserLogin -eq 'UserOne' -and $ownerTwo.Ok -and $ownerTwo.UserLogin -eq 'UserTwo') "$($ownerOne.UserLogin)/$($ownerTwo.UserLogin)"
Gate 'ps-no-reassign' ((-not $kept.Ok) -and $kept.UserLogin -eq 'UserOne') $kept.Detail
Gate 'ps-owner-unavailable' ((-not $absent.Ok) -and -not $absent.UserLogin) $absent.Detail
$userTwoReceipt = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' $key 'UserTwo' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserTwo' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-user-two' ([bool]$userTwoReceipt.Ok) $userTwoReceipt.Detail
$cross = Test-BobHoursReceipt -List (Wrap (New-Entry 'closed' $key 'UserTwo' 'SC100001' '2026-11-08T10:00:00+00:00' 60)) -IdempotencyKey $key -EntryId $id -OnBehalfOf 'UserOne' -Customer 'example-customer' -Project 'SC100001'
Gate 'ps-cross-user' (-not $cross.Ok) $cross.Detail
$rules = Get-Content -LiteralPath (Join-Path $repo 'launcher\agent-rules.md') -Raw
$setup = Get-Content -LiteralPath (Join-Path $repo 'launcher\customer-setup\README.md') -Raw
$setup += Get-Content -LiteralPath (Join-Path $repo 'launcher\customer-setup\SKILL-SECTIONS.md') -Raw
$setup += Get-Content -LiteralPath (Join-Path $repo 'launcher\customer-setup\AGENTS.snippet.md') -Raw
Gate 'rules-are-canonical' ($rules -match 'only statement of identity' -and $rules -match 'Consultant-equivalent effort') 'agent-rules.md holds the reporting rules'
Gate 'customer-setup-pointer' ($setup -match 'launcher/agent-rules.md' -and $setup -notmatch 'Consultant-equivalent effort' -and $setup -notmatch 'idempotency_key') 'customer setup points at the rules and does not copy them'
$identityText = $cs + "`n" + $bob + "`n" + (Get-Content -LiteralPath $client -Raw)
$identityText += "`n" + (Get-Content -LiteralPath (Join-Path $repo 'launcher\agent-rules.md') -Raw)
foreach ($setupFile in (Get-ChildItem -LiteralPath (Join-Path $repo 'launcher\customer-setup') -File)) {
    $identityText += "`n" + (Get-Content -LiteralPath $setupFile.FullName -Raw)
}
Gate 'no-baked-login' ($identityText -notmatch '(?<![A-Za-z])SimonB(?![A-Za-z])') 'hours client has no fixed consultant login'
Gate 'no-os-user' ($cs -notmatch 'Environment\.UserName' -and $cs -notmatch 'PRIORITY_AGENT_HOURS_USER') 'login is not the OS user or a shared env default'

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
