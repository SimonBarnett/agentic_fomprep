---
name: hours-classify
description: >-
  Map work to customer/project/WBS/ticket: project.md first, then docs/skill-sources/hours/wbs-fallback-map.md; never guess.
  Use when /hours-classify or matching hours webhook workflow.
---

# Hours classify

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. SimonBarnett/ce-priority `dayworks/`; Day Works moved there from SimonBarnett/ce-dayworks on 2026-10-09).

Webhook (SimonBarnett/bobiverse#3450): `POST https://bob.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** Opening or closing an hours entry, or drafting Priority lines.

## Purpose

Map work to customer / project / WBS / ticket for the webhook entry and later
Priority draft.

## Inputs

Repo path and URL, ticket, meeting/thread, customer cues.

## Steps

1. Webhook `customer` is the customer repository name. Webhook `project` is the
   project folder name. For customer work that folder must already be the
   authoritative service-call or sales-order id (`SC` or `SO` plus digits).
   Do not rename a folder and do not invent an id. A Medatech booking id is a
   different field and must not be copied into webhook `project`.
   Do not POST `customer_slug` / `project_slug` (bobiverse
   `jeeves/docs/webhooks.md` Agent field map).
2. Read the booking id and WBS from `<folder>/project.md` in that folder.
   **That file comes first.** Those values stay in `project.md`.
3. Only if `project.md` is missing, `docs/skill-sources/hours/wbs-fallback-map.md`
   may hint a booking id or WBS. It must not supply a folder name. If the folder
   is not an authoritative `SC`/`SO` id, leave the entry unclassified.
   Do not hard-code the map in agents.
4. When a `project.md` was missing or wrong, flag `hours-repo-metadata`.
5. When still unsure, leave booking/WBS blank and write `unclassified because...`
   on the entry. **Never guess.**

## Done

Every entry has webhook `customer` / `project` and either a resolved Priority
record/WBS (noting `project.md` vs fallback table) or an explicit unclassified
note.

