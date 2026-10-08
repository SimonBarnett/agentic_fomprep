# Hours repo metadata (project.md)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. ce-priority/dayworks or SimonBarnett/ce-dayworks until Day Works moves).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** `hours-classify` or `hours-draft` finds missing/wrong `project.md`,
or the human confirms Priority record / WBS values to park.

## Purpose

Create or correct customer/project `project.md` files so the next classify run
does not need the fallback table.

## Inputs

Customer and project slugs, repo URL, Priority customer/project record and WBS
confirmed by the drafter or human.

## Layout (Si convention)

- `/customer/project.md` - Priority customer/project record reports are made
  against (example: `ce-priority/project.md` -> PR230001).
- `/customer/project/project.md` - that project's WBS code (example:
  `ce-priority/dayworks/project.md` -> `5`). Until Day Works moves, use
  `ce-dayworks/project.md` for the Day Works WBS.

## Steps

1. Check those paths in the target customer/project repo.
2. If missing or wrong, open a branch and PR **in that repo** adding or fixing
   them. **Never push to `main`.**
3. Cite evidence for the values (human confirm, existing Priority line, map).
4. Never put secrets, passwords, or OData credentials in `project.md`.

## Done

PR open (or merged by a human/MRB) in the correct customer/project repo; the
next `hours-classify` resolves from `project.md` without the fallback table.

