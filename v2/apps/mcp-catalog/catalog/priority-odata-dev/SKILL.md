---
name: priority-odata-dev
description: >
  Read or write Priority dictionary and business data via OData instead of UI-only.
  Use when the user says OData, EPROG dump, FORMLIMITED, RESTFLAG, tabula.ini/base,
  or /priority-odata-dev. User allowlists instances; never invent a base URL.
---

# Priority OData (DEV)

Grab this skill from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-odata-dev`). Call OData **locally** against an instance the **user** listed. This catalog does not call ERP HTTP or SQL.

Do not change repo-root `src\Prepare-NamedForm.ps1`. Do not guess Prepare Upgrade / Install Upgrade ENAMEs; use `v2/config/pin.json`.

## When

Reading or writing Priority dictionary or business data via OData instead of UI-only. Procedure archaeology via EPROG. FORMLIMITED / RESTFLAG audits.

## Hard rules

1. Never log passwords. CredMan only (`credentialTarget` on the allowlist row). Username is case-sensitive (`Si` on CE DEV).
2. Never invent `webBaseUrl`, SQL instance, or company. Only ids from the user's allowlist.
3. If `instances.json` is missing or empty: **stop** and tell the user to fill it.
4. Never run when `allowLive` is false and the row looks live/PRI.
5. Prefer OData EPROG dumps for procedure archaeology; write dumps under the instance work dir.
6. SQL on `system`/`base` is allowed for EXECPREPLOCK / FORMTRIGTEXT / structural asserts. OData does not replace Form Prep success gates (`ok=true` AND UPD=N AND LASTPREPDATE advanced).
7. Company/DNAME: UI title is not the SQL DB name (TEST `base` = "T - Clarkson Evans Live - 20251031"; `test` = "Test"). Check USERENV.DNAME. OData path uses the allowlist `company` (DNAME), not the UI title.

## FORMLIMITED / RESTFLAG (critical)

- `RESTFLAG=Y` on FORMLIMITED can expose forms to OData **but** with LIMITFLAG blank + Si can **hide** the same forms from web sibling-tab strips (seen on PART long-desc tabs 2026-09-15).
- Do **not** leave RESTFLAG-only FORMLIMITED on UI-tested forms until the LIMITFLAG/RESTFLAG pattern for "OData without hiding UI" is confirmed.
- Deleting bad FORMLIMITED rows restored UI tabs.
- `formlimited_audit` flags `restflag_without_limitflag` when RESTFLAG=Y and LIMITFLAG is not Y.
- Dictionary key is **`[T$EXEC]`** (join via ENAME as needed). **`FORMLIMITED.FORM` does not exist** — querying it yields `sql_failed` (issue #7 / MRB `80d8ce4`).
- CATALOG OData may return "API cannot be run"; register CATALOG/COLUMNS/INDEXES/INDCLMNS/CATALOGA via SQL first (`TNAME` max 20).

## Allowlist (user fills this)

`%USERPROFILE%\.priority-formprep\instances.json`
Override: env `PRIORITY_FORMPREP_INSTANCES`.

Same file as formprep. Copy `instances.example.json` from `get_runner_files`. OData base is derived:

`{webBaseUrl}/odata/Priority/{tabulaini}/{company}`

CE DEV proven (document only; still use the allowlist row, do not hardcode in the runner):

- Tabula OData: `https://prioritydev.clarksonevans.co.uk/odata/Priority/tabula.ini/base`
- Procedures: `.../base/EPROG` expand `PROG_SUBFORM` then `PROGTEXT_SUBFORM` for Step Query text (prefer over empty PROCTABLETEXT)
- Auth: HTTP Basic, username **Si** (CredMan `CE/Priority/Si`)
- Forms: EFORM family when licensed; structural asserts may use SQL on DEV when OData 401

## Loop

1. `list_instances` (local plugin) or read the JSON (no secrets besides ids/titles).
2. If more than one instance and the user did not name an id, ask.
3. Call a tool:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Invoke-PriorityOData.ps1 -InstanceId <id> -Action get -Path EPROG
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Invoke-PriorityOData.ps1 -InstanceId <id> -Action query -Path EPROG -Filter "ENAME eq 'FORMPREPDRCT2'" -Expand "PROG_SUBFORM($expand=PROGTEXT_SUBFORM)"
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Invoke-PriorityOData.ps1 -InstanceId <id> -Action dump_procedure -EName FORMPREPDRCT2
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Invoke-PriorityOData.ps1 -InstanceId <id> -Action formlimited_audit -Forms PART,PARTLONGDESC
```

Or local MCP tools `odata_get` / `odata_query` / `odata_dump_procedure` / `formlimited_audit`.

4. `no_cred` -> stop; human sets CredMan for that row's `credentialTarget`.
5. `formlimited_audit` reads dictionary SQL (`sqlDatabase`, usually `system`) on the allowlisted instance (Windows integrated unless `sqlCredentialTarget` is set). HTTP 401 on OData get/query/dump: do not retry with a logged password; SQL structural asserts are allowed on DEV when OData is unlicensed.
6. Report `ok`, `reason`, `url` (no userinfo), dump path, every `errors[]` line. Never print Authorization headers.

## Tools

| Tool | Does |
|------|------|
| odata_get | GET a relative path |
| odata_query | GET with $filter / $expand / $select / $top |
| odata_dump_procedure | ENAME -> PROGTEXT; write JSON under instance work dir |
| formlimited_audit | RESTFLAG/LIMITFLAG risks for a form set |

Path must be relative (e.g. `EPROG`). Refuse `http(s):`, `..`, and absolute URLs.

## Not this catalog

Do not call `odata_get` on `mcp-priority.ntsa.uk`. That host has no ERP. Write runner files from `get_runner_files` (or use the Grok plugin `priority-odata-dev`) and run them where Priority HTTP and dictionary SQL are reachable.
