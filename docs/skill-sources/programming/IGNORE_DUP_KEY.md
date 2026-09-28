# Priority SQL unique indexes: IGNORE_DUP_KEY = ON

Harvest 2026-09-28 from CE DEV Tabula login error (Day Works WP3).

## Tabula error

```
You have defined tables with unique indexes but have not allowed the
'Ignore Duplicate Values' option... The first table in which the problem
was encountered is 'system'.
```

`system` here is the **Priority company / SQL database name**, not a physical table. Scan `system`, `base`, and `pritempdb` (and any other companies Tabula opens).

## Rule

Every **unique** SQL Server index / PK that Priority owns must be created with:

```sql
WITH (IGNORE_DUP_KEY = ON)
```

Stock Priority indexes (e.g. `PART#1#PART`) use this. SSMS / bare `PRIMARY KEY` / `CREATE UNIQUE INDEX` defaults to OFF and Tabula rejects the company at login.

## Confirm

```sql
SELECT
    OBJECT_SCHEMA_NAME(i.object_id) AS schema_name,
    OBJECT_NAME(i.object_id)        AS table_name,
    i.name                          AS index_name,
    i.ignore_dup_key,
    i.is_primary_key
FROM sys.indexes i
JOIN sys.tables t ON t.object_id = i.object_id
WHERE i.is_unique = 1
  AND i.ignore_dup_key = 0
  AND i.index_id > 0
  AND t.is_ms_shipped = 0
ORDER BY table_name, index_name;
```

## Rebuild pattern

1. Backup.
2. If creating the unique index fails with duplicate-key error, **dedupe first** (`IGNORE_DUP_KEY` does not allow building over existing duplicates).
3. Drop the unique index / PK constraint.
4. Recreate with `WITH (IGNORE_DUP_KEY = ON)`.
5. Fully log out of Priority and log back in.

Apply the same rule to `pritempdb` `T$$` shadow unique indexes.

## Two different "Ignore Duplicate" concepts

| Context | Action |
|---------|--------|
| Physical unique index option `IGNORE_DUP_KEY` | **Must be ON** for Priority tables |
| Headed Form Prep dialog "Ignore Duplicate Values" | **Never click** (agent blocked-run); fix data / indexes instead |

## Related

- Child Unique / Origin Table: prefer Automatic (TYPE A) surrogate + FORMJOINS; see FORMCLMNSA join expressions below / Day Works `docs/fixes/logrem-unique-origin-20260928.md`.
- Shadows: `FORMPREP_SHADOW_TABLES.md`
- Dictionary: `DICTIONARY_SQL.md`
