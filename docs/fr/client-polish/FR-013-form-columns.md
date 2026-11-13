# FR-013: form columns without reading rows

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent learns field names before a write.

## Deliverables

- form columns --form <ENAME> returns field names and types.
- Implementation must not call getRows.

## Testable

- Fake form with two columns; stdout has both names.
- getRows call count is 0.

## Out of scope

- Does not change form rows.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #395
