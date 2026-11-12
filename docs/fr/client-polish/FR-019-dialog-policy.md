# FR-019: do not auto-confirm error dialogs

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Error dialogs stay visible to the agent unless it opts in.

## Deliverables

- messageHandler does not call errorConfirm unless --confirm-errors is set.
- warningConfirm and infoMsgConfirm stay as they are today.

## Testable

- Fake message type error: errorConfirm count 0 by default.
- With --confirm-errors, errorConfirm count 1.

## Out of scope

- Does not change proc message steps.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #401
