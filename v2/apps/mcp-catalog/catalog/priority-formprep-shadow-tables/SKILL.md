---
name: priority-formprep-shadow-tables
description: >
  Create pritempdb T$$ shadow tables before Form Prep, and treat EXECPREPLOCK
  UPD=N + LASTPREPDATE as the only success signal. Use when SQL 208 on prep,
  T$$ missing, or /priority-formprep-shadow-tables.
---

# Form Prep shadow tables

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-formprep-shadow-tables`).

Authority: `docs/skill-sources/programming/FORMPREP_SHADOW_TABLES.md`.

## Hard rules

1. New tables need `pritempdb.dbo.T$$<TNAME>` (+ `T$LINKID`) and CATALOG (`TNAME` ≤ 20).
2. Success only `ok` **and** EXECPREPLOCK `UPD=N` **and** LASTPREPDATE advanced — never fake UPD=N.
3. Prefer Named Form Prep / Web SDK; distrust agent WINRUN exit 0 without EXECPREPLOCK change; avoid `bin\formprep.exe` auth failures.

## Related

- Runner: **priority-formprep**
- After SQL trigger change: **priority-form-prep-after-sql-change**
