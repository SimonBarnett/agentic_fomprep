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
  url: 'https://<host>',
  tabulaini: 'tab<tenant>.ini', // often from POST /webui/<tenant>
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

## CLI

See `v2/apps/priority-saas-wcf/README.md`. Phase 2 will add `prepare` and `proc`.

## Related

- airc fleet Priority verbs (on-prem CredMan / SOAP): bobiverse `airc/priority-worker`
- On-prem named form prep: `src/Prepare-NamedForm.ps1`
- UAT walk notes: `priority-uat-wcf`
