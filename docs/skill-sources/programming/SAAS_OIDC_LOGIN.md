# Priority SaaS / Cloud - OIDC + Accounts MFA login (generic)

Authoritative companion to catalog skill `priority-saas-oidc-login`.
Harvested 2026-10-25; extended 2026-10-26. Customer tenants and emails are
**examples only** - never commit passwords, OTPs, or tokens.

Use this when an agent must obtain a **Bearer access token** for Priority
SaaS WebUI / WCF / cloud APIs and only Tabula user + password (often with
email MFA) is available. Prefer a **PAT** (`token` / `PAT`) for OData when
one exists - see `ODATA_REST_CLOUD.md`.

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
| `wcf` | WCF service URL (e.g. `.../wcf/service.svc`) |
| `server` | Cloud fabric label (e.g. `AWS_PROD`) |
| `h5client` | Static client CDN base |
| `admode` | Auth mode (OIDC when non-zero / interactive) |
| `authority` | OIDC issuer (usually `https://<host>/auth/`) |
| `priorityParams` | Query bag; includes `_tabulaini=tab....ini` |

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

### PowerShell: join query params with `&`

PowerShell can stringify arrays with **spaces** if `-join` binds wrong.
Build with an ordered map, then join:

```powershell
$params = [ordered]@{
  client_id = 'priority-web'
  redirect_uri = "https://$host/webui"
  response_type = 'code'
  scope = 'openid wcf_api'
  # ... state, nonce, code_challenge, code_challenge_method, audience, prompt, ssoTenant
}
$q = ($params.GetEnumerator() | ForEach-Object {
  '{0}={1}' -f $_.Key, [uri]::EscapeDataString([string]$_.Value)
}) -join '&'
$authUrl = "https://$host/auth/oauth2/auth?$q"
```

Spaces instead of `&` yield Hydra `invalid_client` / `invalid_request`.

## Accounts login + MFA

1. `GET` authorize URL -> 302/200 to
   `https://<host>/accounts/login?login_challenge=...`
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

Success returns JSON `{"redirect":"https://<host>/auth/oauth2/auth?...login_verifier=..."}`.

**Save the full `redirect` string to disk immediately** (long URL). Truncating
it in logs loses the login; OTP cannot be replayed (HTTP **435**).

## Finish OAuth (consent + code)

Do **not** rely on `Invoke-WebRequest -MaximumRedirection 0` alone - it can
still throw `MaximumRedirectExceeded` without a usable Location. Prefer
`HttpClientHandler { AllowAutoRedirect = $false }` and read `Location` yourself.

Always send a normal browser `User-Agent`. CloudFront may return **403**
("Request blocked") without one.

Typical path:

1. `login_verifier` authorize URL -> 302 `/accounts/consent?consent_challenge=...`
2. Consent **GET** with browser UA often **302**s back into `/auth/oauth2/auth?...`
   (no separate accept API required in the observed path)
3. Final 303/302 to `https://<host>/webui?code=ory_ac_...&scope=...&state=...`

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

### OData after OIDC

Try:

```text
https://<host>/odata/Priority/<tabulaini>/$metadata
Authorization: Bearer <access_token>
```

Company segment is still **DNAME** (`.../<tabulaini>/<DNAME>/...`).

| Result | Meaning |
|--------|---------|
| 401 with Tabula Basic | Common on SaaS; use Bearer or PAT |
| **500 empty JSON body** with Bearer on guessed DNAMEs | Often **wrong DNAME** and/or **API module / licence** - stop guessing; get DNAME from operator or USERENV; prefer PAT |
| 200 `$metadata` | Proceed; still audit FORMLIMITED RESTFLAG |

Unauthenticated `.../<tabulaini>/$metadata` returning **401** only proves the
OData front door exists.

### WCF note

`POST .../wcf/service.svc/formStart` style REST paths may return **404** on
SaaS even when tenant JSON lists that `wcf` URL. Do not treat that as proof
WCF is down - transport/shape may differ from on-prem web-sdk examples.

## Connectivity checklist (before login)

| Check | Expect |
|-------|--------|
| DNS / TCP 443 to host | OK |
| `GET /webui/<tenant>` | 200 HTML shell |
| `POST /webui/<tenant>` | 200 JSON with `wcf` + `_tabulaini` |
| `GET .../odata/Priority/<tabulaini>/$metadata` unauthenticated | 401 (endpoint exists) |

## Hard rules

1. Never invent host or tenant; take them from the operator / connections file.
2. Never commit passwords, OTPs, cookies, or tokens.
3. OTP is single-use; complete redirect + token exchange in the **same** script.
4. Prefer DEV / test SaaS hosts for writes; Live only with explicit approval.
5. Prefer PAT for unattended OData; OIDC+MFA is for interactive agent sessions.
6. **FR #226:** After **N** empty HTTP **500** bodies on
   `/odata/Priority/<tabulaini>/<guessed-company>/...` (default N=2,
   env `PRIORITY_ODATA_EMPTY_500_MAX`), **stop inventing DNAMEs**. Confirm
   company DNAME and API licence or PAT with the operator. Helper:
   `Register-ODataEmpty500Probe` / `Assert-ODataCompanyProbeAllowed` in
   `priority-odata-dev` runner `lib/odata.ps1`.

## Related

- `ODATA_REST_CLOUD.md` / `priority-odata-dev` - OData base, PAT, RESTFLAG
- `priority-mcp-setup` - MCP PAT / OAuth public clients (different client ids)
- `priority-uat-wcf` - WCF form walking after you have a session
