# FR-004: Launcher CLI chooser

**Repo:** SimonBarnett/agentic_fomprep
**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/569
**Labels:** feature-request

## Goal

PriorityAgent.exe uses the same choice rules as the MSI.

## Deliverables

- None installed and the console is interactive: offer Grok, Cursor, OpenCode, and refuse.
- Refuse prints the not-found line and exits 1. No download.
- Exactly one installed: launch it.
- Two or more installed: ask which to launch. Do not pick by token fuel.
- A missing pick asks "Install it now?" before any download.
- Redirected stdin does not prompt and does not download.

## Testable

- Launcher tests with fake binaries for zero, one, and many CLIs.
- A missing grok.exe is not the only error path.
- Redirected stdin starts no installer.

## Out of scope

- The argument list for Cursor and OpenCode (FR-005).
