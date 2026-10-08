# FR-008: VISION.md honesty-box intake success bound

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

Root `VISION.md` states that honesty-box filings for this product use Bobiverse intake with `repo=SimonBarnett/agentic_fomprep`, dual-mode CWD/skillbook.

## Deliverables

- Short Mission/Bounds bullet(s): intake URL; default repo; CWD agent + referred skillbook.
- Do not weaken Form Prep success (`EXECPREPLOCK.UPD` / `LASTPREPDATE`) or DEV-only refuse.
- UTF-8 **without BOM**; ASCII punctuation preferred where CAT-T55/T56 care.

## Testable

- `VISION.md` contains `irc.ntsa.uk/bob/v1/intake` and `SimonBarnett/agentic_fomprep`.
- File remains UTF-8 no BOM (existing CAT-T55 class checks still pass).
- `Test-PriorityCatalog.ps1` exit 0.

## Out of scope

- Rewriting Form Prep success criteria; UI mocks.
