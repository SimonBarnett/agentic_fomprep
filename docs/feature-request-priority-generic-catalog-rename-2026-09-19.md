# Feature request: Rename ce-priority-* catalog to Priority-generic only

**Intake issue / MRB home:** [GitHub issue #4](https://github.com/SimonBarnett/agentic_fomprep/issues/4)  
**Date:** 2026-09-19  
**Status:** SHIPPED on main (catalog rename `6a929db`; durable gate `CAT-T44` on FR #4)  
**Repo:** https://github.com/SimonBarnett/agentic_fomprep  
**Raised by:** Simon (via Bob)  
**Build:** Bob Start-BobBuild on ionos  
**UAT + hostile MRB:** Bob (Simon-raised FR) — Eshbel/Jester verify their UAT skills still resolve after rename  

## Ask

`agentic_fomprep` must be a **generic Priority** tooling repo. Strip Clarkson Evans–branded skill ids and folder names. CE remains an **example deployment** in config/docs only.

## Scope — rename (git mv) catalog folders + meta

| Current | Target |
|---------|--------|
| `v2/apps/mcp-catalog/catalog/ce-priority-day-works-uat/` | `priority-day-works-uat/` |
| `v2/apps/mcp-catalog/catalog/ce-priority-ht-delete-smoke/` | `priority-ht-delete-smoke/` |
| `v2/apps/mcp-catalog/catalog/ce-priority-project-create-smoke/` | `priority-project-create-smoke/` |

In each `SKILL.md` / `meta.json`:
- `name` / id fields → `priority-*` (not `ce-priority-*`)
- when-to-use text describes **Priority** workflows; CE paths/hosts only as examples or in `instances.example.json`
- Inputs: instance, machine, env/config — never hard-coded CE-only targets as the skill identity

## Also update

- `v2/tools/Test-PriorityCatalog.ps1` and any marketplace / README / skill-sources indexes that list the old folder names
- Cross-links inside `priority-uat-orchestrator`, `priority-form-engineering`, and other catalog skills
- Docs that **instruct** new skills to use `ce-priority-*` ids (e.g. DBA FR proposed names) → rewrite to `priority-*`
- Historical FR filenames may keep `ce-priority` in the **filename** for git history, but body text must say Priority-generic going forward; optional rename of active DBA FR docs to `feature-request-priority-dba-skills-*.md` with a one-line stub at the old path

## Do not

- Delete skill bodies or weaken UAT coverage
- Hard-code CE jump box / `10.220.0.5` / company names into skill logic
- Change v1 `src\Prepare-NamedForm.ps1`
- Break pin Medatech ENAMEs (`ZEMG_*`) or WP0 walker behaviour — only naming/branding of **skills**
- Rename Tedious harvest source filenames under `docs/skill-sources/dba/` that are historical dumps (may note CE in content); new promoted catalog skills must be `priority-*`

## Acceptance

1. No catalog folder under `v2/apps/mcp-catalog/catalog/` whose name starts with `ce-priority-`
2. `rg 'ce-priority-' v2/apps/mcp-catalog/` returns no skill id / folder references (examples in prose OK if clearly “e.g. Clarkson Evans”)
3. Offline `Test-PriorityCatalog` (or equivalent) passes with new paths
4. README / skill-sources index lists only `priority-*` (and existing `prepare-all-unprepared-priority-forms`, `priority-formprep`, etc.)
5. Commit + push to main

## Out of scope

- Reworking DBA skills implement (separate job) beyond aligning proposed skill ids to `priority-*`
- Club Madeira / non-Priority products
