# Report form zooms (ZOOMCOLUMNS2)

Link a **visible name column** on a Priority report (`TYPE=R`) to a Priority
**form**, using the hidden id column as the join key.

## Table

`system.dbo.ZOOMCOLUMNS2`

| Column | Meaning |
|--------|---------|
| `FORMEXEC` | `T$EXEC` of the **report** (or form) that owns the clickable column |
| `COLNAME` | Visible column name the user clicks (e.g. `PARTNAME`) |
| `ZOOMEXEC` | `T$EXEC` of the **target form** (`TYPE=F`) |
| `JOINCOL` | Id column name on the report row used to open the form (e.g. `PART`) |

Unique key: `(FORMEXEC, COLNAME, ZOOMEXEC, JOINCOL)`.

## Pattern

1. Report table holds both the **name** (display) and the **id** (join).
2. `REPCLMNS`: show the name; **hide** the id (`HIDE='Y'`).
3. Insert `ZOOMCOLUMNS2` so the name zooms with `JOINCOL` = id column.

Example (anonymised):

```sql
-- Report T$EXEC = @ExecR; part number zooms to Parts (LOGPART or PART)
INSERT INTO ZOOMCOLUMNS2 (FORMEXEC, COLNAME, ZOOMEXEC, JOINCOL)
VALUES (@ExecR, N'PARTNAME', @LogPartExec, N'PART');

INSERT INTO ZOOMCOLUMNS2 (FORMEXEC, COLNAME, ZOOMEXEC, JOINCOL)
VALUES (@ExecR, N'SERIALNAME', @SerialExec, N'SERIAL');

INSERT INTO ZOOMCOLUMNS2 (FORMEXEC, COLNAME, ZOOMEXEC, JOINCOL)
VALUES (@ExecR, N'LOTSERNUM', @SernumbersExec, N'SERN');
```

Resolve target `T$EXEC` from `T$EXEC` where `TYPE='F'` and `ENAME` is the form
(e.g. `PART`, `LOGPART`, `SERIAL`, `SERNUMBERS`). Prefer the estate’s common
zoom target: many estates zoom `PARTNAME` to **`LOGPART`** more often than bare
`PART` — count existing `ZOOMCOLUMNS2` rows for `COLNAME='PARTNAME'` before
choosing.

## Also show descriptions

Ids alone are wrong in the report UI. Add a description column when the
business name is not enough (e.g. `PARTDES` next to `PARTNAME`), fill it in the
procedure SQLI from the master table, and add a `REPCLMNS` row. Descriptions
usually do **not** need their own zoom when the name column already opens the
form.

## After dictionary change

Set `EXECPREPLOCK.UPD='Y'` for the report (and owning procedure if SQLI
changed) and **Prepare** (`REPPREPDIRECT2` / `priority-procedure-prep`). Zooms
and new columns land in the `.prp` only after a successful prepare.

## Related

- Report column list: `REPCLMNS` (+ `COLUMNS` for `CNAME` / titles)
- Procedure prepare: `PREPARE_PROCEDURE.md` / **priority-procedure-prep**
- Table/column bootstrap: **priority-create-table** / **priority-dictionary-sql**
