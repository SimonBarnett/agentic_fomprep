# Skill sources for Priority catalog FR

Build agent: port catalog SKILL.md from:

1. FR sections A-D in docs/feature-request-priority-skills-catalog-2026-09-19.md (authoritative for B/C)
2. docs/skill-sources/uat/ (authoritative for D + UAT procedure). Dated notes: docs/jester-priority-uat-skill-harvest-2026-09-19.md (summary) and docs/jester-priority-uat-skill-harvest-2026-09-24.md (supplement).
3. If available on this box under %USERPROFILE%\.grok\skills or a mapped workflows share, copy bodies for:
   - priority-project-create-smoke
   - priority-day-works-uat
   - prepare-all-unprepared-priority-forms
4. Do not invent ENAMEs. Do not edit v1 Prepare-NamedForm.ps1.

Ionos 2026-09-19: Grok Bot workflow leaflets were not on this box. UAT skills were written from the Jester harvest. `prepare-all-unprepared-priority-forms` documents the repo DEV method (named Form Prep; headed web tile fallback). The Medatech hours trio was skipped that day (optional / out of CE scope); reporting-hours procedures landed 2026-09-24 â€” see the Hours section below. Gates C-G stay parked until UNPARK.

2026-09-24: full learned UAT procedure lives under `docs/skill-sources/uat/` (see that folder's README). Catalog `SKILL.md` files for `priority-uat-orchestrator`, `priority-project-create-smoke`, `priority-day-works-uat`, and `priority-ht-delete-smoke` are ported from those sources. CE hosts and companies are examples only.

## CE Priority DBA (relocated 2026-09-29)

CE-bound DBA / hardware / install pack moved to private
[`SimonBarnett/ce-priority`](https://github.com/SimonBarnett/ce-priority)
`docs/dba/`. See `docs/skill-sources/dba/README.md` (pointer only).

### Naming rule (Simon)
Skills in **this** repo must be **Priority-generic** (config-driven instance).
CE hosts, disk letters, and CE-only scripts are **not** skill identity here —
harvest those to `ce-priority`.

Portable adjacent skills that stay in the catalog (not CE DBA scripts):

| Catalog folder | Notes |
|----------------|-------|
| `priority-ht-delete-deadlock-triage` | checklist; links `priority-ht-delete-smoke` |
| `priority-form-prep-after-sql-change` | links `prepare-all-unprepared-priority-forms` |
| `priority-hours-handoff-haitch` | process only (generic handoff) |

Form-prep / UAT catalog skills remain under `v2/apps/mcp-catalog/catalog/`.

## Eshbel Priority programming harvest (2026-09-24)

Source dump for FR `docs/feature-request-eshbel-priority-programming-harvest-2026-09-24.md`.

Canonical copies: `docs/skill-sources/programming/`.

See `MANIFEST.md` in that folder. Eshbel owns hostile MRB after implement.

### Catalog ids (programming suite)

| Catalog folder | Harvest |
|----------------|---------|
| `priority-procedure-style` | PROCEDURE_STYLE.md |
| `priority-sql-udate-user` | SQL_UDATE_USER.md |
| `priority-formprep-shadow-tables` | FORMPREP_SHADOW_TABLES.md |
| `priority-recalc-concurrency` | RECALC_CONCURRENCY.md |
| `priority-version-revision-discipline` | VERSION_REVISION.md |
| `priority-dictionary-sql` | `DICTIONARY_SQL.md` |

Also expand existing: `priority-form-engineering`, `priority-odata-dev` (`T$EXEC` key), `priority-ht-delete-deadlock-triage` (rename ce-* smoke refs).

## Priority Cloud MCP skills (issue #51)

Official Priority MCP docs: https://prioritysoftware.github.io/mcp/

| Catalog folder | Focus |
|----------------|-------|
| priority-mcp-setup | Connection / PAT / OAuth2 |
| priority-mcp-discovery | companies / entity_search / form_columns / form_tree |
| priority-mcp-forms | form_fetch / form_update |
| priority-mcp-procedures | procedure_start / procedure_continue |
| priority-mcp-search | enterprise_search vs entity_search |
| priority-mcp-help-and-skills | help / skill_list / skill_fetch |

These are catalog leaflets (no local execute plugin). Cloud tenant credentials stay outside git.

## UAT fast path (issue #53)

Standard smokes use the fastest assert path (WCF preferred). Video/human packs live in SimonBarnett/bob-design-uat `uat-video-pack`. Catalog: `priority-uat-orchestrator`, `priority-uat-wcf`, plus project-create / day-works / ht-delete smokes.
