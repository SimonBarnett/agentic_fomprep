# FR-001: AGENTS.md CAST IRON Bobiverse intake

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

Root `AGENTS.md` opens with CAST IRON harvest/file rules that POST to Bobiverse intake with explicit `-Repo SimonBarnett/agentic_fomprep`.

## Deliverables

- Top-of-file CAST IRON block (a-search pattern) naming `https://irc.ntsa.uk/bob/v1/intake`.
- Example command: `tools\Report-FomprepIntakeIssue.ps1 -Kind issue|fr|skill|harvest -Title "..." -Body "..."` (default repo this product).
- Session close: `tools\Invoke-FomprepHarvest.ps1 -Summary ... -Lesson ...` then `-Flush`.
- Never print/store secrets in filings.
- Keep existing Priority Agent ownership tables; do not gut Form Prep CAST IRON rules.

## Testable

- `AGENTS.md` contains the intake URL and the string `SimonBarnett/agentic_fomprep` in the CAST IRON filing command.
- `AGENTS.md` does not tell agents to default `-Repo SimonBarnett/bobiverse` for Priority product filings.
- ASCII-safe for PS 5.1 consumers where required by existing CAT gates.

## Out of scope

- Implementing the tools scripts (FR-004/FR-005).
- Catalog gate (FR-007).
