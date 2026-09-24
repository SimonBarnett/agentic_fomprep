---
name: priority-hours-export-excel
description: >-
  Export Reports of Project Hrs/Expenses search results to Excel with No Template.
  Use when /priority-hours-export-excel or matching hours workflow trigger.
---

# Priority hours export to Excel

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-hours-export-excel`).

Authoritative harvest: `docs/skill-sources/hours/priority-hours-export-excel.md` (2026-09-24 Haitch).

# Priority hours — export search results to Excel

**When:** Need a spreadsheet of booked Reports of Project Hrs/Expenses rows (day or month search already on screen).

## Steps

1. Run the search skill so results are visible.
2. Export / Download as Spreadsheet with **No Template** (avoid styled templates that drop columns).
3. Save under the operator’s agreed report root; do not commit exports with personal data to git.

## Notes

- Prefer this for human review; prefer OData query for agent reconciliation when available.
