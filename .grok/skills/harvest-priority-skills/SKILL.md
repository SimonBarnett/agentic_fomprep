---
name: harvest-priority-skills
description: >
  Promote repeatable Priority / formprep / hours / UAT / DBA playbooks into
  SimonBarnett/agentic_fomprep (catalog + docs/skill-sources + optional
  .grok/skills). Use when you learn a new Priority procedure, or the user says
  harvest skills, add it to the skills, skill harvest, harvest back to the
  Priority repo, /harvest-priority-skills, CAST IRON harvest, or everyone
  harvest your skill. Do not wait for a scheduled harvest. Does not dispatch
  product builds.
---

# Harvest Priority skills (`agentic_fomprep`)

Remote: `https://github.com/SimonBarnett/agentic_fomprep`.

This is the **foundation harvest skill** for the Priority skills product. Sister
harvest skills own other products (see CAST IRON table).

## CAST IRON (Simon 2026-09-22)

**If you learn something new, harvest it back to the relevant repo.** Do not
leave a playbook only in a local `~/.grok/skills` or agent workflow folder.
Do not wait for an hourly task.

| Playbook | Repo | Harvest skill |
|----------|------|----------------|
| Priority catalog, formprep, hours, UAT, OData, shell, DBA skills in this product | `SimonBarnett/agentic_fomprep` | `harvest-priority-skills` (this file) |
| Fleet / build / MRB / Bob jobs | `SimonBarnett/agentic_build` | `harvest-agent-skills` |
| IRC wire, talk seats, SEAL, moot, file, dumb, invite-airc, Ergo, Watch-Bobiverse, Halloy | `SimonBarnett/agentic_irc` | harvest into that repo’s `.grok/skills/` |
| Other skill products | that public repo | `.grok/skills/harvest-<repo>/SKILL.md` |

**During the job, not later.** If this session learned a repeatable Priority
procedure (trigger, owner skill, hard rule), write or edit:

1. `docs/skill-sources/<area>/` — authoritative procedure body (Priority-generic).
2. `v2/apps/mcp-catalog/catalog/<skill-id>/SKILL.md` + `meta.json` — catalog leaflet.
3. Dated note under `docs/*-skill-harvest-YYYY-MM-DD.md` when the batch is material.
4. Optional `.grok/skills/<name>/SKILL.md` for Grok-local install mirrors.

Commit on a **branch** and open a **PR**. Do not `git push origin main` for a
skill harvest. Empty harvest: **no git commit**.

## Scan

1. Local agent workflows / demo notes that encode Priority UI or OData steps.
2. Teammate harvest packs under `/workspace/*harvest*` on the box.
3. Gaps called out in `docs/skill-sources/README.md` (e.g. skipped hours trio).
4. Existing catalog skills — expand stubs; do not duplicate under a CE-only id.

A candidate is useful only if it is **repeatable**, has a clear trigger, and is
not a single incident report.

## Write rules

- Priority-generic skill ids (`priority-*`). CE / Medatech hosts and project
  codes are **examples** in prose/config only — not the skill identity.
- No secrets, passwords, or live OData bases hardcoded.
- Do not invent ENAMEs or edit v1 Form Prep runners unless the FR says so.
- Keep DBA handoff (`priority-hours-handoff-haitch`) distinct from timesheet
  skills (`priority-hours-*` entry/search/OData).

## Do not

- Commit "nothing found".
- Force-push, secrets, or `password=` assignments.
- Invent skills from noisy chat without a procedure.
- Claim ready for human UAT.
- Route IRC playbooks into this repo — those go to `agentic_irc`.
