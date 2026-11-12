# FR-042: batch up to 8 reads on one login

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Several reads share one session.

## Deliverables

- batch --request <file> with a reads array.
- Allowed verbs: whoami, form columns, form rows, table columns, table exists, companies, proc text, interface list.
- Maximum 8 reads. A 9th exits 2 before login.
- Any other verb exits 2 reason batch_write_refused before login.
- One login for the whole file.

## Testable

- Three reads: login count 1 and three result objects.
- A form new inside the file: login count 0 and exit 2.
- Nine reads: exit 2.

## Out of scope

- Writes stay single-verb.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #424
