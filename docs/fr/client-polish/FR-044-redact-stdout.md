# FR-044: login errors do not echo bearer tokens

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A token that appears in an exception is stripped from stdout.

## Deliverables

- json-out redact removes strings that look like bearer tokens and the access_token assignment.
- Apply it on the login error path before emit.

## Testable

- Fixture error message containing Bearer FIXTURETOKEN is emitted without FIXTURETOKEN.
- The reason code login_failed remains.

## Out of scope

- Does not log the token file path contents.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #426
