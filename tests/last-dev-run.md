# DEV1 runs — 2026-09-16 (peer review v2)

Host `$env:COMPUTERNAME`=CE-PRIORITY-DEV (DNS CE-PRIORITY-DEV1). SQL `10.220.0.5\DEV` database `system`. No secrets.

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
