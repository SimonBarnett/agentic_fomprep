---
name: harvest-priority-skills
description: >
  Promote repeatable Priority-generic formprep / hours / UAT / Priority MCP
  playbooks into SimonBarnett/agentic_fomprep (catalog + docs/skill-sources +
  optional .grok/skills). Nothing that requires a Clarkson Evans Priority
  installation. Use when you learn a new Priority procedure, or the user says
  harvest skills, /harvest-priority-skills, CAST IRON harvest, honesty box.
  AUTOMATIC same-turn. Does not dispatch product builds.
---

# Harvest Priority skills (`agentic_fomprep`)

Remote: `https://github.com/SimonBarnett/agentic_fomprep`.

Foundation bargain (book-wide): see `harvest-agent-skills` (honesty box /
Three Laws). This skill owns **Priority-generic** harvest paths in this repo.

## CAST IRON (Simon 2026-09-22 / honesty-box 2026-09-28)

**If you learn something new, harvest it back to the relevant repo.** Do not
leave a playbook only in a local `~/.grok/skills` or agent workflow folder.

**AUTOMATIC same-turn:** harvest before `!bored` / idle when this session
learned a repeatable Priority procedure or hit a wrong skill.

| Playbook | Repo | Harvest skill |
|----------|------|----------------|
| Priority-**generic** catalog, formprep, hours, UAT, OData, shell, Priority MCP (no CE install required) | `SimonBarnett/agentic_fomprep` | `harvest-priority-skills` (this file) |
| Clarkson Evans Priority instance / hardware / DBA / CE customisations | `SimonBarnett/ce-priority` | `.grok/skills/harvest-agent-skills` |
| CE Day Works **product** only | `SimonBarnett/ce-dayworks` | `.grok/skills/harvest-agent-skills` |
| Fleet / build / MRB / Bob jobs | `SimonBarnett/agentic_build` | `harvest-agent-skills` |
| IRC wire, talk seats, SEAL, moot, file, dumb, invite-airc, Ergo, Watch-Bobiverse, Halloy | `SimonBarnett/agentic_irc` | harvest into that repo's `.grok/skills/` |
| Other skill products | that public repo | `.grok/skills/harvest-agent-skills/SKILL.md` |

**During the job, not later.** If this session learned a repeatable Priority
procedure (trigger, owner skill, hard rule), write or edit:

1. `docs/skill-sources/<area>/` - authoritative procedure body (Priority-generic).
2. `v2/apps/mcp-catalog/catalog/<skill-id>/SKILL.md` + `meta.json` - catalog leaflet.
3. Dated note under `docs/*-skill-harvest-YYYY-MM-DD.md` when the batch is material.
4. Optional `.grok/skills/<name>/SKILL.md` for Grok-local install mirrors.
5. Append `docs/skill-harvest-log.md`.

Commit on a **branch** and open a **PR**. Do not `git push origin main` for a
skill harvest. Empty harvest: **no git commit**.

If push/PR fails: open a `harvest:` / `FR:` issue with the patch description;
on Bob seats without git push, use Bob intake/outbox so a push-capable seat
lands the PR (same as DEV1 -> ionos path for issue #58).

## Scan

1. Local agent workflows / demo notes that encode Priority UI or OData steps.
2. Teammate harvest packs under `/workspace/*harvest*` on the box.
3. Gaps called out in `docs/skill-sources/README.md`.
4. Existing catalog skills - expand stubs; do not duplicate under a CE-only id.

## Write rules

- Priority-generic skill ids (`priority-*`). CE / Medatech hosts and project
  codes are **examples** in prose/config only - not the skill identity.
- Every catalog leaflet includes:
  `Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.`
- No secrets, passwords, or live OData bases hardcoded.
- Do not invent ENAMEs or edit v1 Form Prep runners unless the FR says so.
- Keep hours handoff (`priority-hours-handoff-haitch`) distinct from timesheet
  skills (`priority-hours-*` entry/search/OData).
- CE DBA / hardware / install scripts → `ce-priority` (`docs/dba/`), never
  re-land under `docs/skill-sources/dba/` here (pointer README only).

## Do not

- Commit "nothing found".
- Force-push, secrets, or `password=` assignments.
- Invent skills from noisy chat without a procedure.
- Claim ready for human UAT.
- Route IRC playbooks into this repo - those go to `agentic_irc`.
- Land content that **requires** a Clarkson Evans Priority installation.
