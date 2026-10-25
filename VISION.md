# Vision - agentic_fomprep

Priority-generic **agent home**: Form Prep runners, MCP catalog, and
`.grok/skills` so an agent started at the **repo root** has portable Priority
skills without customer product packs. Example pins may use a DEV estate.
**Priority Agent rules v2 (PR #200):** a launched agent may connect to the
selected customer's systems using the machine-local
`C:\passwords\<repo>-connections.txt` **without asking first**; prefer DEV/test
for changes; still **never** commit or echo secrets; still **ask Simon before
messaging** the customer's people. This file is the vision-first source for
hostile MRB (quote it; do not invent product intent).

## Mission

- Ship a supervised desktop / Web SDK Form Prep pack and a Priority-generic skills catalog (`v2/apps/mcp-catalog`) that agents can harvest and run without embedding secrets.
- Keep **Priority Agent** entry at repo root (`AGENTS.md` + synced `.grok/skills`).
- Prefer Priority-generic naming over customer-specific `ce-*-*` ids in the default agent skill set.
- Honesty-box harvest: learned playbooks return as skills / intake issues; catalog leaflets stay ASCII-safe for Windows PowerShell 5.1 where required.
- Honesty-box filings for this product use Bobiverse intake
  (`POST https://irc.ntsa.uk/bob/v1/intake`) with
  `repo=SimonBarnett/agentic_fomprep` (never omit the product repo). Dual-mode:
  CWD agent at repo root **or** referred skillbook (`docs/skillbook-referral.md`).
- After catalog harvests, re-run `tools/Sync-PriorityGrokSkills.ps1` so Grok CWD discovery stays current.

## Success (Form Prep)

A form is **prepared** only when both are true:

1. `EXECPREPLOCK.UPD = 'N'`
2. `LASTPREPDATE` moved (bigint increased)

Never report success from Playwright finish, winrun exit 0, or SQL flips of `UPD` alone. Never leave the unprepared estate marked prepared. Never embed passwords in this repo (CredMan / redacted logs only).

## Bounds

- **Prefer DEV:** Form Prep pins and default changes target environment `DEV` (SQL instance and web host on the DEV stack). Live/PRI connections for the selected customer are allowed via the machine-local passwords file **without asking first** (rules v2); prefer DEV/test for writes and Form Prep runs when a DEV estate exists.
- Still **never** commit, copy, quote, echo or summarise secrets from that file (or any credential store) into chat, logs, PRs, issues, skills, IRC or hours.
- Still **ask Simon before messaging** the customer's people (email, Teams, Slack, tickets or calls).
- Headed Playwright needs an unlocked DEV1 session until session-0 / headless proof exists.
- Autonomous named-form path (`Prepare-NamedForm.ps1` / FORMPREPDRCT2) is the preferred non-UI success path when available.
- Product issue / FR / skill / harvest filings bound to Bobiverse intake
  `repo=SimonBarnett/agentic_fomprep` whether the agent CWD is this repo or a
  referred skillbook session (see Mission honesty-box intake bullet).

## Catalog / MCP

- Catalog `meta.json` files are UTF-8 **without BOM** (Node/MCP consumers break on `U+FEFF`).
- `Test-PriorityCatalog.ps1` is the merge gate for catalog and harvest regressions (including priority-uat-wcf).
- Skill-sources under `docs/skill-sources/` feed leaflets; `.grok/skills` mirrors via `Sync-PriorityGrokSkills.ps1` (default set excludes Day Works product and DBA/backup leaflets).

## Non-goals

- Overnight unattended Form Prep on locked session-0 without proof.
- Messaging the customer's people, or committing/echoing secrets, without the rules-v2 gates above.
- Owning CE Day Works product delivery (`ce-priority/dayworks`, formerly `ce-dayworks`) or CE DBA estate packs (`ce-priority`).
- Replacing human judgment on Ignore Duplicate / AllUnprepared / cookie recapture stops.
