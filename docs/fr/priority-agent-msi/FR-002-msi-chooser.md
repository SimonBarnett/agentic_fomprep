# FR-002: MSI chooser for Grok, Cursor, or OpenCode

**Repo:** SimonBarnett/agentic_fomprep
**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/567
**Labels:** feature-request

## Goal

An interactive install offers Grok, Cursor, OpenCode, and Not now.

## Deliverables

- WiX UI dialog with those four choices.
- Not now completes the install and downloads nothing.
- A yes records exactly one choice.
- msiexec /qn shows no dialog.

## Testable

- tests/priority-agent-cli covers the four choices.
- The CLI action is absent when the UI is silent.

## Out of scope

- Running the real installers (FR-003).
- Launcher behavior (FR-004).
