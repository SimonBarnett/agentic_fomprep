---
name: hours-log-work-session
description: >-
  Open a Bob Fleet hours webhook entry when a task starts and close it on DONE/GIVEUP; heartbeat on long tasks; idempotency_key on retry; always append {customer}/{project}/log.md for billing evidence.
  Use when /hours-start, /hours-stop, log-work-session or matching hours webhook workflow.
---

# Hours start / stop (log work session)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. ce-priority/dayworks or SimonBarnett/ce-dayworks until Day Works moves).

Webhook (SimonBarnett/bobiverse#3450): `POST https://irc.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).

Authoritative body: `docs/skill-sources/hours/hours-log-work-session.md`.
Wire examples: bobiverse `jeeves/docs/webhooks.md`.

**When:** An agent ACKs a billable/fleet job and later DONE or GIVEUP, or the human asks to record closed hours for a day.

## Purpose

Open a time entry when a task starts and close it when it ends so the hours
drafter has source material. Entries are **not** posted to Priority by this
skill.

## CAST IRON — project work log

Always append actual work done to `{customer}/{project}/log.md` (customer-repo
layout: `{project}/log.md`). **Create if missing.** Billing evidence — not
optional. No secrets.

## Live JSON fields (required names)

`idempotency_key`, `agent`, `on_behalf_of`, `start` (**not** `started_at`),
optional `end`, `customer` (**not** `customer_slug`), `project` (**not**
`project_slug`), `repo_url`, `description`, `tickets`, `source`,
`billable_hint`.

Closed-in-one-POST: send `start` + `end` together; expect `status:closed` and
`duration_minutes`.

## Steps (hours-start)

1. On ACK (or explicit start), `POST /bob/v1/hours` with open entry fields.
2. Store the returned entry id with the job context.
3. On long tasks, heartbeat every 15-30 minutes: `POST /bob/v1/hours/{id}/heartbeat`.
4. Reuse the same `idempotency_key` if the create must be retried.

## Steps (hours-stop)

1. On DONE or GIVEUP, `POST /bob/v1/hours/{id}/close` with `{"end":"..."}`.
2. If create never succeeded, do not invent a second open entry; note the gap for
   `hours-correct` / the drafter.
3. Nothing may stay open past the webhook timeout without a reason note.
4. Append the work summary to `log.md` (CAST IRON).

## Done

- Every ACKed job has exactly one entry, closed at DONE/GIVEUP.
- Retries did not create duplicates (same `idempotency_key`).
- Project `log.md` updated for billing queries.
