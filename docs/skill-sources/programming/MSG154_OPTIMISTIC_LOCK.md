# Priority msg 154 — optimistic lock / original buffer :$1.*

Harvest 2026-09-29 (mid-edit DB write / file attach).
Expanded 2026-09-30 (nullable form columns + resync hygiene).

## Error

```
Record has been modified or deleted by another user
```

(Priority msg 154: original form record has been modified.)

## Cause A — mid-edit DB write

Built-in form UPDATE uses optimistic locking: the `WHERE` clause compares
**original** buffer values (`:$1.COL`) to the current DB row.

If another write changes one of those columns **during** the edit (common:
file attach writes `EXTFILENAME` early), leave-line UPDATE matches **0 rows**
→ msg 154.

## Cause B — nullable origin columns painted on the form (2026-09-30)

When new physical columns are added to a table **and** painted on the form
(`FORMCLMNS`) without `DEFAULT` and without backfilling existing rows, those
rows hold **NULL**.

SQL Server treats `NULL = NULL` as unknown. Priority’s optimistic `WHERE`
uses equality on originals, so leave-line UPDATE matches **0 rows** → msg 154
on **any** save of that row (often first noticed when editing a visible
field such as a price).

Proof sketch:

```sql
-- broken (0 rows)
UPDATE T SET C = C WHERE KEY = @k AND NULLABLE_COL = NULL;

-- fixed after backfill to non-null (1 row)
UPDATE T SET C = C WHERE KEY = @k AND NULLABLE_COL = 0;  -- or ''
```

## Fix pattern — PRE-UPDATE :$1 resync (Cause A)

In **PRE-UPDATE** (FORMTRIG TRIG=5), resync only the originals that
mid-edit side effects can change, before validation / built-in UPDATE:

```sql
SELECT COL1, COL2
INTO :$1.COL1, :$1.COL2
FROM TABLENAME
WHERE KEYCOL = :$.KEYCOL
AND :$.KEYCOL <> 0
;
```

### Resync hygiene (CAST IRON)

- **Do** resync columns written early by side effects (file path, PO number).
- **Do** resync newly painted nullable columns if any NULL can still slip
  through (defense), after you also DEFAULT + backfill.
- **Do not** resync the column the user is actively editing (e.g. price) or
  unrelated keys “just in case” — keep `: $1` honest for real concurrency.
- Split statements so each `FORMTRIGTEXT.TEXT` line stays within the column
  max length (**68** on current estates). Long `INTO :$1.A, :$1.B, …` lines
  truncate and leave SELECT/INTO mismatched.

After changing FORMTRIGTEXT: Named Form Prep; success = `UPD=N` and
`LASTPREPDATE` advanced.

## Fix pattern — DEFAULT + backfill (Cause B)

When adding nullable columns that will appear on a form:

1. `UPDATE … SET col = <non-null>` for existing rows (`0` / `''` as appropriate).
2. `ALTER TABLE … ADD CONSTRAINT DF_… DEFAULT (…) FOR col`.
3. Prefer `NOT NULL` with DEFAULT when the product allows it.
4. Users with the form already open must **re-retrieve** (close/reopen or
   re-login); an open buffer still holds NULL originals until refresh.

## Concurrent sessions

Same login on another device (WCF / Form Prep / second browser) can also
trip msg 154. Prefer one session while reproducing leave-line saves.

## Proof sketch (Cause A)

1. Mid-edit `UPDATE … SET EXTFILENAME=… WHERE KEY=…`
2. Leave-line-style `UPDATE … WHERE EXTFILENAME=''` (stale :$1) → 0 rows
3. After PRE-UPDATE resync, leave-line UPDATE matches 1 row

## Related

- Identity 8102 / TYPE=A: `INDEXES_TYPE_A_IDENTITY.md`
- Form Prep after trigger SQL: catalog `priority-form-prep-after-sql-change`
- Procedure style / FORMTRIGTEXT line length: `PROCEDURE_STYLE.md`
- Dedicated TRIG: `PROCEDURE_STYLE.md`
