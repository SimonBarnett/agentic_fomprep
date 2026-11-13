# FR-016: delete one positioned row only with confirm

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A delete requires an explicit confirm flag.

## Deliverables

- form delete --form <ENAME> --filter --confirm.
- Without --confirm exit 2 reason confirm_required and do not call delete.
- allowLive false returns before login.

## Testable

- Fake test: missing confirm, delete count 0.
- With confirm and allowLive, delete count 1.

## Out of scope

- Does not add a row (FR-15).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #398
