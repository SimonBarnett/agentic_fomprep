# Priority SaaS / Cloud — OIDC + Accounts MFA login (generic)

Authoritative companion to catalog skill `priority-saas-oidc-login`.
Harvested 2026-10-25 from Priority Cloud (AWS) WebUI OIDC work. Customer
tenants and emails are **examples only** — never commit passwords, OTPs, or
tokens.

Use this when an agent must obtain a **Bearer access token** for Priority
SaaS WebUI / WCF / cloud APIs and only Tabula user + password (often with
email MFA) is available. Prefer a **PAT** (`token` / `PAT`) for OData when
one exists — see `ODATA_REST_CLOUD.md`.

## Discover the tenant (no auth)

```http
POST https://<host>/webui/<tenant>
Accept: application/json
```

Example host: `p.priority-connect.online`. Tenant = last path segment of the
WebUI URL (`/webui/<tenant>`).

JSON fields that matter:

| Field | Meaning |
|-------|---------|
| `wcf` | WCF service URL (e.g. `…/wcf/service.svc`) |
| `server` | Cloud fabric label (e.g. `AWS_PROD`) |
| `h5client` | Static client CDN base |
| `admode` | Auth mode (OIDC when non-zero / interactive) |
| `authority` | OIDC issuer (usually `https://<host>/auth/`) |
| `priorityParams` | Query bag; includes `_tabulaini=tab….ini` |

**Tabula ini on SaaS is often `tab<tenant>.ini`**, not on-prem `tabula.ini`.
Parse `_tabulaini=` from `priorityParams` before calling OData.

## OIDC client (WebUI)

From WebUI bootstrap (`bootstrapWebUISys.js`):

| Setting | Value |
|---------|-------|
| `authority` | `https://<host>/auth/` |
| `client_id` | `priority-web` |
| `redirect_uri` | `https://<host>/webui` |
| `response_type` | `code` |
| `scope` | `openid wcf_api` |
| PKCE | S256 (`code_challenge` / `code_verifier`) |
| Extra | `audience=wcf_api`, `prompt=login`, `ssoTenant=<tenant>` |

Discovery: `GET https://<host>/auth/.well-known/openid-configuration`

Build the authorize URL with **proper `&` separators** (PowerShell array
stringification with spaces breaks Hydra and yields `invalid_client` /
`invalid_request`).

## Accounts login + MFA

1. `GET` authorize URL → 302/200 to  
   `https://<host>/accounts/login?login_challenge=…`
2. HTML meta tags on the SPA shell:
   - `csrf-token` (may be literal `Deprecated`)
   - `challenge` (login challenge blob)
3. Accounts XHR client base: `https://<host>/accounts/`  
   Default headers: `Content-Type: application/json`, `csrf-token`, `challenge`.
4. Password step:

```http
POST /accounts/login/checkPassword
Headers: csrf-token, challenge, lang: 3
Body: {"email":"<user>","password":"<password>"}
```

Success (MFA email):

```json
{"step":"verify_email","email":"<user>","supportedMethods":["email","reconfigure"]}
```

5. OTP step (single-use):

```http
POST /accounts/mfa/checkotp
Headers: csrf-token, challenge, lang: 3
Body: {"totp":"<digits>"}
```

Success returns JSON `{"redirect":"https://<host>/auth/oauth2/auth?…login_verifier=…"}`.

**Save the full `redirect` string immediately** (long URL). Truncating it
loses the login and the OTP cannot be replayed (HTTP **435** /
Unauthorized-style Accounts codes).

## Finish OAuth (consent + code)

Follow redirects with **`AllowAutoRedirect = false`** and a normal browser
`User-Agent`. CloudFront may return **403** without one.

Typical path:

1. `login_verifier` authorize URL → 302 `/accounts/consent?consent_challenge=…`
2. Consent GET often 302 back into `/auth/oauth2/auth?…`
3. Final 303/302 to `https://<host>/webui?code=ory_ac_…&scope=…&state=…`

Exchange:

```http
POST https://<host>/auth/oauth2/token
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code
&client_id=priority-web
&redirect_uri=https%3A%2F%2F<host>%2Fwebui
&code=<auth_code>
&code_verifier=<pkce_verifier>
```

Expect `access_token`, optional `refresh_token`, `expires_in` (~1800).

Store tokens **only** outside git (e.g. `C:\passwords\<customer>-oauth-tokens.json`).
Never echo them in chat, hours, PRs, or logs.

## Use the token

```http
POST https://<host>/webui/<tenant>
Authorization: Bearer <access_token>
```

Same Bearer for cloud APIs that accept OIDC. For OData, try:

```text
https://<host>/odata/Priority/<tabulaini>/$metadata
Authorization: Bearer <access_token>
```

Company segment is still **DNAME** when calling entity sets
(`…/<tabulaini>/<DNAME>/…`). Tabula user/password Basic often stays **401**
on SaaS even when OIDC works — use Bearer or PAT.

## Connectivity checklist (before login)

| Check | Expect |
|-------|--------|
| DNS / TCP 443 to host | OK |
| `GET /webui/<tenant>` | 200 HTML shell |
| `POST /webui/<tenant>` | 200 JSON with `wcf` + `_tabulaini` |
| `GET …/odata/Priority/<guess>/$metadata` unauthenticated | 401 (endpoint exists) |

## Hard rules

1. Never invent host or tenant; take them from the operator / connections file.
2. Never commit passwords, OTPs, cookies, or tokens.
3. OTP is single-use; complete redirect + token exchange in the **same** script.
4. Prefer DEV / test SaaS hosts for writes; Live only with explicit approval.
5. Prefer PAT for unattended OData; OIDC+MFA is for interactive agent sessions.

## Related

- `ODATA_REST_CLOUD.md` / `priority-odata-dev` — OData base, PAT, RESTFLAG
- `priority-mcp-setup` — MCP PAT / OAuth public clients (different client ids)
- `priority-uat-wcf` — WCF form walking after you have a session
