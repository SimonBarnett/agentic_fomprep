# Harvest pack for Bob — CE Priority DBA skills → SimonBarnett/agentic_fomprep

Prepared by Tedious 2026-09-19 for FR harvest.

## Canonical on CE-PRIORITY-DEV1 (machineId `f88819e4-f16e-4c2d-93b3-eef3c4d20530`)

| Artifact | Path |
|----------|------|
| BACKUP_STANDARD.md | `C:\Users\medatech.si\dba-reports\backup-audit-20260917\BACKUP_STANDARD.md` |
| Invoke-BackupAudit.ps1 | `C:\Users\medatech.si\dba-reports\backup-audit-20260917\Invoke-BackupAudit.ps1` |
| Invoke-LiveAudit.ps1 | `C:\Users\medatech.si\dba-reports\backup-audit-20260917\Invoke-LiveAudit.ps1` |
| Invoke-PostMoveHealth.ps1 | `C:\Users\medatech.si\dba-reports\backup-audit-20260917\Invoke-PostMoveHealth.ps1` |
| Layout PDF (IT) | `C:\Users\medatech.si\dba-reports\backup-audit-20260917\Clarkson_Evans_SQL_Disk_and_Maintenance_Layout.pdf` |
| Health SQL (if present) | also smoked as `C:\Users\medatech.si\dba_instance_health_collect.sql` historically |

## Same pack on Tedious box (this folder)

`/workspace/dba-reports/harvest-for-bob/`

- BACKUP_STANDARD.md (copied from DEV1)
- BACKUP_CHANGE_PLAN.md, GAP_REPORT.md (pre-cutover plan/gaps — useful context)
- Invoke-BackupAudit.ps1, Invoke-LiveAudit.ps1, Invoke-PostMoveHealth.ps1
- dba_instance_health_collect.sql
- sunday-ce-priority-backup-check.ROUTINE.md (routine prompt text; live routine folder `sunday-ce-priority-backup-check`)

## Standing process notes for skills

- Jump box: CE-PRIORITY-DEV1 → instances DEV/TST/PRI on `10.220.0.5`
- Data `F:\{instance}`; logs+backups `G:\{instance}`; monitor **mount points**, not F:/G: stubs
- PRI = FULL chain; DEV/TST = SIMPLE (no t-log chain)
- Retention defaults: bak 14d / trn 3d
- Hours → Haitch (WBS e.g. 2.35); do not Teams Gergo for backup notices
- Tedious owns UAT + hostile MRB return to Bob after build lands

## Out of scope

Club Madeira RDS / Postgres migration.
