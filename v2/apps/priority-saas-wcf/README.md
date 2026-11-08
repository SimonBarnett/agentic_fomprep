# Priority SaaS WCF client

Allowlist-gated **priority-web-sdk** client for **Priority Cloud / SaaS**.
Used by PriorityAgent after an OIDC Bearer token exists (`priority-saas-oidc-login`).

## Auth (Phase 1)

1. Obtain tokens with skill `priority-saas-oidc-login` (PKCE + MFA).
2. Store under `C:\passwords\<id>-oauth-tokens.json` (outside git):

```json
{ "access_token": "...", "refresh_token": "...", "expires_at": "..." }
```

3. Or set env `PRIORITY_SAAS_TOKEN` for the process only.

The Web SDK `login({ accessToken })` sends that token as the WCF UsernameToken password.

## Allowlist-gated

Local file (default `%USERPROFILE%\.priority-saas-wcf\instances.json`, override
`PRIORITY_SAAS_WCF_INSTANCES` or `--instances`):

```json
{
  "instances": [
    {
      "id": "customer-saas-dev",
      "host": "p.priority-connect.online",
      "tenant": "<tenant>",
      "company": "<DNAME>",
      "user": "<user>",
      "tokenFile": "C:\\passwords\\customer-saas-oauth-tokens.json",
      "language": 3,
      "allowLive": false
    }
  ]
}
```

Copy from `instances.example.json`. Never put passwords or tokens in the allowlist.
Unknown / missing instance → exit 2, no SaaS call.

## Install

```powershell
cd v2\apps\priority-saas-wcf
npm ci
```

## CLI

```powershell
node bin\priority-wcf.mjs probe   --instance customer-saas-dev
node bin\priority-wcf.mjs session --instance customer-saas-dev
node bin\priority-wcf.mjs session --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form start --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form rows  --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form set   --instance customer-saas-dev --form CUSTOMERS --filter "{\"field\":\"CUSTNAME\",\"fromval\":\"X\"}" --fields "{\"EMAIL\":\"a@b.c\"}"
node bin\priority-wcf.mjs form save  --instance customer-saas-dev --form CUSTOMERS --filter "..." --fields "{...}"
```

Writes (`form set` / `form save`) require `allowLive: true` on the row (and operator approval).

`prepare` / `proc` verbs are Phase 2 (not implemented yet).

## CAST IRON

- Never invent host, tenant, company DNAME, or WCF URL.
- Never log or commit tokens / passwords / OTPs.
- SaaS REST `formStart` 404 is not proof auth failed; use this Web SDK path.
- OIDC MFA stays in `priority-saas-oidc-login`; this client only consumes the token.

## Tests

```powershell
npm test
```

## Related

- Skill: `priority-saas-wcf` (catalog + `.grok/skills` after sync)
- OIDC: `priority-saas-oidc-login`, `docs/skill-sources/programming/SAAS_OIDC_LOGIN.md`
- On-prem password formprep: `src/Prepare-NamedForm.ps1` (unchanged)
- airc Priority verbs: bobiverse `airc/priority-worker` (fleet console; CredMan on-prem)
