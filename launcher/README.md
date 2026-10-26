# Priority Agent launcher

`PriorityAgent.exe` is a Windows console launcher. It starts a **Grok coding agent for Priority ERP work**
with the right context.

## What it does on every start

1. It **fast-forwards SimonBarnett/agentic_fomprep**.
   - Default preferred path: `D:\ai\agentic_fomprep` (`--root` / `PRIORITY_AGENT_ROOT`, default `D:\ai`).
     Search order after that: `C:\ai`, `D:\repos`, `C:\repos`. A directory counts as a clone only when it has a `.git` folder and `origin` matches `SimonBarnett/agentic_fomprep`.
   - **Empty stub:** if `D:\ai\agentic_fomprep` exists but is **not** a git clone (for example only a `.grok` folder, no `.git`), the launcher skips it and uses another clean clone such as `C:\ai\agentic_fomprep`. Agents must use the resolved `{{FOMPREP_DIR}}` / session cwd for `git pull` --- never hardcode `D:\ai\agentic_fomprep`.
   - Operator choices when the preferred path is a stub: (1) rename/remove the stub and `gh repo clone SimonBarnett/agentic_fomprep D:\ai\agentic_fomprep`, or (2) set `PRIORITY_AGENT_ROOT=C:\ai` / `--root C:\ai` and keep the real clone under `C:\ai\agentic_fomprep`.
   - It does `fetch --prune`, then `merge --ff-only`, but only when the clone is on `main` and clean.
     A dirty clone is skipped or reported, never reset.
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
   - **Customer**: cwd is the customer clone. A repo new to the machine is cloned into `D:\ai\<repo>`;
     an existing clone in `D:\ai`, `C:\ai` or `D:\repos` is reused.
   - **Project / service call**: one of the customer repo's top-level folders, skipping dot-folders.
     cwd is that folder.
5. **New customer / new project** never creates anything. It prints `Ask Haitch: new customer repo for X`
   or `Ask Haitch: new project folder Y in <repo>`, copies the line to the clipboard and exits. Haitch creates it.
6. It checks fuel like `ce-dayworks/scripts/Start-DayWorks.ps1`.
   - Source: the Bob report `machines.<machine>.pcent["grok-chat"]`.
   - Above 0 means the pool is used. 0 or unknown gives a warning and asks before continuing.
   - It never handles keys.
7. It **starts Grok** in the same console:
   `grok --cwd <context> --session-id <new uuid> --trust --rules <agent rules> "<context brief>"`.
   - The rules come from `launcher/agent-rules.md` in the agentic_fomprep clone when its `rules-version` is at
     least the embedded copy's; otherwise the copy embedded in the exe is used. The `{{...}}` placeholders are filled in.
   - The brief names the customer, project, paths and the files to read first.
8. **Hours are mandatory.** When the agent exits, the launcher fetches `origin/hours` from the customer repo
   (agentic_fomprep for a general session). It checks that `hours/<today>.md` has a `dev` line **and** a `test`
   line, each with evidence and tagged `session:<first 8 hex of session id>`.
   - If they are missing, it shows a loud red warning.
   - It then **relaunches the same session** (`grok --resume <id>`) with a "report your hours now" prompt.
   - It repeats until the lines are there. Typing `SKIP` overrides this, and the override is logged.

Logs go to `%LOCALAPPDATA%\PriorityAgent\logs`. Per-session `launch.json` and the rendered rules go to `...\sessions`.

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
- **Hours (mandatory)**: the format comes from ce-dayworks.
  - Lines go in `hours/YYYY-MM-DD.md` on the customer repo's **`hours` branch**, from `hours/_template.md`.
    If the repo has none, copy `launcher/hours-template.md`, which is the ce-dayworks template.
  - The hours are human-equivalent, every line has evidence, and the file is append-only (no force-push).
  - Haitch proposes the bookings and Simon approves them.

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
PriorityAgent.exe --check-hours D:\ai\rees --session <uuid>      run only the hours check
PriorityAgent.exe --mcp-catalog [<catalog dir>]                 fallback stdio catalog MCP (env PRIORITY_CATALOG_DIR)
```

Other options: `--root <dir>` (clone root, default `D:\ai`, env `PRIORITY_AGENT_ROOT`),
`--passwords-dir <dir>`, `--no-fuel-check`, `--no-pause`.

Requirements: `git`, `gh` (logged in as SimonBarnett) and the Grok CLI (`%USERPROFILE%\.grok\bin\grok.exe`).

Optional execute plugins (formprep, compile, install, odata) need node and `instances.json`, so the launcher doesn't install them:
`grok plugin marketplace add SimonBarnett/agentic_fomprep`, then `grok plugin install priority-formprep --trust` (and so on).

## Build

Requires the .NET 8 SDK. It builds on Windows or Linux; the icon is embedded either way.

```
cd launcher
dotnet publish PriorityAgent.csproj -c Release -o out     # -> out\PriorityAgent.exe (self-contained, single file, ~35 MB)
.\build.ps1 -Install                                      # Windows: build + copy to D:\tools\PriorityAgent + desktop shortcut
```

## Icon

`priority.ico` is the Priority client's own icon, copied from `C:\Program Files (x86)\Priority\favicon.ico`
on MarchHare. It has 16, 24, 32, 48, 128 and 256 px frames and is the same "p" logo as `WINMENU.exe`, the
Priority desktop shortcut target. Priority is a trademark of Priority Software.
