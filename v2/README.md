# v2 — portable form prep (catalog MCP + local execute)

The **built CE DEV1 pack** an agent is already using stays at repo-root `src\Prepare-NamedForm.ps1`. Do not change that path for the in-flight agent.

This folder is the next version:

| Path | Role |
|------|------|
| `v2/apps/mcp-catalog/` | Amplify app for **https://mcp.ntsa.uk** (skill catalog MCP). Add a skill by adding `catalog/<name>/`. |
| `v2/plugins/priority-formprep/` | Grok plugin: local execute (`list_instances`, `prepare_form`) against the **user** instance allowlist. |
| `v2/plugins/priority-shell-compile/` | Grok plugin: local `compile_shell`. Separate from install. WCF walker uses pinned Prepare Upgrade ENAME. |
| `v2/plugins/priority-shell-install/` | Grok plugin: local `install_shell`. Parse, path allowlist, DBI refuse before WCF. SQL gate + `formsUnprepared[]` handoff (no auto-prep). |
| `v2/plugins/priority-odata-dev/` | Grok plugin: local `odata_get` / `odata_query` / `odata_dump_procedure` / `formlimited_audit`. CredMan Basic auth. |
| `v2/lib/` | Shared kernel (allowlist, sql, cred, parse-sh). Do not extract v1. |
| `v2/tools/Test-WP0.ps1` | Shell compile/install WP0 fail-fast. Red before WCF. |
| `v2/tools/Test-PriorityCatalog.ps1` | Catalog A-D presence + OData fixture tests. No live ERP. |

Catalog MCP never compiles a form and never sees on-prem SQL. Prepare runs on a host that can reach that instance’s WCF and dictionary SQL.

## Add a skill later

Put a new folder at `v2/apps/mcp-catalog/catalog/<name>/` with `meta.json` and `SKILL.md`. The landing page and `list_catalog` pick it up. No MCP handler change.

If that skill also **executes** locally, add `v2/plugins/<name>/` and list it in `.grok-plugin/marketplace.json`.

## Amplify + DNS (you)

Deploy settings, env names, and what Amplify cannot run: [docs/amplify-hosting.md](../docs/amplify-hosting.md).

1. Amplify Hosting compute (`WEB_COMPUTE`) → this GitHub repo, branch `main`, monorepo app root `v2/apps/mcp-catalog` (`amplify.yml`).
2. ntsa.uk DNS: the CNAME records the Amplify console prints for `mcp.ntsa.uk`. Do not invent the `*.amplifyapp.com` target.
3. Amplify console → custom domain `mcp.ntsa.uk` on branch `main`.

Skill leaflets still mention `mcp-priority.ntsa.uk`. That name is allowlisted if you attach it as a second hostname. It is not a separate app.

**Local stdio (recommended):** `grok mcp add priority-catalog -- node <clone>/v2/apps/mcp-catalog/stdio.mjs`. It is zero-dependency (no npm install), serves `catalog/` from the clone and has the same tools. The Priority Agent launcher registers it automatically. Amplify does not serve stdio.

Hosted MCP URL: `https://mcp.ntsa.uk/mcp` (one JSON-RPC POST per request, protocol `2024-11-05`). Tools: `list_catalog`, `get_skill`, `get_instance_schema`, `get_runner_files`. There is **no** `prepare_form` on Amplify.

## Local execute (after grab)

User copies `instances.example.json` to `%USERPROFILE%\.priority-formprep\instances.json` and fills real ids. Then:

```powershell
cd v2\plugins\priority-formprep\scripts
npm install
powershell -NoProfile -ExecutionPolicy Bypass -File .\Prepare-NamedForm.ps1 -InstanceId <id> -Name <ENAME>
```

Grok: `grok plugin marketplace add SimonBarnett/agentic_fomprep` then `grok plugin install priority-formprep --trust` (and `priority-shell-compile` / `priority-shell-install` / `priority-odata-dev` for the other execute plugins).

Shell compile/install pins live in `v2/config/pin.json` (`PinComplete=true`, Medatech wrappers on CE DEV). WCF walkers read those ENAMEs only. `WcfFileStepWorks` stays null (unproven); WINRUN is not invented. `install_shell` returns `postInstall.formsUnprepared[]` and does not call `prepare_form`. Offline catalog + OData fixture gates (no live ERP):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File v2\tools\Test-PriorityCatalog.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File v2\tools\Test-WP0.ps1
```
