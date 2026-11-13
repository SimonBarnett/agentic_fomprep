# FR-030: read dictionary columns for one table

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent can list columns before an edit.

## Deliverables

- table columns --name <TABLE> returns column name, type, and title.
- Read-only via OData COLUMNS or the WINDBI form.
- Unknown table returns exists false and columns [].

## Testable

- Fake OData value array of two columns is returned.
- Empty value returns columns length 0 and exit 0.

## Out of scope

- Does not write the dictionary.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #412
