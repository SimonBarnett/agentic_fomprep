# FR-027: read procedure body

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can read a procedure without a write.

## Deliverables

- proc text --name <ENAME> returns {name, body}.
- Read-only. allowLive is not required.
- Missing body returns reason proc_text_missing and exit 2.

## Testable

- Fake EXEC row returns the fixture body.
- Empty body exits 2.
- Stdout has no token.

## Out of scope

- Write is FR-28.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #409
