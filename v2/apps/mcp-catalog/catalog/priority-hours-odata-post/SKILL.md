---
name: priority-hours-odata-post
description: >-
  Post confirmed timesheet lines via OData TRANSORDER_q; PDES max 60; force FLAG N for non-billable; prefer over UI automation.
  Use when /priority-hours-odata-post or matching hours workflow trigger.
---

# Priority hours OData post

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-hours-odata-post`).

Authoritative harvest: `docs/skill-sources/hours/priority-hours-odata-post.md` (2026-09-24 Haitch).

# Priority hours — OData post (TRANSORDER)

**When:** Posting confirmed draft lines; prefer over UI automation.

## Auth / endpoint (config — do not hardcode secrets)

- Username: employee OData user (example: `SimonB`).
- Password: from secrets store (example env name `PRIORITY_ODATA_PASSWORD`) — never write secrets into skills or git.
- Live company OData may work while a DEV company returns 401 with the same credential — treat as separate allowlist rows.
- Entity set used in practice: **`TRANSORDER_q`** (confirm on the target instance; name can vary by version).

## Field discipline (learned)

- **PDES** (description): max **60** characters; truncate intelligently.
- Billable **FLAG**: force **N** for non-billable customers (examples: recording project `PR17000010`, other internal non-billable). Customer project (example `PR230001`) typically **Y** unless policy says otherwise.
- Date, project, WBS, hours must match the confirmed draft.
- Do not post until the human says to post.

## Loop

1. GET existing lines for employee+date (avoid duplicates).
2. POST each new line from the confirmed draft.
3. Re-GET and sum; expect 8.0h on a full weekday including Recording Hours.
4. Optionally verify with Less-than-8 report for the month.

## Do not

- Log passwords.
- Invent base URLs — use operator allowlist.
- Post agent jargon or WP codes in PDES.
