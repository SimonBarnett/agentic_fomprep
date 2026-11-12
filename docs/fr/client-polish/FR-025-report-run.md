# FR-025: report run is proc start with type R

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent has a report verb.

## Deliverables

- report run --name <ENAME> calls procStart with ptype R.
- The result includes urls from FR-24.
- help report lists run.

## Testable

- Fake test: ptype passed to procStart is R.
- help report stdout contains run.

## Out of scope

- Does not prepare the report (prepare report already exists).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #407
