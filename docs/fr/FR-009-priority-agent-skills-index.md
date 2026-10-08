# FR-009: PRIORITY-AGENT-SKILLS index lists intake tools

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

`.grok/skills/PRIORITY-AGENT-SKILLS.md` (and Sync writer if it regenerates the file) lists harvest intake helpers so CWD agents discover them.

## Deliverables

- Index rows for `tools/Report-FomprepIntakeIssue.ps1` and `tools/Invoke-FomprepHarvest.ps1`.
- Pointer to `docs/skillbook-referral.md`.
- If `Sync-PriorityGrokSkills.ps1` regenerates the manifest via `WriteAllText` UTF-8 no BOM, update that generator path; do not reintroduce `Set-Content -Encoding UTF8` (BOM / CAT-T60).

## Testable

- Manifest contains both tool filenames and `skillbook-referral`.
- Regenerated file has no UTF-8 BOM (first bytes not EF BB BF).
- CAT-T60 still green.

## Out of scope

- Changing default Sync exclude lists for Day Works / DBA.
