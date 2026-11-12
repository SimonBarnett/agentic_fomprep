# FR-005: Launch the chosen CLI

**Repo:** SimonBarnett/agentic_fomprep
**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/570
**Labels:** feature-request

## Goal

The selected work directory is the start directory. Grok keeps RunGrok.
Cursor and OpenCode do not receive Grok arguments. The hours relaunch
uses the same choice.

## Deliverables

- Three start paths.
- Read agent --help and opencode --help before adding flags.
- If those flags are still unknown, start with the work directory only.

## Testable

- The started exe path matches the choice.
- Cursor and OpenCode argument lists omit Grok MCP flags.
- The hours loop relaunches the chosen CLI, not a hardcoded grok.exe.

## Out of scope

- Flag-for-flag parity with Grok MCP registration.
- Remembering the last CLI.
