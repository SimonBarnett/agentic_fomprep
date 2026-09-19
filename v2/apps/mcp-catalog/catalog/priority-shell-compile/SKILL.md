---
name: priority-shell-compile
description: >
  Compile one Priority Version Revision into NN.sh on a user-allowlisted instance
  (Prepare Upgrade). SQL/file-gated. Use when the user says compile a shell,
  prepare upgrade, version revision shell, or /priority-shell-compile.
  Never invent a WCF URL. Until PinComplete this skill is skeleton-only (no WCF).
---

# Priority shell compile

Grab this skill from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-shell-compile`). Compile **locally** against an instance the **user** listed. This catalog does not call SQL or WCF.

This is **not** form prep and **not** install. Do not call `install_shell` from this tool. Do not change repo-root `src\Prepare-NamedForm.ps1`.

Until WP0 pins exist (`v2/config/pin.json` `PinComplete=false`), the runner refuses the WCF path with `reason=pin_incomplete`. Do not guess the Prepare Upgrade ENAME.

## Hard rules

1. Never report compiled unless the compile gate holds: procedure reached end without Blocker messages, output `.sh` exists, size > 0, path returned.
2. Never SQL-fake a compile.
3. Never invent `webBaseUrl`, SQL instance, or company. Only ids from the user’s allowlist.
4. Never log the web password. CredMan only.
5. One revision per call. SDK/procedure “successfully completed” is not success.
6. If `instances.json` is missing or empty: **stop** and tell the user to fill it.
7. Never run when `allowLive` is false and the row looks live/PRI.
8. Never create Version Revisions or fixture entities.

## Allowlist (user fills this)

`%USERPROFILE%\.priority-formprep\instances.json`  
Override: env `PRIORITY_FORMPREP_INSTANCES`.

Copy `instances.example.json` from `get_runner_files`. Optional `buildSetRoot` / `agentWork` are the only roots a later `install_shell` may read.

## Loop

1. `list_instances` (local plugin) or read the JSON (no secrets besides ids/titles).
2. If more than one instance and the user did not name an id, ask.
3. Compile:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\Compile-Shell.ps1 -InstanceId <id> -Revision <NN>
```

Or local MCP tool `compile_shell` `{ instance_id, revision }`.

4. Report `ok`, `reason`, `revision`, `path`, `bytes`, every `errors[]` line.
5. `pin_incomplete` → stop. Human must pin Prepare Upgrade ENAME after recon. Do not guess.
6. `no_cred` → stop; human sets CredMan for that row’s `credentialTarget`.
7. `ok=false` → return `errors[]` (never empty). Do not install.

`-WhatIf` does not call WCF (`reason=whatIf`, exit 0).

## Success / errors

| `ok` | `reason` | Meaning |
|------|----------|---------|
| true | compiled | Shell file exists, size > 0, path returned |
| false | whatIf | Dry run; no WCF |
| false | revision_missing | Revision not on that instance |
| false | shell_not_created | Proc ran; no `.sh` |
| false | pin_incomplete | WP0 pins missing; no WCF |
| false | no_cred | CredMan missing |
| false | instance_unknown | id not in allowlist |
| false | live_refused | Looks live/PRI and allowLive is false |
| false | windows_only | Non-Windows runner |

On **fail**, `errors[]` length >= 1. On **success**, omit empty error-form scrapes.

## Not this catalog

Do not call `compile_shell` on `mcp-priority.ntsa.uk`. That host has no ERP SQL. Write runner files from `get_runner_files` (or use the Grok plugin `priority-shell-compile`) and run them where WCF and dictionary SQL are reachable.
