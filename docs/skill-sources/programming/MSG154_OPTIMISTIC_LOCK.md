# Priority msg 154 — optimistic lock / original buffer :$1.*

Harvest 2026-09-29 (from Element Edits + file attach; rule is Priority-generic).

## Error

```
Record has been modified or deleted by another user
```

(Priority msg 154: original form record has been modified.)

## Cause

Built-in form UPDATE uses optimistic locking: the `WHERE` clause compares
**original** buffer values (`:$1.COL`) to the current DB row.

If another write changes one of those columns **during** the edit (common:
file attach writes `EXTFILENAME` early), leave-line UPDATE matches **0 rows**
→ msg 154.

## Fix pattern

In **PRE-UPDATE** (FORMTRIG TRIG=5), resync the originals you care about
from the row before validation / built-in UPDATE:

```sql
SELECT COL1, COL2, …
INTO :$1.COL1, :$1.COL2, …
FROM TABLENAME
WHERE KEYCOL = :$.KEYCOL
AND :$.KEYCOL <> 0
;
```

Only resync columns that mid-edit side effects can change. Then run existing
ERRMSG checks.

After changing FORMTRIGTEXT: Named Form Prep; success = `UPD=N` and
`LASTPREPDATE` advanced.

## Proof sketch

1. Mid-edit `UPDATE … SET EXTFILENAME=… WHERE KEY=…`
2. Leave-line-style `UPDATE … WHERE EXTFILENAME=''` (stale :$1) → 0 rows
3. After PRE-UPDATE resync, leave-line UPDATE matches 1 row

## Related

- Identity 8102 / TYPE=A: `INDEXES_TYPE_A_IDENTITY.md`
- Form Prep after trigger SQL: catalog `priority-form-prep-after-sql-change`
- Procedure style / dedicated TRIG: `PROCEDURE_STYLE.md`
