---
name: priority-backup-audit
description: >
  Read-only Priority SQL backup inventory vs the backup standard. Use when the user says
  backup audit, msdb backup jobs, G: backup path check, gap report, or /priority-backup-audit.
---

# Priority SQL backup audit (read-only)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-backup-audit`).

Compares live SQL Agent jobs, maintenance plans, backup destinations, recovery models, and files on the backup volume against **priority-backup-standard**. Does **not** change jobs, plans, or delete backup files.

## When

Before or after a backup cutover; weekly health; answering “are we aligned with the standard?”

## Inputs

| Input | Source |
|-------|--------|
| SQL host | `instances.json` → `sqlHost` (example CE: jump box reaches `10.220.0.5`) |
| Instance names | `instanceIds` e.g. `DEV`, `TST`, `PRI` |
| Report folder | `reportRoot` (writable evidence path on the jump box) |

Copy `runner/instances.example.json` to `%USERPROFILE%\.priority-dba\instances.json` or set `PRIORITY_DBA_INSTANCES`.

## Do

1. Run inventory audit (full gap pack):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File runner\Invoke-PriorityBackupAudit.ps1 -Mode inventory -InstancesPath %USERPROFILE%\.priority-dba\instances.json
```

2. Optional live snapshot (`Invoke-LiveAudit.ps1`):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File runner\Invoke-PriorityBackupAudit.ps1 -Mode live
```

3. Read `BACKUP_STANDARD.md` in repo `docs/skill-sources/dba/` and reconcile gaps in the report TSV/MD outputs under `reportRoot`.

## Do not

- Put SQL passwords in git, prompts, or logs. **Windows integrated security only** on the jump box.
- Auto-prune old F: backup trees.
- Run destructive cutover from this skill (use **priority-backup-cutover** with explicit human confirm).

## Success

Evidence folder populated; gap list vs standard is explicit; no ERROR-only TSV for reachable instances.

## Offline / skip

If SQL is unreachable: script writes ERROR rows; treat as **fail for live UAT**, **skip for offline catalog test** (runner exits 2 only for missing config or missing source script).

## Reference

Canonical scripts: `docs/skill-sources/dba/Invoke-BackupAudit.ps1`, `Invoke-LiveAudit.ps1`.
