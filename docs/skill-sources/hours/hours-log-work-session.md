# Hours start / stop (log work session)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.
Harvest routing: generic Priority / fleet-hours lessons stay in this repo; customer-level lessons go to the customer repo (e.g. SimonBarnett/ce-priority); project-level lessons go to the project repo (e.g. SimonBarnett/ce-priority `dayworks/`; Day Works moved there from SimonBarnett/ce-dayworks on 2026-10-09).

Webhook (SimonBarnett/bobiverse#3450): `POST https://bob.ntsa.uk/bob/v1/hours` create; `POST .../hours/{id}/heartbeat|close|withdraw`; `GET .../hours` list/summary/export. Europe/London day boundaries. Idempotency via `idempotency_key`. Reject credential fields. Never log bodies or print secrets (including Priority OData passwords).

Canonical wire examples: `jeeves/docs/webhooks.md` in SimonBarnett/bobiverse (FR #3450).

**When:** An agent ACKs a billable/fleet job and later DONE or GIVEUP, or the human asks to record closed hours for a day.

## Purpose

Open a time entry when a task starts and close it when it ends so the hours
drafter has source material. Entries are **not** posted to Priority by this
skill.

## CAST IRON - project work log (billing evidence)

Whenever you record hours (open/close **or** closed-in-one-POST), also append a
human-readable summary of **actual work done** to the project work log:

| Repo layout | Path |
|-------------|------|
| Customer repo with an SC/SO folder | `{SCxxxxxx-or-SOxxxxxx}/log.md` |
| Multi-folder layout | `{customer}/{SCxxxxxx-or-SOxxxxxx}/log.md` |

**Create the file if it is missing.** Dated entries; enough detail for a later
billing query (what shipped, PRs/issues, hours day, Bob hours entry id if known).
Never put secrets in `log.md`.

This is mandatory alongside the webhook - the webhook alone is not billing
evidence.

## Inputs (canonical POST body fields)

Source of truth: SimonBarnett/bobiverse `jeeves/docs/webhooks.md` (Agent field
map; FR #3450 / FR #3673).

| Field | Meaning |
|-------|---------|
| `idempotency_key` | Stable key; reuse on retry (required) |
| `agent` | Agent nick (required); do not send `agent_nick` |
| `on_behalf_of` | Priority USERLOGIN supplied for this agent session. Not a fixed person. |
| `start` | ISO-8601 start with offset (Europe/London) |
| `end` | ISO-8601 end; omit while open; include with `start` for closed-in-one-POST |
| `customer` | Customer repository name. Empty for a general session. |
| `project` | Authoritative `SCxxxxxx` or `SOxxxxxx` folder. Not the Medatech booking id. |
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
`{"error":"missing_start","hint":"expected: start"}` plus `rejected_aliases`
when an alias was present (bobiverse FR #3673). Unparseable `start` returns
`bad_start`. Prefer the curl examples in bobiverse `jeeves/docs/webhooks.md`.

## Steps (hours-start)

1. On ACK (or explicit start), `POST /bob/v1/hours` with open entry fields above
   (`start` set, no `end`).
2. Store the returned entry `id` with the job context.
3. On long tasks, heartbeat every 15-30 minutes: `POST /bob/v1/hours/{id}/heartbeat`.
4. Reuse the same `idempotency_key` if the create must be retried.
5. Ensure `{customer}/{project}/log.md` (or `{project}/log.md`) exists; note the
   session start there if useful.

## Steps (hours-stop)

1. On DONE or GIVEUP, `POST /bob/v1/hours/{id}/close` with
   `{"end":"<ISO-8601 Europe/London>"}`.
2. If create never succeeded, do not invent a second open entry; note the gap for
   `hours-correct` / the drafter.
3. Nothing may stay open past the webhook timeout without a reason note.
4. **Append the work summary to `log.md`** (CAST IRON above).

## Closed-in-one-POST (backfill / explicit day booking)

When the human asks to record N hours for a past or current day:

```json
{
  "idempotency_key": "priority-agent-<full-session-uuid>",
  "agent": "grok-<seat>",
  "on_behalf_of": "<Priority USERLOGIN>",
  "start": "YYYY-MM-DDT09:00:00+00:00",
  "end": "YYYY-MM-DDT10:00:00+00:00",
  "customer": "<customer-repo>",
  "project": "SC100001",
  "repo_url": "https://github.com/SimonBarnett/<customer-repo>",
  "description": "Short description of actual work",
  "tickets": ["#21"],
  "source": "<machine>",
  "billable_hint": "Y"
}
```

Do not send `duration_minutes`. On a real close the server sets `status` to
`closed` and derives `duration_minutes` from start and end (60 for the span
above). Then append `log.md`. A fixture or a blocked GET is not a receipt.

Verify only with a supported read:

```text
GET /bob/v1/hours?user=<Priority USERLOGIN>&from=YYYY-MM-DD&to=YYYY-MM-DD
GET /bob/v1/hours/summary?user=<Priority USERLOGIN>&date=YYYY-MM-DD
```

Match `idempotency_key` on the returned entries. The query has no key filter.

## Done

- Every ACKed job has exactly one entry, closed at DONE/GIVEUP (or one closed
  backfill entry per day/topic idempotency key).
- Retries did not create duplicates (same `idempotency_key`).
- `{customer}/{project}/log.md` (or `{project}/log.md`) updated with the work
  summary for billing queries.
