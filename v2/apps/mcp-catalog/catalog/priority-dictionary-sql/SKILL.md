---
name: priority-dictionary-sql
description: >
  Insert Priority dictionary rows (CATALOG, COLUMNS, T$EXEC, INDEXES, INDCLMNS,
  EXECMODULE, EXECPREPLOCK) with IDENTITY keys via SCOPE_IDENTITY. Use for SQL
  form/table bootstrap, name_missing on Form Prep, or /priority-dictionary-sql.
---

# Priority dictionary SQL (IDENTITY-safe)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-dictionary-sql`).

## Hard rules

1. Do not insert into identity columns: `CATALOG.T$TABLE`, `COLUMNS.T$COLUMN`, `T$EXEC.T$EXEC`, `INDEXES.T$KEY`.
2. Use `SCOPE_IDENTITY()` on the same batch/connection.
3. `COLUMNS` uses **`CNAME`**; `INDEXES` uses **`T$KEY`** (+ `INDCLMNS`).
4. `CATALOG` (CE DEV) columns: `TNAME`, `T$TABLE`, `SIZE` only.
5. Seed `EXECPREPLOCK` before Named Form Prep or reason=`name_missing`.
6. Link `EXECMODULE` (CE custom forms often MODULE=1).
7. Avoid `Tee-Object` inside PowerShell functions that return ids.
8. Physical unique indexes / PKs must use **`WITH (IGNORE_DUP_KEY = ON)`** or Tabula login fails (*Ignore Duplicate Values*; first company often reported as `system`). Same for `pritempdb` `T$$` shadows. Dedupe before CREATE if data already has duplicates.
9. Child join columns need **FORMCLMNSA** expressions (`= :$$.COL`) or Form Prep can rewrite FORMJOINS and raise Unique Index / Origin Table warnings.

## Related

`priority-formprep`, `priority-formprep-shadow-tables`, `priority-version-revision-discipline`.

Sources: `docs/skill-sources/programming/DICTIONARY_SQL.md`, `IGNORE_DUP_KEY.md`, `FORMCLMNSA_JOINS.md`.
