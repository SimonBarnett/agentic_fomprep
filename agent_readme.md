# Agent handover — prepare one Priority form (DEV)

This is the method. Read this file first. Do not invent a second executor.

You run on **CE-PRIORITY-DEV1** (NetBIOS `CE-PRIORITY-DEV`) against Clarkson Evans **DEV only**. Repo: `M:\py\agentic_fomprep` (`\\10.220.0.5\dev\py\agentic_fomprep`). HEAD at handover: `17a23ed` plus this file.

Entry point: **`src\Prepare-NamedForm.ps1`**. Headless Web SDK (`EFORM` → `FORMPREPDRCT2` over WCF). No Chrome. No Playwright. No park. Password from CredMan, never from git.

`src\Prepare-Forms.ps1` is the old headed Playwright fallback. Do not use it unless a human tells you to. It needs an unlocked desktop, live cookies, and OPEN-park repair.

## Hard rules

1. Never report a form prepared unless `ok=true` **and** `EXECPREPLOCK.UPD='N'` **and** bigint `LASTPREPDATE` increased.
2. Never `UPDATE EXECPREPLOCK SET UPD='N'` to fake success.
3. Never leave the unprepared estate marked prepared. `-ForceUnprepared` on a failed run restores the original `UPD`.
4. Never embed or log the Si password. CredMan target is `CE/Priority/Si`. Username is `Si` (case-sensitive).
5. Never run against live/PRI. `-Environment` must be `DEV`. SQL instance `10.220.0.5\DEV`, web `https://prioritydev.clarksonevans.co.uk`, company `base` (UI label **D - Clarkson Evans Live**).
6. One name at a time. Do not `-AllUnprepared`. Do not click Ignore Duplicate / Yes on index dialogs (Playwright path only).
7. SDK *The program has been successfully completed.* is **not** success. Playwright finished and winrun exit 0 are **not** success.

## Preconditions (already true on DEV1)

- `config\dev.psd1` has `PinComplete=$true`.
- CredMan `CE/Priority/Si` is set. If `reason=no_cred`, **stop** and ask a human to run `tools\Set-WinrunCredential.ps1`. Do not prompt yourself in a way that writes the password into chat or git.
- Scripts are unsigned. Always `-ExecutionPolicy Bypass`.
- Node is on PATH (Web SDK under `src\sdk`).
- You are the process on CE-PRIORITY-DEV / CE-PRIORITY-DEV1.

Cookies at `C:\Priority\tmp\agent-formprep\si-web-state.json` are for the Playwright fallback only. Named-form prep does not use them.

## The loop

```powershell
cd M:\py\agentic_fomprep

powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-NamedForm.ps1 -Name ZCLA_PARTLONGDESC

powershell -NoProfile -ExecutionPolicy Bypass -File tools\Get-LastFormPrepResult.ps1
```

Replace `ZCLA_PARTLONGDESC` with the form's internal uppercase name (`ENAME`). Name must match `^[A-Za-z][A-Za-z0-9_]*$`.

Stdout prints `resultJson=C:\Priority\tmp\agent-formprep\<guid>\result.json` and the same JSON. The helper reads `C:\Priority\tmp\agent-formprep\last-named.json` (newest named-form result).

The unapproved-verb warning from `Import-Module CE.FormPrep` is noise. Ignore it.

### Optional switches

| Switch | Use |
|--------|-----|
| `-Name` | Required. One form. |
| `-ForceUnprepared` | Set `UPD='Y'` before prep so a recompile is forced. On SQL fail, restores the original `UPD`. Do not use this to park or to fake success. |
| `-Proc FORMPREPDRCT2` | Default. **Reprepare Form**. Do not switch to `FORMPREPDRCT` unless a human says so; that proc can claim success without moving `LASTPREPDATE`. |
| `-Environment DEV` | Default. Anything else throws. |
| `-TimeoutSeconds 180` | SDK walk cap. |

## How to read the result

Trust `ok`, `reason`, `updBefore`/`updAfter`, `lastPrepBefore`/`lastPrepAfter`, `errors[]`. Do not trust `sdk.ok` alone.

| `ok` | `reason` | Meaning | You do |
|------|----------|---------|--------|
| `true` | `prepared` | `UPD=N` and `lastPrep` advanced | Done. If `errors[]` has Warning lines, the form compiled with messages — read them; do not re-prep unless asked. |
| `false` | `still_unprepared` | Still `UPD=Y` | Not prepared. Read `errors[]`. Fix the form in Priority if that is your task. Do not SQL-flip. |
| `false` | `lastprep_unchanged` | `UPD=N` but date did not move | Did not recompile. Read `errors[]`. |
| `false` | `name_missing` | Not in `T$EXEC`/`EXECPREPLOCK` | Stop. Wrong name. |
| `false` | `no_cred` | CredMan missing | Stop. Human sets CredMan. |

Process exit: `0` = `ok=true`. `2` = refused (bad name, not DEV, no cred). `3` = ran but SQL gate failed.

### `errors[]`

Each item: `source`, `severity` (`Info` / `Warning` / `Blocker`), `text`, optional `formHint`.

| `source` | When |
|----------|------|
| `sdk` | Procedure messages during `FORMPREPDRCT2`. |
| `FORMPREPERRS` | Rows from form **Form Preparation-Errors/Warnings** (exec 6146). Columns: `TYPE`, `MESSAGE`, `CMESSAGE`. No SQL table. |
| `PREPMSG` | Errors Report URL/HTML if the proc opened a report. |

On **fail**, FORMPREPERRS is always present: either real rows (`TYPE: message`) or `FORMPREPERRS returned no rows after failed prep`. On **success**, FORMPREPERRS is omitted (a clean compile leaves that form empty).

Name mention in an error line is Warning, not Blocker. `ok` stays SQL-gated.

## Proven on this box

Success (human run 2026-09-16, `ZCLA_PARTLONGDESC` exec `101883`):

```
ok=true  reason=prepared  upd N→N  lastPrep 20359916→20359949
formprepErrs=0
sdk: The program has been successfully completed.
```

Fail path (bad proc, `-ForceUnprepared`): `ok=false`, `upd` restored `N→N`, `errors[]` includes `sdk` *No such Tabula Entity* and `FORMPREPERRS returned no rows after failed prep`.

`tools\Test-Pack.ps1` PASS (parse, schema, AT6, unit-mutex, unit-lastprep, unit-lock-execid, unit-error-parse, AT3 fixture).

WCF: `https://prioritydev.clarksonevans.co.uk` (`…/wcf/wcf/service.svc`). Company `base`. User `Si`.

## Not proven / do not assume

- Live `TYPE`/`MESSAGE`/`CMESSAGE` text from a form that **fails to compile**. DEV had `0` rows `UPD='Y'`. There is no throwaway `ZCLA_AGENT_PREP_AT2`. Do not inject a broken trigger into a real form to “prove” errors.
- Overnight unattended / session-0. CredMan login works without a headed browser; it still needs the DEV box and the stored credential.
- OData, MCP, or CLI `winrun` compiling on CE on-prem ~24.1. CLI can exit 0 and **not** move `LASTPREPDATE`. OData/MCP cannot compile here.
- `FORMPREPDRCT` (Prepare Form) as the success proc. Use `FORMPREPDRCT2`.
- Playwright cookies as a live session. If you are ever told to use `Prepare-Forms.ps1` and the probe says recapture / auth_expired, **stop** and ask a human for `tools\Save-WebStorageState.ps1`.

## What not to run

```text
Prepare-Forms.ps1                  unless a human asks for the headed fallback
Prepare-Forms.ps1 -AllUnprepared
Prepare-Forms.ps1 while OPEN parks exist
tools\Save-WebStorageState.ps1     unless a human is at the desktop to log in
SQL UPDATE … UPD='N'
headed Chromium / Playwright       for this method
second overlapping Prepare-NamedForm on the same form
```

If a human sends you to the Playwright path: `OPEN` parks must be 0 (`tools\Invoke-OpenCount.ps1`). Exit 3 → `Prepare-Forms.ps1 -RepairOpenParks -Environment DEV` only. Do not start a second parked run until `OPEN=0`. Named-form prep does not take parks.

## SQL (read-only sanity)

Dictionary DB `system` on `10.220.0.5\DEV`. Integrated security. Identifiers: `dbo.T$EXEC` (`ENAME`, `T$EXEC` bigint), `dbo.EXECPREPLOCK` (`T$EXEC`, `UPD` nchar, `LASTPREPDATE` bigint).

```sql
SELECT E.ENAME, L.UPD, L.LASTPREPDATE, L.COMPUTERNAME, L.PID
FROM dbo.EXECPREPLOCK L
JOIN dbo.[T$EXEC] E ON E.[T$EXEC] = L.[T$EXEC]
WHERE E.ENAME = N'ZCLA_PARTLONGDESC';

SELECT COUNT(*) AS open_parks
FROM dbo.AGENT_FORMPREP_PARK
WHERE restored_at IS NULL;
```

`LASTPREPDATE` is a Priority bigint date, not a SQL datetime. Compare with `>` as int64. `UPD` trim to `N` or `Y`.

## Layout you will touch

| Path | Role |
|------|------|
| `src\Prepare-NamedForm.ps1` | Agent entry |
| `src\sdk\run-formprep.mjs` | EFORM search → `FORMPREPDRCT2` → scrape `FORMPREPERRS` |
| `tools\Get-LastFormPrepResult.ps1` | Print last named-form (or parked) result + `errors[]` |
| `config\dev.psd1` | Pins (no passwords) |
| `C:\Priority\tmp\agent-formprep\<guid>\` | Per-run dump: `result.json`, `errors.json`, `formprep-errs-rows.json` |
| `C:\Priority\tmp\agent-formprep\last-named.json` | Latest named-form result |
| `reviews\agentic_fomprep_Agent_Working_Method.pdf` | Old headed-loop method (history) |
| `docs\OPERATOR_HOWTO_ESHBEL.md` | Operator notes; Playwright still described there — **this file overrides it for the agent** |

## First task

1. `cd M:\py\agentic_fomprep`
2. Prepare **one** named form you were given (example `ZCLA_PARTLONGDESC`).
3. `Get-LastFormPrepResult.ps1`
4. Report `ok`, `reason`, `lastPrep` before→after, `upd` before→after, and every `errors[]` line.
5. If `ok=false`, return the FORMPREPERRS lines. Do not SQL-flip. Do not re-prep in a loop without a form change.
