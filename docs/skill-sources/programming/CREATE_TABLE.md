# Priority: create tables properly (physical + dictionary)

Harvest 2026-10-08 after Form Generator **Table X is missing column Y** and
Tabula **Ignore Duplicate Values** on a SQL-bootstrapped custom table.

## CAST IRON rules

### 1. Unique indexes: `IGNORE_DUP_KEY = ON`

Never create a bare SQL Server `PRIMARY KEY` / unique index with
`IGNORE_DUP_KEY` off for Priority business tables.

```sql
CREATE TABLE dbo.ZCLA_EXAMPLE (
  EDITID bigint NOT NULL,
  GUID nvarchar(64) NOT NULL
  -- no CONSTRAINT PRIMARY KEY here
);
CREATE UNIQUE CLUSTERED INDEX [ZCLA_EXAMPLE#1#EDITID#GUID]
  ON dbo.ZCLA_EXAMPLE (EDITID, GUID)
  WITH (IGNORE_DUP_KEY = ON);
```

Name pattern: `TABLE#1#COL1#COL2...` (Tabula style). Same rule for
`pritempdb` `T$$` shadows when they have unique keys.

Symptom if wrong: Tabula reports *You have defined tables with unique
indexes but have not allowed the "Ignore Duplicate Values" option* and
names the first bad table.

### 2. `COLUMNS.SIZE` must never be 0

Form Generator symptom when CHAR `SIZE=0`: **Table T is missing column C**
even though `COLUMNS.CNAME` and the physical column both exist.

| TYPE | WIDTH | SIZE |
|------|-------|------|
| CHAR / DATE / TIME / DAY | display width | **SIZE = WIDTH** |
| REAL | display width (often 16) | **8** |
| INT | display width (often 13/17) | **8** |

```sql
INSERT INTO COLUMNS ([T$TABLE], POS, CNAME, TYPE, WIDTH, SIZE, TITLE)
VALUES (@tab, 2, N'GUID', N'CHAR', 64, 64, N'GUID');  -- SIZE=64 not 0
```

### 3. Dictionary insert order (IDENTITY-safe)

See `DICTIONARY_SQL.md`. Short path:

1. Physical table + unique index (`IGNORE_DUP_KEY=ON`)
2. `T$$` shadow in `pritempdb`
3. `CATALOG` -> `COLUMNS` (correct SIZE) -> `INDEXES` / `INDCLMNS`
4. `T$EXEC` TYPE=F -> `EXECMODULE` -> `EXECPREPLOCK`
5. FORMLINKS / FORMJOINS / FORMCLMNSA as needed
6. Form Generator FCLMN paint -> Named Form Prep -> `UPD=N`

### 4. Prefer shell DBI `CREATE TABLE` + Prepare Upgrade

Hand SQL bootstrap is a DEV bridge. Ship via Version Revision TAKE* /
Prepare-emitted DBI when possible (`VERSION_REVISION.md`).

## Heal existing bad table

```sql
-- Physical
ALTER TABLE dbo.T DROP CONSTRAINT PK_T;  -- if bare PK
CREATE UNIQUE CLUSTERED INDEX [T#1#COL...]
  ON dbo.T (...) WITH (IGNORE_DUP_KEY = ON);

-- Dictionary SIZE
UPDATE COLUMNS SET SIZE = CASE
  WHEN TYPE IN (N'CHAR',N'DATE',N'TIME',N'DAY') THEN WIDTH
  WHEN TYPE IN (N'REAL',N'INT') THEN 8
  ELSE SIZE END
WHERE [T$TABLE] = (SELECT [T$TABLE] FROM CATALOG WHERE TNAME=N'T');
```

Then **fully log out of Priority and log back in** before Form Generator.

## Assert gates

- Unique index on table: `is_unique=1` and `ignore_dup_key=1`
- No `COLUMNS` row with `SIZE=0`
- CHAR/DATE: `SIZE=WIDTH`; REAL/INT: `SIZE=8`
