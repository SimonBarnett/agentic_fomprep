# v2 — portable form prep (catalog MCP + local execute)

The **built CE DEV1 pack** an agent is already using stays at repo-root `src\Prepare-NamedForm.ps1`. Do not change that path for the in-flight agent.

This folder is the next version:

| Path | Role |
|------|------|
| `v2/apps/mcp-catalog/` | Amplify app for **https://mcp-priority.ntsa.uk** (skill catalog MCP). Add a skill by adding `catalog/<name>/`. |
| `v2/plugins/priority-formprep/` | Grok plugin: local execute (`list_instances`, `prepare_form`) against the **user** instance allowlist. |
| `v2/plugins/priority-shell-compile/` | Grok plugin: local `compile_shell`. Separate from install. Until `v2/config/pin.json` PinComplete, refuses WCF. |
| `v2/plugins/priority-shell-install/` | Grok plugin: local `install_shell`. Parse, path allowlist, DBI refuse before WCF. |
| `v2/lib/` | Shared kernel (allowlist, sql, cred, parse-sh). Do not extract v1. |
| `v2/tools/Test-WP0.ps1` | Shell compile/install WP0 fail-fast. Red before WCF. |

Catalog MCP never compiles a form and never sees on-prem SQL. Prepare runs on a host that can reach that instance’s WCF and dictionary SQL.

## Add a skill later

Put a new folder at `v2/apps/mcp-catalog/catalog/<name>/` with `meta.json` and `SKILL.md`. The landing page and `list_catalog` pick it up. No MCP handler change.

If that skill also **executes** locally, add `v2/plugins/<name>/` and list it in `.grok-plugin/marketplace.json`.

## Amplify + DNS (you)

1. Amplify Hosting → this GitHub repo, branch `main`, monorepo app root `v2/apps/mcp-catalog` (`amplify.yml` already set).
2. ntsa.uk DNS: CNAME `mcp-priority` → the Amplify default hostname (`*.amplifyapp.com`).
3. Amplify console → custom domain `mcp-priority.ntsa.uk`.

MCP URL: `https://mcp-priority.ntsa.uk/mcp` (JSON-RPC POST). Tools: `list_catalog`, `get_skill`, `get_instance_schema`, `get_runner_files`. There is **no** `prepare_form` on Amplify.

## Local execute (after grab)

User copies `instances.example.json` to `%USERPROFILE%\.priority-formprep\instances.json` and fills real ids. Then:

```powershell
cd v2\plugins\priority-formprep\scripts
npm install
powershell -NoProfile -ExecutionPolicy Bypass -File .\Prepare-NamedForm.ps1 -InstanceId <id> -Name <ENAME>
```

Grok: `grok plugin marketplace add SimonBarnett/agentic_fomprep` then `grok plugin install priority-formprep --trust` (and `priority-shell-compile` / `priority-shell-install` for the v2 shell skills).

WP0 skeleton (`PinComplete=false`): `compile_shell` / `install_shell` implement parser, allowlist, WhatIf, schemas, and refuse paths only. They do **not** guess Prepare Upgrade / Install Upgrade ENAMEs. Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File v2\tools\Test-WP0.ps1
```
