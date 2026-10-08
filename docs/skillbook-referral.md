# Skillbook referral (CWD agent vs referred skillbook)

How an agent loads the Priority Agent skillbook from `SimonBarnett/agentic_fomprep`
and still files every issue / FR / skill / harvest to this product via Bobiverse
intake.

Intake (no secret required; offline payloads queue and retry):

`POST https://irc.ntsa.uk/bob/v1/intake` with payload
`repo=SimonBarnett/agentic_fomprep` and `kind` = `issue` | `fr` | `skill` |
`harvest`.

Repo-local wrappers (default `-Repo` is this product):

```powershell
tools\Report-FomprepIntakeIssue.ps1 -Kind issue|fr|skill|harvest -Title "..." -Body "..."
tools\Invoke-FomprepHarvest.ps1 -Summary "..." -Lesson "..."
tools\Invoke-FomprepHarvest.ps1 -Flush
```

When calling shared Bobiverse helpers instead, always pass an explicit
`-Repo SimonBarnett/agentic_fomprep` (never omit `-Repo` so the filing lands on
bobiverse by accident). Never put secrets in filings.

Promote Priority-generic playbooks as a **branch + PR** to
`SimonBarnett/agentic_fomprep` (never `git push origin main` for harvest).

## Mode A - CWD is this repo

1. Start the agent with CWD at the **repo root**.
2. Read root `AGENTS.md` (CAST IRON intake block first).
3. Load project skills from `.grok/skills/` (folder must be trusted:
   `grok --trust` or an interactive grant).
4. Index: `.grok/skills/PRIORITY-AGENT-SKILLS.md`.
5. After a pull, if skills are missing, re-sync:

```powershell
git pull
powershell -NoProfile -ExecutionPolicy Bypass -File tools\Sync-PriorityGrokSkills.ps1
```

6. File gaps and session harvest with the wrappers above (or intake POST with
   `repo=SimonBarnett/agentic_fomprep`).

## Mode B - another agent is referred to this skillbook

Use when the agent CWD is **not** this repo (for example a fleet shop seat, Plan
seat, or another product) but the operator pointed it at Priority / formprep
skills.

1. Load foundation skills that name this home in frontmatter / prose:
   - `harvest-priority-skills` (Priority-generic harvest)
   - `harvest-agent-skills` (foundation twin; `github:` this repo)
2. Load the needed `priority-*` leaflets from a clone of this repo under
   `.grok/skills/`, or from a tree already refreshed by
   `tools\Sync-PriorityGrokSkills.ps1`.
3. Optional note only: copying leaflets into the user global `~/.grok/skills`
   tree is allowed for discovery, but **filings still target**
   `SimonBarnett/agentic_fomprep` (intake `repo` / `-Repo`), not the referrer
   product.
4. If this clone is on disk, prefer `tools\Report-FomprepIntakeIssue.ps1` /
   `tools\Invoke-FomprepHarvest.ps1` with `-NoDelegate` when the bob install
   must not rewrite the home repo. If scripts are unavailable, POST intake
   directly with `repo=SimonBarnett/agentic_fomprep`.
5. Open playbook PRs against **this** repo. Do not land Priority-generic tips
   under bobiverse harvest.

## Wrong-book (do not file here)

| Concern | Home |
|---------|------|
| Fleet / Bob / Airc / Jeeves / MSI / digest wire | `SimonBarnett/bobiverse` |
| IRC moot / talk seats / Ergo client skills | `SimonBarnett/agentic_irc` |
| Fleet build / TipForm / older agentic_build books | `SimonBarnett/agentic_build` |
| CE Day Works **product** only | `SimonBarnett/ce-dayworks` |
| CE instance / hardware / DBA / backup packs | `SimonBarnett/ce-priority` |

Priority-generic Form Prep, dictionary SQL, OData, UAT WCF kernel, hours
patterns, and catalog harvest stay on `SimonBarnett/agentic_fomprep`.

## Related

- Root `AGENTS.md` - CAST IRON + Skill discovery
- `.grok/skills/harvest-priority-skills/SKILL.md`
- `.grok/skills/harvest-agent-skills/SKILL.md`
- Parent brief: `docs/feature-request-bobiverse-intake-skillbook-2026-10-08.md`
