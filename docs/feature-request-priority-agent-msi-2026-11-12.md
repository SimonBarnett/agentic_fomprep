# Vision: Priority Agent MSI

Feature request on the existing repo SimonBarnett/agentic_fomprep.
Gap check: origin/main b0b27df. launcher/Program.cs still resolves only
grok.exe and exits 1 with "grok CLI not found". No MSI. The client-polish
pack already names docs/mocks/home.html, so these wireframes live under
docs/mocks/priority-agent-msi/. This pack does not create a repo and does
not change Form Prep gates.

## Objective

A person can install Priority Agent from one per-machine MSI, choose
Grok, Cursor, or OpenCode, and be asked before that CLI is installed
into their own profile. The launcher starts the chosen CLI.

LOCKED

## Success

| id | metric | target | how measured | fail-when |
|----|--------|--------|--------------|-----------|
| S1 | Three-way install prompt | Interactive MSI on a user with none of the three CLIs shows Grok, Cursor, OpenCode, and Not now. | `tests/priority-agent-cli/` chooser fixture lists all four choices | The dialog is missing, or it offers only Grok. |
| S2 | One CLI per yes | Choosing one CLI runs only that installer. Afterwards that CLI's version command exits 0. | `tests/priority-agent-cli/` starts one fake installer and checks version exit 0 | A yes runs a second installer, or the chosen binary is still absent. |
| S3 | Not now | Not now finishes the MSI with exit 0, installs Priority Agent, and starts none of the three installers. | `tests/priority-agent-cli/` asserts zero installer starts and MSI exit 0 | Not now downloads a CLI, or the MSI rolls back. |
| S4 | Silent install | `msiexec /i ... /qn` exits 0, installs Priority Agent, shows no dialog, and starts no CLI installer. | WiX source check in `tests/priority-agent-cli/` plus one local `/qn` smoke | Silent install fails because a CLI is missing, or it downloads one. |
| S5 | Right Windows user | Each installer runs as the interactive user. No deferred system custom action runs any of them. | `tests/priority-agent-cli/` asserts the installer token is the user | A CLI appears only under the SYSTEM profile. |
| S6 | Cursor is not Grok | A machine whose only agent.exe is under the Grok bin is reported as Cursor missing. | `tests/priority-agent-cli/` fixture with `.grok\bin\agent.exe` and no cursor-agent cmd | The chooser marks Cursor installed. |
| S7 | Launcher choice | None installed: show the three plus refuse. Refuse exits 1 with no download. Exactly one installed: launch it. Two or more: ask which. A missing pick asks to install, then launches. Redirected stdin does not download. | `tests/priority-agent-cli/` launcher cases for 0, 1, and many CLIs | It only errors for a missing grok.exe, auto-picks by fuel, or downloads with no yes. |
| S8 | Launch the chosen tool | Grok keeps the current RunGrok argument list. Cursor and OpenCode start in the work directory without those arguments. The hours loop relaunches the chosen CLI. | `tests/priority-agent-cli/` asserts the started exe path and that Cursor/OpenCode args omit Grok MCP flags | The launcher still starts only grok.exe, or Grok flags are passed through unchanged. |

## Shape

Primary: **app**

Hybrid note: the product remains the existing Priority Agent desktop
launcher plus skills catalog. This request's product surface is the MSI
and the launcher chooser. GitHub, Form Prep, and the MCP catalog stay
delivery.

LOCKED

## Stack

Default: WiX Toolset v3, shipping the existing .NET 8 self-contained
PriorityAgent.exe. CLI installers run only after a yes, in the
interactive user session.

Why: the repo already publishes that exe. WiX v3 is the fleet pack path
(per-machine, major upgrade, embedded cab, sha256 sidecar). Grok and
Cursor publish PowerShell installers. OpenCode on Windows publishes a
standalone binary.

Why-not:

- Do not copy the dev layout D:\tools\PriorityAgent into the MSI.
- Do not install under C:\ai. That tree is the fleet service root.
- Do not vendor the three CLIs inside the MSI.
- Do not use a deferred CAQuietExec to run a CLI installer.
- Do not switch the pack to Inno or NSIS.
- Do not install OpenCode with Scoop, Chocolatey, WinGet, or a bash
  script inside PowerShell.
- Do not copy a fuel order that prefers Cursor tokens, then Grok tokens.
  This chooser is the person's pick.

Install directory: C:\Program Files\Priority Agent. Start-menu shortcut
and a per-machine desktop shortcut. The loose exe pre-release stays.
The MSI is added beside it.

LOCKED

## Architecture

```
interactive msiexec
  -> copy PriorityAgent.exe + shortcuts
     (per-machine, LocalSystem file copy only)
  -> if UI is interactive:
        dialog: Install a CLI?
          [Grok] [Cursor] [OpenCode] [Not now]
        one yes -> that installer as this user, then re-check only that binary
        Not now -> continue, no CLI installed
  -> /qn skips the dialog and never starts an installer

later double-click of Priority Agent
  -> detect the three binaries (Cursor check rejects \.grok\bin\agent.exe)
  -> none installed AND console interactive:
        same chooser; refuse -> not-found line, exit 1
  -> exactly one installed: launch it
  -> two or more: ask which to launch
  -> pick a missing one: Install it now? Y installs then launches; N returns
  -> stdin redirected: no prompt, no download, exit 1 when none is installed
```

Detection:

- Grok: grok.exe via the existing lookup, then %USERPROFILE%\.grok\bin\grok.exe.
- Cursor: %LOCALAPPDATA%\cursor-agent\agent.cmd, then agent.cmd or
  cursor-agent.cmd on PATH. Reject any candidate under .grok\bin.
- OpenCode: %USERPROFILE%\.opencode\bin\opencode.exe, then opencode.exe on PATH.

Launch:

- Grok: keep EnsureGrokMcp, the skills path, and RunGrok.
- Cursor: start the resolved agent.cmd with the selected work directory.
  Read agent --help before choosing flags. Do not reuse Grok's arguments.
- OpenCode: start the resolved opencode.exe the same way.

Trust boundary: machine-wide files versus one user's profile. The MSI
never reads C:\passwords, never collects an API key, and never prints
installer output that could contain a token. git and gh stay hard
requirements with the current error. Login for each CLI stays that
CLI's own first-run flow.

LOCKED

## Screens

HTML wireframes, no PNGs.

| id | file | state |
|----|------|-------|
| M1 | docs/mocks/priority-agent-msi/home.html | All three CLIs found. Continue. |
| M2 | docs/mocks/priority-agent-msi/empty.html | None found. Grok, Cursor, OpenCode, Not now. |
| M3 | docs/mocks/priority-agent-msi/error.html | The chosen CLI install failed. Retry, pick another, or Close. |

LOCKED

## LOCKED

- Shape is app. Install root is C:\Program Files\Priority Agent.
- The person picks the CLI. Not now still installs Priority Agent.
- Silent install never downloads a CLI.
- CLI installers run as the interactive user.
- Cursor detection rejects Grok's agent.exe.
- Grok keeps its current launch arguments. Cursor and OpenCode do not
  receive them.
- git and gh are out of this request.
- The loose exe pre-release stays.

## UNKNOWN

- The exact OpenCode Windows zip URL. Read it from the official install
  page at implementation. Do not invent a package-manager command.
- Cursor and OpenCode arguments beyond the work directory, until
  --help is read.
- Whether a later slice should remember the last CLI, or also prompt
  for git and gh.
- Exact WiX dialog control sizes.

## Filed

| id | issue | slice |
|----|-------|-------|
| FR-001 | #566 | Pack the MSI. No CLI action. |
| FR-002 | #567 | Interactive chooser. Silent install downloads nothing. |
| FR-003 | #568 | User-context installers and detection. |
| FR-004 | #569 | Launcher chooser. |
| FR-005 | #570 | Launch the chosen CLI. |
| FR-006 | #571 | Offline fake-installer tests. |
| FR-007 | #572 | README and release note. |
| FR-008 | #573 | Docs park pointer. Closed by the docs PR only. |
