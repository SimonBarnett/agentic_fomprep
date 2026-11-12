# FR-014: form rows accepts a filter

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

A filtered read positions the form before getRows.

## Deliverables

- form rows --filter or request-file filter calls the SDK search once.
- Then getRows from 1.
- Missing filter keeps today's unfiltered read.

## Testable

- Fake test: one setSearchFilter call when filter is present.
- Zero setSearchFilter calls when filter is absent.

## Out of scope

- Writes stay on form set and form save.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #396
