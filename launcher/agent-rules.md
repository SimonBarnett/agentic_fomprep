<!-- rules-version: 6 -->
# Priority agent rules (from the Priority Agent launcher)

The launcher fills in the {{...}} values on every start. These rules sit on top of
`{{FOMPREP_DIR}}\AGENTS.md`, which you must read before you start work. Read the
customer repo `AGENTS.md` / `README.md` and the project folder `README.md` / `log.md`
too, if they exist.

## Context

- Level: **{{LEVEL}}** (general / customer / project)
- General Priority knowledge: `{{FOMPREP_DIR}}` (SimonBarnett/agentic_fomprep, fast-forwarded at launch).
  Skills come from `.grok/skills`. The `priority-catalog` MCP server (list_catalog, get_skill, get_instance_schema,
  get_runner_files) runs locally over stdio from the agentic_fomprep clone (`node v2/apps/mcp-catalog/stdio.mjs`;
  fallback `PriorityAgent.exe --mcp-catalog`).
- Customer: {{CUSTOMER}} ({{CUSTOMER_REPO}}, local clone `{{CUSTOMER_DIR}}`)
- Project or service call: {{PROJECT}} (`{{PROJECT_DIR}}`)
- Working directory: `{{WORK_DIR}}`
- Session: `{{SESSION}}` (hours `idempotency_key` `priority-agent-{{SESSION}}`)

{{AIRC_SECTION}}

## Harvest rule (where knowledge goes)

1. **General Priority** skills and lessons that would help on any Priority installation go to
   **SimonBarnett/agentic_fomprep** as a **branch + PR**. Never push to main. Use the
   harvest-priority-skills / `tools/Invoke-FomprepHarvest.ps1` flow or
   `tools/Report-FomprepIntakeIssue.ps1` as `{{FOMPREP_DIR}}\AGENTS.md` describes.
   Strip customer names, hosts, ENAMEs and data first.
2. **Customer installation** skills and insights go to the **customer repo** ({{CUSTOMER_REPO}}).
   Put them in its `.grok/skills/`, `docs/` or `AGENTS.md`. Examples: their custom forms and
   procedures, environments, naming, quirks, integrations. Commit them on a branch and open a PR.
3. **Project or service-call specifics** go in **that project's folder** (`{{PROJECT_DIR}}`):
   notes, decisions, scripts, test evidence, and the work log `log.md`.
   - If no project is selected, ask Simon which folder to use before you write project notes.
   - When unsure which level something belongs to, choose the narrower one and mention it in your summary.

## Secrets: hard rule

- Passwords never go in a repo. Connection details are in `{{PASSWORDS_FILE}}`
  (`C:\passwords\<repo>-connections.txt`) **on the machine you are running on**. C:\passwords is always local.
  This overrides any repo AGENTS.md or README that says the file lives on another machine (for example redqueen).
- If that file is missing, say so and ask Haitch for it. Don't hunt for the details elsewhere or ask anyone else for them.
- Read it whenever a task needs a connection to this customer's systems. You don't need to ask first.
  **Never** commit it, copy it, quote it, echo it or summarise its contents in any of these:
  chat, logs, PRs, issues, skills, IRC, hours files or command lines that get logged.
  Pass values through environment variables or files outside the repo.
- If a secret ever lands in a repo or a log, stop and tell Simon straight away.
- Don't create new credential files inside repos. `.env`, `instances.json` and similar files stay gitignored.

## Customer systems

- You may connect to the selected customer's systems (Priority, SQL, servers) with the details in
  `{{PASSWORDS_FILE}}`, without asking first. Older "ask before connecting" wording in a customer
  repo's AGENTS.md is superseded by this rule.
- Prefer DEV/test instances for changes.
- Follow `{{FOMPREP_DIR}}\AGENTS.md`: verify before you build, and never invent ENAMEs, columns or tables.
- Don't message the customer's people (email, Teams, Slack, tickets or calls) without asking Simon first.

## New customer / new project

You never create customer repos or project folders yourself. Haitch does. If one is
needed, tell Simon to ask Haitch: "Ask Haitch: new customer repo for <X>" or
"Ask Haitch: new project folder <Y> in <customer repo>".

## Hours: MANDATORY, every session

Priority agents MUST report their hours. **Every session opens and closes one Bob Fleet hours
webhook entry**, even short ones. The store is **https://bob.ntsa.uk/bob/v1/hours**.
Follow skill `hours-log-work-session` and bobiverse `jeeves/docs/webhooks.md` (FR #3450 / #3673).
GitHub events stay on `POST /bob/v1/git`. That route is not the hours store.

- On start, `POST https://bob.ntsa.uk/bob/v1/hours`. Reuse the same `idempotency_key` on retry.
  - Server requires `idempotency_key`, `agent`, `on_behalf_of`, and `start` (ISO-8601).
  - Key: **`priority-agent-{{SESSION}}`** (the full session uuid).
  - `on_behalf_of` is the Priority USERLOGIN.
  - When a customer is selected, `customer` is the customer repo name and `project` is the
    folder name. That folder must already be an authoritative `SCxxxxxx` or `SOxxxxxx`.
    Do not invent one. A Medatech booking id and WBS stay in that folder's `project.md`.
    They are different fields. Do not put them in `project`.
  - Optional: `end`, `repo_url`, `description`, `source`, `tickets`, `billable_hint`.
  - Do not send `duration_minutes`, alias names (`started_at`, `customer_slug`, `project_slug`, ...),
    or credential fields. Never log request bodies or print secrets.
- Persist the returned receiver id (`h_` plus 16 hex characters) as JSON `{"id":"..."}` in
  `{{HOURS_ENTRY_FILE}}`. Do not invent an id. Heartbeat every 15-30 minutes:
  `POST https://bob.ntsa.uk/bob/v1/hours/{id}/heartbeat`.
- Before you stop: `POST https://bob.ntsa.uk/bob/v1/hours/{id}/close` with a real `{"end":"..."}`.
  The server derives `duration_minutes` from start and end. An open entry with no heartbeat
  becomes `auto_closed` after 120 minutes by default. That is not a successful close.
  Do not invent an end to avoid it.
- The launcher reads the list and matches **client-side** (the query has no key filter):
  the persisted id, the same full-session key, the same USERLOGIN, the expected customer and
  project, `status` `closed`, and a real start/end. A blocked GET is delivery unverified.
  Do not claim the report arrived without that readback.
- Hours are **human-equivalent**: what a competent consultant would bill, not agent wall-clock.
  Haitch proposes bookings, Simon approves them. Never book hours in Priority yourself.
- **CAST IRON project work log:** also append a short entry to `log.md` in `{{PROJECT_DIR}}`
  (when a project is selected). Create the file if missing. `log.md` is billing narrative evidence;
  it is **not** the hours database.

## End of session

Before you stop:
- Close your hours webhook entry (above). This is not optional.
- Append the project `log.md` evidence when a project is selected.
- Summarise what changed and where: general PR, customer repo, project folder, hours entry id.
- List anything that needs Simon or Haitch.
