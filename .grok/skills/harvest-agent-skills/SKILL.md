---
name: harvest-agent-skills
description: >
  FOUNDATION skill for every skill book. Identify this skill's home GitHub,
  harvest playbooks back as a PR, and report gaps as issues/FRs. Triggers:
  harvest skills, CAST IRON harvest, honesty box, skill book foundation,
  learned a procedure, hourly skill check, /harvest-agent-skills, promote a
  playbook, skill harvest. Prefer deterministic scripts over LLM reasoning.
  Does not dispatch product builds.
github: https://github.com/SimonBarnett/agentic_fomprep
---

# Harvest agent skills (honesty box)

## Home GitHub (required on every harvest skill)

**This skill's home:** `https://github.com/SimonBarnett/agentic_fomprep`

Every skill book ships this foundation skill (or a repo-local twin). The twin's
frontmatter `github:` MUST name the public repo that owns that book.

| Playbook domain | Home repo | Foundation skill |
|-----------------|-----------|------------------|
| Priority catalog, formprep, hours, UAT, OData, shell, DBA, Priority MCP | `SimonBarnett/agentic_fomprep` | `harvest-priority-skills` (this book) |
| IRC wire, Jeeves, talk seats, SEAL, moot, file, dumb, Ergo, Watch-Bobiverse | `SimonBarnett/agentic_irc` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Fleet / build / MRB / Bob jobs / TipForm | `SimonBarnett/agentic_build` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| MUD / Discworld | `SimonBarnett/mud-skill` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Visionary / new-product strategy | `SimonBarnett/skills-visionary` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Design UAT | `SimonBarnett/bob-design-uat` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Club Madeira Awin connector | `SimonBarnett/club-madeira-awin-connector` | `.grok/skills/harvest-agent-skills/SKILL.md` |
| Other skill products | that public repo | `.grok/skills/harvest-agent-skills/SKILL.md` |

**Priority domain:** use `harvest-priority-skills` for catalog + `docs/skill-sources` harvests in this repo. This foundation skill still owns the honesty-box bargain and routing table.

## CAST IRON - cost of using this skill book

**You used these skills. You owe the home repo a report.**

This is an honesty box. Using any skill from this book binds you to return
what you learned, what broke, and what is missing. Silence after a useful
session is a breach of the bargain. Do not wait for an hourly task, a
reminder, or Bob to dismiss you.

### AUTOMATIC same-turn (non-negotiable)

If this session learned a repeatable Priority/formprep/UAT procedure, hit a
wrong skill, or invented a workaround: **harvest in the same turn** before
`!bored` / idle. Do not park "harvest later".

### Three Laws (bound)

1. Do not gut CAST IRON, safety gates, or honesty-box duties to ship faster.
2. Prefer deterministic scripts over LLM narration.
3. Report gaps as issues/FRs when a PR cannot land.

### You MUST report back to the home GitHub when any of these are true

1. You learned a **repeatable** procedure (trigger + steps + owner) not already
   in the book.
2. A skill was **wrong, incomplete, ambiguous, or token-wasteful**.
3. You hit a **bug**, gap, or missing tool that a deterministic script should
   own.
4. You invented a workaround that should become a skill or a code change.

### How to report (strict order - no main pushes)

1. **Skill harvest / playbook / fix with write access** -> branch + **pull
   request** against the home repo. Never `git push origin main` for harvest.
2. **If the PR cannot be opened** (no permission, API fail, fork blocked) ->
   open a **GitHub issue** on the home repo titled `harvest:` or `FR:` and
   paste the intended PR title, branch name, file list, and full body, **and**
   POST the same payload via Bobiverse intake (below) so a push-capable seat
   can land the PR.
3. **Bugs / feature requests without a ready patch** -> GitHub **issue** or
   **FR** on the home repo (or intake below when `gh` is unavailable).
4. Empty harvest (nothing new, nothing broken): **no commit, no empty PR**.

Prefer `gh` / existing harvest scripts over free-form reasoning.

### CAST IRON - Bobiverse intake (same-turn file path)

When `gh` push/PR is blocked, or when filing issue|fr|skill|harvest gaps without
a ready patch, POST to Bobiverse intake in the **same turn** (no GitHub account
required; offline payloads queue and retry):

`POST https://bob.ntsa.uk/bob/v1/intake` with payload `repo=SimonBarnett/agentic_fomprep`
(and `kind` = `issue` | `fr` | `skill` | `harvest`).

Repo-local wrappers (default repo this product; scripts land in FR-004/FR-005):

```powershell
tools\Report-FomprepIntakeIssue.ps1 -Kind issue|fr|skill|harvest -Title "..." -Body "..."
tools\Invoke-FomprepHarvest.ps1 -Summary "..." -Lesson "..."
tools\Invoke-FomprepHarvest.ps1 -Flush
```

Branch + PR remains the **preferred** path for playbook landings. Intake is
**mandatory** when a PR cannot open and for issue/FR gaps. Never omit the product
`repo` / `-Repo SimonBarnett/agentic_fomprep` (shared Bobiverse helpers default to
bobiverse if `-Repo` is missing). Dual-mode CWD vs referred skillbook:
`docs/skillbook-referral.md`. Never put secrets in filings.

## Token efficiency (non-negotiable)

- Prefer a **deterministic tool or script** over LLM reasoning whenever both
  could finish the job.
- Do not narrate step-by-step tool plans in skills; write the command or the
  script name.
- One home per fact. Point at the owner skill; do not duplicate.
- ASCII in `SKILL.md`. Short triggers in frontmatter `description`.

## Scan (deterministic first)

1. Diff local installed skills vs repo `.grok/skills/` - promote repeatable
   user-only playbooks.
2. Run repo harvest script if present; do not reinvent it.
3. Check recent `docs/*` FRs and `docs/skill-harvest-log.md` (create if missing).
4. Skip one-off incident notes and noisy chat.

## Write

1. Edit or add `.grok/skills/<name>/SKILL.md` (`name` + `description`;
   foundation skill also has `github:` of THIS repo).
2. For Priority catalog leaflets: also update
   `v2/apps/mcp-catalog/catalog/<id>/SKILL.md` + `docs/skill-sources/` via
   `harvest-priority-skills`.
3. Append a dated line to `docs/skill-harvest-log.md`.
4. Commit on a **branch**, open a **PR**. Link related issues. Never stage `.bobiverse-seat` (gitignored; FR #349).
5. If catalog gates exist, add/adjust and run `v2/tools/Test-PriorityCatalog.ps1`.

## Inclusion rule

**Every skill book MUST include this foundation skill** (twin with that book's
`github:`). Other skills in the book SHOULD link it in one line:

`Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.`

(Catalog leaflets use `harvest-priority-skills`. Fleet/Bob skills in other
books use `harvest-agent-skills` pointing at their home.)

## Do not

- Commit `.bobiverse-seat` (Bobiverse job seat marker). Keep it gitignored / untracked; never `git add` it on harvest or MRB tips (FR #349).

- Push harvest to `main`.
- Commit "nothing found".
- Force-push, secrets, or live credentials into skills.
- Invent skills from noisy session chat.
- Claim ready for human UAT from a harvest alone.
- Dispatch product builds under the harvest label.

## Harvested lessons (intake)

- Priority Agent home (this repo) needs a-search-style CAST IRON Bobiverse intake: always pass `-Repo SimonBarnett/agentic_fomprep` (or the matching intake payload `repo`), ship repo-local `Report-FomprepIntakeIssue.ps1` / `Invoke-FomprepHarvest.ps1` wrappers, document dual-mode CWD vs referred skillbook in `docs/skillbook-referral.md`, and pin CAT needles for the intake default-repo path. File many small Goal/Deliverables/Testable FRs (not one omnibus). Backlog: issues #109-#118; docs park PR #119.
- Register priority-catalog as PriorityAgent.exe --mcp-catalog stdio from the fomprep clone; do not grok mcp add the hosted mcp-priority URL (no DNS).
- Priority Agent lists customers from GitHub topic priority-customer; ff-only clean main for fomprep; new customer/project is Ask Haitch only; secrets stay in C:\passwords\<repo>-connections.txt unread by the launcher.
- When rules v2 lands connect-without-ask, update VISION.md in a separate FR (do not edit VISION inside the product PR); prefer DEV; never commit/echo secrets; ask before messaging people; refresh hostile pins that still require Never-touch/allowlist
- Use priority-saas-oidc-login for Cloud WebUI Bearer; tabulaini from POST /webui/<tenant>; OTP single-use; prefer PAT for unattended OData
- Never rewrite catalog meta.json with a UTF-8 BOM (CAT-T51 / Node MCP); bump version as UTF-8 no BOM pretty JSON.
- When intake files a catalog-skill FR after the harvest already landed, add the missing hostile pin (OTP single-use, prefer PAT, no secret literals) and Closes the FR; do not duplicate the skill folder.
- priority-customer repos need root VISION.md for hostile MRB: customer-specific harvest here not agentic_fomprep; project logs in authoritative SC/SO folders; hours store is the bob.ntsa.uk /bob/v1/hours webhook (not a git hours ref); secrets only in C:\passwords\<repo>-connections.txt never in git
- When a live-fix evidence PR CONFLICTS with a prior docs next-step tip, keep-both fold prefers the completed-write tip narrative; verify OData evidence JSON for the write
- fomprep catalog harvest: CAT-T51 no BOM on new meta.json; CAT-T41 password-equals fail on ODATA_REST_CLOUD.md is pre-existing on main -- confirm on origin/main before FAIL.
- fomprep CAT-T41: do not treat documented PAT Basic (password field is PAT) as a secret; require password-equals plus a quote, or reword the skill-source.
- priority-saas-oidc-login v1.1: PowerShell & join; HttpClient no-auto-redirect; OData Bearer empty 500 means stop guessing DNAME; prefer PAT
- Priority SaaS OData: after N empty HTTP 500 on guessed company/DNAME (default 2; PRIORITY_ODATA_EMPTY_500_MAX), stop inventing names and confirm DNAME/API licence or PAT --- Assert-ODataCompanyProbeAllowed in odata.ps1 (FR #226).
- Priority Agent clone path: only dirs with .git count; empty D:\ai\agentic_fomprep stub is skipped for C:\ai; agents use FOMPREP_DIR not hardcoded D:\ai; operators reclone or PRIORITY_AGENT_ROOT/--root
- Do not create a new GitHub repo from an FR that says Simon must confirm owner and name first; GIVEUP owner-confirm and leave the issue open.
- priority-branding FR #233: after owner-confirm SimonBarnett/priority-branding, still GIVEUP needs_human if M:\ce-priority-extension is unmapped - never invent rules.json affiliate IDs
- Greenfield product FR that needs a new repo: create the confirmed repo, seed verbatim first commit, then land generic changes on a fr-N branch PR with Closes owner/origin-repo#N; cross-repo closingIssuesReferences may stay empty until merge - comment the PR on the origin issue and note MRB confirm-close.
- PriorityAgent EnsureClone: never skip a valid dirty agentic_fomprep clone for preferClean; warn+skip pull; FATAL must list every candidate path and reject reason
- FR #247: allow_auto_merge true is not enough; main must have classic protection (0 reviews, no path-filtered validate) or GraphQL enablePullRequestAutoMerge fails Protected branch rules not configured.
- UAT pin drift: when agent-rules.md bumps rules-version, Fr201 must use >= N like Mrb200 or main stays red and UAT FAILs with no release
- Re-offered FR with open Closes PR: ACK, verify closingIssuesReferences, DONE that PR URL; never open a second implement PR
- PRIORITY_AGENT_AIRC_REPORT_JSON fixture is for dry-runs without fetch; Discover(explicit fetch) must ignore that env so CI GITHUB_ENV cannot break inject unit tests (MRB #259/#261)
- PriorityAgent airc: never derive customer target as #<stem> from *_console nick; use digest airc_console_details[].channel, else #wonderland (shops keep #flamingo/#marchhare/#redqueen)
- Launcher-v tags must pass -p:Version / FileVersion / InformationalVersion into dotnet publish; csproj Version 1.0.0 is only the local default.
- Custom SQLI queue columns must not be named PART/SERIAL/SERN; use QPART-style names
- agentic_fomprep UAT #0: confirm open issues/PRs clear, run tests/Test-*.ps1 + Test-PriorityCatalog on main, SKIP live Form Prep without connections file, docs/UAT-LOG PR then gh release create uat-YYYY-MM-DD
- OData GET empty while form shows rows: try installed language code after ini (comma); do not hardcode British English 2; omit host/credentials from harvest
- Service-desk training checkpoint issues are receipts: when a later checkpoint (#328) supersedes an earlier one (#317) and cited skill PRs are all MERGED, close the earlier checkpoint as Duplicate of the later issue and DONE FR with the covering merged PR URL; do not open a second implement PR.
- SaaS prepare: port EFORM/EXEC activateStart walks onto accessToken sessions; scrape FORMPREPERRS; gate via odataBase re-read when SQL unavailable; walkOk alone is not preparedClaim
- priority-web-sdk appends /wcf/wcf/Service.svc unless url ends in .svc; use tenant probe wcf. OIDC user needs API License for WCF; PAT+OData/MCP for dictionary. Strip UTF-8 BOM on Windows token JSON.
- Root .gitignore must list .bobiverse-seat and **/ .bobiverse-seat so harvest/MRB tips cannot commit Bobiverse job seat markers; document in harvest-agent-skills Do-not + Write tip (FR #349 / PR #350).
- PowerShell (?m)$ gates against gitignore must normalize CRLF (or use \r?$) before match; ASCII pin scripts UTF-8 no BOM (WinPS 5.1: non-ASCII scripts need a UTF-8 BOM).
- Public mcp-catalog must sync docs/_dag into data/ at build, trace data/dag.json, expose resolve_skills matching resolve_dag.py, and fail build on catalog↔DAG drift or secret-like DAG content; repair conflict-marker corruption in dag.json before sync.
- Priority Agent launcher FR that cites bobiverse #6026 means the merged priority_wcf.py client (#6035): drop airc launcher option, pass per-instance serverUrl+mode, never store creds in .priority-agent.json; --airc-console exits with removed message.
- MRB README/docs: reject C0 BEL/BS/VT in changed .md; string-contains gates on tokenFile can PASS via a clean JSON example while prose is corrupted --- pin contiguous SaaS words and a no-C0 regex.
- After a schema change on a record type, grep the whole product for old field names before DONE; unit string-gates on WcfSupport alone miss Program.cs compile breaks that only show in dotnet publish CI.
- MCP get_skill should return skillMd plus required skill ids from DAG depends_on and topic-dependency skills (exclude same-topic peers); stack get_skill follow-ups on the open DAG tip (fr-354) and note manual issue close when base is not main.
- After Amplify deploys mcp-catalog DAG tools, run npm run smoke:live (scripts/smoke-mcp-live.mjs) against mcp.ntsa.uk and record evidence in docs/amplify-hosting.md Live evidence (FR #364).
- Seat-side resolve_skills overlay: merge public MCP with local customer .grok/skills + SO/SC markdown; never POST overlay; normalizeMcpToolsUrl accepts https://mcp.ntsa.uk or .../mcp.
- Read %USERPROFILE%\.priority-agent\last-user.json by WCF instance id for the interactive USERLOGIN prompt; do not invent the OS account as a default.
- fail() must emit boolean retryable; true only for login_connect; api_licence and token_expired keep a hint and retryable false.
- When folding a verb PR into FR-008 help, add the new verb to usage() and HELP_TOPICS so help <verb> stays one screen.
- When MRB tip goes DIRTY after stacking docs, fetch real origin/main (ls-remote) before fold; keep both sides of skill/CLI conflicts (dry-run + request + help topics)
- form rows --filter calls setSearchFilter once then getRows from 1; omit filter for the unfiltered read.
- error dialogs stay for the agent unless --confirm-errors; wire CLI setConfirmErrors(hasFlag) plus tests that count errorConfirm 0/1.
- form action --form ENAME --name ACT needs allowLive; refuseLiveWrite before login; return message-handler list from activateStart/invoke
- interface run is procStart ptype I with FR-21/FR-22 walker; --inputs on inputFields; two options needs_input; write so allowLive required
- A BPM status missing from the flow chart that already exists on create is often deleted; restore it from the deleted-status list via the + icon; do not insert in tables.
- Stacked service-desk harvests conflict on PRIORITY-AGENT-SKILLS and skill-harvest-log; keep every sibling skill name when folding.
- FIX for a CONFLICTING polish PR: merge origin/main onto the assigned head (fr-N), keep both the original verb and later form verbs, push HEAD:assigned-ref, DONE FIX with the assigned PR URL.
- Service-desk harvest leaflets: pin grok=catalog SKILL.md, SC ticket, Stop unverified requester, and forbid DB MFA edits; CAT-T59 on untouched files is not a FAIL.
- After a FIX fold, keep cmdForm const write = on one line so MRB-460/471 source pins still match; include set/save/delete/new/action and subform --set.
- Classify form.delete as verbIsWrite so --dry-run never looks like a read; empty filter matches must not call deleteRow.
- FR-003: fake install runners and refuse LocalSystem; never treat .grok\bin\agent.exe as Cursor
- MSI CLI chooser is a WiX fragment: four radio values grok/cursor/opencode/none, default none, InstallChosenCli only when UILevel > 3 and not none; msiexec /qn never shows the dialog or runs the CLI action.
- CI Priority Agent CLI tests use in-memory fake installers; a guard fails any test line that irm/IWR/curl-calls x.ai, cursor.com/install, or opencode.ai.
- Priority-generic customer-setup skill belongs in agentic_fomprep (FR #4970); verify catalog/.grok byte mirror and password-file pointer rules before PASS.
- FORMCLTRIGTEXT lives in system dictionary DB, not company DB
