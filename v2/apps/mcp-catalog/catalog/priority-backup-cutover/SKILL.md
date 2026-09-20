---
name: priority-backup-cutover
description: >
  Phased Priority backup cutover to the G: standard (DEV, then TST, then PRI). Agent jobs,
  SIMPLE where required, rollback notes. Use when the user says backup cutover, Phase 4,
  move backups to G:, or /priority-backup-cutover.
---

# Priority SQL backup cutover (phased apply)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-backup-cutover`).

Applies **priority-backup-standard** on live SQL **only** with human sign-off. Out of scope for unattended agents on PRI without Tedious UAT.

## When

Moving backup roots to G:, enabling Phase 4 Agent jobs, or fixing recovery model mismatch after audit gaps.

## Order

1. **DEV** — validate SIMPLE chain, jobs, G: paths, post-move health
2. **TST** — same
3. **PRI** — FULL chain + hourly TLOG; **never** without explicit production approval

Run **priority-backup-audit** before and after each phase.

## Do

1. Confirm `Default BackupDirectory` and physical files target G: mount for each instance (from config).
2. Create or fix Agent jobs per standard naming (`{INST}_FULL_WEEKLY`, etc.).
3. Switch DEV/TST user DBs to SIMPLE where standard requires; leave PRI user DBs FULL.
4. Disable (do not delete) old maint-plan backup jobs after replacement jobs succeed.
5. Run **priority-post-move-health** after each phase.
6. Document rollback: re-enable old jobs, revert `sp_configure` backup directory, restore from last good G: full if needed.

## Do not

- **Never** prune or delete old F: backup directory trees without **explicit** Simon/Tedious confirm.
- Put SQL passwords in git or chat — Windows integrated auth on the jump box only.
- Run PRI cutover in this repo’s CI or offline tests.

## Success

Overnight jobs succeed; backups only on G:; audit gap report clean; post-move health PASS.

## Escalate

Any job failure, backup still on F:, or PRI log_reuse_wait stuck — stop phase, capture job history, use **priority-sunday-backup-check** facts for Haitch handoff.

## Reference

Plan context: `docs/skill-sources/dba/` harvest pack (`BACKUP_STANDARD.md`, audit scripts). CE change plan may appear as historical markdown in the same folder when Tedious adds it.
