# FR-043: form rows stops at a limit

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent does not pull an unbounded row set.

## Deliverables

- --limit N, default 50, maximum 500.
- Values above 500 exit 2 reason limit_too_high.
- The client stops after N rows.

## Testable

- Fake 1000-row form with --limit 10 returns 10.
- Omitted limit returns 50 from a long fake.
- --limit 501 exits 2.

## Out of scope

- Does not change form columns.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #425
