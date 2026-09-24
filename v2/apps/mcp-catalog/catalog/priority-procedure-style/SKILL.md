---
name: priority-procedure-style
description: >
  Write or edit Priority form triggers and SQLI procedures: required banners,
  Inputs/Outputs :VARs, debug includes, dedicated vs shared TRIG. Use when
  authoring triggers, #INCLUDE bodies, or /priority-procedure-style.
---

# Priority procedure style

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

## Related

- Form Prep / generator nav: **priority-form-engineering**
- UDATE mint: **priority-sql-udate-user**
