# Build-and-test plan — Priority skills catalog (2026-09-19)

**FR:** docs/feature-request-priority-skills-catalog-2026-09-19.md  
**Repo:** SimonBarnett/agentic_fomprep  
**GitHub (MRB home):** https://github.com/SimonBarnett/agentic_fomprep/issues/7  

## Phases

### P0 — Catalog ports (A)
- Add `catalog/` entries (or v2 plugin catalog folders per existing v2 pattern) for:
  - priority-project-create-smoke
  - priority-day-works-uat
  - prepare-all-unprepared-priority-forms
  - (optional) Medatech hours skills if in-scope
- Each: `meta.json` + `SKILL.md` ported from workflow leaflets; no handler edits on Amplify catalog host beyond dropping folders.

### P1 — priority-odata-dev (B)
- New catalog + local plugin tools: `odata_get`, `odata_query`, `odata_dump_procedure`, `formlimited_audit`
- CredMan/env auth; never log passwords
- Document FORMLIMITED/RESTFLAG footgun in SKILL.md
- Offline/unit tests with fixtures where possible; live UAT is Eshbel’s on DEV1

### P2 — priority-form-engineering (C)
- SKILL.md covering Named Form Prep success gate, generator nav, HT PRE-DELETE, shell install verification
- Point at existing `Prepare-NamedForm.ps1` — do not fork v1

### P3 — priority-uat-orchestrator + Jester harvest (D)
- Expand `priority-uat-orchestrator` with cross-cutting standing rules (not a stub)
- Flesh `priority-project-create-smoke` and `priority-day-works-uat`
- Add `priority-ht-delete-smoke`
- Gates C-G stay parked until UNPARK

### P4 — Tests + docs
- Extend Test-Pack (`v2/tools/Test-PriorityCatalog.ps1`) — offline gates **CAT-T1…CAT-T25** (catalog A–D, OData plugin, grab-only MCP, v1 untouched, `formlimited_audit` fixture + **composed** SQL via `New-FormLimitedAuditSql` / `-ComposeSql`). **CAT-T25 mutation bar:** deleting parameter binding, moving the join off the pinned `FormLimitedExecCol`→`ExecIdCol` key, or inlining a form literal must each turn CAT-T25 red (issue #11 / #19 evidence).
- Run: `powershell -NoProfile -ExecutionPolicy Bypass -File v2\tools\Test-PriorityCatalog.ps1`
- Offline evidence: committed `v2/tests/formlimited-audit-composed.json` (statement + placeholders from the CAT-T25 harness pin in `v2/tests/formlimited-audit-compose-pin.json`, not `v2/config/pin.json`). `formlimited_audit` compose/live SQL refuses until `FormLimitedExecCol` is dictionary-pinned in `pin.json`; Eshbel live acceptance (issue #7) after ship — not a substitute for the composed artefact.
- Commit/push; open PR for hostile MRB on issue #19 (Bob chairs; no merge from this job).

## Success

Catalog A-D shipped (Jester harvest folded); v1 untouched; no guessed ENAMEs; Eshbel owns UAT + hostile MRB.
