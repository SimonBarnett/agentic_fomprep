# Feature request: CE Priority DBA agent skills suite

**Intake issue / MRB home:** [GitHub issue #5](https://github.com/SimonBarnett/agentic_fomprep/issues/5)  
**Date:** 2026-09-19  
**Repo:** https://github.com/SimonBarnett/agentic_fomprep  
**Raised by:** Tedious (via Simon)  
**UAT + hostile MRB owner:** Tedious (standing order — originating agent)  
**Build orchestrator:** Bob  

## Ask

Add a suite of **agent skills** (`SKILL.md` + supporting scripts/docs) harvested from Tedious’s Clarkson Evans Priority DBA work so agents can run Priority-instance DBA ops consistently. Repo already has form-prep / UAT skills in `v2/apps/mcp-catalog/catalog/` (catalog A–D landed `9f409c9`); this FR **extends** that catalog with SQL/instance ops for CE Priority **DEV / TST / PRI** on `CE-AZ-UK-S-PRIO` / jump box **CE-PRIORITY-DEV1**.

## Context

Real work already done Sep 2026 — backup cutover Phases 1–4, Sunday check routine, health collect, post-move smoke, IT PDF layout, HT-delete deadlock SQL evidence, Form Prep after trigger fixes. Harvest into reusable skills, not one-off chat.

## Proposed skills (priority order)

1. **ce-priority-backup-standard** — Target model: `F:\{instance}=data`, `G:\{instance}=logs+backups`; PRI=`FULL` (weekly full / daily diff / hourly t-log); DEV+TST=`SIMPLE` (weekly full + daily diff, no t-log chain); retention bak 14d / trn 3d; job name pattern `INST_FULL_WEEKLY` / `_DIFF_DAILY` / `_BAK_CLEANUP` / `PRI_TLOG_HOURLY`; CHECKSUM+COMPRESSION; Default BackupDirectory on G:. Reference `BACKUP_STANDARD.md` / `BACKUP_CHANGE_PLAN.md` from backup-audit-20260917.

2. **ce-priority-backup-audit** — Read-only inventory of Agent jobs, maint plans, destinations, recovery models, file presence on G:, retention/cleanup health. Output gap vs standard. Scripts: `Invoke-BackupAudit.ps1`, `Invoke-LiveAudit.ps1`.

3. **ce-priority-backup-cutover** — Phased apply: DEV → TST → PRI; SIMPLE cutover where required; create/fix Agent jobs; **never** prune old F: backup trees without explicit confirm. Include rollback notes.

4. **ce-priority-sunday-backup-check** — Sunday ~09:00 UK post-overnight: job history + msdb + files on `G:\{instance}`; PRI t-log truncation; short pass/fail for Haitch→Simon. (Matches Tedious routine `sunday-ce-priority-backup-check`.)

5. **ce-priority-instance-health-collect** — Portable `dba_instance_health_collect.sql` across `\DEV` `\TST` `\PRI`: disk/capacity (esp. mount points), memory pressure, early outage signals. Smoke-tested path pattern on DEV1.

6. **ce-priority-post-move-health** — After backup-path moves: services up, jobs/paths, smoke DIFF/TLOG + VERIFYONLY on G:. Script: `Invoke-PostMoveHealth.ps1`.

7. **ce-priority-disk-mount-layout-report** — PDF/report for IT: MDF/LDF/backup paths, per-instance jobs, free space; **monitor mount points** (`F:\pridev`, `G:\pridata`=H:) not ~1GB F:/G: stubs. Used for Gergo/Andrew.

8. **ce-priority-ht-delete-deadlock-triage** — When HT Ctrl+Delete → SQL 1205: pull deadlock graph; compare `FORMTRIGTEXT` PRE-DELETE bodies DEV vs TST; check `PROJACT` / `ZCLA_SMALLWORKSPLOT` indexes; Form Prep after trigger edits; coordinate Eshbel/Jester. Ops skill + SQL evidence checklist — **not** a blind auto-fix. Relates to existing `ce-priority-ht-delete-smoke`.

9. **ce-priority-form-prep-after-sql-change** — Link/document gate after `FORMTRIGTEXT` / trigger SQL changes before UAT retry (extends existing `prepare-all-unprepared-priority-forms`).

10. **ce-priority-hours-handoff-haitch** — After material DBA work: human-equivalent hours + WBS (e.g. 2.35) to Haitch; never Teams Gergo directly for backup notices (standing process).

## Supporting artifacts (pull from Tedious / DEV1)

- `/workspace/dba-reports/backup-audit-20260917/*` (plan, audit PS1, post-move health, gap report)
- `BACKUP_STANDARD.md` on CE-PRIORITY-DEV1 under backup-audit folder
- `dba_instance_health_collect.sql`
- Sunday routine prompt text (`sunday-ce-priority-backup-check`)

If artifacts are missing on the build host, implement skill shells + README pointers and leave `docs/skill-sources/dba/` placeholders; Tedious can PR script bodies.

## Acceptance criteria

- Each item is a skill with clear when-to-use description, inputs (instance, machine), do/don’t, success criteria.
- Skills live under `v2/apps/mcp-catalog/catalog/<skill-id>/` with `SKILL.md` + `meta.json` (match catalog A–D pattern).
- Generic for CE Priority DEV/TST/PRI; secrets/hosts via env or machine config — **no hard-coded passwords**.
- README index in repo listing new **DBA** skills vs existing **form-prep / UAT** skills (`docs/skill-sources/README.md` and/or catalog README).
- Prefer PowerShell / sqlcmd patterns that run from jump box **CE-PRIORITY-DEV1** against `10.220.0.5` instances.
- Offline tests where live SQL is unreachable; document skip vs fail clearly.
- Do **not** break or rewrite v1 `src\Prepare-NamedForm.ps1`.
- Do **not** auto-prune F: backup trees.

## Out of scope

- Club Madeira RDS / Postgres migration skills
- Azure cost review
- Live destructive cutover on PRI without Tedious UAT sign-off

## Standing order

Tedious performs UAT + hostile MRB back to Bob. Bob parks this FR and dispatches builds.

## Constraint (Simon 2026-09-19)

Skills harvested from Tedious / Eshbel / Jester work must be **Priority-generic**, not Clarkson Evans–instance-specific.

- Name skills for Priority DBA / Form Prep / UAT patterns (e.g. `priority-backup-standard`), not `ce-priority-*` unless the skill is truly CE-only process.
- Hosts, instance ids (DEV/TST/PRI), paths (`F:\`/`G:\`), jump box, and company names come from **config / env / instances.json** — never hard-coded as the only target.
- CE paths and `10.220.0.5` may appear as **examples** in docs and example config, not as required constants in skill logic.
- Same rule applies to form-prep / UAT catalog skills already landed: prefer generic Priority wording in when-to-use text; CE is one deployment.
