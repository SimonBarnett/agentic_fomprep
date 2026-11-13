# FR-035: list interface names

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can list interfaces.

## Deliverables

- interface list returns {interfaces:[{name, title}]}.
- Read-only.

## Testable

- Fake catalog form returns two names.
- help interface stdout contains list.

## Out of scope

- Run is FR-36.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #417
