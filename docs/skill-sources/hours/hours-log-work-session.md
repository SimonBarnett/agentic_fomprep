# Hours start / stop (log work session)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. ce-priority/dayworks or SimonBarnett/ce-dayworks until Day Works moves).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).


**When:** An agent ACKs a billable/fleet job and later DONE or GIVEUP.

## Purpose

Open a time entry when a task starts and close it when it ends so the hours
drafter has source material. Entries are **not** posted to Priority by this
skill.

## Inputs

| Field | Meaning |
|-------|---------|
| agent nick | IRC / seat nick |
| `on_behalf_of` | Priority USERLOGIN (example: `SimonB`) |
| customer slug | e.g. `ce-priority` |
| project slug | e.g. `dayworks` (or `ce-dayworks` until Day Works moves under ce-priority) |
| repo URL | GitHub URL for the work |
| task / ticket ref | issue, FR, PE-xx, meeting id |
| `idempotency_key` | stable key for this job (reuse on retry) |
| source seat / machine | e.g. `marchhare-20680` |

## Steps (hours-start)

1. On ACK (or explicit start), `POST /bob/v1/hours` with open entry fields above.
2. Store the returned entry id with the job context.
3. On long tasks, heartbeat every 15-30 minutes: `POST /bob/v1/hours/{id}/heartbeat`.
4. Reuse the same `idempotency_key` if the create must be retried.

## Steps (hours-stop)

1. On DONE or GIVEUP, `POST /bob/v1/hours/{id}/close` with end time (Europe/London).
2. If create never succeeded, do not invent a second open entry; note the gap for
   `hours-correct` / the drafter.
3. Nothing may stay open past the webhook timeout without a reason note.

## Done

- Every ACKed job has exactly one entry, closed at DONE/GIVEUP.
- Retries did not create duplicates (same `idempotency_key`).

