# FR-006: session metadata records where the login came from

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Session files say whether the login was client, saved, or flag.

## Deliverables

- session metadata JSON includes priorityUserLogin and userLoginSource.
- userLoginSource is client, saved, or flag.
- Hours routing file repeats the same login.

## Testable

- launcher.Tests reads session metadata and expects userLoginSource saved when Enter accepted the default.
- A --hours-user that matches whoami records flag.

## Out of scope

- Do not change the hours webhook field names.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #388
