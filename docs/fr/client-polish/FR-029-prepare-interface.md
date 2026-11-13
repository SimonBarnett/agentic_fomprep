# FR-029: prepare interface refuses until the proc name is pinned

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Interface prepare cannot invent a procedure ENAME.

## Deliverables

- prepare interface --name <ENAME> reads config/interface-prep.json in the repo.
- When proc is missing or empty, return reason interface_prep_unknown, exit 2, and do not call login.
- When proc is a non-empty string, run that prepare proc for --name and apply the same OData gate as prepare report.
- Ship the config file with proc set to an empty string.

## Testable

- Missing proc: login count 0 and reason interface_prep_unknown.
- Fixture config proc REPPREPDIRECT2: the prepare runner is invoked with that proc name.

## Out of scope

- Do not put a guessed interface ENAME in the config.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #411
