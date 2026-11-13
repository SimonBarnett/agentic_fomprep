# FR-008: per-verb help text

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

help <verb> prints only that verb so the agent can read one screen.

## Deliverables

- help form, help prepare, help proc, help table, help interface, help report.
- Unknown verb exits 2.
- help form lists columns, rows, new, delete, action and does not list proc start.

## Testable

- Node test: spawn help form and assert stdout contains columns and not proc start.
- help nosuch exits 2.

## Out of scope

- Do not remove the top-level help summary.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #390
