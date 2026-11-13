# FR-011: stable process exit codes

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can branch on the process exit code.

## Deliverables

- Exit 0 when ok is true.
- Exit 2 for usage, allowlist, and request_invalid.
- Exit 3 for login_failed, api_licence, login_connect, token_expired, user_unidentified.
- Exit 4 when a prepare walk finishes and the gate status is unavailable.
- Document the four codes in the client README.

## Testable

- Fake failures assert the four codes.
- README contains the strings exit 0, exit 2, exit 3, exit 4.

## Out of scope

- Do not change preparedClaim rules.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #393
