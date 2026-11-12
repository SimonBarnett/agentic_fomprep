# FR-023: proc continue resumes with an explicit option

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The agent answers a needs_input result without a person at the keyboard.

## Deliverables

- proc continue --instance <id> --from <step.json> --option <field>.
- --inputs <file> applies on the next inputFields.
- Missing --from exits 2.

## Testable

- Fake two-step: continue with the second option calls inputOptions with that field.
- Missing --from exits 2 and login count 0.

## Out of scope

- Does not auto-pick.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #405
