<!-- rules-version: 2 -->
# Priority agent rules (from the Priority Agent launcher)

The launcher fills in the {{...}} values on every start. These rules sit on top of
`{{FOMPREP_DIR}}\AGENTS.md`, which you must read before you start work. Read the
customer repo `AGENTS.md` / `README.md` and the project folder `README.md` / `log.md`
too, if they exist.

## Context

- Level: **{{LEVEL}}** (general / customer / project)
- General Priority knowledge: `{{FOMPREP_DIR}}` (SimonBarnett/agentic_fomprep, fast-forwarded at launch).
  Skills come from `.grok/skills`. The `priority-catalog` MCP server (list_catalog, get_skill, get_instance_schema,
  get_runner_files) runs locally from the agentic_fomprep clone (`PriorityAgent.exe --mcp-catalog`).
- Customer: {{CUSTOMER}} ({{CUSTOMER_REPO}}, local clone `{{CUSTOMER_DIR}}`)
- Project or service call: {{PROJECT}} (`{{PROJECT_DIR}}`)
- Working directory: `{{WORK_DIR}}`
- Session: `{{SESSION}}` (hours tag `session:{{SESSION_SHORT}}`)

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

Priority agents MUST report their hours. **Every session ends with hours lines**, even short ones.
The launcher checks for them when you exit. If they are missing it relaunches you until they are written.

- Repo: **{{HOURS_REPO}}**. For a customer or project session that is the customer repo; for a
  general-Priority-only session it is SimonBarnett/agentic_fomprep.
- File: `hours/YYYY-MM-DD.md` (today is {{TODAY}}) on the **`hours` branch only**. Never put it on main,
  and don't open a PR for it.
- Use a separate worktree so the working checkout is not disturbed:
  ```
  git -C "{{HOURS_REPO_DIR}}" fetch origin
  git -C "{{HOURS_REPO_DIR}}" worktree add "{{HOURS_WORKTREE}}" hours
  ```
  - If the worktree already exists: `git -C "{{HOURS_WORKTREE}}" pull --ff-only`.
  - If the repo has no `hours` branch yet, create it from the default branch:
    `git -C "{{HOURS_REPO_DIR}}" worktree add -b hours "{{HOURS_WORKTREE}}" origin/main`
    and then `git push -u origin hours`.
- Template: start each new day file from `hours/_template.md` on that branch. If the repo has none,
  copy it from SimonBarnett/ce-dayworks `hours/_template.md` (local copy:
  `{{FOMPREP_DIR}}\launcher\hours-template.md`) and commit it to `hours`.
  - Set `date:` to the day.
  - Set `agent: priority-grok`.
  - Leave `status: staged`.
- Write **at least two lines for this session**: one `dev` line and one `test` line. Append them to the table.
  - Hours are **human-equivalent**: what a competent consultant would bill, not agent run time.
    Use 0.0 for a role that genuinely had no effort, and say why in the description.
  - Every line needs **evidence**: a link to a PR, commit, file or log. End the evidence cell with
    the session tag **`session:{{SESSION_SHORT}}`**. The launcher looks for that tag.
  - project = Priority project or service call ({{PROJECT}}, or the code in project.md); wbs = 5 unless known, `?` if unsure.
  - Example: `| {{PROJECT}} | 5 | dev | 1.5 | Plain deliverable wording | PR #12 session:{{SESSION_SHORT}} |`
- Rules:
  - The file is append-only: never edit or delete a pushed line, and never force-push or delete the branch.
    To correct a line, add a minus line with the reason.
  - Commit and **push to `origin hours`**. Haitch picks the files up from GitHub.
  - Haitch proposes the bookings, Simon approves them, and only Haitch sets `booked`.
    Never book hours in Priority yourself.

Also append a short entry to the project work log `log.md` in `{{PROJECT_DIR}}` (when a project is selected).

## End of session

Before you stop:
- Write and push your hours lines (above). This is not optional.
- Summarise what changed and where: general PR, customer repo, project folder, hours.
- List anything that needs Simon or Haitch.
