# FR-031: table exists is a read

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can check a table before create.

## Deliverables

- table exists --name <TABLE> returns {name, exists}.
- No write calls.

## Testable

- Fake hit: exists true.
- Fake miss: exists false and exit 0.

## Out of scope

- Create is FR-34.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #413
