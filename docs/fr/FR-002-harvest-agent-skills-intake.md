# FR-002: harvest-agent-skills documents Bobiverse intake

**Repo:** SimonBarnett/priority-mcp  
**Labels:** feature-request

## Goal

Foundation skill `.grok/skills/harvest-agent-skills/SKILL.md` makes Bobiverse intake the same-turn file path for issue|fr|skill|harvest when `gh` push/PR is blocked or for bugs without a patch.

## Deliverables

- Keep frontmatter `github: https://github.com/SimonBarnett/priority-mcp`.
- Add CAST IRON intake subsection: POST `https://bob.ntsa.uk/bob/v1/intake` with `repo=SimonBarnett/priority-mcp`.
- Point at `tools/Report-FomprepIntakeIssue.ps1` and `tools/Invoke-FomprepHarvest.ps1`.
- Keep branch+PR as preferred path for playbook landings; intake is mandatory when PR cannot open and for issue/FR gaps.
- Wrong-book table unchanged for IRC/fleet/MUD homes.

## Testable

- Skill text contains intake URL and `SimonBarnett/priority-mcp` as intake repo.
- Skill text names both tools scripts.
- Frontmatter `github:` still this repo.

## Out of scope

- harvest-priority-skills twin edits (FR-003).
- Script implementation (FR-004/005).
