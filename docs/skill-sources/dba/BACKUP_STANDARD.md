# CE Priority SQL backup standard (Phase 4)

Host: CE-AZ-UK-S-PRIO (10.220.0.5)
Layout: data on F:\{pridev|pritest|pridata}; logs+backups on G:\{pridev|pritest|pridata}

## Policy
| Instance | Recovery | Chain |
|----------|----------|-------|
| PRI | FULL (pritempdb SIMPLE) | Weekly FULL + daily DIFF + hourly TLOG |
| DEV | SIMPLE | Weekly FULL + daily DIFF (no TLOG) |
| TST | SIMPLE | Weekly FULL + daily DIFF (no TLOG) |

## Backup root
G:\{pridev|pritest|pridata}\MSSQL16.{DEV|TST|PRI}\MSSQL\Backup
Also set as instance BackupDirectory.

## Agent jobs (enabled)
| Job | Schedule |
|-----|----------|
| PRI_FULL_WEEKLY | Sun 02:00 |
| PRI_DIFF_DAILY | Mon–Sat 00:30 |
| PRI_TLOG_HOURLY | Every hour |
| PRI_BAK_CLEANUP | Daily 04:30 |
| DEV_FULL_WEEKLY | Sun 03:00 |
| DEV_DIFF_DAILY | Mon–Sat 01:00 |
| DEV_BAK_CLEANUP | Daily 05:00 |
| TST_FULL_WEEKLY | Sun 04:00 |
| TST_DIFF_DAILY | Mon–Sat 02:00 |
| TST_BAK_CLEANUP | Daily 06:00 |

## Retention (cleanup jobs)
- .bak older than 14 days
- .trn older than 3 days
- Path = that instance's G: Backup root only
- Do not prune old F: trees without a separate Simon confirm

## Left alone
- Azure/VM ~02:15 GUID/VSS fulls
- Index Rebuild/Reorganise (TST), Compare Code, SQL Reports, syspolicy_purge_history

## Old maint-plan backup jobs
Remain disabled (not deleted) on each instance after cutover.
