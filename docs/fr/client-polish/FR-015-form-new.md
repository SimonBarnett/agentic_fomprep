# FR-015: insert one form row

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can add one row when the instance allows writes.

## Deliverables

- form new --form <ENAME> --fields or --fields-file.
- allowLive true is required.
- allowLive false returns before login with reason live_refused.

## Testable

- Fake test: allowLive true calls the insert path once.
- allowLive false: login count 0 and exit 2.

## Out of scope

- Does not delete (FR-16).
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #397
