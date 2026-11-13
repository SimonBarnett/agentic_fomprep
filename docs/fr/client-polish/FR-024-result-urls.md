# FR-024: proc and prepare results include report URLs

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent receives URLs the SDK already exposes.

## Deliverables

- Add urls: string[] to proc start and prepare JSON, from displayUrlOf on each step.
- Absent URLs yield an empty array.

## Testable

- Fake step with Urls.url https://example.invalid/r returns that string in urls.
- A step with no Urls yields urls length 0.

## Out of scope

- Does not download the URL.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #406
