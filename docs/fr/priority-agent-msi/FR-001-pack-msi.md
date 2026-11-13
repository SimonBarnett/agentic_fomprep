# FR-001: Pack the Priority Agent MSI

**Repo:** SimonBarnett/priority-mcp
**Issue:** https://github.com/SimonBarnett/priority-mcp/issues/566
**Labels:** feature-request

## Goal

A per-machine WiX v3 MSI installs PriorityAgent.exe to
C:\Program Files\Priority Agent with Start-menu and desktop shortcuts,
a major upgrade, and a .sha256 sidecar.

## Deliverables

- Pack script and Product.wxs.
- Harvest of the published exe.
- No CLI dialog and no CLI custom action.

## Testable

- The MSI source has InstallScope perMachine and the install directory above.
- The source does not reference the Grok, Cursor, or OpenCode installer URLs.
- The pack writes the msi and the sha256 file.

## Out of scope

- The CLI chooser (FR-002) and the installers (FR-003).
