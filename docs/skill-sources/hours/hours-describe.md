# Hours describe

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. SimonBarnett/ce-priority `dayworks/`; Day Works moved there from SimonBarnett/ce-dayworks on 2026-10-09).

Webhook (SimonBarnett/bobiverse#3450): `POST https://bob.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** Writing the webhook description or Priority PDES short form.

## Purpose

Plain-English deliverable description for humans and Priority.

## Rules

Canonical text is `launcher/agent-rules.md` (PriorityAgent loads it). Do not
copy those rules into a customer repo and do not keep a second wording here.

- Short Priority PDES form is **<= 60** characters.
- No internal WP ids in that sentence.

Bad (do not use): `WP3 gate`.

## Done

Description passes the rules; short form length <= 60.

