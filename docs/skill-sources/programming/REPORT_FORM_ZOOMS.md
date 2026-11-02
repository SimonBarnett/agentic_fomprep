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
2. `REPCLMNS`: show the name (`HIDE` blank); **hide** the id (`HIDE='Y'`). Optional `RSELECT='N'` on id cols (vendor ACTPART pattern).
   - Do **not** set `HIDE='I'` on display name columns — on reports **`I` means Input** (parameter dialog), not “interactive/zoom”.
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
and new columns land in the `.prp` / `.p` only after a successful prepare.

## HTML reports need REPCLMNSA `_winform` (not only ZOOMCOLUMNS2)

`ZOOMCOLUMNS2` is the **form** zoom table. HTML **report** click-through uses
`REPCLMNSA` (Report Columns–HTML Design), per Priority SDK “Accessing a Related
Form” / Dynamic Access:

1. Hidden calculated `REPCLMNS` rows (`T$COLUMN=0`, `EXPRESSION='Y'`, `HIDE='Y'`,
   `FORDER` set) with `REPCLMNSA.TYPE='CHAR'` and `EXPR` = `N'''LOGPART'''` (etc.).
2. On the visible name column’s `REPCLMNSA` row: `LINKTYPE='P'`,
   `LINKRETVAL='_winform'`, `LINKPOS`/`LINKPROCPOS` = that helper POS.
3. Set `FORDER` (Sort) on the name columns and keep id join columns on the report
   with `HIDE='Y'` and blank `RSELECT` so keys stay in the row.
4. Prepare the report after changing `REPCLMNSA`.

### Calculated display (`STRCAT`) must be `T$COLUMN=0`

`REPCLMNSA.EXPR` with `STRCAT(...)` is only valid on **calculated** report
columns (`REPCLMNS.T$COLUMN=0`, `EXPRESSION='Y'`). Putting `STRCAT` on a real
table column (e.g. `PARTNAME`) makes Prepare emit it into the WHERE clause and
fail with `parse error at or near symbol STRCAT`. Pattern for indented names:
hide the raw name column; add a calc POS titled “Part Number” with
`STRCAT(TABLE.INDENT, TABLE.PARTNAME)` and the `_winform` link on that calc row.

### HTML report paint quirks

- HTML **escapes** `&nbsp;` to literal text. Store Unicode U+00A0 (NBSP) in the
  indent column instead.
- `HIDE='Y'` alone often still paints id / RUNKEY / PATHKEY columns. Use
  `RSELECT='N'` as well, or **DELETE** the `REPCLMNS` row (table column can stay
  for SQLI fill). Helper form-ENAME cols: `HIDE='Y'` + `RSELECT='N'` + high
  `FORDER` (do **not** set `FWIDTH=0` — that drops them from the row and kills
  `_winform` links).
- Shifted INT qty (QUANT-style) may still show as `2,000` in HTML. Prefer a calc
  CHAR column `ITOA(TABLE.QTY/1000)` for a plain `2`.
- Sort the tree with hidden `LINEORD` `FORDER=1` + `RSELECT='N'`; put name-column
  `FORDER` after that or Part Number sorts ahead of the root.

## Related

- Report column list: `REPCLMNS` / `REPCLMNSA` (+ `COLUMNS` for `CNAME` / titles)
- Procedure prepare: `PREPARE_PROCEDURE.md` / **priority-procedure-prep**
- Table/column bootstrap: **priority-create-table** / **priority-dictionary-sql**
