---
name: priority-dictionary-sql
description: >
  Insert Priority dictionary rows (CATALOG, COLUMNS, T$EXEC, INDEXES,
  INDCLMNS, EXECMODULE, EXECPREPLOCK) with IDENTITY keys via SCOPE_IDENTITY.
  Use when creating tables/forms in SQL, WP form bootstrap, name_missing on
  Form Prep, or /priority-dictionary-sql.
github: https://github.com/SimonBarnett/agentic_fomprep
---

# Priority dictionary SQL (IDENTITY-safe)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. **Do not supply identity columns** on insert: `CATALOG.T$TABLE`,
   `COLUMNS.T$COLUMN`, `T$EXEC.T$EXEC`, `INDEXES.T$KEY` are IDENTITY.
2. Capture ids with `SCOPE_IDENTITY()` on the same connection/batch.
3. `COLUMNS` key column name is **`CNAME`** (not `NAME`).
4. `INDEXES` key column is **`T$KEY`** (not `T$INDEX`). `INDCLMNS` links
   `(T$KEY, T$COLUMN, PRIO)`.
5. `CATALOG` live columns are `TNAME`, `T$TABLE`, `SIZE` only (no TITLE/EDES
   on CE DEV).
6. PowerShell helpers must not pipeline-log (`Tee-Object`) inside functions
   that `return` ids - logging pollutes the return as `Object[]`.
7. Physical unique indexes / PKs: **`WITH (IGNORE_DUP_KEY = ON)`** (Tabula).
   Same for `T$$` shadows. Dedupe before CREATE if needed.
8. Child joins need **FORMCLMNSA** `= :$$.COL` or Form Prep rewrites FORMJOINS.

## Minimal form bootstrap (after physical table + T$$)

1. `INSERT CATALOG (TNAME, SIZE) ...; SELECT SCOPE_IDENTITY()`
2. `INSERT COLUMNS (T$TABLE, POS, CNAME, TYPE, WIDTH, SIZE, TITLE) ...`
3. `INSERT INDEXES (T$TABLE, TYPE, PRIO) ...` then `INDCLMNS`
4. `INSERT T$EXEC (ENAME, TITLE, T$TABLE, TYPE, EDES, ...) ...` TYPE=`F`
5. `INSERT EXECMODULE (T$EXEC, MODULE)` - CE Day Works forms use **MODULE=1**
6. `INSERT EXECPREPLOCK (...) UPD='Y', LASTPREPDATE=0` - required before
   Named Form Prep (`Prepare-NamedForm` INNER JOINs lock; missing ->
   `reason=name_missing`)
7. FORMLINKS / FORMJOINS as needed
8. Form Generator FCLMN paint, then Named Form Prep -> UPD=N + LASTPREPDATE->

## Related

- Shadows: `priority-formprep-shadow-tables`
- Prep gate: `priority-formprep`
- Shells: `priority-version-revision-discipline`, `priority-shell-compile`
