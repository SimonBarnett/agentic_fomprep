# WP0 recon — CE Priority DEV proof instance

**Date:** 2026-09-19  
**Author:** Eshbel (Priority engineering)  
**Repo:** SimonBarnett/agentic_fomprep  
**Scope:** dictionary evidence only — no invented ENAMEs  
**v1:** `src/Prepare-NamedForm.ps1` untouched  

This note records **observed** dictionary rows from the CE Priority DEV system DB and the pin values written into `v2/config/pin.json` / `v2/config/pin.psd1`. It does **not** authorize a WCF walker (skeleton still has no procedure invocation).

## Instance

| Pin / env | Value |
|---|---|
| ProofInstanceId | `ce-priority-dev` |
| Dictionary SQL | `10.220.0.5\DEV` database `system` |
| WebHost (formprep DEV) | `prioritydev.clarksonevans.co.uk` |
| Company | `base` (formprep `config/dev.psd1`; ENVIRONMENT / company DBs on this instance use company `base`) |
| AllowedComputer | `CE-PRIORITY-DEV1` (NetBIOS also `CE-PRIORITY-DEV`) |
| ExecTitleColumn | `TITLE` (`T$EXEC.TITLE`) |
| ExecTable / ExecNameCol / ExecIdCol | `dbo.T$EXEC` / `ENAME` / `T$EXEC` (matches v1 `config/dev.psd1`; not `dbo.EXEC`) |
| FormLimitedTable / FormLimitedExecCol | `dbo.FORMLIMITED` / `T$EXEC` — audit filter joins `FORMLIMITED.[T$EXEC]` to `T$EXEC.T$EXEC`, then `T$EXEC.ENAME` for form names (no `FORM` column on `FORMLIMITED`; see MRB note issue #9) |

The proof runner **must** set `PRIORITY_WP0_INSTANCE=ce-priority-dev` so WP0-R\* walks this instance (allowlist id, CredMan, dictionary SQL, upgrades path). Until that env is set on the runner, `Test-WP0` skips R\* (`WP0-R-SKIP`).

Align the allowlist row `id` with `ProofInstanceId`. Do not invent a second instance id.

## PinComplete — true (Simon, 2026-09-19 Europe/London)

Preferred pin values below use the **CE / Medatech wrappers** (`ZEMG_TAKEUPGRADE` / `ZEMG_EXECUPGRADES`). Stock `TAKEUPGRADE` / `EXECUPGRADES` remain **valid dictionary alternatives** with the same TYPE=P and related titles; they are **not** the pinned path.

**Simon confirmed Medatech wrappers on 2026-09-19 Europe/London.** `PinComplete` is now `true`. The WP0 walker must use `ZEMG_TAKEUPGRADE` / `ZEMG_EXECUPGRADES`, not stock `TAKEUPGRADE` / `EXECUPGRADES`. Walker implementation: `docs/wp0-walker-slice-2026-09-19.md`.

## Prepare (procedure TYPE=P)

Observed on `T$EXEC` (title column `TITLE`):

| ENAME | T$EXEC | TITLE | TYPE |
|---|---|---|---|
| `TAKEUPGRADE` | 2488 | Prepare the Revision | P |
| `ZEMG_TAKEUPGRADE` | 95256 | Medatech - Prepare the Revision | P |

### PROGPARAM — `ZEMG_TAKEUPGRADE`

| Step | Title | Notes |
|---|---|---|
| `PAR` | Revision | LINE — pin `RevisionInputStep` |
| `FN` | Full File Name | CHAR — pin `FilePathInputStep` (Medatech prepare) |
| `NAM` | Just File Name | companion name-only step; not the pinned path step |

### PROGPARAM — `TAKEUPGRADE`

`PAR`, `FLN`, `MSG`, `GO`. File UI titles are less clear than Medatech. Stock remains a dictionary sibling only; do not treat `FLN` as the pinned file step. Simon confirmed Medatech prepare (`PAR` / `FN`).

## Install (procedure TYPE=P)

| ENAME | T$EXEC | TITLE | TYPE |
|---|---|---|---|
| `EXECUPGRADES` | 5229 | Install Upgrade | P |
| `ZEMG_EXECUPGRADES` | 95257 | Medatech - Install Upgrade | P |

### PROGPARAM — `EXECUPGRADES`

| Step | Title | Notes |
|---|---|---|
| `NAM` | File Name | CHAR, HIDE I — install file step on stock |

### PROGPARAM — `ZEMG_EXECUPGRADES`

| Step | Title | Notes |
|---|---|---|
| `FN` | Optional .rv File / Full File Name variants | CHAR |
| `NAM` | File Name | install file step on Medatech (and stock) |
| `REV` / `BAK` / `NOM` | flags | not path steps |

The single pin field `FilePathInputStep` is the **prepare** full-path step (`FN` on Medatech). Install walks `NAM` (File Name) on both `EXECUPGRADES` and `ZEMG_EXECUPGRADES`. Do not invent a second pin key.

### Companion install-errors form

| ENAME | T$EXEC | TITLE | TYPE |
|---|---|---|---|
| `EXECUPGRERR` | 9685 | Install Upgrade - Errors | R |

Pin: `InstallErrorForm=EXECUPGRERR`.

## Version Revisions form (TYPE=F)

| ENAME | T$EXEC | TITLE | TYPE |
|---|---|---|---|
| `UPGRADES` | 2461 | Version Revisions | F |
| `VERUPGRADES` | 2477 | Version Revisions | F |

Recent CE shells live on **`UPGRADES`** (e.g. UPGNUM 8341–8350). Pin `VersionRevisionsEname=UPGRADES`. `VERUPGRADES` is a same-title dictionary sibling — not invented, not pinned.

## Install log table

Table `INSTALLEDUPGRADES` columns observed:

| Column | Role |
|---|---|
| `FILENAME` | path of the installed shell (canonical upgrades dir **and** mail-staged paths) |
| `STARTDATE` | start of install |
| `ENDDATE` | end of install |
| `UPG` | revision id |
| `T$USER` | user |
| `REM` | remark |
| `STANDARD` | standard flag |

Pin:

- `InstallLogTable=INSTALLEDUPGRADES`
- `InstallLogRevisionCol=UPG`
- `InstallLogDateCol=STARTDATE` (`ENDDATE` is also present; STARTDATE is the pinned date column)

## Paths

| Path | Evidence |
|---|---|
| `C:\Priority\system\upgrades` | canonical upgrades dir (`UpgradesDir`) |
| `C:\Priority\system\mail\...\upgrades\` | observed in `INSTALLEDUPGRADES.FILENAME` (mail-staged copies) |

`AllowedBuildSetRoots` is pinned to `@('C:\Priority\system\upgrades')` only. Optionally adding `C:\Priority\system\mail` would allow the walker to resolve mail-staged FILENAME values without treating them as foreign paths. That root is **not** pinned: mail is a staging tree, not the build-set root, and widening it without a human path-policy call is out of scope.

`WcfFileStepWorks` stays `null` — file-step vs WINRUN is unproven on this instance. Do not set true/false from titles.

## DbiMarker

`DbiMarker` is left as the empty string.

Not observed in the first shell sample pass. **Do not invent** a token. The parser default (`DBI` as a public Version Revision modification code) is not a dictionary pin and must not be copied into this field until a real on-disk `.sh` on this instance shows a marker.

## Pins written (CE / Medatech path — confirmed)

Titles are from the dictionary rows above. `PinComplete=true` after Simon confirmed Medatech wrappers on 2026-09-19 Europe/London.

| Field | Value |
|---|---|
| PrepareUpgradeEname | `ZEMG_TAKEUPGRADE` |
| PrepareUpgradeType | `P` |
| InstallUpgradeEname | `ZEMG_EXECUPGRADES` |
| InstallUpgradeType | `P` |
| VersionRevisionsEname | `UPGRADES` |
| RevisionInputStep | `PAR` |
| FilePathInputStep | `FN` |
| WcfFileStepWorks | `null` |
| InstallLogTable | `INSTALLEDUPGRADES` |
| InstallLogRevisionCol | `UPG` |
| InstallLogDateCol | `STARTDATE` |
| DbiMarker | `""` (unknown) |
| InstallErrorForm | `EXECUPGRERR` |
| ExecTitleColumn | `TITLE` |
| UpgradesDir | `C:\Priority\system\upgrades` |
| ProofInstanceId | `ce-priority-dev` |
| AllowedBuildSetRoots | `@('C:\Priority\system\upgrades')` |
| PinComplete | `true` |

Stock alternatives (not pinned): `TAKEUPGRADE` / `EXECUPGRADES`. Simon confirmed Medatech wrappers; do not switch the pin back to stock.

## Explicit non-claims

- No live compile or install on this recon note (walker code is a later slice).
- This recon does not set `WcfFileStepWorks`.
- No guessed ENAMEs (`PREPAREUPGRADE`, `INSTALLUPGRADE`, `PREPUPG`, `INSTUPG`, etc. were not used).
- No DbiMarker invented from the public `DBI` modification code.
- v1 Form Prep pack unchanged.
