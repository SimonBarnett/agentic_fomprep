# FR-012: list companies for this login

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can see company names without a person typing one.

## Deliverables

- Verb companies --instance <id>, read-only.
- JSON {companies:[{name, title}]}.
- Does not require allowLive.

## Testable

- Fake SDK returns two companies; stdout lists both names.
- allowLive false still returns ok.

## Out of scope

- Do not switch the session company.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #394
