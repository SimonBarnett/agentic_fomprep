# Vision — agentic_fomprep

Priority-generic **Form Prep** and MCP catalog for Clarkson Evans **DEV only**.
This file is the vision-first source for hostile MRB (quote it; do not invent product intent).

## Mission

- Ship a supervised desktop / Web SDK Form Prep pack and a Priority-generic skills catalog (`v2/apps/mcp-catalog`) that agents can harvest and run without embedding secrets.
- Prefer Priority-generic naming over customer-specific `ce-priority-*` ids in the catalog.
- Honesty-box harvest: learned playbooks return as skills / intake issues; catalog leaflets stay ASCII-safe for Windows PowerShell 5.1 where required.

## Success (Form Prep)

A form is **prepared** only when both are true:

1. `EXECPREPLOCK.UPD = 'N'`
2. `LASTPREPDATE` moved (bigint increased)

Never report success from Playwright finish, winrun exit 0, or SQL flips of `UPD` alone. Never leave the unprepared estate marked prepared. Never embed passwords in this repo (CredMan / redacted logs only).

## Bounds

- **DEV only:** environment `DEV`, SQL instance and web host pinned to the DEV stack; refuse live/PRI.
- Headed Playwright needs an unlocked DEV1 session until session-0 / headless proof exists.
- Autonomous named-form path (`Prepare-NamedForm.ps1` / FORMPREPDRCT2) is the preferred non-UI success path when available.

## Catalog / MCP

- Catalog `meta.json` files are UTF-8 **without BOM** (Node/MCP consumers break on `U+FEFF`).
- `Test-PriorityCatalog.ps1` is the merge gate for catalog and harvest regressions (including priority-uat-wcf).
- Skill-sources under `docs/skill-sources/` feed leaflets; `.grok/skills` mirrors stay in sync when the catalog says so.

## Non-goals

- Overnight unattended Form Prep on locked session-0 without proof.
- Live/PRI execution from this pack.
- Replacing human judgment on Ignore Duplicate / AllUnprepared / cookie recapture stops.
