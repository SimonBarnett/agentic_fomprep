# FR-007: CAT gates for intake needles + default Repo

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

Lock S1–S4 with new unique `Add-Gate` ids in `v2/tools/Test-PriorityCatalog.ps1` so intake routing cannot regress silently.

## Deliverables

- Before coding: `Select-String Add-Gate` and take next free ids (expect CAT-T61+ after CAT-T60 on main @ 4dd00ab).
- Gates asserting:
  - `AGENTS.md` has intake URL + `SimonBarnett/agentic_fomprep`.
  - Both harvest `SKILL.md` files have intake URL + home repo.
  - `tools/Report-FomprepIntakeIssue.ps1` and `tools/Invoke-FomprepHarvest.ps1` exist and contain default repo string.
  - `docs/skillbook-referral.md` exists with intake + home repo needles.
- ASCII-only runner discipline; never reuse Add-Gate ids.
- Suite exit 0 on the PR.

## Testable

- `v2\tools\Test-PriorityCatalog.ps1` exit 0 on the branch after FR-001..006 land (or this PR stacks after them).
- New gate ids unique vs existing CAT-T*.
- Intentionally removing the `-Repo` needle from AGENTS fails the new gate in a local negative check (document in PR body).

## Out of scope

- Implementing AGENTS/skills/tools/docs content (prior FRs); this FR may land after or with them but gates must not go green on stubs that lack needles.
