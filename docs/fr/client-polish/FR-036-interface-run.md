# FR-036: run one interface with an inputs file

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent starts an interface and gets needs_input instead of a hidden choice.

## Deliverables

- interface run --name <ENAME> --inputs <file>.
- Uses the proc walker rules from FR-21 and FR-22.
- Result is ended or needs_input.

## Testable

- Fake single inputFields applies the file.
- Fake two-option step returns needs_input.

## Out of scope

- Mapping edits are FR-37.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #418
