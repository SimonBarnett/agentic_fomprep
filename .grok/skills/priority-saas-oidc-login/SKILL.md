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
Applies to **any** SaaS tenant — not one customer.

## Hard rules

1. Never invent host or tenant. Operator allowlists / local connections file only.
2. Never commit or log passwords, OTPs, cookies, or tokens. Store under
   `C:\passwords\` (or CredMan), outside git.
3. OTP (`POST …/mfa/checkotp`) is **single-use**. Save the full JSON `redirect`
   and finish consent + `/auth/oauth2/token` in the same script.
4. Prefer PAT Basic (`token`/`PAT`) for unattended OData (`priority-odata-dev`).
5. Live writes only with explicit operator approval of the exact change.
6. **FR #226:** After N empty HTTP 500 bodies on guessed OData company/DNAME
   paths (default 2; `PRIORITY_ODATA_EMPTY_500_MAX`), stop inventing DNAMEs.
   Confirm DNAME and API licence or PAT. Use
   `Assert-ODataCompanyProbeAllowed` from `priority-odata-dev` `lib/odata.ps1`.

## Loop

1. **Tenant probe (no auth):** `POST https://<host>/webui/<tenant>` → read
   `wcf`, `authority`, `_tabulaini=` inside `priorityParams` (often
   `tab<tenant>.ini`, not `tabula.ini`).
2. **Authorize (PKCE S256):** `client_id=priority-web`,
   `redirect_uri=https://<host>/webui`, `scope=openid wcf_api`,
   `audience=wcf_api`, `prompt=login`, `ssoTenant=<tenant>`.
   Join query params with `&` (spaces break Hydra).
3. **Password:** on `/accounts/login`, POST
   `/accounts/login/checkPassword` with headers `csrf-token` + `challenge`
   from HTML meta; body `{"email","password"}`; header `lang: 3`.
4. **MFA:** when `step=verify_email`, wait for operator OTP; POST
   `/accounts/mfa/checkotp` with `{"totp":"<code>"}`.
5. **Redirects:** follow with browser `User-Agent` and no auto-redirect;
   pass `/accounts/consent`; capture `code` on `/webui?code=…`.
6. **Token:** `POST /auth/oauth2/token` with `authorization_code` +
   `code_verifier`. Persist tokens outside the repo.
7. **Smoke:** `POST /webui/<tenant>` with `Authorization: Bearer …` returns
   tenant JSON; then OData/WCF as licensed.

## Gotchas

| Symptom | Cause / fix |
|---------|-------------|
| `invalid_client` on authorize | Malformed query (spaces instead of `&`) or wrong client |
| `redirect_uri` mismatch | Must be exactly `https://<host>/webui` for `priority-web` |
| OData Basic 401 with Tabula password | Normal on many SaaS tenants; use Bearer or PAT |
| checkotp HTTP 435 | OTP already used or session stale; re-run checkPassword |
| CloudFront 403 on consent | Send a normal browser User-Agent |
| Truncated redirect URL | Loses login_verifier; cannot continue without new OTP |
| OData empty HTTP 500 on company guesses | Unknown DNAME and/or no API licence; stop after N empties (FR #226) |

## Success

`access_token` obtained; tenant POST with Bearer returns `wcf` + tabulaini;
tokens only on the local secrets path.

## Do not

- Commit secrets or paste tokens into PRs / hours / IRC
- Treat MCP public client ids (`priority-mcp-setup`) as the WebUI client
- Assume on-prem `tabula.ini` on SaaS
- Invent OData company/DNAME after empty HTTP 500s (FR #226)

## Related

- Long form: `docs/skill-sources/programming/SAAS_OIDC_LOGIN.md`
- OData / PAT: `priority-odata-dev`, `ODATA_REST_CLOUD.md`
- MCP: `priority-mcp-setup`
- WCF UAT after session: `priority-uat-wcf`
