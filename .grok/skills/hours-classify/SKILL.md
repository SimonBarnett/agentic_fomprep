---
name: hours-classify
description: >-
  Map work to customer/project/WBS/ticket: project.md first, then docs/skill-sources/hours/wbs-fallback-map.md; never guess.
  Use when /hours-classify or matching hours webhook workflow.
---

# Hours classify

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. ce-priority/dayworks or SimonBarnett/ce-dayworks until Day Works moves).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** Opening or closing an hours entry, or drafting Priority lines.

## Purpose

Map work to customer / project / WBS / ticket for the webhook entry and later
Priority draft.

## Inputs

Repo path and URL, ticket, meeting/thread, customer cues.

## Steps

1. Resolve customer and project slugs from the repo path convention
   `/{customer}/{project}` (generic Priority stays in agentic_fomprep).
   Example: customer `ce-priority`, project `dayworks`. Until Day Works moves,
   treat `SimonBarnett/ce-dayworks` as the Day Works project location.
2. Read Priority customer/project record from `/customer/project.md` and WBS from
   `/customer/project/project.md`. **These files come first.**
   Example: `ce-priority/project.md` -> Clarkson Evans record `PR230001`;
   `ce-priority/dayworks/project.md` (or `ce-dayworks/project.md`) -> WBS `5`.
3. Only if those files are missing, fall back to
   `docs/skill-sources/hours/wbs-fallback-map.md` (same table as
   `priority-hours-orchestrator` examples). Do not hard-code the map in agents.
4. When a `project.md` was missing or wrong, flag `hours-repo-metadata`.
5. When still unsure, leave project/WBS blank and write `unclassified because...`
   on the entry. **Never guess.**

## Done

Every entry has customer/project slugs and either a resolved Priority record/WBS
(noting `project.md` vs fallback table) or an explicit unclassified note.

