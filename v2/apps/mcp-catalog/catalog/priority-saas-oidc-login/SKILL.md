---
name: priority-saas-oidc-login
description: >
  Log into Priority Cloud / SaaS WebUI with OIDC (priority-web PKCE) and Accounts
  email MFA. Use when the user says SaaS login, cloud login, checkPassword,
  Accounts MFA, webui Bearer token, ssoTenant, or /priority-saas-oidc-login.
---

# Priority SaaS OIDC + Accounts MFA login

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Long form: `docs/skill-sources/programming/SAAS_OIDC_LOGIN.md`.
Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp`
(`get_skill` with `name=priority-saas-oidc-login`).

## When

Need a **Bearer access token** for Priority SaaS (`p.priority-connect.online` /
regional hosts) and only a Tabula user + password (email MFA) is available.
Applies to **any** SaaS tenant - not one customer.

## Hard rules

1. Never invent host or tenant. Operator allowlists / local connections file only.
2. Never commit or log passwords, OTPs, cookies, or tokens. Store under
   `C:\passwords\` (or CredMan), outside git.
3. OTP (`POST .../mfa/checkotp`) is **single-use**. Save the full JSON `redirect`
   and finish consent + `/auth/oauth2/token` in the same script.
4. Prefer PAT Basic (`token`/`PAT`) for unattended OData (`priority-odata-dev`).
5. Live writes only with explicit operator approval of the exact change.
6. Empty OData HTTP **500** on guessed DNAMEs: stop inventing company segments.

## Loop

1. **Tenant probe (no auth):** `POST https://<host>/webui/<tenant>` -> read
   `wcf`, `authority`, `_tabulaini=` inside `priorityParams` (often
   `tab<tenant>.ini`, not `tabula.ini`).
2. **Authorize (PKCE S256):** `client_id=priority-web`,
   `redirect_uri=https://<host>/webui`, `scope=openid wcf_api`,
   `audience=wcf_api`, `prompt=login`, `ssoTenant=<tenant>`.
   Join query params with `&` via ordered map (spaces break Hydra).
3. **Password:** on `/accounts/login`, POST
   `/accounts/login/checkPassword` with headers `csrf-token` + `challenge`
   from HTML meta; body `{"email","password"}`; header `lang: 3`.
4. **MFA:** when `step=verify_email`, wait for operator OTP; POST
   `/accounts/mfa/checkotp` with `{"totp":"<code>"}`.
5. **Redirects:** `HttpClient` with `AllowAutoRedirect=false` + browser
   `User-Agent`; consent GET often 302s through; capture `code` on `/webui?code=...`.
6. **Token:** `POST /auth/oauth2/token` with `authorization_code` +
   `code_verifier`. Persist tokens outside the repo.
7. **Smoke:** `POST /webui/<tenant>` with Bearer returns tenant JSON; then
   OData/WCF only with known DNAME / PAT / licence.

## Gotchas

| Symptom | Cause / fix |
|---------|-------------|
| `invalid_client` on authorize | Malformed query (spaces instead of `&`) or wrong client |
| `redirect_uri` mismatch | Must be exactly `https://<host>/webui` for `priority-web` |
| OData Basic 401 with Tabula password | Normal on many SaaS tenants; use Bearer or PAT |
| OData Bearer **500** empty body | Wrong DNAME and/or API licence - do not keep guessing |
| checkotp HTTP 435 | OTP already used or session stale; re-run checkPassword |
| CloudFront 403 on consent | Send a normal browser User-Agent |
| `MaximumRedirectExceeded` | Use HttpClient AllowAutoRedirect=false |
| Truncated redirect URL | Loses login_verifier; cannot continue without new OTP |
| `service.svc/formStart` 404 | SaaS WCF shape may differ; not proof auth failed |

## Success

`access_token` obtained; tenant POST with Bearer returns `wcf` + tabulaini;
tokens only on the local secrets path.

## Do not

- Commit secrets or paste tokens into PRs / hours / IRC
- Treat MCP public client ids (`priority-mcp-setup`) as the WebUI client
- Assume on-prem `tabula.ini` on SaaS

## Related

- Long form: `docs/skill-sources/programming/SAAS_OIDC_LOGIN.md`
- OData / PAT: `priority-odata-dev`, `ODATA_REST_CLOUD.md`
- MCP: `priority-mcp-setup`
- WCF UAT after session: `priority-uat-wcf`
