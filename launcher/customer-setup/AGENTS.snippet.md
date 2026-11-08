## Hours

Report work with `POST https://bob.ntsa.uk/bob/v1/hours` using
`tools/BobHoursClient.ps1` from SimonBarnett/agentic_fomprep (or the launcher
hours check). `project` is this repo's `SC`/`SO` folder. Priority booking id
and WBS stay in that folder's `project.md`. Do not post hours to Priority.
Do not use a git `hours` branch as the store.

GitHub events, if configured, use `POST /bob/v1/git`. That is not the hours endpoint.

## Projects

Keep the customer repo name. Add a folder only for an authoritative `SCxxxxxx`
or `SOxxxxxx`. If the number is not evidenced, leave the existing folder unchanged.
