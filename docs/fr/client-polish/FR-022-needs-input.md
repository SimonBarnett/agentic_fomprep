# FR-022: ambiguous procedure options return needs_input

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The walker does not pick the first option.

## Deliverables

- When inputOptions has more than one choice and none is selected, return ok false, reason needs_input, and the option list.
- Do not call inputOptions.
- A single option may still be taken.
- Write the step snapshot to --out when --out is set, for FR-23.

## Testable

- Fake two-option step: inputOptions call count 0 and reason needs_input.
- Fake one-option step: inputOptions call count 1.

## Out of scope

- Resume is FR-23.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #404
