---
name: priority-saas-wcf
description: >
  Allowlist-gated Priority SaaS Web SDK (WCF) client for PriorityAgent:
  Bearer accessToken login, tenant probe, form start/rows/set/save/subform.
  Use when connecting SaaS/Cloud Priority over Web SDK, or /priority-saas-wcf.
---

# Priority SaaS WCF client

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Runner: `v2/apps/priority-saas-wcf/` (`bin/priority-wcf.mjs`).
Long form: `docs/skill-sources/programming/SAAS_WCF_CLIENT.md`.
Grab from catalog MCP (`get_skill` with `name=priority-saas-wcf`).

## When

Need a **deterministic** Web SDK session against Priority **SaaS / Cloud**
(`p.priority-connect.online` or regional host) to open forms, read/edit rows,
or (Phase 2) prepare form/procedure/report. On-prem CredMan password path stays
`priority-formprep` / `src/Prepare-NamedForm.ps1`.

## Hard rules

1. Never invent host, tenant, company DNAME, or WCF URL. Allowlist only.
2. Never commit or log tokens, passwords, or OTPs.
3. OIDC + MFA first: `priority-saas-oidc-login` -> token file under `C:\passwords\`.
4. This client reads `PRIORITY_SAAS_TOKEN` or `instance.tokenFile` (`access_token`).
5. Live writes need `allowLive: true` and explicit operator approval.
6. REST `…/service.svc/formStart` 404 on SaaS is not proof auth failed; use this SDK.

## Loop

1. Copy `v2/apps/priority-saas-wcf/instances.example.json` to
   `%USERPROFILE%\.priority-saas-wcf\instances.json` and fill real allowlist rows.
2. `cd v2/apps/priority-saas-wcf && npm ci` (once).
3. Obtain token (skill `priority-saas-oidc-login`); store JSON with `access_token`.
4. `node bin/priority-wcf.mjs probe --instance <id>`
5. `node bin/priority-wcf.mjs session --instance <id>`
6. Form verbs: `form start|rows|set|save|subform` with `--form <ENAME>`.

## Related

- OIDC: `priority-saas-oidc-login`
- UAT walk notes: `priority-uat-wcf`
- OData/PAT: `priority-odata-dev`
- On-prem formprep: `priority-formprep`
