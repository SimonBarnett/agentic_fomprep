# FR-004: non-interactive launch uses the saved USERLOGIN

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A redirected console with a saved login does not fail for a missing prompt.

## Deliverables

- When Console.IsInputRedirected and a saved login exists, bind it and continue.
- When stdin is redirected and no saved login and no --hours-user, exit 2 with Priority USERLOGIN unavailable.
- Do not block on ReadLine.

## Testable

- launcher.Tests redirected stdin plus saved login exits the prompt step with that login.
- launcher.Tests redirected stdin and no file exits 2.

## Out of scope

- Do not start Grok in the unit test.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #386
