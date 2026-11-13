# FR-018: write one subform row

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Subform start grows a set path.

## Deliverables

- form subform --form <PARENT> --subform <CHILD> --set --fields-file.
- allowLive true required.
- Read-only subform start (no --set) stays as shipped.

## Testable

- Fake test: --set calls field update on the child.
- allowLive false with --set: login count 0.

## Out of scope

- Does not redesign the form.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #400
