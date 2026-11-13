# FR-021: procedure inputs come from a file

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

inputValues is applied on the first inputFields step.

## Deliverables

- --inputs <file> JSON map is passed into runProcStart as inputValues.
- The walker writes those values onto matching EditField names.
- Name-hint fill runs only for fields the file did not set.

## Testable

- Fake step: file sets PAR to FROMFILE; the inputFields payload contains FROMFILE.
- A field absent from the file still receives the name hint.

## Out of scope

- Option selection policy is FR-22.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #403
