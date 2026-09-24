# Skill sources for Priority catalog FR

Build agent: port catalog SKILL.md from:

1. FR sections A-D in docs/feature-request-priority-skills-catalog-2026-09-19.md (authoritative for B/C)
2. docs/skill-sources/uat/ (authoritative for D + UAT procedure). Dated notes: docs/jester-priority-uat-skill-harvest-2026-09-19.md (summary) and docs/jester-priority-uat-skill-harvest-2026-09-24.md (supplement).
3. If available on this box under %USERPROFILE%\.grok\skills or a mapped workflows share, copy bodies for:
   - priority-project-create-smoke
   - priority-day-works-uat
   - prepare-all-unprepared-priority-forms
4. Do not invent ENAMEs. Do not edit v1 Prepare-NamedForm.ps1.

Ionos 2026-09-19: Grok Bot workflow leaflets were not on this box. UAT skills were written from the Jester harvest. `prepare-all-unprepared-priority-forms` documents the repo DEV method (named Form Prep; headed web tile fallback). Medatech hours trio skipped (optional / out of CE scope). Gates C-G stay parked until UNPARK.

2026-09-24: full learned UAT procedure lives under `docs/skill-sources/uat/` (see that folder's README). Catalog `SKILL.md` files for `priority-uat-orchestrator`, `priority-project-create-smoke`, `priority-day-works-uat`, and `priority-ht-delete-smoke` are ported from those sources. CE hosts and companies are examples only.

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

