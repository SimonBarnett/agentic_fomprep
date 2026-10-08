---
name: priority-create-table
description: >
  Create Priority custom tables the Tabula-safe way: physical CREATE + unique
  index IGNORE_DUP_KEY=ON, COLUMNS.SIZE never 0 (CHAR SIZE=WIDTH; REAL/INT=8),
  then CATALOG/INDEXES/T$EXEC bootstrap. Use when Form Generator says "Table X
  is missing column Y", Ignore Duplicate Values names a new table, SQL table
  bootstrap, or /priority-create-table.
---

# Priority create table (Tabula-safe)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-create-table`).

## Hard rules

1. **Do not** use bare `CONSTRAINT … PRIMARY KEY` / unique indexes with
   `IGNORE_DUP_KEY` off. Use:
   `CREATE UNIQUE CLUSTERED INDEX [T#1#COL…] ON dbo.T (…) WITH (IGNORE_DUP_KEY = ON)`.
2. **`COLUMNS.SIZE` must never be 0.**
   - CHAR / DATE / TIME / DAY → `SIZE = WIDTH`
   - REAL → `SIZE = 8`
   - INT → `SIZE = 8`
3. Form Generator **"Table T is missing column C"** with a visible `COLUMNS`
   row almost always means CHAR `SIZE=0` (or client cache — log out/in after heal).
4. Tabula **"Ignore Duplicate Values"** naming table T → that table's unique
   index has `ignore_dup_key=0`. Rebuild with ON.
5. Dictionary inserts stay IDENTITY-safe (`priority-dictionary-sql`).
6. After physical+dict: Form Generator FCLMN paint, then Named Form Prep
   (`UPD=N` + `LASTPREPDATE` advanced).

## Minimal physical + SIZE

```sql
CREATE TABLE dbo.ZCLA_EXAMPLE (
  EDITID bigint NOT NULL,
  GUID nvarchar(64) NOT NULL
);
CREATE UNIQUE CLUSTERED INDEX [ZCLA_EXAMPLE#1#EDITID#GUID]
  ON dbo.ZCLA_EXAMPLE (EDITID, GUID)
  WITH (IGNORE_DUP_KEY = ON);

INSERT INTO COLUMNS ([T$TABLE], POS, CNAME, TYPE, WIDTH, SIZE, TITLE)
VALUES (@tab, 1, N'EDITID', N'INT', 13, 8, N'Edit (ID)');
INSERT INTO COLUMNS ([T$TABLE], POS, CNAME, TYPE, WIDTH, SIZE, TITLE)
VALUES (@tab, 2, N'GUID', N'CHAR', 64, 64, N'GUID');
```

## Related

`priority-dictionary-sql`, `priority-formprep-shadow-tables`, `priority-formprep`,
`priority-version-revision-discipline`.

Sources: `docs/skill-sources/programming/CREATE_TABLE.md`, `IGNORE_DUP_KEY.md`,
`DICTIONARY_SQL.md`.
