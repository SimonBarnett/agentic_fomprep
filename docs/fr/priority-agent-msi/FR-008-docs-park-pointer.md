# FR-008: Docs park pointer

**Repo:** SimonBarnett/priority-mcp
**Issue:** https://github.com/SimonBarnett/priority-mcp/issues/573
**Labels:** feature-request

## Goal

Park the MSI vision, functional spec, mocks, and FR mirrors under docs/.
Open one GitHub issue per implementation slice. The docs PR uses Refs
for those issues and Closes only this park-process issue.

## Deliverables

- docs/feature-request-priority-agent-msi-2026-11-12.md
- docs/functional-spec-priority-agent-msi.md
- docs/mocks/priority-agent-msi/home.html, empty.html, error.html
- docs/fr/priority-agent-msi/FR-001 through FR-007

## Testable

- The docs PR body lists Refs for the implementation issues.
- Those issues stay open after the docs PR merges.
- Only this issue is closed by the docs PR.
