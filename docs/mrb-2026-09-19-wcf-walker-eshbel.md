# Hostile MRB — WCF walker + skills catalog (Eshbel)

**Date:** 2026-09-19  
**Repo:** SimonBarnett/agentic_fomprep  
**Scope reviewed:** WCF walker + install SQL gate + Priority skills catalog at tip `23e7e64`  
**Author:** Eshbel (Priority engineering)  
**Machine:** CE-PRIORITY-DEV1  
**Env:** `PRIORITY_WP0_INSTANCE=ce-priority-dev`  
**v1:** `src\Prepare-NamedForm.ps1` — no diff (WP0-T9)  

Tip `23e7e64` = `v2: WCF walker + install SQL gate from Medatech pins`.  
This board reviews that slice plus the catalog that is already on the same line (`priority-odata-dev` / `formlimited_audit`, `ce-priority-*` UAT folders). One commit after the tip (`ae4eddf`) parks a rename FR; it is **not** claimed as shipped.

## Verdict

**PASS-with-nits** for off-instance WP0 + proof-instance reachability + OData dump on `ce-priority-dev`.

**Not** ready for human UAT of live compile/install. There is still **no live WCF prepare/install walk transcript**. WhatIf is not a walk.

Only Bob may declare **ready for human UAT**. This board does not. This is not a Bob stamp.

## Blockers for human UAT of live compile/install

None against the locked off-instance + reachability slice.

These **are** blockers if anyone claims live compile/install, `WcfFileStepWorks` known, or human UAT of a Version Revision:

- No live WCF prepare/install run. FR §15 dummy revision **compile → install → truncated → `prepare_form`** is still outstanding. Evidence is WhatIf only (`reason=whatIf`, `wcfAttempted=false`).
- `WcfFileStepWorks` is still `null`. WINRUN is **not** implemented. Runners correctly refuse `winrun_required` if the pin is `false`; a null pin is not evidence that file-step WCF works.
- `DbiMarker` is still empty. Do not invent a token from the public `DBI` modification code.

Ionos `docs/wp0-walker-slice-2026-09-19.md` already said the same non-claims. DEV1 did **not** close them.

## Evidence (DEV1)

Allowlist written (local to the runner, **not** in git): `%USERPROFILE%\.priority-formprep\instances.json`

| Field | Value used |
|-------|------------|
| id | `ce-priority-dev` |
| CredMan | `CE/Priority/Si` |
| sql | `10.220.0.5\DEV` |
| web | `https://prioritydev.clarksonevans.co.uk` |
| company | `base` |
| buildSetRoot | `C:\Priority\system\upgrades` |
| allowLive | `true` |

| Gate | Result |
|------|--------|
| `v2/tools/Test-WP0.ps1` | **WP0 PASS**, `failed=0`. All WP0-T\* and WP0-R1..R7 **PASS**. |
| WP0-R4 | Pinned ENAMEs present in `T$EXEC`: `ZEMG_TAKEUPGRADE`, `ZEMG_EXECUPGRADES`, `UPGRADES`. |
| WP0-R7 | PASS with no walk transcript. Expected: pin is `WcfFileStepWorks=null`; no contradiction without a walk. |
| WP0-T9 | `src\Prepare-NamedForm.ps1` present and **unpatched**. |
| `Compile-Shell -WhatIf -Revision 8350` | exit 0, `reason=whatIf`, `wcfAttempted=false`. |
| `Invoke-PriorityOData dump_procedure -EName ZEMG_TAKEUPGRADE` | `ok=true`; dumped `PROGTEXT` (live OData, Basic `Si`). |
| `formlimited_audit` Forms `ZCLA_PARTLONGDESC,ZCLA_PARTLONGDHIST,ZCLA_PARTLONGDREV` | **FAIL** `sql_failed`: Invalid column name `'FORM'`. |

### FORM column bug (do not bury)

Live `formlimited_audit` on DEV1 is **broken**. The runner asks:

```sql
SELECT * FROM dbo.FORMLIMITED WHERE FORM IN (@f0, @f1, …)
```

`FORMLIMITED` does **not** have a `FORM` column. The real key is `FORMLIMITED.[T$EXEC]`. Resolve the form ENAME by joining `T$EXEC.ENAME` (same pattern as Form Prep locks / WP0-R4), then filter on those ENAMEs.

This is a product defect in `Invoke-PriorityOData.ps1` (`formlimited_audit` action), not a DEV1 allowlist miss. Fixture-mode audits can still pass because they skip SQL. Live RESTFLAG/LIMITFLAG audit of the PART long-desc set did **not** run.

Mapper already accepts `ENAME` as a form-name fallback (`ConvertTo-FormLimitedRow`). The SQL is the part that is wrong.

This MRB does **not** ship that fix. Prefer Bob stamp of this evidence first; fix SQL in a follow-up (required fix 1).

## Spec MUST / MUST NOT (walker + catalog)

| Requirement | Status |
|-------------|--------|
| v2 only; do not change repo-root `src\Prepare-NamedForm.ps1` | Met (WP0-T9) |
| Walk **pinned** TYPE=P only; no guessed `PREPAREUPGRADE` / `INSTALLUPGRADE` ENAMEs | Met (pins are Medatech `ZEMG_*`; WP0-T6 / R4) |
| Two tools `compile_shell` / `install_shell` | Met |
| Install SQL gate on `INSTALLEDUPGRADES` + `TAKESINGLEENT` in `T$EXEC` | Code present; **not** proven on a live install |
| `postInstall.formsUnprepared[]` handoff; no auto-prep | Code + WP0-T10/T11; **not** proven after a live install |
| WINRUN not invented | Met (refuse `winrun_required` if `WcfFileStepWorks=false`) |
| `DbiMarker` empty until observed on a real `.sh` | Met (empty) |
| Catalog MCP grab-only | Met |
| No secrets in git | Met (`instances.json` is runner-local) |
| Document FORMLIMITED / RESTFLAG footgun | Skill text present; **live audit SQL fails** (FORM column) |
| Live compile/install of a Version Revision | **Not met** — WhatIf only |

## Required fixes (ordered)

1. **Fix `formlimited_audit` SQL** to use `FORMLIMITED.[T$EXEC]` and join `T$EXEC.ENAME` — **not** `FORM`. Until that lands, do not claim live FORMLIMITED audit. This is the only product-code defect this board treats as in-slice.
2. **Optional / already parked:** rename catalog folders `ce-priority-*` → `priority-*` aliases per Simon’s Priority-generic rule (hosts via config). Keep skill bodies; CE is an example deployment, not the product identity. Parked on `ae4eddf` (`docs/feature-request-priority-generic-catalog-rename-2026-09-19.md`). Do not block the walker stamp on the rename.
3. **Prove live WCF compile** of a throwaway revision on `ce-priority-dev`. Set `WcfFileStepWorks` `true`/`false` from that transcript — not from titles. Then run the install SQL gate + `formsUnprepared[]` handoff demo (FR §15). Only after that may Bob reconsider **ready for human UAT**.

## Nits (do not block this stamp)

1. Lib copies across catalog / plugin / `v2/lib` still drift. `Sync-ShellRunnerLibs.ps1` exists; one edited copy will still lie.
2. `instances.json` is local to the runner (not in git). Proof hosts **must** create the allowlist row (`id=ce-priority-dev`, CredMan, SQL, web, `allowLive`). Document that in the shell-compile / OData skills if it is not already obvious. Ionos skipped R\* because the row was missing; that is correct fail-closed behaviour, not a pin bug.
3. R7 “no pin or walk transcript” / “no contradiction without a walk” is **expected** until a live walk. Do not read R7 PASS as file-step proven.
4. Catalog folders at the reviewed tip still use `ce-priority-*` ids. Rename is a parked FR (`ae4eddf`), not a walker regression.

## What this board is not

- Not a live shell compile/install.
- Not a Bob stamp for human UAT.
- Not a v1 change.
- Not a claim that `WcfFileStepWorks` is known.
- Not a claim that `formlimited_audit` works on live SQL.
- Not a WINRUN executor.
- Not a rename of `ce-priority-*` catalog folders.

Slogan still holds for the success path: **red before a live WCF walk**. WhatIf and R\* reachability are not that walk.
