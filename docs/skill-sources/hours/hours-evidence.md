# Hours evidence

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. ce-priority/dayworks or SimonBarnett/ce-dayworks until Day Works moves).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** Closing an hours entry or preparing the drafter pack.

## Purpose

Attach proof links so a human can verify the work before Priority post.

## Steps

1. Collect at least one of: PR URL, commit SHA URL, issue/FR URL, Teams message
   link, email message id, meeting invite/notes link.
2. Attach links on the closed entry (webhook fields or drafter notes).
3. If none exist (e.g. pure verbal advice with no artifact), write
   `no evidence because...` explicitly.

## Done

Every closed entry has at least one evidence link, or a note saying why there
is none. Never attach secrets or credential material.

