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

## P0-W1

`C:\Priority\tmp\agent-formprep\si-web-state.json` is absent. Headed pin of Unprepared Forms was not run. `selectors.json` `pinnedAt` remains unverified. `formprep.mjs` no longer sets `progressSeen` on the menu-title click; OK prefers the prep dialog; progress waits on `progressbar`/`status` or a progress string that is not `Form Preparation`.
