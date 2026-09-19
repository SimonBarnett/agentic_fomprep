# Hostile MRB — WCF walker tip 23e7e64 (Eshbel)

**Date:** 2026-09-19  
**Reviewer:** Eshbel (CE-PRIORITY-DEV1)  
**Tip:** `23e7e64` — v2 WCF walker + install SQL gate from Medatech pins  
**Verdict:** **PASS-with-nits** for WP0 suite + proof reachability + OData dump. **Not** ready for human UAT of live compile/install.

## Evidence

- `Test-WP0.ps1` **PASS** failed=0 with `PRIORITY_WP0_INSTANCE=ce-priority-dev` after local allowlist `%USERPROFILE%\.priority-formprep\instances.json` (CredMan CE/Priority/Si). All WP0-T* and R1–R7 PASS; R4 sees `ZEMG_TAKEUPGRADE` / `ZEMG_EXECUPGRADES` / `UPGRADES`.
- `Compile-Shell -WhatIf -Revision 8350` → exit 0, whatIf, `wcfAttempted=false`.
- OData `dump_procedure ZEMG_TAKEUPGRADE` → ok=true (live).
- `formlimited_audit` → **FAIL** Invalid column name `FORM` (should be `T$EXEC`).
- v1 `Prepare-NamedForm.ps1` untouched.

## Blockers for live human UAT

- No live WCF prepare/install walk yet.
- `WcfFileStepWorks` null; `DbiMarker` empty.

## Required fixes

1. Fix `formlimited_audit` to `FORMLIMITED.[T$EXEC]` (+ ENAME join).
2. Prefer `priority-*` catalog ids over `ce-priority-*` (generic rule) — tracked by FR `docs/feature-request-priority-generic-catalog-rename-2026-09-19.md` / job `a4af52e8`.
3. Live throwaway compile→install on `ce-priority-dev`; set `WcfFileStepWorks` from evidence.

## Follow-up

Bob Start-BobBuild for fixes 1+3 (and align with rename job for 2). Eshbel re-UATs + hostile MRBs the fix tip. Full MRB md may arrive via Eshbel cloud agent PR.
