# Priority hours orchestrator (standing rules)

**When:** Any weekday timesheet draft, entry, or OData post for Reports of Project Hrs/Expenses.

## Caps and cadence

- Target **8.0h per weekday** for the named employee (config). Weekends ordinarily empty unless the human says otherwise.
- Every weekday needs **0.25h Recording Hours** on the internal recording project/WBS (CE Medatech example: project `PR17000010`, WBS `1`, non-billable). Skip only if that day already has a Recording Hours line.
- Work units: prefer **≥0.5h** for real deliverables; 0.25 is fine for Recording Hours and short kickoffs.
- Split blobs: task / testing the task / shell or form work for the task — avoid one giant line per day.

## WBS map (CE Medatech examples — map per customer)

| Work | Example WBS on PR230001 |
|------|-------------------------|
| Helping / supporting developers, Day Works, form UAT | `5` |
| DBA / SQL / disk / backup (human-equivalent) | `2.35` |
| Wider-team / Clarkson catchups | `1000` (not 5) |

Recording Hours stay on the recording project, not the customer project.

## Descriptions (PDES)

- Plain deliverable wording only.
- No agent names, no internal WP/Gate codes, no Jira ids unless that day's work **is** those tickets.
- Meeting attendees: `/w Name` (e.g. `/w Gergo /w Krishna`).
- Keep ≤ ~60 characters (OData truncation / UI limit — treat 60 as hard for OData posts).

## Draft → confirm → post

1. Gather calendar/Teams/mail + teammate claims for the day.
2. Read already-booked lines (search skill or OData).
3. Show a draft that totals ≤8.0h; wait for explicit “post it” / confirm.
4. Post (prefer OData); confirm; run Less-than-8 check when closing a month/week.

## Overflow and agent claims

- If staged work exceeds 8.0h, keep the day at 8.0h and **overflow to the next working day** (skip weekends).
- Scrutinise agent wall-clock claims → book **human-equivalent** hours only; trim inflated totals before staging.
- Teammate engineering/DBA/UAT work done for Simon books as **Simon’s** hours on the customer project with the right WBS.

## Prefer OData

UI automation for hours is fragile. Prefer `priority-hours-odata-post` when credentials and entity set are known. Use UI skills for search/verify and when OData is unavailable.
