---
name: hours-draft
description: >-
  Turn webhook hours entries into a Priority draft with de-overlap and 8h rules; never auto-post; update missing project.md via hours-repo-metadata.
  Use when /hours-draft or matching hours webhook workflow.
---

# Hours draft (Priority)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. SimonBarnett/ce-priority `dayworks/`; Day Works moved there from SimonBarnett/ce-dayworks on 2026-10-09).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** The drafting agent (e.g. Haitch) builds a weekday timesheet from
webhook entries plus calendar/Teams/email.

## Purpose

Turn webhook entries into a Priority hours draft for human approval. Never
auto-post to Priority.

## Steps

1. GET entries and the day summary for the day/week (Europe/London).
2. Resolve each entry's Priority record and WBS from customer/project
   `project.md` first; use `docs/skill-sources/hours/wbs-fallback-map.md` only
   as fallback. If a report arrives without `project.md`, run
   `hours-repo-metadata` to open a PR.
3. Merge with calendar, Teams and email.
4. De-overlap parallel agent time: book **human-equivalent** time, not the sum
   of agent wall clocks (see `priority-hours-orchestrator`).
5. Apply orchestrator rules: 8h/day target, real work first, filler reduced not
   padded, Recording Hours line (`priority-hours-orchestrator`).
6. Show the draft to the human. Only after **explicit approval**, post via
   `priority-hours-odata-post` to TRANSORDER_q.

## Never

- Auto-post without human approval.
- Print or store OData passwords or other secrets.
- Guess WBS when unclassified.
- Skip `{customer}/{project}/log.md` (or `{project}/log.md`) when hours were recorded — CAST IRON billing evidence (`hours-log-work-session`).

## Done

Human approved the draft; posted lines re-read and the day total matches the
draft; any missing `project.md` has a PR open.

