# FR-017: run one named form activation

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can run a form action by name.

## Deliverables

- form action --form <ENAME> --name <activation>.
- Return the message list from the client message handler.
- allowLive true required. Refuse before login when false.

## Testable

- Fake test: activation SAVE is invoked once.
- allowLive false: login count 0.

## Out of scope

- Procedure walker is unchanged.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #399
