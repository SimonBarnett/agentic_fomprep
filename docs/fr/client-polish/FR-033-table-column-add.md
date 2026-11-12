# FR-033: add one column or refuse on SaaS without SQL

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

One column add is explicit, and SaaS without SQL does not pretend to DDL.

## Deliverables

- table column add --name <TABLE> --column <COL> --type <T> --title <title>.
- Run the title check from FR-32 first.
- allowLive true required.
- An instance with no sqlProfile returns reason table_ddl_needs_sql before login.
- An instance with sqlProfile and allowLive performs one dictionary add.

## Testable

- No sqlProfile: login count 0 and reason table_ddl_needs_sql.
- sqlProfile plus allowLive: one add call on the fake.

## Out of scope

- Full table create is FR-34.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #415
