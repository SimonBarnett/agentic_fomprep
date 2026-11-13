# FR-045: launcher rules show whoami and the saved-user prompt

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent instructions match the client.

## Deliverables

- WcfSupport.RenderSessionRules example uses whoami and --request.
- The section states that an empty Priority USERLOGIN answer accepts the saved login.
- It does not say that no default login is used.

## Testable

- launcher.Tests renders the section and expects whoami.
- The rendered section does not contain the sentence No default login is used.

## Out of scope

- Does not change hours webhook fields.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #427
