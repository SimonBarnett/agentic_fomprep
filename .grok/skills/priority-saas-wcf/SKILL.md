---
name: priority-saas-wcf
description: >
  Allowlist-gated Priority SaaS Web SDK (WCF) client for PriorityAgent:
  Bearer accessToken login, tenant probe, form start/rows/set/save/subform,
  prepare form|procedure|report, FORMPREPERRS, proc start, whoami USERLOGIN,
  SaaS OData gate.
  Use when: SaaS WCF, Cloud Web SDK, priority-wcf.mjs, formStart SaaS,
  connect SaaS Priority, accessToken WCF, prepare SaaS, whoami, /priority-saas-wcf.
---

# Priority SaaS WCF client

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Runner: `v2/apps/priority-saas-wcf/` (`bin/priority-wcf.mjs`).
Long form: `docs/skill-sources/programming/SAAS_WCF_CLIENT.md`.
Grab from catalog MCP (`get_skill` with `name=priority-saas-wcf`).

## When

Need a **deterministic** Web SDK session against Priority **SaaS / Cloud**
(`p.priority-connect.online` or regional host) to **open/edit business forms**
or **prepare form/procedure/report** / run `proc start`. On-prem CredMan password
path stays `priority-formprep` / `src/Prepare-NamedForm.ps1`.

For Cloud **dictionary / trigger** archaeology (`EFORM`, `FORMTRIG`, SEARCH-ALL-FIELD
bodies), prefer **REST PAT + OData** (`priority-odata-dev`) or **Priority Cloud MCP**
(`priority-mcp-forms`) first — do not start MFA solely for that.

## Hard rules

1. Never invent host, tenant, company DNAME, or WCF URL. Allowlist only.
2. Never commit or log tokens, passwords, or OTPs.
3. OIDC + MFA first for Web SDK: `priority-saas-oidc-login` -> token file under `C:\passwords\` (UTF-8 no BOM; `expires_in` + `obtained_at` ok).
4. This client reads `PRIORITY_SAAS_TOKEN` or `instance.tokenFile` (`access_token`); login URL = probed `wcf` (`…/service.svc`).
5. Live writes need `allowLive: true` and explicit operator approval.
6. REST `…/service.svc/formStart` 404 on SaaS is not proof auth failed; use this SDK.
7. OIDC user needs API License (`USERSB.REST`) for WCF login; otherwise use PAT/MCP fallback (see `SAAS_WCF_CLIENT.md`).

## Loop

1. Copy `v2/apps/priority-saas-wcf/instances.example.json` to
   `%USERPROFILE%\.priority-saas-wcf\instances.json` and fill real allowlist rows.
2. `cd v2/apps/priority-saas-wcf && npm ci` (once).
3. Obtain token (skill `priority-saas-oidc-login`); store JSON with `access_token`.
4. `node bin/priority-wcf.mjs probe --instance <id>`
5. `node bin/priority-wcf.mjs session --instance <id>`
6. `node bin/priority-wcf.mjs whoami --instance <id>` -> `{ok,userLogin,source}` (`login` or `users`); never OS user; exit 3 = `user_unidentified`.
7. `--dry-run` on any verb: prints `instanceId`, `verb`, `write` without login
   (unknown instance still exits 2 / `instance_unknown`). Does not write last-user.json.
8. Form verbs: `form start|rows|set|save|subform` with `--form <ENAME>`.
9. Prepare: `prepare form|procedure|report --name <ENAME>` (needs `allowLive`).
   Success = walk ended **and** independent gate (`odataBase` OData UPD/LASTPREPDATE
   when SQL unavailable). Without gate, `preparedClaim` stays false.
10. Proc: `proc start --name <ENAME> [--ptype P]`.

## Related

- OIDC: `priority-saas-oidc-login`
- UAT walk notes: `priority-uat-wcf`
- OData/PAT: `priority-odata-dev`
- On-prem formprep: `priority-formprep`
