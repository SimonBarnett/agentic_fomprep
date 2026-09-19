# Build-and-test plan — Priority skills catalog (2026-09-19)

**FR:** docs/feature-request-priority-skills-catalog-2026-09-19.md  
**Repo:** SimonBarnett/agentic_fomprep  

## Phases

### P0 — Catalog ports (A)
- Add `catalog/` entries (or v2 plugin catalog folders per existing v2 pattern) for:
  - ce-priority-project-create-smoke
  - ce-priority-day-works-uat
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

### P3 — priority-uat-orchestrator stub (D)
- Stub SKILL.md with UNPARK/CASE protocol; note Jester harvest pending

### P4 — Tests + docs
- Extend Test-Pack / parse-check as appropriate
- Commit/push; Eshbel hostile MRB + UAT (OData dump + named Form Prep smoke when DEV1 up)

## Success

Catalog A–C shipped; D stub; v1 untouched; no guessed ENAMEs; Eshbel MRB filed to Bob.
