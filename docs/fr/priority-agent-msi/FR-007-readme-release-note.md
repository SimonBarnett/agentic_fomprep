# FR-007: README and release note for the MSI

**Repo:** SimonBarnett/agentic_fomprep
**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/572
**Labels:** feature-request

## Goal

The README says the MSI is an extra asset next to the exe pre-release,
and documents the three-CLI prompt.

## Deliverables

- launcher/README.md names the MSI, the four choices, and that /qn does not download a CLI.
- The release workflow text says the MSI is an additional asset. The loose exe stays.

## Testable

- The README contains the install directory, Grok, Cursor, OpenCode, Not now, and /qn.
- Implementation issues for the MSI and the chooser stay open. This slice does not close them.

## Out of scope

- Building or publishing the MSI.
