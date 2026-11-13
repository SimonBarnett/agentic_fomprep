# FR-001: whoami returns the Priority USERLOGIN

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

priority-wcf whoami prints the Priority USERLOGIN for the allowlisted instance.

## Deliverables

- Add verb whoami --instance <id>.
- Read USERLOGIN from the login result when the SDK exposes it.
- Otherwise read one USERS row filtered by the allowlist user.
- Stdout JSON is {ok, userLogin, source} where source is login or users.
- On failure return reason user_unidentified and do not use the OS user.
- Stdout must not contain the access token.

## Testable

- Fake SDK test: login result userLogin MEDATECH yields source login.
- Fake SDK test: empty login profile plus one USERS row yields source users.
- Fake SDK test: neither source yields user_unidentified and exit 3.
- A fixture token string in the session is absent from stdout.

## Out of scope

- Do not write last-user.json (FR-02). Do not change the launcher prompt (FR-03).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #383
