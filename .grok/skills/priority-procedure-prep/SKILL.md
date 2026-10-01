---
name: priority-procedure-prep
description: >
  Prepare one Priority procedure or report by internal name (ENAME) via Web SDK
  (EXEC + REPPREPDIRECT2). SQL/file-gate on EXECPREPLOCK.UPD=N and
  system/prep/d{T$EXEC}.prp mtime advanced. Use when the user says prepare a
  procedure, reprepare procedure, REPPREPDIRECT2, TYPE=P prep, or
  /priority-procedure-prep. User allowlists instances; never invent a WCF URL.
---

# Priority named-procedure prep

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authoritative procedure: `docs/skill-sources/programming/PREPARE_PROCEDURE.md`.

Grab this skill from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill`). Compile **locally** against an instance the **user** listed. This catalog does not call SQL or WCF.

Repo runner (CE DEV1 pack): `src\Prepare-NamedProcedure.ps1` + `src\sdk\run-repprep-via-exec.mjs`.

## Hard rules

1. Never report prepared unless `ok=true` **and** `UPD='N'` **and** `d{T$EXEC}.prp` mtime advanced on **that instance**.
2. Never `UPDATE … SET UPD='N'` to fake success.
3. Never invent `webBaseUrl`, SQL instance, or company. Only ids from the user’s allowlist.
4. Never log the web password. CredMan only.
5. One name per call. SDK toast alone is not success.
6. If `instances.json` is missing or empty: **stop** and tell the user to fill it.
7. Do **not** use Named Form Prep (`EFORM` / `FORMPREPDRCT2`) for `TYPE=P` — it returns form-not-found.

## Allowlist

`%USERPROFILE%\.priority-formprep\instances.json`  
Override: env `PRIORITY_FORMPREP_INSTANCES`.

Same allowlist as `priority-formprep`. Passwords stay in CredMan (`credentialTarget`).

## Loop

1. Confirm instance id (ask if more than one and user did not name it).
2. Prepare:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File src\Prepare-NamedProcedure.ps1 -Name <ENAME> -Environment DEV -ForceUnprepared
```

3. Report `ok`, `reason`, upd before→after, `.prp` before→after, every `errors[]` line.
4. `no_cred` → stop; human sets CredMan.
5. `ok=false` → return errors. Do not SQL-flip. Do not blind-loop without a dictionary change.

## Success / errors

| `ok` | `reason` | Meaning |
|------|----------|---------|
| true | prepared | UPD=N and `.prp` mtime advanced |
| false | still_unprepared | Still UPD=Y |
| false | prp_unchanged | UPD=N but `.prp` did not move |
| false | name_missing | ENAME not in T$EXEC/EXECPREPLOCK for TYPE=P (or `-ExecType R`) |
| false | walk_incomplete | WCF walk did not reach `end` |
| false | no_cred | CredMan missing |

`LASTPREPDATE` may stay `0` for TYPE=P on some estates — do not require it to advance when `.prp` did.

## WCF shape

`EXEC` (Entity Titles) → search ENAME → `activateStart(REPPREPDIRECT2)`.  
Bare `procStart(REPPREPDIRECT2)` without the EXEC row often cannot fill the FILE `PAR` link.

## Related

- Forms: **priority-formprep** (`FORMPREPDRCT2`)
- Shell AFTERPREP: **priority-version-revision-discipline** / **priority-shell-compile**
