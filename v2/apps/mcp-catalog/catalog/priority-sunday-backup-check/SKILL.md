---
name: priority-sunday-backup-check
description: >
  Sunday Priority backup verification after overnight jobs: Agent history, msdb, G: files,
  PRI t-log truncation. Short pass/fail to Haitch. Use when the user says Sunday backup
  check, weekly backup signal, or /priority-sunday-backup-check.
---

# Priority Sunday backup check

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-sunday-backup-check`).

Human routine (~09:00 Europe/London). Matches harvest text in `docs/skill-sources/dba/sunday-ce-priority-backup-check.ROUTINE.md`.

## When

Every Sunday after overnight backups on all configured instances.

## Verify (each instance in config)

1. SQL Agent success for **priority-backup-standard** job names in the overnight window.
2. msdb `backupset` / files present under **G:** backup roots (not legacy F:).
3. **PRI only:** transaction log truncation healthy (not stuck on `LOG_BACKUP` for FULL user DBs).
4. Cleanup jobs succeed (retention DATEADD / `xp_delete_file` syntax).

## Comms

- Send **Haitch** a short pass/fail (instance, failed job name, last error line if any).
- Do **not** Teams Gergo (or other infra) directly for backup notices — standing process.

## Dry-run (offline / catalog)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File runner\Invoke-SundayBackupCheck.ps1 -DryRun
```

Emits checklist JSON only; no SQL.

## Live

Execute the checklist manually on the jump box with integrated auth, or extend the runner with read-only SQL (future). Always send Haitch the signal — do not stay quiet on pass.

## Related

**priority-backup-audit** for deep gap reports; **priority-hours-handoff-haitch** after material DBA work.
