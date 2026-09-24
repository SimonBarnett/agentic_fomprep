# Hostile MRB — WCF walker + skills catalog (Eshbel)

**Date:** 2026-09-19  
**Repo:** SimonBarnett/agentic_fomprep  
**Scope reviewed:** WCF walker + install SQL gate + Priority skills catalog at tip `23e7e64`  
**Author:** Eshbel (Priority engineering)  
**MRB issue:** [#9](https://github.com/SimonBarnett/agentic_fomprep/issues/9)  
**v1:** `src\Prepare-NamedForm.ps1` — no diff (WP0-T9)  

Tip `23e7e64` = `v2: WCF walker + install SQL gate from Medatech pins`.  
This board reviews that slice plus the catalog on the same line (`priority-odata-dev` / `formlimited_audit`, `ce-priority-*` UAT folders). One commit after the tip (`ae4eddf`) parks a rename FR; it is **not** claimed as shipped.

## Verdict

**PASS-nits** for the off-instance walker slice (WP0 offline gates + catalog gates). Bob chairs MRB on issue #9.

**Not** a live WCF prepare/install walk. WhatIf is not a walk. Only Bob may stamp human UAT; this board does not.

## WP0 evidence (committed only)

The **only** WP0 artefact in git is `v2/tests/wp0-last.json`. With `PRIORITY_WP0_INSTANCE` unset, reachability gates **WP0-R1..R7** are recorded as **WP0-R-SKIP** (no proof instance on the runner). This doc does **not** claim DEV1 R1–R7 PASS from a local allowlist or ad-hoc machine runs.

Offline WP0-T* gates in that file are green (`failed=0`). That is not live compile/install proof.

## Historical note (FORM column bug)

Earlier draft text claimed live `formlimited_audit` on DEV1 and cited `Invalid column name 'FORM'`. The defect was real: `FORMLIMITED` has no `FORM` column; filter via `FORMLIMITED.[T$EXEC]` joined to `T$EXEC.ENAME`. Commit `c0355d8` moved the filter to `ENAME` but composed an invalid `IN (" + (@f0 @f1 -join ', ') + ")` list; offline **CAT-T25** at that SHA regex-matched runner source and stayed green. `7db4bcc` repaired the here-string expansion but CAT-T25 still asserted source text, not the composed statement — fixture CAT-T16/T17/T18 never hit the SQL branch. Issue #10 lands `New-FormLimitedAuditSql` + composed **CAT-T25** / mutation **CAT-T26**; live SQL on a proof instance remains red until Eshbel runs acceptance 2 on DEV1.

## Spec MUST / MUST NOT (walker + catalog)

| Requirement | Status |
|-------------|--------|
| v2 only; do not change repo-root `src\Prepare-NamedForm.ps1` | Met (WP0-T9) |
| Walk **pinned** TYPE=P only; no guessed `PREPAREUPGRADE` / `INSTALLUPGRADE` ENAMEs | Met (pins are Medatech `ZEMG_*`; WP0-T6) |
| Two tools `compile_shell` / `install_shell` | Met |
| Install SQL gate on `INSTALLEDUPGRADES` + `TAKESINGLEENT` in `T$EXEC` | Code present; **not** proven on a live install |
| `postInstall.formsUnprepared[]` handoff; no auto-prep | Code + WP0-T10/T11; **not** proven after a live install |
| WINRUN not invented | Met (refuse `winrun_required` if `WcfFileStepWorks=false`) |
| `DbiMarker` empty until observed on a real `.sh` | Met (empty) |
| Catalog MCP grab-only | Met |
| No secrets in git | Met (`instances.json` is runner-local) |
| Document FORMLIMITED / RESTFLAG footgun | Skill text present; live SQL audit needs proof instance |
| Live compile/install of a Version Revision | **Not met** — WhatIf only until required fix 5 |

## Required fixes (issue #9, ordered)

1. **Fix `formlimited_audit` SQL** — `FORMLIMITED.[T$EXEC]` + `T$EXEC.ENAME` join; offline composed **CAT-T25** / **CAT-T26** (not source regex). **Partial** through `7db4bcc`; composed gate + pins tracked on [#10](https://github.com/SimonBarnett/agentic_fomprep/issues/10) / #7 acceptance 2.
2. **Withdraw false R1–R7 PASS claims**; committed WP0 evidence = `wp0-last.json` with WP0-R-SKIP when unset. **Addressed** in this doc.
3. **De-dupe MRB docs** — keep this file; short duplicate is a pointer; no `docs/mrb-*.pdf`. **Addressed**; see `docs/README.md`.
4. **Verdict vocabulary** — off-instance slice is **PASS-nits** (not PASS-with-nits). **Addressed** in this doc.
5. **Live WCF compile→install walk** on a proof instance; set `WcfFileStepWorks` from transcript; FR §15 handoff. **Still red** — no walk on machines without proof instance.

**Optional / parked:** rename catalog folders `ce-priority-*` → `priority-*` per `docs/feature-request-priority-generic-catalog-rename-2026-09-19.md` (`ae4eddf`). Do not block the walker slice on the rename.

## Nits (do not block PASS-nits)

1. Lib copies across catalog / plugin / `v2/lib` still drift. `Sync-ShellRunnerLibs.ps1` exists; one edited copy will still lie.
2. `instances.json` is local to the runner (not in git). Proof hosts **must** create the allowlist row (`id=ce-priority-dev`, CredMan, SQL, web, `allowLive`).
3. Catalog folders at the reviewed tip still use `ce-priority-*` ids. Rename is a parked FR, not a walker regression.

## What this board is not

- Not a live shell compile/install.
- Not a Bob stamp for human UAT.
- Not a v1 change.
- Not a claim that `WcfFileStepWorks` is known.
- Not a WINRUN executor.
- Not a rename of `ce-priority-*` catalog folders.

Slogan still holds for the success path: **red before a live WCF walk**. Offline gates and WP0-R-SKIP are not that walk.
