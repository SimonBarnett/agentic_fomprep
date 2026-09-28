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
github: https://github.com/SimonBarnett/agentic_fomprep
three_laws: bound
---

# Harvest Priority skills (`agentic_fomprep`)

Foundation: harvest-agent-skills (honesty box) -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Remote: `https://github.com/SimonBarnett/agentic_fomprep`.

This is the **Priority-product harvest skill**. Sister foundation
`harvest-agent-skills` owns the honesty-box contract and cross-repo table;
this file owns where Priority files go inside this repo.

## Three Laws

Bound by Asimov's Three Laws (SimonBarnett/skill-tree `CAST_IRON/THREE_LAWS.md`).
No harvest may loosen them.

## AUTOMATIC harvest (CAST IRON - no waiting)

**Harvest in the same turn you learn or fix a Priority playbook.** Do not ask
permission. Do not wait for an hourly task. Do not leave the playbook only in
chat, `~/.grok/skills`, or a temp dir.

| Playbook | Repo | Harvest skill |
|----------|------|----------------|
| Priority catalog, formprep, hours, UAT, OData, shell, DBA skills in this product | `SimonBarnett/agentic_fomprep` | `harvest-priority-skills` (this file) |
| CE Day Works-only (WP/gate/launcher/IRC) | `SimonBarnett/ce-dayworks` | that repo's `harvest-agent-skills` |
| Fleet / build / MRB / Bob jobs | `SimonBarnett/agentic_build` | `harvest-agent-skills` |
| IRC wire, talk seats, SEAL, moot, file, dumb, invite-airc, Ergo, Watch-Bobiverse, Halloy | `SimonBarnett/agentic_irc` | harvest into that repo's `.grok/skills/` |
| Other skill products | that public repo | that repo's harvest skill |

## How to report (strict order - no main pushes)

1. Branch + **PR** against `agentic_fomprep` **in this turn**. Never
   `git push origin main` for harvest.
2. If the PR cannot be opened -> GitHub issue titled `harvest:` or `FR:` with
   intended title, branch, file list, and body **in this turn**.
3. No `gh` / not authenticated -> POST `https://irc.ntsa.uk/bob/v1/intake`
   (same JSON shape as `harvest-agent-skills`; set `repo` to
   `SimonBarnett/agentic_fomprep`). Key from `BOB_INTAKE_KEY` env only.
4. Intake unreachable -> `harvest-outbox/<ts>.json`, retry next run.
5. Empty harvest: **no git commit**, no empty PR.

## Write (Priority paths)

If this session learned a repeatable Priority procedure (trigger, owner skill,
hard rule), write or edit:

1. `docs/skill-sources/<area>/` — authoritative procedure body (Priority-generic).
2. `v2/apps/mcp-catalog/catalog/<skill-id>/SKILL.md` + `meta.json` — catalog leaflet.
3. Dated note in `docs/skill-harvest-log.md` (and a batch doc under `docs/` when material).
4. Optional `.grok/skills/<name>/SKILL.md` for Grok-local install mirrors.

Every new or edited catalog `SKILL.md` MUST include one Foundation line:
`Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.`

## Scan

1. Local agent workflows / demo notes that encode Priority UI or OData steps.
2. Teammate harvest packs under `/workspace/*harvest*` on the box.
3. Gaps called out in `docs/skill-sources/README.md`.
4. Existing catalog skills — expand stubs; do not duplicate under a CE-only id.
5. Retry `harvest-outbox/`.

A candidate is useful only if it is **repeatable**, has a clear trigger, and is
not a single incident report.

## Write rules

- Priority-generic skill ids (`priority-*`). CE / Medatech hosts and project
  codes are **examples** in prose/config only — not the skill identity.
- No secrets, passwords, or live OData bases hardcoded.
- Do not invent ENAMEs or edit v1 Form Prep runners unless the FR says so.
- Keep DBA handoff (`priority-hours-handoff-haitch`) distinct from timesheet
  skills (`priority-hours-*` entry/search/OData).
- Prefer a deterministic script over LLM reasoning when both could finish.

## Do not

- Commit "nothing found".
- Force-push, secrets, or `password=` assignments (including intake key).
- Invent skills from noisy chat without a procedure.
- Claim ready for human UAT.
- Route IRC playbooks into this repo — those go to `agentic_irc`.
- Route Day Works-only playbooks here — those go to `ce-dayworks`.
- End the turn with a new/fixed Priority skill only in chat or `~/.grok`
  without a PR, `harvest:` issue, intake POST, or outbox file.
- Ask the human whether to harvest when the honesty box already fires.
