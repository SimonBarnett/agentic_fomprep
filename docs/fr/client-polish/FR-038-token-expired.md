# FR-038: refuse an expired access token before login

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

An expired token fails closed without a SaaS call.

## Deliverables

- If expires_at is in the past, or obtained_at plus expires_in is in the past, return reason token_expired, retryable false, exit 3.
- Do not call login.
- A token with no expiry still attempts login (today's behaviour).

## Testable

- Fixture expires_at in the past: login count 0.
- Fixture expiry in the future: login is attempted on the fake.

## Out of scope

- Refresh is FR-39.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #420
