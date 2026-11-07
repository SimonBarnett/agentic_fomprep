---
name: priority-backup-standard
description: >
  Priority SQL backup target model: data vs log/backup paths, FULL/SIMPLE recovery,
  Agent job naming, retention, CHECKSUM+COMPRESSION. Use when the user says backup standard,
  Phase 4 layout, G: backup root, or /priority-backup-standard.
---

# Priority SQL backup standard (reference)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-backup-standard`).

This skill is the **policy** other DBA skills measure against. Deployment-specific paths and host names live in **config** (`instances.json`, env), not in skill logic.

## Target layout (config-driven)

| Role | Typical pattern (example CE) |
|------|------------------------------|
| Data files | `F:\{mountName}\...` --- monitor **mount points**, not ~1 GB drive-letter stubs |
| Logs + backups | `G:\{mountName}\MSSQL16.{INST}\MSSQL\Backup` |
| Default backup directory | Same G: backup root per instance |

Map `mountName` and `INST` per deployment in config (example names: `pridev`, `pritest`, `pridata` for DEV/TST/PRI).

## Recovery and chains

| Tier | Recovery | Backup chain |
|------|----------|--------------|
| Production / PRI | FULL (tempdb may stay SIMPLE) | Weekly FULL + daily DIFF + **hourly TLOG** |
| Non-prod DEV/TST | SIMPLE | Weekly FULL + daily DIFF --- **no** t-log chain |

## Agent jobs (enabled naming pattern)

Per instance `INST`:

- `{INST}_FULL_WEEKLY`
- `{INST}_DIFF_DAILY`
- `{INST}_BAK_CLEANUP`
- `{INST}_TLOG_HOURLY` --- **PRI only**

Schedules are deployment-specific; CE Phase 4 example lives in repo `docs/skill-sources/dba/BACKUP_STANDARD.md`.

## Retention (cleanup jobs)

- `.bak` older than **14** days
- `.trn` older than **3** days
- Scope: that instance's **G:** backup root only

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
- Store or request SQL passwords --- integrated auth from the jump box only

## Canonical doc

`docs/skill-sources/dba/BACKUP_STANDARD.md` (harvested reference; CE is one example deployment).


## Example: disk-pressure cleanup is not a new retention standard (SC263422)

Issue type: database disk monitoring went critical while backup files were retained. This example does not replace the 14-day `.bak` / 3-day `.trn` policy above.

Known mitigation: on 2026-10-29 an operator, with the cleanup recorded at 13:39 GMT, deleted older backups and kept the latest-night backup. Monitoring reported RECOVERY / OK at 13:46 GMT. That is short-term free space, not a restore test and not proof the retention constant is correct.

Unknown: why SQLBACKUPDAYS set to 2 still showed 3 backups. The note that changing it from 2 to 1 might then keep 2 was an explicit guess. Do not copy 2-to-1, or any other constant edit, as a universal retention setting. The next scheduled cycle was not verified. No restore was demonstrated.

Steps: read the monitoring trend and list what is actually using space, per company, including which backup is the latest restorable copy and what recovery retention is required. Treat a constant-versus-file-count mismatch as a hypothesis until the next cycle is observed. An authorized backup owner chooses any deletion or retention change. This harvest authorizes neither. After cleanup, watch free space and backup health. Deleting a company or a database is not this mitigation.

Opened 2026-10-29 08:30 GMT. SC263449 asked which copy companies might be deleted and did not record an approved cleanup. Do not merge that call into this example.


## Stray root backup, not the retention constant (SC263261)

A second capacity incident. An old January backup was sitting at a drive root, outside the folder the retention job cleans. Support deleted that one file at 2026-10-19 10:39 BST. Monitoring reported OK at 10:40 BST, with free space moving from about 10 percent to 16 percent. Opened 2026-10-19 10:04 BST.

That delete is not permission to remove backups. No restore test was recorded. A DBA still has to check policy, the restore chain, offsite copies, and the approved scope before any file is removed. Free space is not proof the remaining backups are valid. Do not shrink databases or silence the alert. The drive letter is omitted on purpose.

This is separate from the SQLBACKUPDAYS guess in SC263422. Do not mix them into one retention change.


## A backup.zip is not automatically disposable (SC263205)

On 2026-10-15 11:43 BST support deleted a backup.zip that was using a lot of space. At 11:44:56 BST monitoring reported OK, and free space was 22 percent after an earlier critical reading around 6 percent. Opened 2026-10-14.

The archive's role in the restore chain was not documented. This is capacity relief, not a corrected retention policy. Do not treat every backup.zip as safe to delete. No shrink and no fabricated backup history. A DBA still checks restorable copies before removal.
