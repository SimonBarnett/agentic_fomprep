---
date: YYYY-MM-DD       # the working day the effort belongs to (weekday)
agent: dayworks-grok
status: staged          # staged, then booked (Haitch sets this)
# booked: YYYY-MM-DD    # Haitch adds this when booked
---

| project  | wbs | role | hours | description                                    | evidence       |
|----------|-----|------|-------|------------------------------------------------|----------------|
| PR230001 | 5   | dev  | 0.0   | Plain deliverable wording                      | PR #n          |
| PR230001 | 5   | test | 0.0   | Plain deliverable wording for the tests        | evidence/...   |

<!--
Rules (see docs/agent-loop.md):
- Push daily files to the `hours` branch, never to main. That branch is
  append-only: no force-push, no delete. No PR needed.
- Human-equivalent hours, not agent run time. Every line needs evidence.
- Failed test runs link to their CASE file in evidence/ (on main).
- Never edit after push; correct with a minus line + reason.
- WBS 5 by default, 2.35 DBA/disk, 1000 catch-up, ? if unsure.
-->
