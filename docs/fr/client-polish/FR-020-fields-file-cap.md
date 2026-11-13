# FR-020: cap the fields file at 1 MiB and reject a BOM

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Long text comes from a file with a hard size cap.

## Deliverables

- --fields-file reads UTF-8.
- A leading EF BB BF exits 2 reason bom_refused.
- A file larger than 1 MiB exits 2 reason fields_file_too_large.
- The client does not log the file body.

## Testable

- Fixture tests for BOM, 1 MiB plus 1 byte, and a small ASCII file.
- The small file parses to the expected fields object.

## Out of scope

- Does not change form save.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #402
