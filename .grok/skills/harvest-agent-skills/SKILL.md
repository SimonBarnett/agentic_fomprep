---
name: harvest-agent-skills
description: >
  FOUNDATION skill for every skill book. Identify this skill's home GitHub,
  harvest playbooks back as a PR, and report gaps as issues/FRs. Triggers:
  harvest skills, CAST IRON harvest, honesty box, skill book foundation,
  learned a procedure, hourly skill check, /harvest-agent-skills, promote a
  playbook, skill harvest. Prefer deterministic scripts over LLM reasoning.
  Does not dispatch product builds.
github: https://github.com/SimonBarnett/agentic_fomprep
---

# Harvest agent skills (honesty box)

## Home GitHub (required on every harvest skill)

**This skill's home:** `https://github.com/SimonBarnett/agentic_fomprep`

Every skill book ships this foundation skill (or a repo-local twin). The twin's
frontmatter `github:` MUST name the public repo that owns that book.

| Playbook domain | Home repo | Foundation skill |
|-----------------|-----------|------------------|
| Priority catalog, formprep, hours, UAT, OData, shell, DBA, Priority MCP | `SimonBarnett/agentic_fomprep` | `harvest-priority-skills` (this book) |
| IRC wire, Jeeves, talk seats, SEAL, moot, file, dumb, Ergo, Watch-Bobiverse | `SimonBarnett/agentic_irc` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Fleet / build / MRB / Bob jobs / TipForm | `SimonBarnett/agentic_build` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| MUD / Discworld | `SimonBarnett/mud-skill` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Visionary / new-product strategy | `SimonBarnett/skills-visionary` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Design UAT | `SimonBarnett/bob-design-uat` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Club Madeira Awin connector | `SimonBarnett/club-madeira-awin-connector` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Other skill products | that public repo | `.grok/skills/harvest-agent-skills/SKILL.md` |

**Priority domain:** use `harvest-priority-skills` for catalog + `docs/skill-sources` harvests in this repo. This foundation skill still owns the honesty-box bargain and routing table.

## CAST IRON - cost of using this skill book

**You used these skills. You owe the home repo a report.**

This is an honesty box. Using any skill from this book binds you to return
what you learned, what broke, and what is missing. Silence after a useful
session is a breach of the bargain. Do not wait for an hourly task, a
reminder, or Bob to dismiss you.

### AUTOMATIC same-turn (non-negotiable)

If this session learned a repeatable Priority/formprep/UAT procedure, hit a
wrong skill, or invented a workaround: **harvest in the same turn** before
`!bored` / idle. Do not park "harvest later".

### Three Laws (bound)

1. Do not gut CAST IRON, safety gates, or honesty-box duties to ship faster.
2. Prefer deterministic scripts over LLM narration.
3. Report gaps as issues/FRs when a PR cannot land.

### You MUST report back to the home GitHub when any of these are true

1. You learned a **repeatable** procedure (trigger + steps + owner) not already
   in the book.
2. A skill was **wrong, incomplete, ambiguous, or token-wasteful**.
3. You hit a **bug**, gap, or missing tool that a deterministic script should
   own.
4. You invented a workaround that should become a skill or a code change.

### How to report (strict order - no main pushes)

1. **Skill harvest / playbook / fix with write access** -> branch + **pull
   request** against the home repo. Never `git push origin main` for harvest.
2. **If the PR cannot be opened** (no permission, API fail, fork blocked) ->
   open a **GitHub issue** on the home repo titled `harvest:` or `FR:` and
   paste the intended PR title, branch name, file list, and full body.
   On Bob fleet seats without `gh` push: also drop the same payload via
   **Bob intake** / shop outbox so ionos (or a push-capable seat) can land the PR.
3. **Bugs / feature requests without a ready patch** -> GitHub **issue** or
   **FR** on the home repo.
4. Empty harvest (nothing new, nothing broken): **no commit, no empty PR**.

Prefer `gh` / existing harvest scripts over free-form reasoning.

## Token efficiency (non-negotiable)

- Prefer a **deterministic tool or script** over LLM reasoning whenever both
  could finish the job.
- Do not narrate step-by-step tool plans in skills; write the command or the
  script name.
- One home per fact. Point at the owner skill; do not duplicate.
- ASCII in `SKILL.md`. Short triggers in frontmatter `description`.

## Scan (deterministic first)

1. Diff local installed skills vs repo `.grok/skills/` - promote repeatable
   user-only playbooks.
2. Run repo harvest script if present; do not reinvent it.
3. Check recent `docs/*` FRs and `docs/skill-harvest-log.md` (create if missing).
4. Skip one-off incident notes and noisy chat.

## Write

1. Edit or add `.grok/skills/<name>/SKILL.md` (`name` + `description`;
   foundation skill also has `github:` of THIS repo).
2. For Priority catalog leaflets: also update
   `v2/apps/mcp-catalog/catalog/<id>/SKILL.md` + `docs/skill-sources/` via
   `harvest-priority-skills`.
3. Append a dated line to `docs/skill-harvest-log.md`.
4. Commit on a **branch**, open a **PR**. Link related issues.
5. If catalog gates exist, add/adjust and run `v2/tools/Test-PriorityCatalog.ps1`.

## Inclusion rule

**Every skill book MUST include this foundation skill** (twin with that book's
`github:`). Other skills in the book SHOULD link it in one line:

`Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.`

(Catalog leaflets use `harvest-priority-skills`. Fleet/Bob skills in other
books use `harvest-agent-skills` pointing at their home.)

## Do not

- Push harvest to `main`.
- Commit "nothing found".
- Force-push, secrets, or live credentials into skills.
- Invent skills from noisy session chat.
- Claim ready for human UAT from a harvest alone.
- Dispatch product builds under the harvest label.
