---
name: priority-api-licence-wcf
description: >
  Fix priority-web-sdk / SaaS WCF "API Licence" blockers: PRIVUSERS.REST is the
  API License checkbox; set USERSB.RESTLOGIN first. Use when formStart or SaaS
  login fails with API Licence, or /priority-api-licence-wcf.
---

# Priority API Licence (WCF)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authoritative procedure: `docs/skill-sources/programming/API_LICENCE_WCF.md`.

## Hard rules

1. Dictionary column `USERSB.REST` = **API License** — not `LICENSETYPE` alone.
2. Via **forms** (Cloud MCP): tick **`PRIVUSERS.REST`**, after setting **`USERSB.RESTLOGIN`**. `USERSB` often does not expose `REST` to the form API.
3. Dev/test only unless the operator approved the exact Live write.
4. Never log or commit the web password.
5. Prefer recycling the IIS **app pool** over `iisreset` (reset can leave W3SVC stopped).

## Loop

1. Confirm login user (OIDC email may map to a different `USERLOGIN`).
2. Ensure `RESTLOGIN` is set on **USERSB** for that user.
3. Set `REST='Y'` / true on **PRIVUSERS** (or SQL `USERSB.REST` when SQL is available).
4. Retry the SDK / `priority-wcf.mjs session` walk; report the next error if any.

## Related

- **priority-procedure-prep** / `PREPARE_PROCEDURE.md`
- **priority-saas-wcf** / `SAAS_WCF_CLIENT.md`
- **priority-mcp-forms** / `root_records`
- **priority-odata-dev** / `ODATA_REST_CLOUD.md`
