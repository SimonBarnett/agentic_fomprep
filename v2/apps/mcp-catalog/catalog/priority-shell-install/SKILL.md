---
name: priority-shell-install
description: >
  Install one caller-supplied Priority upgrade shell (.sh) onto a user-allowlisted
  instance (Install Upgrade). Parse, path-allowlist, and DBI-refuse before WCF.
  Use when the user says install a shell, install upgrade, or /priority-shell-install.
  Never invent a WCF URL. Walks the pinned Install Upgrade procedure (from v2/config/pin.json) over WCF. SQL-gated. Does not auto-prep forms.
---

# Priority shell install

Grab this skill from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-shell-install`). Install **locally** against an instance the **user** listed. This catalog does not call SQL or WCF.

This is **not** form prep and **not** compile. Do not call `compile_shell` or `prepare_form` from this tool. If the shell names forms, return `postInstall.formsUnprepared[]` for the caller to feed `prepare_form`. Do not change repo-root `src\Prepare-NamedForm.ps1`.

`PinComplete` is true on the CE proof instance. The runner reads Install Upgrade ENAME / type / install-log table from `v2/config/pin.json` only. Do not guess an ENAME. If pins are incomplete, `reason=pin_incomplete` and no WCF.

After a successful install, `postInstall.formsUnprepared[]` lists `TAKESINGLEENT` names for the caller to feed `prepare_form`. This tool does **not** call `prepare_form`.

## Hard rules

1. Never report installed unless the install gate holds: procedure reached end without Blocker messages; pinned install-log / revision row advanced after `startedAt`; every `TAKESINGLEENT` name parsed from the shell exists in `T$EXEC` on that instance; no `errors[].severity=Blocker`.
2. Never SQL-fake an install.
3. Never invent instance URLs.
4. Never log passwords.
5. Never install fixtures from git onto a non-proof instance (`catalog/**/fixtures` and `plugins/**/fixtures` are refuse).
6. Never create `ZCLA_AGENT_SI_*` (or any fixture) from this tool.
7. Never auto-prepare forms after install.
8. Never run when `allowLive` is false and the row looks live/PRI.
9. `shell` is a path on the runner / build set, not “latest file in system\upgrades”.
10. One `.sh` per call. No directory install.

## Allowlist (user fills this)

`%USERPROFILE%\.priority-formprep\instances.json`  
Override: env `PRIORITY_FORMPREP_INSTANCES`.

`install_shell.shell` must resolve under `buildSetRoot`, `agentWork`, env `PRIORITY_SHELL_BUILDSET`, or pin `AllowedBuildSetRoots`. Refuse `..`, foreign UNC, and catalog fixtures.

## Loop

1. `list_instances` (local plugin) or read the JSON (no secrets besides ids/titles).
2. If more than one instance and the user did not name an id, ask.
3. Install:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Install-Shell.ps1 -InstanceId <id> -Shell <path-to-NN.sh>
```

Or local MCP tool `install_shell` `{ instance_id, shell, allow_dbi? }`. `allow_dbi` defaults false.

4. Parse the file **before** WCF. Not a Priority shell → `reason=parse_failed`, no install.
5. If parse shows DBI and `allow_dbi` is false → `reason=dbi_refused`, no WCF.
6. Report `ok`, `reason`, `path`, `revision`, `codes[]`, `dbi`, `gate`, `postInstall.formsUnprepared[]`, every `errors[]` line.
7. `pin_incomplete` → stop. Pins must stay dictionary-backed. Do not guess.
8. `no_cred` → stop.

`-WhatIf` parses and allowlists but does not call WCF (`reason=whatIf`, exit 0).

## Success / errors

| `ok` | `reason` | Meaning |
|------|----------|---------|
| true | installed | SQL gate passed; no Blocker |
| false | whatIf | Dry run; no WCF |
| false | parse_failed | Not a Priority shell |
| false | path_refused | `..`, fixtures, foreign UNC, missing file, outside roots |
| false | dbi_refused | DBI in shell and allow_dbi is false |
| false | pin_incomplete | WP0 pins missing; no WCF |
| false | sql_failed | Dictionary SQL unreachable before WCF |
| false | winrun_required | WcfFileStepWorks=false; WINRUN not implemented |
| false | proc_failed | Procedure ended with Blocker |
| false | gate_unchanged | Install-log / revision row did not advance |
| false | partial_entities | TAKESINGLEENT name missing from T$EXEC |
| false | no_cred | CredMan missing |
| false | instance_unknown | id not in allowlist |
| false | live_refused | Looks live/PRI and allowLive is false |
| false | windows_only | Non-Windows runner |

On **fail**, `errors[]` length >= 1 (`source` = parse \| policy \| gate \| sdk). Never `ok=false` with `errors=[]`.

Populate `errors[]` in order, whatever WP0 finds exists: SDK messages, upgrade/revision error form, gate failures, parse/path/DBI refuses.

## Not this catalog

Do not call `install_shell` on `mcp-priority.ntsa.uk`. That host has no ERP SQL. Write runner files from `get_runner_files` (or use the Grok plugin `priority-shell-install`) and run them where WCF and dictionary SQL are reachable.
