# FR-010: DryRun/fixture test for intake tools default repo

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

Automated test proves Report/Harvest tools emit `repo=SimonBarnett/agentic_fomprep` when `-Repo` is omitted.

## Deliverables

- Test under `tests/` or catalog-adjacent fixture invoked by `Test-PriorityCatalog.ps1` or a small `tests/Test-FomprepIntakeTools.ps1`.
- Invoke tools with `-DryRun` (or parse script defaults if DryRun prints JSON).
- Assert default repo string; assert Kind validation rejects garbage kind.
- No live POST in the test (offline only).

## Testable

- Test exit 0 on CI/local without network.
- Breaking the default repo string fails the test.
- Does not require CredMan / SQL / DEV1.

## Out of scope

- Live intake integration test against irc.ntsa.uk.
