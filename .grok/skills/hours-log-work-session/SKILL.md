---
name: hours-log-work-session
description: >-
  Open a Bob Fleet hours webhook entry when a task starts and close it on DONE/GIVEUP; heartbeat on long tasks; idempotency_key on retry; always append {customer}/{project}/log.md for billing evidence.
  Use when /hours-start, /hours-stop, log-work-session or matching hours webhook workflow.
---

# Hours start / stop (log work session)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. SimonBarnett/ce-priority `dayworks/`; Day Works moved there from SimonBarnett/ce-dayworks on 2026-10-09).

Webhook (SimonBarnett/bobiverse#3450): `POST https://bob.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).

Authoritative body: `docs/skill-sources/hours/hours-log-work-session.md`.
Wire examples: bobiverse `jeeves/docs/webhooks.md`.

**When:** An agent ACKs a billable/fleet job and later DONE or GIVEUP, or the human asks to record closed hours for a day.

## Purpose

Open a time entry when a task starts and close it when it ends so the hours
drafter has source material. Entries are **not** posted to Priority by this
skill.

## CAST IRON - project work log

Always append actual work done to `{customer}/{project}/log.md` (customer-repo
layout: `{project}/log.md`). **Create if missing.** Billing evidence - not
optional. No secrets.

## Inputs (canonical POST body fields)

Source of truth for accepted vs rejected names:
SimonBarnett/bobiverse `jeeves/docs/webhooks.md` (Agent field map; FR #3673).
Authoritative examples also live in `docs/skill-sources/hours/hours-log-work-session.md`.

| Field | Meaning |
|-------|---------|
| `idempotency_key` | Stable key; reuse on retry (required) |
| `agent` | IRC / seat nick (required) |
| `on_behalf_of` | Priority USERLOGIN (example: `SimonB`) |
| `start` | ISO-8601 datetime when the entry opens (required on create) |
| `end` | ISO-8601; omit while open; include with `start` for closed-in-one-POST |
| `customer` | e.g. `ce-priority` / `trutex` |
| `project` | e.g. `dayworks` / `deposco` |
| `repo_url` | GitHub URL for the work |
| `description` | Short human description |
| `tickets` | Optional array of issue/PR refs |
| `source` | Seat / machine (example: `marchhare`) |
| `billable_hint` | Optional `Y` / `N` |

### Rejected aliases (do not send)

| Accepted | Rejected aliases |
|----------|------------------|
| `start` | `started_at`, `start_at`, `started`, `from` |
| `end` | `ended_at`, `finish` |
| `customer` | `customer_slug` |
| `project` | `project_slug` |

Missing/empty `start` (including when only an alias was sent) returns
`missing_start` with `rejected_aliases` (bobiverse FR #3673). Unparseable
`start` returns `bad_start`.

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
