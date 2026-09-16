# agentic_fomprep

Unattended Priority **Form Prep** for Clarkson Evans **DEV only**.

Build plan (v1.0): `CE_Priority_Autonomous_Form_Prep_Build_Plan.pdf`.

**Hard rule:** never report a form prepared unless `EXECPREPLOCK.UPD='N'` **and** `LASTPREPDATE` moved. Never leave the unprepared estate marked prepared. Never embed passwords in this repo.

This checkout is the install pack. Do not run it against live/PRI. The runner fail-closes unless:

- `-Environment DEV`
- SQL instance is `10.220.0.5\DEV`
- web host is `prioritydev.clarksonevans.co.uk`
- computer is `CE-PRIORITY-DEV1` (or the DEV RDP host you pin in `config/dev.psd1`)
- `PinComplete = $true` after recon (required for any park)

## Install on CE-PRIORITY-DEV1

```powershell
cd <this-repo>
powershell -File tools\Install-OnDev.ps1
powershell -File tools\Invoke-Recon.ps1
# edit config\dev.psd1 - pin SqlDatabase, ExecTable, lock columns; set PinComplete = $true
powershell -File tools\Install-OnDev.ps1 -ApplyParkTable
powershell -File tools\Set-WinrunCredential.ps1
```

Log into https://prioritydev.clarksonevans.co.uk once as Si and save Playwright `storageState` to `C:\Priority\tmp\agent-formprep\si-web-state.json` (ACL: the agent account only).

```powershell
powershell -File src\Prepare-Forms.ps1 -Names ZCLA_PARTLONGDESC -Environment DEV -WhatIf
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
SELECT ENAME, UPD, LASTPREPDATE, COMPUTERNAME, PID
FROM dbo.EXECPREPLOCK L
JOIN dbo.EXEC E ON E.[EXEC] = L.[EXEC]
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

On DEV1 after pin: AT1, AT4, AT6, AT7, AT8 must be green for MVP. AT2/AT3 green or waived in this README with a reason.

| ID | Script | Off-DEV |
|----|--------|---------|
| AT1 | `tests/AT1-already-prepared.ps1` | skip |
| AT2 | `tests/AT2-broken-trigger.ps1` | skip (needs ZCLA_AGENT_PREP_AT2) |
| AT3 | `tests/AT3-index-dialog.ps1` | skip (waive until a live/fixture dialog exists) |
| AT4 | `tests/AT4-abort-restores.ps1` | skip |
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

`config/dev.psd1` ships with `PinComplete = $false` and `<PIN>` table names on purpose. Recon on DEV1 fills them. Frozen hosts/SQL instance live in `src/Private/Get-FrozenEnvironment.ps1` and cannot be pointed at PRI by editing config alone.
