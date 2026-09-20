# Build-and-test plan — Priority skills catalog (2026-09-19)

**FR:** docs/feature-request-priority-skills-catalog-2026-09-19.md  
**Repo:** SimonBarnett/agentic_fomprep  

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
- Extend Test-Pack (`v2/tools/Test-PriorityCatalog.ps1`)
- Commit/push; Eshbel hostile MRB + UAT (OData dump + named Form Prep smoke when DEV1 up)

## Success

Catalog A-D shipped (Jester harvest folded); v1 untouched; no guessed ENAMEs; Eshbel owns UAT + hostile MRB.
