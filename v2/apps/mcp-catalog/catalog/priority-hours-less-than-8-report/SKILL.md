---
name: priority-hours-less-than-8-report
description: >-
  Run Less than 8 Rep Hours shortcut, Excel No Template; empty means all weekdays in range are full.
  Use when /priority-hours-less-than-8-report or matching hours workflow trigger.
---

# Priority less-than-8 report hours

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-hours-less-than-8-report`).

Authoritative harvest: `docs/skill-sources/hours/priority-hours-less-than-8-report.md` (2026-09-24 Haitch).

# Priority hours — Less than 8 Rep Hours report

**Purpose:** Find weekdays with under 8.0 booked report hours. Empty result means all days in range are full.

## Steps

1. From Priority **My Shortcuts**, open **Less than 8 Rep Hours** (exact title may vary).
2. Download as Spreadsheet (**No Template**).
3. Parameter Input: From = start of range (often start of month); To = end of range (often end of month).
4. Open Excel: short days list booked hours < 8.

## Success

- After filling a month, the report should be **empty** for that employee’s weekdays.
- Use as the post-entry verification check, not as the entry UI.
