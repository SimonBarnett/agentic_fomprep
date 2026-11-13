# FR-032: dictionary titles longer than 20 characters are refused

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

WINDBI titles stay within 20 characters.

## Deliverables

- Any dictionary title write checks title length before the call.
- Longer than 20 returns reason title_too_long, exit 2, and does not call the SDK.
- 20 characters is accepted by the checker.

## Testable

- Unit test: 21-character title exits 2 with login count 0.
- 20-character title passes the checker.

## Out of scope

- Does not add a column by itself (FR-33).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #414
