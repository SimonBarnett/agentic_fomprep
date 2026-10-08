# FR-003: harvest-priority-skills documents Bobiverse intake

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

`harvest-priority-skills` mandates Bobiverse intake filings to `SimonBarnett/agentic_fomprep` for Priority-generic gaps and blocked harvest PRs.

## Deliverables

- Replace vague "Bob intake/outbox" prose with explicit URL + `-Repo SimonBarnett/agentic_fomprep`.
- Same-turn AUTOMATIC: file issue|fr|skill|harvest via tools scripts before idle.
- Keep Priority-generic vs ce-priority vs ce-dayworks routing table.
- Keep Sync-PriorityGrokSkills.ps1 step after catalog harvest.

## Testable

- `Select-String` finds intake URL and `SimonBarnett/agentic_fomprep` in `.grok/skills/harvest-priority-skills/SKILL.md`.
- Skill still forbids landing CE Day Works product / CE DBA runbooks here.

## Out of scope

- Foundation skill (FR-002); tools (FR-004/005).
