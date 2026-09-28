# Priority dictionary SQL (IDENTITY-safe)

CE DEV (`system` DB) harvest 2026-09-28 from Day Works WP3 bootstrap.

## Identity columns

| Table | Identity |
|-------|----------|
| CATALOG | `T$TABLE` |
| COLUMNS | `T$COLUMN` |
| T$EXEC | `T$EXEC` |
| INDEXES | `T$KEY` |

Insert without those columns; read `SCOPE_IDENTITY()`.

## Column name traps

- COLUMNS: **`CNAME`** (not NAME)
- INDEXES: **`T$KEY`** (not T$INDEX); children in **INDCLMNS** `(T$KEY, T$COLUMN, PRIO)`
- CATALOG live: `TNAME`, `T$TABLE`, `SIZE` only

## Form Prep bootstrap

1. Physical table + `pritempdb` `T$$` shadow
2. CATALOG + COLUMNS + INDEXES/INDCLMNS
3. T$EXEC TYPE=F + EXECMODULE (MODULE=1 for CE Internal Development)
4. **EXECPREPLOCK** row (UPD=Y, LASTPREPDATE=0) ÔÇö without it Prepare-NamedForm returns `name_missing`
5. Form Generator FCLMN paint
6. Named Form Prep ÔåÆ UPD=N and LASTPREPDATE advanced

## Physical unique indexes (SQL Server)

Priority / Tabula requires unique indexes with **`IGNORE_DUP_KEY = ON`**:

```sql
CREATE UNIQUE CLUSTERED INDEX [TNAME#1#COL]
ON dbo.TNAME (COL)
WITH (IGNORE_DUP_KEY = ON);
```

Bare SSMS PKs (option OFF) cause Tabula login: *Ignore Duplicate Values* — first company often reported as `system`. See `IGNORE_DUP_KEY.md`.

## Child form joins

Join columns need **FORMCLMNSA** expressions (`= :$$.COL`). Without them Form Prep can rewrite FORMJOINS and trigger Unique Index / Origin Table warnings. See `FORMCLMNSA_JOINS.md`.

## Shell DBI (Version Revision .sh)

```
DBI <<\EOF
CREATE TABLE ZCLA_EXAMPLE 'Title' 0
COL1(INT,13,'Label')
COL2(CHAR,64,'GUID')
UNIQUE(COL1,COL2)
;
EOF
```

After shell install / SQL CREATE, verify physical unique indexes have `ignore_dup_key = 1`. See CE `C:\Priority\system\upgrades\8311.sh` / Day Works `shells/8357.sh`.
