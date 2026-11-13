## Hours and reporting

Do not copy hours rules into this repo. PriorityAgent loads them from
SimonBarnett/priority-mcp `launcher/agent-rules.md`.

## This repo's data

`project` folders are evidenced `SCxxxxxx` or `SOxxxxxx` ids. Booking id and
WBS are `priority_project` and `wbs` in that folder's `project.md`. They are
not the work sentence. Secrets stay out of git.

Keep [`company.md`](company.md) current: it is the company knowledge file,
linked from the README. Agents add what they learn about the company there.
[`connections.md`](connections.md) is secret-free and points at
`C:\passwords\<client>-connections.txt` on MarchHare. Never dump that file
to stdout.
