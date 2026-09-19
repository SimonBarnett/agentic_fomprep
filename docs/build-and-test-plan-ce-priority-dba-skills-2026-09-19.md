# Build-and-test plan: CE Priority DBA skills suite

**FR:** `docs/feature-request-ce-priority-dba-skills-2026-09-19.md`  
**Repo:** SimonBarnett/agentic_fomprep  
**Date:** 2026-09-19  

## Goal

Land skills 1–10 from the FR into the mcp-catalog (and thin runners under each skill folder where scripts already exist), plus a README index separating DBA vs form-prep skills.

## Steps

1. Read existing catalog pattern from `v2/apps/mcp-catalog/catalog/*/SKILL.md` and `docs/skill-sources/README.md`.
2. Search CE-PRIORITY-DEV1 / Tedious-provided paths for backup-audit-20260917 artifacts; copy non-secret scripts into `docs/skill-sources/dba/` and wire from skills.
3. Implement skills in priority order 1→10 (minimum viable: SKILL.md + meta.json + script stubs that call documented entrypoints).
4. For skill 9: prefer a short skill that **links** `prepare-all-unprepared-priority-forms` as a required gate rather than duplicating it.
5. For skill 8: checklist + evidence queries only; no auto ALTER.
6. Update `docs/skill-sources/README.md` and catalog README with DBA section.
7. Add/extend a catalog test (mirror `v2/tools/Test-PriorityCatalog.ps1`) for new skill folders present + frontmatter.
8. Commit/push to main (or PR if main is contested by concurrent WCF/skills jobs — prefer a clean commit of DBA skills only).

## Test

- Offline: catalog folder presence, SKILL.md frontmatter `name`/`description`, meta.json parse, no password literals in committed files (`rg` / Select-String scan).
- Live (Tedious UAT on DEV1): backup-audit read-only against DEV; health-collect smoke; sunday-check dry-run; post-move health if G: paths exist.
- Tedious hostile MRB → Bob.

## Non-goals

Do not run PRI cutover or delete F: backup trees during this build.
