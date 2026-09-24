---
name: priority-hours-search-by-date-employee
description: >-
  F11 / month-wildcard search on Reports of Project Hrs/Expenses by date and employee; never Down into Tasks.
  Use when /priority-hours-search-by-date-employee or matching hours workflow trigger.
---

# Priority hours search by date and employee

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-hours-search-by-date-employee`).

Authoritative harvest: `docs/skill-sources/hours/priority-hours-search-by-date-employee.md` (2026-09-24 Haitch).

# Priority hours — search by date and employee

**Form:** Reports of Project Hrs/Expenses (name varies by localisation).

## Day search (F11)

1. Open Reports of Project Hrs/Expenses.
2. F11 or magnifying glass.
3. Date: type **DDMMYY** (six digits, no separators) — Priority accepts this in the date finder.
4. **Right Arrow** to Employee (never Down into Tasks).
5. Type a name fragment; Enter to accept autocomplete; Enter again to run search.

## Month search

1. F11 on the same form.
2. Date: `??/MM/YY` (e.g. `??/09/26` for all days in Sep 2026).
3. Tab to Employee; type fragment; Enter to search.

## Notes

- Confirm the employee id/name from config (example Medatech: `SimonB`).
- Empty result for a weekday usually means nothing booked yet — draft from calendar/agents.
- Do not invent rows while searching; entry is a separate skill.
