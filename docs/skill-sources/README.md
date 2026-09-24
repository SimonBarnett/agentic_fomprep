# Skill sources for Priority catalog FR

Build agent: port catalog SKILL.md from:

1. FR sections A-D in docs/feature-request-priority-skills-catalog-2026-09-19.md (authoritative for B/C)
2. docs/jester-priority-uat-skill-harvest-2026-09-19.md (authoritative for D + UAT procedure)
3. If available on this box under %USERPROFILE%\.grok\skills or a mapped workflows share, copy bodies for:
   - priority-project-create-smoke
   - priority-day-works-uat
   - prepare-all-unprepared-priority-forms
4. Do not invent ENAMEs. Do not edit v1 Prepare-NamedForm.ps1.

Ionos 2026-09-19: Grok Bot workflow leaflets were not on this box. UAT skills were written from the Jester harvest. `prepare-all-unprepared-priority-forms` documents the repo DEV method (named Form Prep; headed web tile fallback). The Medatech hours trio was skipped that day (optional / out of CE scope); reporting-hours procedures landed 2026-09-24 — see the Hours section below. Gates C-G stay parked until UNPARK.

## CE Priority DBA harvest (Tedious 2026-09-19)

Source dump for FR `docs/feature-request-ce-priority-dba-skills-2026-09-19.md`.

Canonical copies live under `docs/skill-sources/dba/` (from CE-PRIORITY-DEV1 `C:\Users\medatech.si\dba-reports\harvest-for-bob\`).

See `MANIFEST.md` in that folder. Tedious owns UAT + hostile MRB after implement.

### Naming rule (Simon)
Skills must be **Priority-generic** (config-driven instance). CE is an example deployment, not the skill identity.

### Catalog ids (DBA suite, issue #5)

| Catalog folder | Harvest / runner |
|----------------|------------------|
| `priority-backup-standard` | `dba/BACKUP_STANDARD.md` |
| `priority-backup-audit` | `Invoke-BackupAudit.ps1`, `Invoke-LiveAudit.ps1` |
| `priority-backup-cutover` | procedure skill (no live auto-cutover) |
| `priority-sunday-backup-check` | `sunday-ce-priority-backup-check.ROUTINE.md` |
| `priority-instance-health-collect` | `dba_instance_health_collect.sql` |
| `priority-post-move-health` | `Invoke-PostMoveHealth.ps1` |
| `priority-disk-mount-layout-report` | collect + IT narrative |
| `priority-ht-delete-deadlock-triage` | checklist; links `ce-priority-ht-delete-smoke` |
| `priority-form-prep-after-sql-change` | links `prepare-all-unprepared-priority-forms` |
| `priority-hours-handoff-haitch` | process only |

Form-prep / UAT catalog skills remain under the same `v2/apps/mcp-catalog/catalog/` tree (project-create, day-works, HT smoke, formprep, shell, OData, orchestrator).

## Haitch Priority reporting-hours harvest (2026-09-24)

Source dump for `docs/haitch-priority-hours-skill-harvest-2026-09-24.md`.

Canonical procedure: `docs/skill-sources/hours/`.

Catalog: `priority-hours-orchestrator`, `priority-hours-search-by-date-employee`, `priority-hours-enter-line`, `priority-hours-less-than-8-report`, `priority-hours-export-excel`, `priority-hours-odata-post`.

Does **not** replace `priority-hours-handoff-haitch` (DBA → Haitch handoff).

