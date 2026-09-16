# DEV1 runs — 2026-09-16 (peer review v2)

Host `$env:COMPUTERNAME`=CE-PRIORITY-DEV (DNS CE-PRIORITY-DEV1). SQL `10.220.0.5\DEV` database `system`. No secrets.

## Restart test 2026-09-16 evening

`Test-Pack PASS`. `OPEN=0`. WhatIf `ZCLA_PARTLONGDESC` exec=101883 upd=Y lastPrep=20359498 wouldPark=2. Real prepare: wrapper 20min killed mid-run; RepairOpenParks restored 2/2 (`ZCLA_INVOICEFIX`, `ZPTI_SALES_ORDER`); OPEN=0. Retry: exit 2 `auth_expired` `probe_timeout`, parked=0. Did not SQL-flip. Cookies need recapture before the next web prepare.


## P0-CO company pin (review v3)

Web Select Company label **D - Clarkson Evans Live** is DEV (`selectors.json` `companyCode=base`, `sqlDatabase=system`). WINRUN company is `base`. `T$EXEC` 101883 exists on `10.220.0.5\DEV`. Did not connect to PRI. `allowLiveCompanyLabel=true` only for that exact pin. Do not click D-Test or D-Global Swap 4.

## P0-BG wait-for-idle (review v3)

`Wait-FormPrepIdle` runs before restore: live PID on this box (process still alive) + 30s quiet Y-count. One-name run while session live: `executor=web parked=2 restored=2` then sibling `ZCLA_PARTLONGDHIST` lastprep `20359477→20359498` (UPD stayed N) — wait was not enough while PID 13048 leftover with LOCKEXPIRY=0. Idle wait now treats leftover PID as live only if `Get-Process -Id` still exists. Re-run blocked: `si-web-state.json` expired (login page). DESC left `UPD=Y` lastprep 20359498 for the next supervised web run. Did not SQL-flip siblings.

## P0-DDL

`OPEN parks=0`. `dbo.AGENT_FORMPREP_PARK` columns include `prev_lockexpiry`. ApplyParkTable not required this run.

## AT4 (`tests/AT4-abort-restores.ps1`)

```
AT4 Y-count before=3 (P0-T4: no required constant)
AT4 zclaAlreadyY=3 expectedOpen=5
AT4 dummies: BUILDNETWORK=63, UPDATEPARAM=64, FORMSREP=70, PROCACT=83, REBUILDNETWORK=98
AT4 open_park refuse PASS
AT4 PASS restored 5/5 (5 dummies)
AT4 Y-count after cleanup=3
```

## AT7 (`tests/AT7-auth-expired-no-park.ps1`)

```
AT7 PASS parkedCount=0 parkTable unchanged
```

After this session (historical restored rows): `parkRows=17 open=0`.

## AT1 (`tests/AT1-already-prepared.ps1`, `-SkipWeb`)

```
AT1 before ZCLA_PARTLONGDESC exec=101883 upd=Y lastPrep=0
AT1 before ZCLA_PARTLONGDHIST exec=101884 upd=Y lastPrep=0
AT1 before ZCLA_PARTLONGDREV exec=101885 upd=Y lastPrep=0
AT1 exit=3 reason=cli_noop ok=False parked=0 restored=0 restoreOk=True
AT1 after  ZCLA_PARTLONGDESC upd=Y lastPrep=0 (before 0)
AT1 after  ZCLA_PARTLONGDHIST upd=Y lastPrep=0 (before 0)
AT1 after  ZCLA_PARTLONGDREV upd=Y lastPrep=0 (before 0)
AT1 Y-count before=3 after=3 openParks=0 moved=0
```

CLI skipped: Credential Manager target `CE/Priority/Si` is empty. **Did not SQL-flip UPD=N.**

## WP3 CLI one-form (after CredMan)

First probe with cred used a shifted WINRUN argv (`WINACTIV` taken as a SQL database). Restore short 2/3: park row `ZGCW_DEL_IPP_STATS` / 101886 had no `T$EXEC` or `EXECPREPLOCK` row (orphaned). Y-count left at 3 (ZCLA trio). Did not INSERT a lock row.

After argv fix (`WINRUN "" Si *** prep base WINACTIV -P FORMPREP`):

```
WP3 before ZCLA_PARTLONGDESC exec=101883 upd=Y lastPrep=0 Y=3
WP3 exit=3 reason=cli_noop ok=False parked=2 restored=2 restoreOk=True executor=none
WP3 after  ZCLA_PARTLONGDESC upd=Y lastPrep=0 Y=3 open=0
cli-stdout: launch (redacted): ...\winrun.exe "" Si *** ...\prep base WINACTIV -P FORMPREP
exit=0
```

CLI exit 0 did not advance LASTPREPDATE. No SQL-flip.

CredMan `UserName` must not be passed to WINRUN (it can marshal as the password, filling the username field and launching `C:\priority\bin.95\-P`). Username is pinned to config `Si`. After that:

```
launch (redacted): ...\winrun.exe "" "Si" *** "C:\Priority\system\prep" "base" WINACTIV -P FORMPREP
exit=0
WP3 after ZCLA_PARTLONGDESC upd=Y lastPrep=0 parked=2 restored=2
```

## P0-W1 headed pin (2026-09-16)

Session: `si-web-state.json` (14 cookies, gitignored). Dashboard has **Form Preparation** tile (no My Shortcuts). **Select Company** dialog: `D - Clarkson Evans Live`.

Run `586beda4-63a1-4e30-9d95-cb5f55218e4b` (`Prepare-Forms -Names ZCLA_PARTLONGDESC -SkipCli`):

```
before ZCLA_PARTLONGDESC exec=101883 upd=Y lastPrep=0
exit=0 ok=True parked=4 restored=4 restoreOk=True executor=web auth=ok
after  ZCLA_PARTLONGDESC upd=N lastPrep=20359477
```

All three ZCLA_PARTLONG* ended `UPD=N` LASTPREPDATE `20359477` (siblings may have compiled after restore while server prep was still running). Screenshots: `tests/fixtures/web-pin/`. `selectors.json` `pinnedAt=2026-09-16T12:20:00Z`.

## P0-W1 (earlier)

`si-web-state.json` captured 2026-09-16 12:13 (gitignored). See P0-W1 headed pin above.
