# FR-028: write procedure body through the form

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can replace a procedure body when writes are allowed.

## Deliverables

- proc text set --name <ENAME> --file <path>.
- allowLive false returns before login with live_refused.
- The write goes through the procedure form, not a raw SQL string from the agent.

## Testable

- allowLive false: login count 0.
- allowLive true: fake form receives the file text once.

## Out of scope

- Does not prepare the procedure.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #410
