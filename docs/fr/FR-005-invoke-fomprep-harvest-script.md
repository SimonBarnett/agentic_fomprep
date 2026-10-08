# FR-005: tools/Invoke-FomprepHarvest.ps1

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

Session-close harvest helper defaults to `SimonBarnett/agentic_fomprep` and supports `-Flush` of queued harvest payloads.

## Deliverables

- `tools/Invoke-FomprepHarvest.ps1`: `-Summary`, `-Lesson`, optional `-Repo` default `SimonBarnett/agentic_fomprep`, `-Flush`, secret scan.
- kind=`harvest` payload to same intake URL as FR-004.
- Offline harvest-outbox + idempotent flush.
- Documented relationship: use Report script for individual bugs/FRs; use this to close a session.

## Testable

- Default `-Repo` in script source / DryRun JSON is `SimonBarnett/agentic_fomprep`.
- `-Flush` alone does not require Summary/Lesson.
- Empty harvest (no summary/lesson and not Flush) exits non-zero or no-ops per documented contract (pick one and test it).

## Out of scope

- Report script (FR-004); skill prose (FR-002/003).
