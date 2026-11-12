# FR-003: User-context CLI installers and detection

**Repo:** SimonBarnett/agentic_fomprep
**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/568
**Labels:** feature-request

## Goal

A yes runs only that CLI's official installer as the interactive user,
then re-checks only that binary.

## Deliverables

- Grok: irm https://x.ai/cli/install.ps1 | iex, then grok.exe under the user .grok\bin.
- Cursor: irm 'https://cursor.com/install?win32=true' | iex, then cursor-agent\agent.cmd.
- OpenCode: the official Windows standalone binary. Read the URL from the install page. No Scoop, Chocolatey, WinGet, or bash-in-PowerShell.
- Detection rejects any agent.exe under .grok\bin as Cursor.

## Testable

- Fake installer commands. No live network in CI.
- A fixture whose only agent.exe is under .grok\bin reports Cursor missing.
- The installer process is the interactive user, not LocalSystem.
- No deferred custom action runs an installer.

## Out of scope

- Dialog layout (FR-002).
- Starting the CLI for work (FR-005).
