# FR-007: JSON request file for verb arguments

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Agents pass fields and filters in a file so Windows quoting is not required.

## Deliverables

- --request <path> reads UTF-8 JSON.
- Keys fields, filter, inputs, name, form, subform override the matching flags when present.
- Invalid JSON exits 2 with reason request_invalid.
- The file is not copied into the repo.

## Testable

- Fixture request.json with fields EMAIL sets the same object form set uses.
- A broken file exits 2 and does not call login.

## Out of scope

- Verb behaviour stays in the verb FRs.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #389
