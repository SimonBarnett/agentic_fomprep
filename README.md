# agentic_fomprep (Priority Form Prep; spelling: formprep)

Unattended Priority **Form Prep** for Clarkson Evans **DEV only**.

Build plan (v1.0): `CE_Priority_Autonomous_Form_Prep_Build_Plan.pdf`.

Peer reviews (build-agent handoff):

- `reviews/agentic_fomprep_Build_Agent_Peer_Review.pdf` (v1, vs `e9516f4`)
- `reviews/agentic_fomprep_Build_Agent_Peer_Review_v2.pdf` (v2 audit, vs `c1b2ebe`)

**Hard rule:** never report a form prepared unless `EXECPREPLOCK.UPD='N'` **and** `LASTPREPDATE` moved. Never leave the unprepared estate marked prepared. Never embed passwords in this repo.

This checkout is the install pack. Do not run it against live/PRI. The runner fail-closes unless:

- `-Environment DEV`
- SQL instance is `10.220.0.5\DEV`
- web host is `prioritydev.clarksonevans.co.uk`
- computer is `CE-PRIORITY-DEV1` (or the DEV RDP host you pin in `config/dev.psd1`)
- `PinComplete = $true` after recon (required for any park)

WINRUN still puts the Si password on the child process command line for the CLI probe window (P1-C1). `cli-stdout.txt` is redacted to `***`. A Process Explorer screenshot during that window is the residual DEV-only risk. Cookie file `si-web-state.json` is not a live session (P0-A1): a 10s Playwright probe runs before park unless `-SkipWeb`. FORMKEYS hook is empty until a human dump (P1-H1). AT2 waived: no `ZCLA_AGENT_PREP_AT2` throwaway form on DEV. AT3 off-DEV fixture covers Ignore Duplicate Values → blocked-run.

## Install on CE-PRIORITY-DEV1

Scripts in this pack are unsigned. On DEV1 use Bypass (or the current process will hit `UnauthorizedAccess`):

```powershell
cd <this-repo>
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Install-OnDev.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Invoke-Recon.ps1
# config\dev.psd1 is already pinned (WP0); re-run recon if dictionary objects move
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Install-OnDev.ps1 -ApplyParkTable
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC,ZCLA_PARTLONGDHIST,ZCLA_PARTLONGDREV -Environment DEV -WhatIf
powershell -NoProfile -ExecutionPolicy Bypass -File tests\AT4-abort-restores.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Set-WinrunCredential.ps1
```

Log into https://prioritydev.clarksonevans.co.uk once as Si and save Playwright `storageState` to `C:\Priority\tmp\agent-formprep\si-web-state.json` (ACL: the agent account only). Do **not** put that JSON on inetpub (it is a cookie dump). Capture:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Save-WebStorageState.ps1
```

```powershell
powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -WhatIf
powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC,ZCLA_PARTLONGDHIST,ZCLA_PARTLONGDREV -Environment DEV -SkipPark -SkipCli -SkipWeb
# WP3 CLI probe (1-form set, no web). Needs CredMan CE/Priority/Si for LASTPREPDATE to move;
# no_cred / timeout in cli-stdout.txt is a valid WP3 no-op close.
powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -SkipWeb -CliTimeoutSeconds 60
powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -TimeoutMinutes 15
```

After a crash:

```powershell
powershell -File src\Prepare-Forms.ps1 -RepairOpenParks -Environment DEV
# or
powershell -File src\Prepare-Forms.ps1 -RepairOpenParks -RunId <guid> -Environment DEV
```

Inspect:

```sql
SELECT * FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL;
SELECT E.ENAME, L.UPD, L.LASTPREPDATE, L.COMPUTERNAME, L.PID
FROM dbo.EXECPREPLOCK L
JOIN dbo.[T$EXEC] E ON E.[T$EXEC] = L.[T$EXEC]
WHERE E.ENAME LIKE 'ZCLA_PARTLONG%';
```

## Public interface

```powershell
Import-Module .\src\CE.FormPrep.psd1

Prepare-Forms -Names @(
    'ZCLA_PARTLONGDESC',
    'ZCLA_PARTLONGDHIST',
    'ZCLA_PARTLONGDREV'
) -Environment DEV -TimeoutMinutes 15 -CliTimeoutSeconds 60 -PostHooks FormKeysRepair
```

| Exit | Meaning |
|------|---------|
| 0 | `ok=true` (or `-WhatIf`, which is `ok=false` + `whatIf=true`) |
| 2 | environment / auth / mutex refuse - **no park** |
| 3 | park taken but prep failed, or restore short |
| 4 | post-hook assertion failed (compiled but keys stripped) |

`ok` is true only when every requested name is in `prepared[]` with `upd=N` and advanced `lastPrepDateAfter`, `restoreOk` is true, `restoredCount==parkedCount`, and no `errors[].severity=Blocker` names a target. UI completion is not a success signal.

Result JSON schema: `schemas/prepare-forms-result.schema.json`.

## How it works (Hybrid F)

1. Assert frozen DEV constants + mutex `Global\CE-DEV-FORMPREP`.
2. Resolve names to exec ids.
3. Park every other `UPD='Y'` row into `dbo.AGENT_FORMPREP_PARK` (SQL is the restore source of truth; the text dump is not).
4. CLI probe: `winrun.exe Si *** <prep> <company> WINACTIV -P FORMPREP` with **no form name**. On timeout the process **tree is killed** so CLI cannot overlap web.
5. If `LASTPREPDATE` has not moved, Playwright web Form Prep (Unprepared Forms). Never click Ignore / Yes on index or duplicate dialogs.
6. Scrape e\*msg, prep.err, Errors Report, EXECPREPLOCK.
7. Restore park in `finally`. Restore short => exit 3 even if targets compiled.
8. FORMKEYS hook is **assert-only** until a human pastes a dump into `hooks/formkeys.psd1`.

## Tests

Off-DEV (this pack, no SQL/web):

```powershell
powershell -File tools\Test-Pack.ps1
```

That parses every script, checks the JSON schema file, runs `tests/AT6-refuse-non-dev.ps1` and `tests/unit-mutex.ps1`.

DEV1 evidence for AT4/AT7/AT1 (2026-09-16) is in `tests/last-dev-run.md`. On DEV1 after pin: AT4 (WP1 dry 5/5 restore), AT1, AT6, AT7, AT8 must be green for MVP. AT2/AT3 green or waived in this README with a reason. Park table `dbo.AGENT_FORMPREP_PARK` uses bigint `exec_id` / `prev_lastprep` / `prev_pid` to match `EXECPREPLOCK`. `LASTPREPDATE` is bigint (`0` = never). WP2 dump (`-SkipPark -SkipCli -SkipWeb`) writes `sql-before.json` and `capture/emsg.txt` without parking.

| ID | Script | Off-DEV |
|----|--------|---------|
| AT1 | `tests/AT1-already-prepared.ps1` | skip (DEV1: force-Y then CLI `-SkipWeb`; blocked until CredMan `CE/Priority/Si` and/or live web pin P0-W1) |
| AT2 | `tests/AT2-broken-trigger.ps1` | skip (needs ZCLA_AGENT_PREP_AT2) |
| AT3 | `tests/AT3-index-dialog.ps1` | skip (waive until a live/fixture dialog exists) |
| AT4 | `tests/AT4-abort-restores.ps1` | skip (DEV1: 5 dummy park, kill, RepairOpenParks 5/5) |
| AT6 | `tests/AT6-refuse-non-dev.ps1` | **runs** |
| AT7 | `tests/AT7-auth-expired-no-park.ps1` | skip |
| AT8 | `tests/AT8-mutex.ps1` | skip (helper covered by `unit-mutex.ps1`) |

## What this pack will not do

- `UPDATE UPD='N'` on targets and call that prepared
- Start web prep before park assert
- Restore from a text file if the SQL park table has rows
- Click through index/duplicate dialogs
- Commit secrets, storageState, or result JSON that contains a password
- Implement `AllUnprepared` in this MVP
- Run Form Prep twice concurrently
- Change live/PRI connection strings

`config/dev.psd1` is pinned on CE-PRIORITY-DEV1 (WP0): `SqlDatabase = system`, `ExecTable = dbo.T$EXEC` (id col `T$EXEC`), `LockTable = dbo.EXECPREPLOCK` (join `T$EXEC`), `FormKeysTable = dbo.FORMKEYS`, `FormJoinsTable = dbo.FORMJOINS`, `PinComplete = $true`. `$env:COMPUTERNAME` is the 15-char NetBIOS `CE-PRIORITY-DEV`; DNS hostname is `CE-PRIORITY-DEV1` — both are in `AllowedComputer`. Frozen hosts/SQL instance live in `src/Private/Get-FrozenEnvironment.ps1` and cannot be pointed at PRI by editing config alone.
