# Routine: Sunday CE Priority backup check

- **Folder / id:** `sunday-ce-priority-backup-check`
- **Schedule:** Every Sunday at 09:00 Europe/London (`0 9 * * 0`)
- **Enabled:** yes
- **First intended run:** 20 Sep 2026

## Prompt (what Tedious should do each fire)

After overnight backups on Clarkson Evans Priority SQL (host CE-AZ-UK-S-PRIO / `10.220.0.5`, jump CE-PRIORITY-DEV1), verify the **post-Phase-4** Agent jobs and paths, then send Haitch a short pass/fail for Simon.

### Verify (DEV, TST, PRI)

1. SQL Agent job history for (names as standardised in Phase 4 / BACKUP_STANDARD.md):
   - `{INST}_FULL_WEEKLY` (DEV/TST/PRI)
   - `{INST}_DIFF_DAILY` (DEV/TST/PRI)
   - `{INST}_BAK_CLEANUP` (DEV/TST/PRI)
   - `PRI_TLOG_HOURLY` (PRI only)
2. Confirm success via job history / msdb backupset / files present under `G:\{instance}\...` backup roots (not F:).
3. On **PRI** only: confirm transaction-log truncation / log_reuse_wait not stuck on LOG_BACKUP for user DBs in FULL recovery.
4. Do **not** Teams Gergo directly — priority-notify Haitch with short facts (instance, pass/fail, any failed job name, path/stamp). Haitch Teams Gergo if needed.

### Pass criteria

All listed jobs succeeded in the overnight window; PRI t-log truncation OK; cleanup jobs not failing on DATEADD/xp_delete_file syntax.

### Fail / escalate

Any failed or missing job, backups still landing on F:, PRI log not truncating, or cleanup errors — include the failing job name and last error line in the Haitch note.

### Stay quiet?

No — always send Haitch a short pass/fail (Simon expects the Sunday signal).
