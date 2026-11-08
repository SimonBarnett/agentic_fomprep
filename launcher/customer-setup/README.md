# Haitch customer setup (Priority)

The launcher does not create customer repos or project folders. Haitch does.
Copy only the data templates in this folder. Do not copy reporting rules.
Those rules are `launcher/agent-rules.md` in SimonBarnett/agentic_fomprep.
PriorityAgent loads that file into every session. The exe embeds a build-time
copy of the same file; at runtime the clone copy is used when its
`rules-version` is at least the embedded copy.

Do not push the customer repo `main` from here. Do not deploy. Do not write
to a customer database.

## What a customer repo holds

- GitHub topic `priority-customer`. The repo name stays the customer name.
- One folder per evidenced `SCxxxxxx` or `SOxxxxxx`. Do not invent an id.
- `<folder>/project.md` from `project.md.template`: `priority_project` (booking
  id, which may look like PR230001) and `wbs`. Those are routing fields, not
  the work sentence.
- `<folder>/log.md` from `log.md.template`: narrative evidence only.
- `AGENTS.snippet.md` is a pointer. It does not restate the hours rules.

## What a customer repo does not hold

Reporting policy, USERLOGIN defaults, description checks, and receipt checks.
Those stay in this repository.
