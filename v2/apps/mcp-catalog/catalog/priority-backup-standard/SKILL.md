---
name: priority-backup-standard
description: >
  Priority SQL backup target model: data vs log/backup paths, FULL/SIMPLE recovery,
  Agent job naming, retention, CHECKSUM+COMPRESSION. Use when the user says backup standard,
  Phase 4 layout, G: backup root, or /priority-backup-standard.
---

# Priority SQL backup standard (reference)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-backup-standard`).

This skill is the **policy** other DBA skills measure against. Deployment-specific paths and host names live in **config** (`instances.json`, env), not in skill logic.

## Target layout (config-driven)

| Role | Typical pattern (example CE) |
|------|------------------------------|
| Data files | `F:\{mountName}\...` — monitor **mount points**, not ~1 GB drive-letter stubs |
| Logs + backups | `G:\{mountName}\MSSQL16.{INST}\MSSQL\Backup` |
| Default backup directory | Same G: backup root per instance |

Map `mountName` and `INST` per deployment in config (example names: `pridev`, `pritest`, `pridata` for DEV/TST/PRI).

## Recovery and chains

| Tier | Recovery | Backup chain |
|------|----------|--------------|
| Production / PRI | FULL (tempdb may stay SIMPLE) | Weekly FULL + daily DIFF + **hourly TLOG** |
| Non-prod DEV/TST | SIMPLE | Weekly FULL + daily DIFF — **no** t-log chain |

## Agent jobs (enabled naming pattern)

Per instance `INST`:

- `{INST}_FULL_WEEKLY`
- `{INST}_DIFF_DAILY`
- `{INST}_BAK_CLEANUP`
- `{INST}_TLOG_HOURLY` — **PRI only**

Schedules are deployment-specific; CE Phase 4 example lives in repo `docs/skill-sources/dba/BACKUP_STANDARD.md`.

## Retention (cleanup jobs)

- `.bak` older than **14** days
- `.trn` older than **3** days
- Scope: that instance’s **G:** backup root only

## Technical defaults

- CHECKSUM + COMPRESSION on native backups
- Leave legacy maint-plan jobs **disabled** (not deleted) after cutover unless Tedious/Simon says otherwise
- Do **not** prune archived F: trees without **explicit** human confirm

## When

Designing cutover, auditing gaps, or explaining IT layout reports.

## Success

Auditor or cutover skill can map every instance to this table with no ambiguous paths.

## Do not

- Hard-code one customer host as the only valid target in automation
- Store or request SQL passwords — integrated auth from the jump box only

## Canonical doc

`docs/skill-sources/dba/BACKUP_STANDARD.md` (harvested reference; CE is one example deployment).
