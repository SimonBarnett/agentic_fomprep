# FR-003: User-context CLI installers and detection

GitHub: #568.

A yes runs only that CLI's official installer as the interactive user, then re-checks only that binary.

- Grok: `irm https://x.ai/cli/install.ps1 | iex`, then `grok.exe` under `.grok\bin`.
- Cursor: `irm 'https://cursor.com/install?win32=true' | iex`, then `cursor-agent\agent.cmd`.
- OpenCode: Windows standalone URL parsed from the install page (tests use a fixture; no live fetch).
- `.grok\bin\agent.exe` is never Cursor.

Installers do not run as LocalSystem. No deferred MSI custom action runs an installer.
