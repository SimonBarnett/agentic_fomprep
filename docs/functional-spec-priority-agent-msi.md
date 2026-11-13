# Functional spec: Priority Agent MSI and CLI choice

Repo: SimonBarnett/priority-mcp. Vision:
docs/feature-request-priority-agent-msi-2026-11-12.md.
Gap baseline: origin/main b0b27df (launcher/Program.cs still exits 1
when grok.exe is missing).

Today the launcher looks up only grok.exe (line 140), exits 1 when it
is missing (line 256), and starts only RunGrok (line 406). The release
is PriorityAgent.exe plus a sha256 file. build.ps1 -Install copies to
D:\tools\PriorityAgent. None of that is the product install.

## Install layout

- Per-machine WiX v3 MSI.
- Files land in C:\Program Files\Priority Agent.
- Shortcuts: Start menu and the common desktop. Target is PriorityAgent.exe.
- Major upgrade replaces an older MSI of this product.
- Ship the MSI and a .sha256 sidecar beside the existing exe pre-release.
- Do not remove the exe asset in this request.
- File copy may run as LocalSystem. No CLI installer may.

## CLI packages

Run a package only after an explicit yes, as the interactive user.

| CLI | Command the yes path runs | Binary afterwards |
|-----|---------------------------|-------------------|
| Grok | irm https://x.ai/cli/install.ps1 \| iex | %USERPROFILE%\.grok\bin\grok.exe |
| Cursor | irm 'https://cursor.com/install?win32=true' \| iex | %LOCALAPPDATA%\cursor-agent\agent.cmd, or agent.cmd / cursor-agent.cmd on PATH |
| OpenCode | official Windows standalone binary | opencode.exe on PATH or %USERPROFILE%\.opencode\bin\opencode.exe |

OpenCode's install page says Windows package managers are not supported.
Do not call Scoop, Chocolatey, WinGet, or curl \| bash from PowerShell.
The exact zip URL is read from that page when the slice is built.

Version checks after a yes:

- grok --version exits 0
- the resolved Cursor agent.cmd --version exits 0
- opencode --version exits 0

A yes for one CLI must not start the other two.

## Detection

- Grok: existing Which("grok.exe") order, including PRIORITY_AGENT_TEST_GROK
  and %USERPROFILE%\.grok\bin\grok.exe.
- Cursor: %LOCALAPPDATA%\cursor-agent\agent.cmd first. Then agent.cmd or
  cursor-agent.cmd on PATH. Drop any hit whose path contains \.grok\bin\.
  Grok's agent.exe is not Cursor.
- OpenCode: %USERPROFILE%\.opencode\bin\opencode.exe, then opencode.exe
  on PATH.
- Test overrides are allowed for the new lookups, same idea as
  PRIORITY_AGENT_TEST_GROK. CI uses fake files, not the network.

## MSI dialog

Interactive install, when the UI is shown:

- Title: Install a CLI?
- Buttons: Grok, Cursor, OpenCode, Not now.
- One choice only.
- Not now: MSI exits 0, Priority Agent is installed, no installer process
  starts, no grok.exe / agent.cmd / opencode.exe is created by the MSI.
- Yes: start that one installer as the installing user, then re-check
  only that binary.
- If the installer fails: Priority Agent stays installed. The dialog
  names the CLI that failed and offers Retry, a different CLI, or Close.
  The other installers have not been started.

Silent install:

- msiexec /qn exits 0.
- No dialog.
- No CLI installer process.
- The WiX CLI action is conditioned on interactive UI level.
- It is not a deferred custom action.

## Launcher

After the exe starts, and after git and gh are still required as today:

- Detect the three CLIs.
- None installed, console interactive: same four choices. Refuse prints
  the existing not-found line and exits 1. No download.
- Exactly one installed: launch that one. Do not ask.
- Two or more installed: ask which to launch. Do not pick by token fuel.
- The person picks a missing CLI: ask "Install it now?" Yes installs
  that one and then launches it. No returns to the list.
- Stdin redirected: do not prompt and do not download. If none is
  installed, print the not-found line and exit 1. If one or more is
  already installed, this pack does not guess; exit 1 and name the
  installed CLIs so the caller can pass a choice. A later slice may add
  a flag. Until then, redirected stdin never downloads.

git and gh missing still exit 1 with the current error. This request
does not offer to install them.

## Launch

- Grok: EnsureGrokMcp, skills path, and the current RunGrok argument
  list stay. Working directory stays the selected work dir.
- Cursor: start the resolved agent.cmd in that work directory. Do not
  pass Grok's MCP or skills arguments. Flags beyond the work directory
  wait until agent --help is read in that slice.
- OpenCode: same rule for opencode.exe.
- The hours relaunch loop calls the same chosen runner, not a hardcoded
  grok.exe path.

The MSI does not read C:\passwords, does not ask for an API key, and
does not log installer stdout that might contain a token. Each CLI's
own login stays outside this pack.

## Tests

All CI tests use fake installer commands and fake binaries.
No test calls x.ai, cursor.com, or opencode.ai.

- Chooser lists four choices.
- Each yes starts one fake command and leaves the other two unstarted.
- Not now and msiexec /qn start zero commands.
- Deferred WiX custom actions do not name the three installer URLs.
- Cursor stays missing when the only agent.exe is under .grok\bin.
- Launcher cases: none, one, many, redirected stdin.
- Started process path matches the choice.
- Cursor and OpenCode argument lists do not contain the Grok MCP flags.

## Non-goals

- Replacing the pre-release exe.
- Remembering the last CLI.
- Fuel-based selection.
- Flag-for-flag parity with Grok MCP registration.
- Form Prep gates, catalog sync, customer repos.
- Building the MSI on the plan seat.

## Filed slices

One GitHub issue per slice. Mirrors and the issue index live in
docs/fr/priority-agent-msi/. The docs PR uses Refs for the
implementation slices and Closes only the park-process issue.
