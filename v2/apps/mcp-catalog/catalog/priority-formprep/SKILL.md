---
name: priority-formprep
description: >
  Prepare one Priority form by internal name (ENAME) via Web SDK (EFORM + FORMPREPDRCT2).
  SQL-gate on EXECPREPLOCK.UPD=N and LASTPREPDATE advanced. Return FORMPREPERRS on fail.
  Use when the user says prepare a form, form prep, FORMPREP, compile a Priority form,
  or /priority-formprep. User allowlists instances; never invent a WCF URL.
---

# Priority named-form prep

Grab this skill from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill`). Compile **locally** against an instance the **user** listed. This catalog does not call SQL or WCF.

The CE DEV1 pack at repo-root `src\Prepare-NamedForm.ps1` is a separate in-flight agent path. Do not change it.

## Hard rules

1. Never report prepared unless `ok=true` **and** `UPD='N'` **and** bigint `LASTPREPDATE` increased on **that instance**.
2. Never `UPDATE … SET UPD='N'` to fake success.
3. Never invent `webBaseUrl`, SQL instance, or company. Only ids from the user’s allowlist.
4. Never log the web password. CredMan only.
5. One name per call. SDK “successfully completed” is not success.
6. If `instances.json` is missing or empty: **stop** and tell the user to fill it. Do not recon-guess live.

## Allowlist (user fills this)

`%USERPROFILE%\.priority-formprep\instances.json`  
Override: env `PRIORITY_FORMPREP_INSTANCES`.

Copy `instances.example.json` from `get_runner_files`. Many instances are allowed. Passwords stay in CredMan (`credentialTarget`). `allowLive` defaults false.

## Loop

1. `list_instances` (local plugin) or read the JSON (no secrets in stdout besides ids/titles).
2. If more than one instance and the user did not name an id, ask.
3. Prepare:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Prepare-NamedForm.ps1 -InstanceId <id> -Name <ENAME>
```

Or local MCP tool `prepare_form` `{ instance_id, name }`.

4. Report `ok`, `reason`, lastprep before→after, upd before→after, every `errors[]` line.
5. `no_cred` → stop; human sets CredMan for that row’s `credentialTarget`.
6. `ok=false` → return FORMPREPERRS lines. Do not SQL-flip. Do not re-prep in a loop without a form change.

## Success / errors

| `ok` | `reason` | Meaning |
|------|----------|---------|
| true | prepared | UPD=N and lastPrep advanced |
| false | still_unprepared | Still UPD=Y |
| false | lastprep_unchanged | UPD=N but date did not move |
| false | name_missing | ENAME not in T$EXEC/EXECPREPLOCK |
| false | no_cred | CredMan missing |
| false | instance_unknown | id not in allowlist |
| false | live_refused | Looks live/PRI and allowLive is false |

On **fail**, `errors[]` always includes `source=FORMPREPERRS` (rows `TYPE: MESSAGE/CMESSAGE`, or “returned no rows after failed prep”). On **success**, FORMPREPERRS is omitted (clean compile leaves that form empty).

Proc default `FORMPREPDRCT2` (Reprepare Form). Do not switch to `FORMPREPDRCT` unless the user pinned it; that proc can claim success without moving LASTPREPDATE.

## Not this catalog

Do not call `prepare_form` on `mcp-priority.ntsa.uk`. That host has no ERP SQL. Write runner files from `get_runner_files` (or use the Grok plugin) and run them where WCF and dictionary SQL are reachable.
