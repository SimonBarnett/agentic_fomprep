# Hours correct

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. SimonBarnett/ce-priority `dayworks/`; Day Works moved there from SimonBarnett/ce-dayworks on 2026-10-09).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** An entry is wrong, duplicated, or must be withdrawn before drafting.

## Purpose

Fix or withdraw without double counting.

## Steps

1. Prefer updating the existing entry fields when the webhook allows a correct
   path; otherwise post a superseding entry with `supersedes: <id>` or
   `POST .../withdraw`.
2. Never post a second independent copy of the same work window.
3. Recompute day totals (Europe/London) before and after; they must reflect a
   single corrected value.

## Done

Day totals before and after show one corrected value; no duplicate open/closed
pairs for the same idempotency key.

