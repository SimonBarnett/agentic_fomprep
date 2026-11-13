# FR-037: update one interface mapping row

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can set one mapping when writes are allowed.

## Deliverables

- interface map set --name <ENAME> --fields-file <path>.
- allowLive false: live_refused before login.
- allowLive true: one field update on the mapping row.

## Testable

- allowLive false: login count 0.
- allowLive true: fake update count 1.

## Out of scope

- Does not prepare the interface (FR-29).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #419
