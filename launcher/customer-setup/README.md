# Haitch customer setup (Priority)

The launcher does not create customer repos or project folders. Haitch does.
Copy this folder's templates into the new repo on a branch and open a PR.
Do not push to `main`. Do not deploy. Do not write to a customer database.

## Customer repo

- GitHub topic `priority-customer` on a `SimonBarnett/<customer>` repo.
- Repo name stays the customer name. It is not an SC or SO number.
- Root `AGENTS.md` points hours at the webhook below and keeps secrets out of git.

## Project folder

The folder name is the authoritative service-call or sales-order id already
issued for that work: `SC` or `SO` followed by digits (`SC100001`, `SO100001`).
One customer repo can hold several of those folders.

Do not invent an id. Do not rename `ordinal2`, `project`, or a ticket nickname
into an SC/SO unless the authoritative number is already evidenced. If it is
not evidenced, leave the folder as it is and do not file hours against a guess.

`priority_project` inside `project.md` is the Medatech project booking id.
`wbs` is the work-breakdown code. Neither field replaces the folder name, and
the folder name does not replace them.

## Hours

Store: `POST https://bob.ntsa.uk/bob/v1/hours` (bobiverse `jeeves/docs/webhooks.md`,
FR #3450 / #3673). No shared secret.

- `idempotency_key`: `priority-agent-<full-session-uuid>`. Reuse it on retry.
- Required by the server: `idempotency_key`, `agent`, `on_behalf_of`, `start`.
- `on_behalf_of` is the Priority USERLOGIN for that person.
- `customer` is the customer repo name. `project` is the SC/SO folder name.
- Optional: `end`, `repo_url`, `description`, `source`, `tickets`, `billable_hint`.
- Do not send `duration_minutes`, alias names, or credential fields.
- Persist the returned `id` (`h_` plus 16 hex characters). Heartbeat every 15-30 minutes.
- Close with a real `end`. `auto_closed` after the open timeout (default 120 minutes)
  is not a successful report. Do not invent an end or a duration to avoid it.
- The launcher matches, client-side, one `status: closed` entry with that id,
  the same idempotency key, the same USERLOGIN, customer, and project, and a
  real start/end. The list query has no key filter.
- `log.md` is narrative evidence. It is not the hours database.
- Nothing here posts a Priority timesheet.

GitHub deliveries stay on `POST /bob/v1/git`. That route is not the hours store.
Do not send hours to the git route, and do not treat an IRC hostname as the hours endpoint.

A blocked or missing GET is delivery unverified. Do not claim the report arrived
without a list readback that contains the entry. Do not POST a fixture as if it were work.

## Templates

- `project.md.template` -> `<SCxxxxxx-or-SOxxxxxx>/project.md`
- `log.md.template` -> `<SCxxxxxx-or-SOxxxxxx>/log.md`
- `AGENTS.snippet.md` -> merge into the customer repo `AGENTS.md`
- `SKILL-SECTIONS.md` -> generic sections for the local setup skill (do not overwrite a skill store from this repo)
