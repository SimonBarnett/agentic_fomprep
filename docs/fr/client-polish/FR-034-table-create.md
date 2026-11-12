# FR-034: create table refuses without a SQL profile

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Creating a table uses the same SQL gate as adding a column.

## Deliverables

- table create --name <TABLE> --request <file> describing columns.
- No sqlProfile: reason table_ddl_needs_sql, login count 0.
- allowLive false: live_refused before login.
- With both, one create call on the fake. Do not emit a raw CREATE from the agent prompt.

## Testable

- Three fake tests for the three branches above.

## Out of scope

- Does not install a shell.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #416
