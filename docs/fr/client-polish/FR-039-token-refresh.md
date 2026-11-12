# FR-039: refresh an expired access token once

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A refresh token avoids a manual MFA prompt when the provider accepts it.

## Deliverables

- When the access token is expired and refresh_token is present, POST once to the token endpoint already stored beside the token file (tokenUrl key).
- On 200, rewrite the token file in place, UTF-8 no BOM, and continue the verb.
- On failure, return token_expired and hint priority-saas-oidc-login.
- Never print refresh_token or access_token.
- Missing tokenUrl with a refresh_token returns token_expired without a network call.

## Testable

- Fake token endpoint 200: login sees the new access token.
- Fake 400: exit 3 and the old file body is unchanged.
- Stdout does not contain the fixture refresh token.

## Out of scope

- Do not implement the OIDC browser login.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #421
