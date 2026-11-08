# Priority SaaS WCF / Web SDK client (generic)

Authoritative companion to catalog skill `priority-saas-wcf`.
Phase 1: allowlist + Bearer `accessToken` + probe/session/form verbs.

## Why

On-prem formprep uses CredMan password + `priority-web-sdk`. SaaS tenants
usually need an OIDC Bearer for WCF. This client consumes that token and drives
the same SDK so PriorityAgent can open and edit forms without inventing hosts.

OIDC + MFA remains `priority-saas-oidc-login` / `SAAS_OIDC_LOGIN.md`.

## Allowlist

Path: `%USERPROFILE%\.priority-saas-wcf\instances.json` or
`PRIORITY_SAAS_WCF_INSTANCES`. Example in
`v2/apps/priority-saas-wcf/instances.example.json`.

Required per row: `id`, `host`, `tenant`, `company` (DNAME), `user`.
Optional: `tokenFile`, `tabulaini`, `language`, `allowLive`.

Refuse: missing file, empty list, unknown id, secret keys in JSON, writes when
`allowLive` is false.

## Token

- Env `PRIORITY_SAAS_TOKEN`, or
- JSON file with `access_token` (path on the allowlist row).

Never log the token. CLI redacts JWT-shaped strings in dumps.

## SDK login

```js
await priority.login({
  // MUST be the probed WCF URL ending in .svc on SaaS, e.g.
  // https://p.priority-connect.online/wcf/service.svc
  // Host-only URL makes priority-web-sdk append /wcf/wcf/Service.svc (wrong).
  url: 'https://<host>/wcf/service.svc',
  tabulaini: 'tab<tenant>.ini', // from POST /webui/<tenant> (_tabulaini=)
  language: 3,
  profile: { company: '<DNAME>' },
  appname: 'priority-saas-wcf-<run>',
  username: '<user>',
  accessToken: '<bearer>',
  devicename: 'agent-<run>',
  appid: '',
  appkey: '',
});
```

When `accessToken` is set, the SDK uses it as the WCF UsernameToken password.

This client resolves `url` from tenant probe `wcf` (preferred) before login.

## Failure / fallback (field-proven)

| Symptom | Cause | What to do |
|---------|--------|------------|
| `Can't connect to server.` | Host-only `url` → SDK hits `/wcf/wcf/Service.svc` | Use probed `…/wcf/service.svc` (client does this after probe) |
| `To enter the system via the API, you must flag the user as having an API License.` | OIDC user lacks `USERSB.REST` / API License | Tick API License on that user (approved env), **or** for dictionary/trigger reads use **REST PAT** + OData / Priority Cloud MCP |
| OData `You cannot run API with the type of license…` | Same licence class on Bearer TabulaUser | Prefer PAT Basic (`token` / `PAT`) |
| OData empty HTTP 500 without language segment | Some SaaS tenants need `tab….ini,3/<DNAME>` | Try `,2` / `,3` language segment (FR #226 still applies for wrong DNAME) |
| `token_file_invalid_json` | UTF-8 BOM from PowerShell `Set-Content` | Client strips BOM; write tokens UTF-8 **no BOM** |
| `token_expired` | OIDC `expires_in` ~1800s elapsed | Re-run `priority-saas-oidc-login` |

**Scope:** use this client for **Web SDK form walks** (and Phase 2 prepare). For Cloud **dictionary / FORMTRIG / EFORM** archaeology, prefer `priority-odata-dev` (PAT) or `priority-mcp-forms` first — do not burn MFA on WCF when PAT already works.

## CLI

See `v2/apps/priority-saas-wcf/README.md`. Phase 2 will add `prepare` and `proc`.

## Related

- airc fleet Priority verbs (on-prem CredMan / SOAP): bobiverse `airc/priority-worker`
- On-prem named form prep: `src/Prepare-NamedForm.ps1`
- UAT walk notes: `priority-uat-wcf`
- OData / PAT: `priority-odata-dev`, `ODATA_REST_CLOUD.md`
- MCP forms: `priority-mcp-forms`, `priority-mcp-setup`
