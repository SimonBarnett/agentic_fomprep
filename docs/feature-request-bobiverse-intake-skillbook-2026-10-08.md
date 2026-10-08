# Feature request: Bobiverse intake + dual-mode Priority Agent skillbook

**Target repo:** `SimonBarnett/agentic_fomprep` (existing; do **not** `gh repo create`)  
**Plan session:** `work/plan-20261008-101810`  
**Date:** 2026-10-08  
**Status:** PARKED — small FRs filed as issues #109–#118; mirrors under `docs/fr/`

## Operator brief (LOCKED intent)

1. This repo must **report via the Bobiverse intake** (`POST https://irc.ntsa.uk/bob/v1/intake`).
2. It must work as an **agent started in its CWD** (repo root) **or** as a **skillbook** another agent is pointed at.
3. Other agents that use Priority / formprep skills must file **issues / FRs / skill harvests** back to **`SimonBarnett/agentic_fomprep`**, not to bobiverse harvest tips for product lessons.

Repo spelling is **`agentic_fomprep`** (not `agentic_formprep`).

## Objective

Any agent that starts in `agentic_fomprep` CWD, or loads this repo's skillbook from elsewhere, files every issue/FR/skill/harvest through Bobiverse intake with `repo=SimonBarnett/agentic_fomprep`, and promotes Priority-generic playbooks to this home repo.

LOCKED

## Success

| id | metric | target | how measured | fail-when |
|----|--------|--------|--------------|-----------|
| S1 | AGENTS CAST IRON intake | Root `AGENTS.md` names intake URL and `-Repo SimonBarnett/agentic_fomprep` for kind issue\|fr\|skill\|harvest | `Select-String` / CAT gate on `AGENTS.md` | Missing URL, missing `-Repo`, or default repo is bobiverse |
| S2 | Harvest skills route home | `harvest-agent-skills` + `harvest-priority-skills` document same intake + home repo | CAT gate needles in both `SKILL.md` | Skills only say "open GitHub issue" with no intake path |
| S3 | CWD tools default repo | `tools/Report-FomprepIntakeIssue.ps1` and `tools/Invoke-FomprepHarvest.ps1` default `-Repo SimonBarnett/agentic_fomprep` and POST intake (or queue offline) | Script `-WhatIf`/`-DryRun` JSON `repo` field + Pester/catalog gate | Default repo wrong; no offline queue |
| S4 | Skillbook referral | Docs + harvest skills state: referring agent loads `.grok/skills/harvest-*` / Priority leaflets and still files to `agentic_fomprep` | `docs/skillbook-referral.md` + CAT needles | Referral path silent on intake home |
| S5 | Wrong-book refuse | Fleet bob/airc/jeeves tips stay bobiverse; Priority-generic tips stay here | Prose in AGENTS + harvest skills + optional CAT needle | Product tips directed to bobiverse `harvest/SKILL.md` |
| S6 | Regression gate | New CAT-T ids cover S1–S4 needles; `Test-PriorityCatalog.ps1` exit 0 | Suite run on CI / local | Suite red or gate ids reused |

## Shape

Primary: UNKNOWN

Hybrid note: FR surface is skills + AGENTS + tools scripts (no new UI). Existing product remains Priority Agent / catalog home (`VISION.md`).

LOCKED / UNKNOWN: UNKNOWN

## Stack

Default: Windows PowerShell 5.1 scripts in `tools/`, Markdown skills under `.grok/skills/`, catalog gate `v2/tools/Test-PriorityCatalog.ps1`, Bobiverse intake HTTP POST (no auth by default).

Why: Matches fleet intake already used by bobiverse / a-search; CWD agent and referred skillbook both need a deterministic script without inventing a second webhook.

Why-not: GitHub-only `gh issue create` (fails on seats without push); parking product tips under bobiverse harvest (wrong-book); requiring `C:\ai\bob` install for every Priority session (breaks skillbook-only referral).

LOCKED

## Architecture

```
[Agent in agentic_fomprep CWD]
    -> read AGENTS.md (CAST IRON)
    -> .grok/skills/* (Priority + harvest-*)
    -> tools/Report-FomprepIntakeIssue.ps1  \  POST https://irc.ntsa.uk/bob/v1/intake
    -> tools/Invoke-FomprepHarvest.ps1      /  repo=SimonBarnett/agentic_fomprep
    -> offline: report-outbox/ / harvest-outbox/ then -Flush

[Other agent referred to this skillbook]
    -> load harvest-priority-skills / harvest-agent-skills (github: agentic_fomprep)
    -> same tools path if clone present; else POST intake with explicit repo
    -> Priority playbook PR -> SimonBarnett/agentic_fomprep (never main)
    -> fleet-only lessons -> SimonBarnett/bobiverse (wrong-book refuse here)

Trust: no secrets in filings; intake optional X-Bob-Intake-Key only if host enables keyed mode.
```

LOCKED

## Gap vs origin/main (ff-checked 2026-10-08 @ 4dd00ab)

Present today:

- Root `AGENTS.md` Priority Agent home + Sync-PriorityGrokSkills (CAT-T60).
- `.grok/skills/harvest-agent-skills` frontmatter `github: SimonBarnett/agentic_fomprep`.
- `.grok/skills/harvest-priority-skills` Priority-generic harvest paths + vague "Bob intake/outbox" mention.
- Catalog Foundation line gate CAT-T50; Sync preserves harvest skills.

Missing today:

- No CAST IRON intake block with explicit `-Repo SimonBarnett/agentic_fomprep` (a-search already has this pattern).
- No repo-local `Report-*` / `Invoke-*Harvest` tools defaulting to this product.
- No skillbook-referral doc for agents not sitting in this CWD.
- No CAT gates locking intake needles / default `-Repo`.
- Harvest skills do not make intake the mandatory same-turn file path for issue|fr|skill|harvest.

Related fleet gap (do **not** twin): bobiverse living FR #3318 (Plan-seat harvest still hardcoded to bobiverse). This FR pack is the **product-side** fix for agentic_fomprep CWD + skillbook referral.

## Screens

No UI. Shape UNKNOWN — no HTML mocks.

## LOCKED

- Target repo `SimonBarnett/agentic_fomprep`
- Intake URL `https://irc.ntsa.uk/bob/v1/intake`
- Default intake `repo` field = `SimonBarnett/agentic_fomprep`
- Dual mode: CWD agent + referred skillbook
- Anti-omnibus: many small Goal/Deliverables/Testable FRs (see `fr/`)

## UNKNOWN

- Whether thin tools wrap bobiverse scripts when `BOB_INSTALL_ROOT` exists, or always self-contained POST (recommend self-contained + optional delegate)
- Whether Sync should copy `tools/*.ps1` anywhere outside the clone (recommend no — document clone/tools path)
