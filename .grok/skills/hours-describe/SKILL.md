---
name: hours-describe
description: >-
  Plain-English deliverable description for hours entries; supply a PDES short form of at most 60 characters with no WP/agent jargon.
  Use when /hours-describe or matching hours webhook workflow.
---

# Hours describe

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. ce-priority/dayworks or SimonBarnett/ce-dayworks until Day Works moves).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** Writing the webhook description or Priority PDES short form.

## Purpose

Plain-English deliverable description for humans and Priority.

## Rules

- No internal WP/gate codes.
- No agent names or fleet jargon.
- Jira IDs (e.g. PE-23) only when that day's work was on that ticket.
- Longer webhook description is fine; always also supply a short form **<= 60**
  characters for Priority PDES.

## Examples (short form <= 60)

| Long (webhook ok) | Short PDES (<= 60) |
|-------------------|--------------------|
| Merged Day Works form prep fix for PE-23 and verified LASTPREPDATE moved on DEV | Day Works prep fix PE-23 on DEV |
| Drafted Clarkson Evans timesheet lines from calendar and Teams for Monday | CE hours draft from calendar/Teams |
| Investigated backup job failure on DEV SQL and documented triage steps | DEV SQL backup job triage notes |

Bad (do not use): `WP3 gate G2 Haitch agentic_fomprep FR#121`.

## Done

Description passes the rules; short form length <= 60.

