# FR-006: docs/skillbook-referral.md (other agents)

**Repo:** SimonBarnett/priority-mcp  
**Labels:** feature-request

## Goal

Document how an agent **not** started in this CWD loads the Priority skillbook and still reports to `SimonBarnett/priority-mcp` via Bobiverse intake.

## Deliverables

- New `docs/skillbook-referral.md`:
  - Mode A: CWD = repo root; read `AGENTS.md` then `.grok/skills/`.
  - Mode B: referrer loads `harvest-priority-skills` / `harvest-agent-skills` + needed `priority-*` leaflets (clone or Sync'd `.grok/skills`).
  - Both modes: file with intake `repo=SimonBarnett/priority-mcp`; promote playbooks as PRs to this repo.
  - Wrong-book: fleet/IRC tips → bobiverse / agentic_irc; CE Day Works → ce-dayworks; CE DBA → ce-priority.
- One-line pointer from root `README.md` or `AGENTS.md` "Skill discovery" section to this doc.
- No secrets; ASCII-safe.

## Testable

- File exists on the branch; contains intake URL and `SimonBarnett/priority-mcp`.
- Describes both Mode A and Mode B.
- Linked from `AGENTS.md` or `README.md`.

## Out of scope

- Sync script changes; installing skills into `~/.grok/skills` globally (optional note only).
