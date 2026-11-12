# Priority Agent launcher

`PriorityAgent.exe` is a Windows console launcher. It starts a **Grok coding agent for Priority ERP work**
with the right context.

## What it does on every start

1. It **fast-forwards SimonBarnett/agentic_fomprep**.
   - **AI root:** unless `--root` / `PRIORITY_AGENT_ROOT` is set, the launcher looks for `X:\AI` on ready
     drives in order **C: → D: → E: … Z:**. If none exists, it **creates** `\AI` on the first ready drive
     in that same order (so a machine with only `C:` gets `C:\AI`; a missing `D:` is never chosen).
   - Preferred clone path is `<AI root>\agentic_fomprep`. Search roots after that: every existing `X:\AI`
     and `X:\repos` on ready drives. A directory counts as a clone only when it has a `.git` folder and
     `origin` matches `SimonBarnett/agentic_fomprep`.
   - **Empty stub:** if the preferred path exists but is **not** a git clone (for example only a `.grok`
     folder, no `.git`), the launcher skips it and uses another clean clone under a searched root.
     Agents must use the resolved `{{FOMPREP_DIR}}` / session cwd for `git pull` --- never hardcode a drive letter.
   - Operator choices when the preferred path is a stub: (1) rename/remove the stub and reclone into the
     resolved AI root, or (2) set `PRIORITY_AGENT_ROOT` / `--root` to the folder that holds the real clone.
   - It does `fetch --prune`, then `merge --ff-only`, but only when the clone is on `main` and clean.
     A valid clone with uncommitted changes is still usable: the launcher warns and skips the pull.
     It never resets local work and never aborts only because the clone is dirty. An empty stub
     (no `.git`) is skipped when another real clone exists. If no real clone exists, FATAL lists
     each candidate path and why it was rejected.
2. It **loads the Priority MCP and skills** for every context. The registration is idempotent and user level:
   - It registers the **`priority-catalog`** MCP as a **local stdio server run from the agentic_fomprep clone**:
     `grok mcp add priority-catalog -- node <clone>\v2\apps\mcp-catalog\stdio.mjs`.
     That is the repo's own zero-dependency stdio entry point (no npm install needed). It serves `list_catalog`,
     `get_skill`, `get_instance_schema` and `get_runner_files` from `v2/apps/mcp-catalog/catalog`, so it's always as
     current as the fast-forwarded clone.
     - It needs Node 18+. It looks in `PRIORITY_AGENT_NODE`, `D:\tools\node`, PATH and Program Files, and checks each
       node's version (MarchHare's PATH node is v8, which is too old).
     - If there's no suitable node, or `stdio.mjs` is missing, it falls back to the same server built into the exe
       (`PriorityAgent.exe --mcp-catalog`).
     - Any other registration, such as an old remote URL, is replaced.
     Then it runs `grok mcp doctor priority-catalog`.
   - It adds `<agentic_fomprep>/.grok/skills` to `[skills] paths` in `%USERPROFILE%\.grok\config.toml`.
     A timestamped `.bak-priorityagent-*` backup is written before any change.
   - This is needed because Grok only reads project skills from the cwd's own repo, and a
     customer repo is a different repo. This makes the Priority skills visible to **all** Grok sessions on the machine.
3. It **lists the customer repos**: SimonBarnett repos tagged with the GitHub topic **`priority-customer`**.
   It uses the REST API through `gh api`, with no search-index lag.
4. You pick one of three contexts:
   - **General Priority**: cwd is the agentic_fomprep clone.
   - **Customer**: cwd is the customer clone. A repo new to the machine is cloned into `<AI root>\<repo>`;
     an existing clone under any searched `X:\AI` or `X:\repos` is reused.
   - **Project / service call**: one of the customer repo's top-level folders, skipping dot-folders.
     cwd is that folder.
5. It loads **Priority SaaS WCF allowlist** rows (FR #348): default %USERPROFILE%\.priority-saas-wcf\instances.json (env PRIORITY_SAAS_WCF_INSTANCES), or a wcfInstancesPath / SaaS-shaped list in .priority-agent.json (project overrides customer). Each row has id, host, tenant, company, user, tokenFile, allowLive (see v2/apps/priority-saas-wcf/instances.example.json). Credentials and tokens are never stored there. The launcher writes a session-only wcf-instances.json and injects instructions for bin/priority-wcf.mjs + skill priority-saas-wcf (not bobiverse #6026 priority_wcf.py). Legacy airc / airc_console fields still load without error and print a warning that they are ignored. --airc, --no-airc and --airc-console are rejected with a clear "removed; use the WCF client" message.
6. **New customer / new project** never creates anything. It prints `Ask Haitch: new customer repo for X`
   or `Ask Haitch: new project folder Y in <repo>`, copies the line to the clipboard and exits. Haitch creates it
   from `launcher/customer-setup`. A project folder must already be an authoritative `SCxxxxxx` or `SOxxxxxx`.
   The Medatech booking id and WBS go in that folder's `project.md`, not in the folder name.
7. It checks fuel like `ce-dayworks/scripts/Start-DayWorks.ps1`.
   - Source: the Bob report `machines.<machine>.pcent["grok-chat"]`.
   - Above 0 means the pool is used. 0 or unknown gives a warning and asks before continuing.
   - It never handles keys.
8. It **starts Grok** in the same console:
   `grok --cwd <context> --session-id <new uuid> --trust --rules <agent rules> "<context brief>"`.
   - The rules come from `launcher/agent-rules.md`. That file is the only reporting
     policy. The exe embeds a copy of it at build time. On launch, `LoadRules` uses the
     clone file when its `rules-version` is at least the embedded copy. Customer repos
     are not given a copy. The `{{...}}` placeholders are filled in.
   - The brief names the customer, project, paths and the files to read first.
9. **Hours are mandatory.** When the agent exits, the launcher looks for one **closed** entry on
   `GET https://bob.ntsa.uk/bob/v1/hours` (bobiverse FR #3450 / #3673). The query is
   `user` and `status=closed`. It does **not** send `idempotency_key` as a query
   parameter. `from` and `to`, when sent, are Europe/London dates from the persisted
   entry `start` through the London day of the check, so an older session is included.
   A naive timestamp is that clock time in UTC, matching bobhours. If `hours-entry.json`
   has no `start`, the date bounds are omitted. The match is client-side: persisted receiver id, `priority-agent-<full session uuid>`,
   the Priority USERLOGIN in `on_behalf_of`, the expected customer and project, `status` `closed`,
   and a real start/end.
   - `?user=` and `on_behalf_of` are the USERLOGIN stored in that session's `identity.json`
     at launch (`--hours-user`, or a prompt when a terminal is attached). When a last-user
     row exists for the selected WCF instance (`%USERPROFILE%\.priority-agent\last-user.json`),
     the prompt is `Priority USERLOGIN [<saved>]:` and Enter binds that login. `--hours-user`
     still wins. The launcher does
     not read the OS account name, a shared environment default, or the connections file.
     A later launch for someone else does not rewrite an existing session.
   - The returned id is persisted in the session `hours-entry.json`. Tests set
     `PRIORITY_AGENT_HOURS_JSON` to a list fixture. When that variable is set, the check does
     not contact the network.
   - A non-success GET is **delivery unverified**. The launcher tries once and does not retry.
     Do not treat a merged rules file or this source change as an installed exe conversion.
     `LoadRules` uses `launcher/agent-rules.md` from the clone when its `rules-version` is at
     least the copy embedded in `PriorityAgent.exe`. The embedded copy changes only when the
     exe is rebuilt and published, which this change does not do.
   - If the entry is missing, open, `auto_closed`, or for a different key, the launcher shows a
     loud red warning and relaunches the same session (`grok --resume <id>`) until the closed
     entry matches, or the operator types `SKIP` (logged).
   - `log.md` stays narrative evidence. It is not the hours store. The check does not read a git hours ref.

Logs go to `%LOCALAPPDATA%\PriorityAgent\logs`. Per-session `launch.json` and the rendered rules go to `...\sessions`.

## WCF configuration (FR #348)

The client is fom-prep v2/apps/priority-saas-wcf (bin/priority-wcf.mjs), skill priority-saas-wcf.
Allowlist default: %USERPROFILE%\.priority-saas-wcf\instances.json (override PRIORITY_SAAS_WCF_INSTANCES).
Copy from v2/apps/priority-saas-wcf/instances.example.json:

```json
{
  "instances": [
    {
      "id": "saas-dev",
      "host": "p.priority-connect.online",
      "tenant": "exampletenant",
      "company": "exampledname",
      "user": "user@example.com",
      "tokenFile": "C:\\passwords\\example-saas-oauth-tokens.json",
      "language": 3,
      "allowLive": false
    }
  ]
}
```


Optional project/customer .priority-agent.json may set wcfInstancesPath to that file, or embed the same
SaaS-shaped wcf / instances array (project overrides customer). **Never** put passwords or tokens in
these files. Tokens come from tokenFile or process env PRIORITY_SAAS_TOKEN (see priority-saas-oidc-login).

Rows that look like bobiverse #6026 (serverUrl + mode direct|relay) are ignored with a warning.

Legacy keys airc and airc_console are ignored with a warning. The launcher does not open DCC and
does not send airc shell PRIVMSGs. Agent rules require priority-wcf.mjs for Priority work and require
a harvest through Bobiverse intake (tools\Report-FomprepIntakeIssue.ps1 / Invoke-FomprepHarvest.ps1)
after every client session.


## Agent rules (summary; full text in `agent-rules.md`)

- **Harvest rule**: knowledge goes to the level it belongs to.
  - General Priority skills go to **agentic_fomprep as a branch + PR**.
  - Customer-installation skills and insights go to the **customer repo**.
  - Project and service-call specifics go to **that project folder** (including `log.md`).
- **Secrets**:
  - Connection details live in `C:\passwords\<repo>-connections.txt` on the machine the agent runs on (always local;
    this overrides any AGENTS.md naming another machine). If the file is missing, the agent asks Haitch for it.
    `<repo>` where `<repo>` is the GitHub repo name in lowercase
    (for example `rees-connections.txt` or `ce-priority-connections.txt`).
    Configure with `--passwords-dir` or the `PRIORITY_AGENT_PASSWORDS` env var.
  - The agent reads the file when it needs a connection and must **never commit, echo, quote or summarise** it.
  - The launcher only checks that the file exists. It never reads it.
- **Customer systems**: agents may connect to the selected customer's systems with the connections file **without asking first**.
  They must not message the customer's people without asking Simon.
- **Hours (mandatory)**: one closed webhook entry per session, matched client-side as in step 9.
  - Human-equivalent time, with evidence links in the description or `tickets`. Haitch proposes
    bookings and Simon approves them. The agent does not post Priority.
  - `launcher/hours-template.md` is a legacy markdown table. It is not the hours store and it is
    not the customer-repo template. Use `launcher/customer-setup` for new repos.

## Use

Double-click the **Priority Agent** desktop shortcut, or:

```
PriorityAgent.exe                                  interactive menu
PriorityAgent.exe --list                           customers (topic priority-customer)
PriorityAgent.exe --list --customer rees           + its project folders
PriorityAgent.exe --customer rees --project SC263182
PriorityAgent.exe --general
PriorityAgent.exe --dry-run --customer rees --project SC263182   show everything, change nothing, print the grok command
PriorityAgent.exe --smoke --customer rees --project SC263182     real setup + one brief no-tools single-turn launch
PriorityAgent.exe --check-hours C:\AI\rees --session <uuid>      run only the hours check (path under the resolved AI root)
PriorityAgent.exe --mcp-catalog [<catalog dir>]                 fallback stdio catalog MCP (env PRIORITY_CATALOG_DIR)
```

Other options: `--root <dir>` (clone root; default: first existing `X:\AI` on C:->Z:, else create `\AI` on the first ready drive; env `PRIORITY_AGENT_ROOT`),
`--passwords-dir <dir>`, `--no-fuel-check`, `--no-pause`.

Requirements: `git`, `gh` (logged in as SimonBarnett) and the Grok CLI (`%USERPROFILE%\.grok\bin\grok.exe`).

Optional execute plugins (formprep, compile, install, odata) need node and `instances.json`, so the launcher doesn't install them:
`grok plugin marketplace add SimonBarnett/agentic_fomprep`, then `grok plugin install priority-formprep --trust` (and so on).

## Build

Requires the .NET 8 SDK. It builds on Windows or Linux; the icon is embedded either way.

```
# From the repository root:
dotnet publish launcher/PriorityAgent.csproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -o launcher/out
# -> launcher/out/PriorityAgent.exe (self-contained, single file, ~35 MB)
dotnet run --project launcher.Tests/PriorityAgent.Tests.csproj -c Release
# The launcher acceptance checks are a console harness (dotnet test does not discover tests).
cd launcher
.\build.ps1 -Install                                      # Windows: build + copy to D:\tools\PriorityAgent + desktop shortcut
```

The Windows workflow also runs the published executable through dry-run integration scenarios with isolated
profiles and fake GitHub/Grok CLIs, checking config preservation, WCF session instance files, and connection-file
canary handling. The `Launcher release` workflow runs on launcher pull requests and `main` pushes for validation;
it publishes a GitHub **pre-release** with `PriorityAgent.exe` and its `.sha256` file for `launcher-v*` tags or a
manual dispatch from `main`. A `launcher-vX.Y.Z` tag stamps banner / FileVersion `X.Y.Z` / `X.Y.Z.0` and
ProductVersion `X.Y.Z+<commit>` (FR #267). Local `launcher\build.ps1 -Install` defaults to `1.0.0` unless you pass `-Version`. Download
it from [GitHub Releases](https://github.com/SimonBarnett/agentic_fomprep/releases) and verify the checksum
before use. Releases remain pre-release until separately approved.

## Icon

`priority.ico` is the Priority client's own icon, copied from `C:\Program Files (x86)\Priority\favicon.ico`
on MarchHare. It has 16, 24, 32, 48, 128 and 256 px frames and is the same "p" logo as `WINMENU.exe`, the
Priority desktop shortcut target. Priority is a trademark of Priority Software.
