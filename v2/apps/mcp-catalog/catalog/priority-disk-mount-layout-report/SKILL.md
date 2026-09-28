---
name: priority-disk-mount-layout-report
description: >
  Produce IT disk/mount layout for Priority SQL: data vs backup paths, Agent jobs, free space
  on mount points (not F:/G: stubs). Use when the user says disk layout PDF, mount point
  report, Gergo layout, or /priority-disk-mount-layout-report.
---

# Priority disk and mount layout report (IT)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-disk-mount-layout-report`).

Explains **where SQL lives** for infrastructure teams: MDF/LDF paths, backup roots, maintenance jobs, and **free space on mount points** (example CE: `F:\pridev`, `G:\pridata` backed by larger volumes — not ~1 GB drive-letter stubs).

## When

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Capacity planning, post-cutover communication, or annual infra review.

## Collect

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

1. Run **priority-instance-health-collect** and **priority-backup-audit**; keep TSV/TXT under `reportRoot`.
2. From SQL (integrated auth on jump box), capture per instance:
   - `sys.master_files` physical paths grouped by mount
   - `sys.dm_os_volume_stats` free/total for each mount used by data/log/backup
   - Enabled Agent jobs touching backups/index maintenance
3. Summarize in markdown or PDF for IT stakeholders.

## Example artifact

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Historical CE PDF lived on the harvest host under `dba-reports/backup-audit-20260917/` (see `docs/skill-sources/dba/MANIFEST.md`). Regenerate from fresh collect output — do not commit customer PDFs with internal paths unless policy allows.

## Success

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Reader can see mount-point capacity, backup location on G:, and job names without opening SQL Server.

## Do not

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Hard-code one customer as the only template in automation. No passwords in the report bundle.

## Handoff

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Route through **priority-hours-handoff-haitch** / Haitch for customer-facing send — not direct Teams to infra unless standing order changes.
