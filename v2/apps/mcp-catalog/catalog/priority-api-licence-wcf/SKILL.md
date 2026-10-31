---
name: priority-api-licence-wcf
description: >
  Fix priority-web-sdk formStart Blocker "API Licence": USERSB.REST is the API
  License flag. Use when formStart fails with API Licence, REPPREPDIRECT2 login
  works but EXEC will not open, or /priority-api-licence-wcf.
---

# Priority API Licence (WCF)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authoritative procedure: `docs/skill-sources/programming/API_LICENCE_WCF.md`.

## Hard rules

1. `USERSB.REST='Y'` is the API License checkbox — not `LICENSETYPE` alone.
2. Dev/test only unless the operator approved the exact Live write.
3. Never log or commit the web password.
4. Prefer recycling the IIS **app pool** over `iisreset` (reset can leave W3SVC stopped).

## Loop

1. Confirm login user from the allowlist.
2. `SELECT USERLOGIN, REST, RESTLOGIN` from `USERS`/`USERSB`.
3. If `REST` is blank and the estate allows it, set `REST='Y'` on Dev/test.
4. Retry the SDK walk; report the next error if any.

## Related

- **priority-procedure-prep** / `PREPARE_PROCEDURE.md`
- **priority-odata-dev** / `ODATA_REST_CLOUD.md`
