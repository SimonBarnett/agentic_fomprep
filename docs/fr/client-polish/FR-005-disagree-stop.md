# FR-005: stop when the flag disagrees with whoami

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A launch flag that differs from the client-identified login does not start the agent.

## Deliverables

- After whoami, if --hours-user is set and differs, print both logins and exit 2.
- Do not call the Grok process.
- Do not overwrite last-user.json with the flag value.

## Testable

- launcher.Tests: flag OTHERUSER, whoami MEDATECH, exit 2, grok start count 0.
- last-user.json still contains MEDATECH.

## Out of scope

- A matching flag continues (covered by FR-03).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #387
