# FR-006: Fake-installer tests stay offline

**Repo:** SimonBarnett/agentic_fomprep
**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/571
**Labels:** feature-request

## Goal

CI never calls x.ai, cursor.com, or opencode.ai.

## Deliverables

- The tests named in docs/functional-spec-priority-agent-msi.md.
- A guard that fails the suite if a test invokes a network installer URL.

## Testable

- The suite exits 0 with no network.
- A test that calls one of those three hosts fails the guard.

## Out of scope

- One interactive check of the real installers outside CI.
