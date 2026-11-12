# FR-040: retry login_connect once

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A single connect failure is retried inside the client.

## Deliverables

- On reason login_connect, wait briefly and call login one more time.
- Second success returns ok.
- Two failures return login_connect with retryable true.
- api_licence is not retried.

## Testable

- Fake: first throw connect, second ok, result ok, login count 2.
- Fake: two connect throws, login count 2, exit 3.
- Fake api_licence: login count 1.

## Out of scope

- Do not loop more than once.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #422
