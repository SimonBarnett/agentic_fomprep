# Haitch customer setup (Priority)

The launcher does not create customer repos or project folders. Haitch does.
Copy only the data templates in this folder. Do not copy reporting rules.
Those rules are `launcher/agent-rules.md` in SimonBarnett/priority-mcp.
PriorityAgent loads that file into every session. The exe embeds a build-time
copy of the same file; at runtime the clone copy is used when its
`rules-version` is at least the embedded copy.

Do not push the customer repo `main` from here. Do not deploy. Do not write
to a customer database.

## Data the launcher reads

Optional repo-root `hours.json` with only `customer` and `project`. No user.
If that file is absent, the launcher uses the repo name and the selected folder.

`<folder>/project.md` may contain these lines in the prose or inside a fence:

    priority_project: <booking id>
    wbs: <code or unknown>

`unknown` stays unknown. It is not sent on the hours report and it is not replaced.
The hours report uses the folder id and the session USERLOGIN. Booking review is separate.

## What a customer repo holds

- GitHub topic `priority-customer`. The repo name stays the customer name.
- Root `company.md` from `company.md.template`, linked from the README. It is
  the company knowledge file: customer record and code, account owner, contacts
  and roles, Priority version and hosting, servers, environments, companies,
  URLs, named users (no passwords), the booking project and WBS, the service
  call and sales order history, and customisations. Agents must keep adding
  what they learn about the company to this file (or to `connections.md` / the
  work folder when the fact is route- or work-specific).
- Secret-free `connections.md` from `connections.md.template`. It points at
  `C:\passwords\<client>-connections.txt` on MarchHare and never contains
  credentials. Never dump that passwords file to stdout or to agent logs.
- One folder per evidenced `SCxxxxxx` or `SOxxxxxx`. Do not invent an id.
- `<folder>/project.md` from `project.md.template`: `priority_project` (booking
  id, which may look like PR230001) and `wbs`. Those are routing fields, not
  the work sentence.
- `<folder>/log.md` from `log.md.template`: narrative evidence only.
- `AGENTS.snippet.md` is a pointer. It does not restate the hours rules.

## Connection routes

When more than one route exists, use this order:

1. An airc console (for example `<HOST>_console`) is the primary agent route
   when one exists.
2. A remote desktop tool (AnyDesk or TeamViewer) is the human route.
3. Web access is a fallback.

Desktop shortcuts may embed the password only when the user explicitly asks.
Anyone who can open the shortcut properties can see that password in plain
text; say so before saving one.

## Credentials

Write every login and connection for the client to
`C:\passwords\<client>-connections.txt` on MarchHare. The repo only references
that path. Never put passwords in git, a PR, a log or a chat. Never
Get-Content or otherwise write that file to stdout; read it into variables and
print lengths or boolean found flags only. If a secret hits a log, stop and
tell the operator immediately.

## What a customer repo does not hold

Reporting policy, USERLOGIN defaults, description checks, and receipt checks.
Those stay in this repository. Credentials stay in the MarchHare passwords
file, not in the repo.
