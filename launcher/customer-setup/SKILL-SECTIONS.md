# Generic sections for the local setup skill

Save these into the setup skill the parent maintains. Do not treat them as a
live receipt, and do not copy customer-specific folder maps into them.

## Hours store

Work reports go to `POST https://bob.ntsa.uk/bob/v1/hours` (create), then
`POST /bob/v1/hours/{id}/heartbeat`, `/close`, or `/withdraw`.
List with `GET /bob/v1/hours?user=<Priority USERLOGIN>&from=YYYY-MM-DD&to=YYYY-MM-DD&status=closed`.
Summary and export also require `user`. Day filters use Europe/London.
No shared secret. Match `idempotency_key` on the returned `entries` array.
There is no key query parameter.

Required create fields from `bobhours.py`: `idempotency_key`, `agent`,
`on_behalf_of` (Priority USERLOGIN), `start` (ISO-8601). Optional: `end`,
`customer`, `project`, `repo_url`, `description`, `source`, `tickets`,
`billable_hint`. Reject `started_at`, `start_at`, `started`, `from`,
`ended_at`, `finish`, `customer_slug`, `project_slug`, and credential keys.
Do not send `duration_minutes`; a closed entry's duration is derived from
start and end. Reuse one `priority-agent-<full-session-uuid>` key on retry.
Persist the returned `id`. Heartbeat every 15-30 minutes while open.
An open entry with no heartbeat becomes `auto_closed` after 120 minutes by
default. That status is not a successful close. Do not invent an end.

A report counts only when a list readback shows one `closed` entry with the
persisted id, the same key, the same USERLOGIN, the expected customer and
project, and a real start/end whose `duration_minutes` matches that span.
`log.md` is narrative only. Do not book Priority from the webhook.

## Customer project folders

`customer` is the customer repository name. `project` is the folder name, and
that folder must already be the authoritative `SCxxxxxx` or `SOxxxxxx`.
`priority_project` and `wbs` live in `<folder>/project.md`. They are different
fields from the folder name. Do not rename a folder without that evidence.

## Git events stay separate

`POST /bob/v1/git` is the GitHub webhook route. It is not the hours store.
Do not send hours payloads there. An older setup line that names
`irc.ntsa.uk/bob/v1/git` is a git-events integration, not the hours endpoint.
The published HTTP base for `/bob/v1/*` is `https://bob.ntsa.uk`. IRC connectivity
stays on `irc.ntsa.uk` and is not an HTTP hours host.
