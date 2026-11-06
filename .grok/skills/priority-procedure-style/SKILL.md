---
name: priority-procedure-style
description: >
  Write or edit Priority form triggers and SQLI procedures: required banners,
  Inputs/Outputs :VARs, debug includes, dedicated vs shared TRIG, '' vs '\0'
  strings, PROGPARAM/:$.NAME, GOTO vs LOOP. Use when authoring triggers,
  #INCLUDE bodies, or /priority-procedure-style.
---

# Priority procedure style

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-procedure-style`).

Authority: `docs/skill-sources/programming/PROCEDURE_STYLE.md`.

## When

Authoring or heavily editing form triggers, SQLI procedures, or #INCLUDE bodies.

## Hard rules

1. Banner with name + one-line purpose; `/* Inputs */` / `/* Outputs */` listing `:VAR`s; Heading / Sub-heading sections.
2. Update headers on existing stack triggers you touch.
3. Debug: site debug `#INCLUDE`; set `:RUN_BY` before includes; gate on `:DEBUG=1` → `:DEBUGFILE`.
4. Prefer **dedicated** TRIG ids; do not overwrite shared POST-FORM used by siblings.
5. Customer prefix; copy vendor — do not edit vendor in place.
6. **One type per `:VAR` name.** Form Prep error `Variable with two different types : X` means `:X` was used as CHAR and INT/REAL in the same compile unit. Rename (e.g. CHAR `:DWFIXSORT` vs numeric `:SORT`). See `PROCEDURE_STYLE.md`.
7. **`FORMTRIGTEXT` / `PROGRAMSTEXT` max ~68 chars per line.** Split long SQL; truncated INTO lists break runtime after a clean Prepare.
8. **Multi-char strings use `''`, not `'\0'`.** `:VAR = '\0'` is a one-char boolean (Y/`\0`). Init and compare work-order / part / status strings with `''`.
9. **Declare PROGPARAM on every step that reads `:$.NAME`** (INPUT and SQLI). When converting INPUT to plain CHAR params, clear leftover INPUT `PROGRAMSTEXT` (old LINK/ERRMSG).
10. **`GOTO` forward only; `LOOP` for backward** jumps to an earlier LABEL.
11. **Report work tables:** prefer `T$TABLE` / `REPTABLES` without SQLI `LINK` / report `FILE` PROGPARAM. Orphan FILE params cause the system *file links* message (not your TRIGMSG).
12. When editing report expressions, clear **`REPCLMNSA.EXPR`** as well as `REPCLMNSTEXT`.

## Related

- Form Prep / generator nav: **priority-form-engineering**
- Msg 154 / `:$1` optimistic lock: `docs/skill-sources/programming/MSG154_OPTIMISTIC_LOCK.md`
- UDATE mint: **priority-sql-udate-user**
- Form Prep WCF: **priority-formprep**
- Report zooms: **priority-report-form-zooms**

## SQLI custom columns

Do not name custom queue/work columns `PART`/`SERIAL`/`SERN` — clash with entities/:VARs. Use `QPART`-style names. See `PROCEDURE_STYLE.md`.
