---
name: priority-create-table
description: >
  Create Priority custom tables the Tabula-safe way: physical CREATE + unique
  index IGNORE_DUP_KEY=ON, COLUMNS.SIZE never 0 (CHAR SIZE=WIDTH; REAL/INT=8),
  then CATALOG/INDEXES/T$EXEC bootstrap. Use when Form Generator says "Table X
  is missing column Y", Ignore Duplicate Values names a new table, SQL table
  bootstrap, or /priority-create-table.
github: https://github.com/SimonBarnett/agentic_fomprep
---

# Priority create table (Tabula-safe)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. Unique indexes: `CREATE UNIQUE CLUSTERED INDEX [T#1#COL…] … WITH (IGNORE_DUP_KEY = ON)`. Never bare PK with dup-key off.
2. `COLUMNS.SIZE` never 0: CHAR/DATE `SIZE=WIDTH`; REAL/INT `SIZE=8`.
3. "Missing column" in Form Generator with a dictionary row present → fix SIZE, then log out/in.
4. "Ignore Duplicate Values" naming table T → rebuild that table's unique index with ON.
5. Then dictionary bootstrap via `priority-dictionary-sql`; paint; Form Prep.

Authoritative body: `docs/skill-sources/programming/CREATE_TABLE.md`.
