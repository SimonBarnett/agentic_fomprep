# WP0 live §15 proof — CE-PRIORITY-DEV1 (2026-10-01)

**FR:** https://github.com/SimonBarnett/agentic_fomprep/issues/56  
**Host:** `CE-PRIORITY-DEV1` (AllowedComputer)  
**Instance:** `PRIORITY_WP0_INSTANCE=ce-priority-dev`  
**Seat:** `ce-priority-dev1-13204`

## Environment (observed)

| Need | Result |
|------|--------|
| Allowlist `~\.priority-formprep\instances.json` | Present (`id=ce-priority-dev`, CredMan `CE/Priority/Si`) |
| SQL `10.220.0.5\DEV` / `system` | TCP 1433 OK; `T$EXEC` SELECT OK |
| Upgrades dir | `C:\Priority\system\upgrades` reachable |
| Web `https://prioritydev.clarksonevans.co.uk` | HTTP 200 |
| Node + `priority-web-sdk` | Installed under `v2/plugins/priority-formprep/scripts` |

## Test-WP0 (live R*)

```text
PRIORITY_WP0_INSTANCE=ce-priority-dev
powershell -File v2/tools/Test-WP0.ps1
→ WP0 PASS (T1–T13 + R1–R7)
```

Evidence: `v2/tests/wp0-last.json` (re-run after this PR).

## P3 attempts

### Compile (`ZEMG_TAKEUPGRADE`)

Revisions tried: `8341`, `8369` (unprepared row exists in `dbo.UPGRADES`).

WCF walk ended with information messages only:

- `No upgrades are available for preparation.`
- `Revision does not exist!` (Medatech path)

`revisionStepFilled=false`, `fileStepSeen=false`. Pre-existing `NN.sh` was **not** rewritten (mtime unchanged). Early runner falsely reported `reason=compiled` when an on-disk shell already existed; fixed to require `revisionStepFilled`.

Transcript: `v2/tests/wp0-live-2026-10-01/compile-8369-walk.json`.

### Install (`ZEMG_EXECUPGRADES`)

1. `8369.sh` without `-AllowDbi` → `dbi_refused`, `codes=["DBI"]` (no WCF). Confirms live DBI marker.
2. `8341.sh` with `-AllowDbi` → WCF attempted; walk showed `inputFields` titled Parameter Input with **empty** `EditField[]`, then `end`. SQL gate `gate_unchanged` (no `INSTALLEDUPGRADES` advance). `EXECUPGRERR` form open failed: `No such form exists.`

Transcript: `v2/tests/wp0-live-2026-10-01/install-8341-walk.json`.

### Pins from observation

| Field | Value | Basis |
|-------|-------|--------|
| `DbiMarker` | `DBI` | Live `.sh` heredocs + install refuse |
| `WcfFileStepWorks` | `null` (unchanged) | Empty EditField / prepare queue-empty is inconclusive for WINRUN vs file-step; do not invent true/false |

## Still open for full §15 / P3 green

1. Why prepare reports no upgrades available for user `Si` / company `base` despite unprepared `UPGRADES` rows (61+).
2. Why install Parameter Input exposes zero EditFields over WCF (cannot fill `NAM`/`FN`).
3. Successful compile → new/updated `NN.sh` with `revisionStepFilled`.
4. Successful install with `INSTALLEDUPGRADES` advance + `formsUnprepared[]` handoff to caller `prepare_form`.
5. Capture a walk that **proves** file-step vs WINRUN before setting `WcfFileStepWorks`.

## Do not

- Stamp ready for human UAT
- Patch v1 `src\Prepare-NamedForm.ps1`
- Invent ENAMEs or set `WcfFileStepWorks` from titles alone
