# FR-009: dry-run resolves the instance and does not log in

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Agents can check flags without a SaaS call.

## Deliverables

- --dry-run on any verb prints instance id, verb, and write true or false.
- login is not called.
- A missing instance still exits 2.

## Testable

- Fake SDK test: form columns --dry-run calls login zero times.
- Unknown instance still reason instance_unknown.

## Out of scope

- Dry-run does not write last-user.json.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #391
