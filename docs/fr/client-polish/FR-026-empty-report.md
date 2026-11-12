# FR-026: a report with no output is empty, not a failure

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Zero URLs and zero error rows is a successful empty run.

## Deliverables

- When the walk ends, urls length is 0, and errors length is 0, return ok true and empty true.
- Blocker errors still return ok false.

## Testable

- Fake ended walk with no urls: empty true and exit 0.
- Fake blocker: ok false.

## Out of scope

- Does not change the prep gate.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #408
