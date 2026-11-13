# FR-010: machine-readable retry hint on login failures

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

fail() tells the agent whether to retry.

## Deliverables

- Add retryable on every fail() object.
- retryable is true only for login_connect.
- api_licence and token_expired keep a hint string and retryable false.

## Testable

- Unit test the classifier map for those three reasons.
- Stdout JSON parses and has boolean retryable.

## Out of scope

- Do not retry inside this FR (FR-40).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #392
