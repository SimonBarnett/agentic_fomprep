# Hours WBS fallback map (easy to update)

Used by `hours-classify` and `hours-draft` **only when** customer/project
`project.md` files are missing. Prefer `/customer/project.md` and
`/customer/project/project.md` first.

| Work | Priority project (example) | WBS |
|------|----------------------------|-----|
| Clarkson Evans Day Works (with PE-xx ticket) | PR230001 | 5 |
| Wider-team / Clarkson catchups | PR230001 | 1000 |
| Trutex | PR16000050 | (per map / project.md) |
| Internal comms | PR17000011 | (per map / project.md) |
| Recording hours | PR17000010 | (per map / project.md; typically WBS 1) |

Extend this table via PR when new customers/projects appear. Do not hard-code
maps inside agents. Never put secrets here.
