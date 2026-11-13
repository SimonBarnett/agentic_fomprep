# FR-047: VISION.md records the last-user file and keeps the prep gate

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The product vision allows storing the identified login and still fails prep closed.

## Deliverables

- Add sentences to VISION.md: the client may store the identified USERLOGIN in the user-profile last-user file; that file must not contain tokens; the OS user remains ineligible.
- Keep the EXECPREPLOCK UPD=N and LASTPREPDATE success rule.
- Keep allowLive as the live-write gate.
- UTF-8 without BOM. ASCII.

## Testable

- A text test: VISION.md contains last-user and USERLOGIN and still contains LASTPREPDATE.
- The file has no UTF-8 BOM.

## Out of scope

- Do not change catalog gate ids in this FR.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #429
