# Priority SaaS WCF client

Allowlist-gated **priority-web-sdk** client for **Priority Cloud / SaaS**.
Used by PriorityAgent after an OIDC Bearer token exists (`priority-saas-oidc-login`).

## Auth (Phase 1)

1. Obtain tokens with skill `priority-saas-oidc-login` (PKCE + MFA).
2. Store under `C:\passwords\<id>-oauth-tokens.json` (outside git):

```json
{
  "access_token": "...",
  "refresh_token": "...",
  "expires_in": 1800,
  "obtained_at": "2026-11-08T18:00:00.000Z"
}
```

(`expires_at` ISO is also accepted. Write UTF-8 **without BOM** — PowerShell `Set-Content` BOM is stripped by the client but avoid it.)

3. Or set env `PRIORITY_SAAS_TOKEN` for the process only.

The Web SDK `login({ accessToken })` sends that token as the WCF UsernameToken password.
Login **url** is the tenant probe `wcf` value (`…/wcf/service.svc`), not the host alone.

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

### Process exit codes (FR-011)

| Code | When |
|------|------|
| exit 0 | `ok: true` |
| exit 2 | usage / allowlist / `request_invalid` (and other non-auth fails) |
| exit 3 | `login_failed`, `api_licence`, `login_connect`, `token_expired`, `user_unidentified` |
| exit 4 | prepare walk finished (`walkOk`) and gate `status` is `unavailable` |

Every `fail()` stdout object includes boolean `retryable` (true only for `login_connect`). `api_licence` and `token_expired` stay `retryable: false` with a `hint` string. This client does not retry.

## Install

```powershell
cd v2\apps\priority-saas-wcf
npm ci
```

## CLI

```powershell
node bin\priority-wcf.mjs help
node bin\priority-wcf.mjs help form
node bin\priority-wcf.mjs probe   --instance customer-saas-dev
node bin\priority-wcf.mjs session --instance customer-saas-dev
node bin\priority-wcf.mjs whoami  --instance customer-saas-dev
node bin\priority-wcf.mjs companies --instance customer-saas-dev
node bin\priority-wcf.mjs form start --instance customer-saas-dev --dry-run
node bin\priority-wcf.mjs session --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form start --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form columns --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form rows  --instance customer-saas-dev --form CUSTOMERS
node bin\priority-wcf.mjs form rows  --instance customer-saas-dev --form CUSTOMERS --filter "{\"field\":\"CUSTNAME\",\"fromval\":\"X\"}"
node bin\priority-wcf.mjs form set   --instance customer-saas-dev --form CUSTOMERS --filter "{\"field\":\"CUSTNAME\",\"fromval\":\"X\"}" --fields "{\"EMAIL\":\"a@b.c\"}"
node bin\priority-wcf.mjs form save  --instance customer-saas-dev --form CUSTOMERS --filter "..." --fields "{...}"
node bin\priority-wcf.mjs form subform --instance customer-saas-dev --form CUSTOMERS --subform CUSTPERSONNEL
node bin\priority-wcf.mjs form subform --instance customer-saas-dev --form CUSTOMERS --subform CUSTPERSONNEL --set --fields-file C:\temp\fields.json
# Prefer a UTF-8 request file on Windows (no shell quoting). File stays outside the repo.
# request.json example: { "form": "CUSTOMERS", "fields": { "EMAIL": "a@b.c" }, "filter": { "field": "CUSTNAME", "fromval": "X" } }
node bin\priority-wcf.mjs form set --instance customer-saas-dev --request C:\temp\request.json
```

`help` prints the top-level summary. `help <verb>` prints one screen for
`form`, `prepare`, `proc`, `table`, `interface`, or `report` (unknown topic exits 2).

`--confirm-errors` auto-dismisses SDK error dialogs. By default `messageHandler` does not call `errorConfirm` (warnings and info still auto-confirm). Proc walk is unchanged.

`--request <path>` reads UTF-8 JSON. Keys `fields`, `filter`, `inputs`, `name`, `form`, `subform`
override the matching CLI flags when present. Invalid JSON exits 2 with `reason: request_invalid`
before login. Do not copy request files into the repo.

`companies --instance <id>` is read-only JSON `{companies:[{name,title}]}` and does not require `allowLive`. It does not switch the session company.

`form rows --filter` (or request-file `filter`) calls SDK `setSearchFilter` once then `getRows` from 1. Missing filter is the unfiltered read. Writes stay on `form set` / `form save`.

`form subform --set --fields-file` field-updates the child only (`allowLive: true` required). Bare `form subform` (no `--set`) stays read-only.

Writes (`form set` / `form save` / `form action` / `form subform --set`) require `allowLive: true` on the row (and operator approval).
`form action --form <ENAME> --name <activation>` runs one named activation (e.g. SAVE) and returns the
message-handler list. `allowLive: false` is refused before login.

## Phase 2: prepare + proc

```powershell
node bin\priority-wcf.mjs prepare form --instance customer-saas-dev --name MYFORM
node bin\priority-wcf.mjs prepare procedure --instance customer-saas-dev --name MYPROC
node bin\priority-wcf.mjs prepare report --instance customer-saas-dev --name MYREP
node bin\priority-wcf.mjs proc start --instance customer-saas-dev --name SOMEPROC [--ptype P] [--inputs C:\temp\inputs.json] [--hint SOMEPROC]
node bin\priority-wcf.mjs report run --instance customer-saas-dev --name MYREP
node bin\priority-wcf.mjs proc continue --instance customer-saas-dev --from C:\temp\needs-input.json --option FIELD [--inputs C:\temp\inputs.json]
```

- Form prep: `EFORM` + `FORMPREPDRCT2`, then scrape `FORMPREPERRS`.
- Procedure/report prep: `EXEC` + `REPPREPDIRECT2`.
- `proc start --inputs <file>` is a UTF-8 JSON map passed as `inputValues` on the first `inputFields` step. Matching EditField names take file values; name-hint fill runs only for fields the file did not set. Option selection is unchanged.
- `proc start` and `prepare` JSON include `urls: string[]` from SDK `displayUrl` steps (`displayUrlOf`). Missing URLs are `[]`. The client does not download those URLs.
- `report run --name <ENAME>` is `procStart` with `ptype` R (does not prepare). JSON includes `urls: string[]` from displayUrl steps (`[]` when none).
- `proc continue --from <step.json> --option <field>` resumes after needs_input with that option field (does not auto-pick). Missing `--from` exits 2 before login. `--inputs` applies on the next `inputFields` step.
- `prepare` is a write (`allowLive: true` required).
- Ambiguous procedure `inputOptions` (more than one choice, none selected) returns `ok: false` `reason: needs_input` and the option list; the walker does not call `inputOptions`. A single option may still be taken. With `--out`, the step snapshot is written as `needs-input.json` (resume is FR-23).
- A finished `proc start` with zero `urls` and zero `errors` is `ok: true` `empty: true` (exit 0), not a failure. Blocker errors still return `ok: false`. This does not change the prepare OData gate.


## CAST IRON

- Never invent host, tenant, company DNAME, or WCF URL.
- Never log or commit tokens / passwords / OTPs.
- SaaS REST `formStart` 404 is not proof auth failed; use this Web SDK path.
- OIDC MFA stays in `priority-saas-oidc-login`; this client only consumes the token.
- OIDC user needs **API License** for WCF login. If login returns API License, tick REST on the user (approved env) or use PAT + OData/MCP for dictionary work.
- For FORMTRIG/EFORM inventory on Cloud, prefer PAT OData / MCP over this client.

## Tests

```powershell
npm test
```

## Related

- Skill: `priority-saas-wcf` (catalog + `.grok/skills` after sync)
- OIDC: `priority-saas-oidc-login`, `docs/skill-sources/programming/SAAS_OIDC_LOGIN.md`
- On-prem password formprep: `src/Prepare-NamedForm.ps1` (unchanged)
- airc Priority verbs: bobiverse `airc/priority-worker` (fleet console; CredMan on-prem)

### proc text (FR #409)

`proc text --instance <id> --name <ENAME>` reads EXEC `TEXT` as `{name, body}` (read-only; `allowLive` not required). Missing or empty body exits 2 with `proc_text_missing`. Write is FR-028 (`proc text set`).
