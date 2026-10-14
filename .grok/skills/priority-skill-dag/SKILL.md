---
name: priority-skill-dag
description: >
  Lazy-load Priority / Medatech lessons and catalog skills via the skill DAG.
  Resolves which markdown lessons and SKILL.md leaflets to open for a query.
  Use when the user says which skill, load lessons, skill dag, medatech docs,
  Priority procedure lookup, or /priority-skill-dag. Harvest foundation:
  harvest-priority-skills.
---

# Priority skill DAG (lazy loader)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. **Do not load the whole corpus.** Resolve the DAG first; open only the ranked `loadOrder` paths.
2. **Never read `docs/skill-sources/medatech-network/_dag/dag.json`.** It is ~2 MB and will blow context. Run the resolve script. `dag-index.json` is slim metadata only — still prefer the script.
3. Prefer **catalog skills** (`v2/apps/mcp-catalog/catalog/*/SKILL.md`) for executable playbooks (formprep, shell install, hours, UAT).
4. Prefer **lessons** under `docs/skill-sources/medatech-network/` for ops/SOP/install guidance. Use each hit’s `summary` before opening the full file.
5. Respect **byte budget**. Default `MaxBytes=24000`. Files over `SingleFileCeiling=20000` are skipped unless `-AllowLarge`.
6. CAST IRON: new repeatable procedures learned while using lessons must be harvested back (catalog + skill-sources) via `harvest-priority-skills`.
7. No secrets. CE / Medatech hostnames are examples only.

## Resolve

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 `
  -Query "<user intent>" -MaxLessons 8 -MaxSkills 5 -MaxBytes 24000
```

Large install/SDK references (pass only when needed):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 `
  -Query "<user intent>" -AllowLarge -MaxBytes 60000
```

Output JSON fields:

| Field | Meaning |
|-------|---------|
| `skills` | Ranked catalog skills (`path`, `bytes`, `summary`, `score`) |
| `lessons` | Ranked markdown lessons with digests |
| `topics` / `activeTopics` | Topic hubs used to gate lessons |
| `budget` | `maxBytes` / `usedBytes` / `remainingBytes` |
| `skipped` | Hits held back for size (use `-AllowLarge` or tighter query) |
| `loadOrder` | Suggested open order (skills then lessons) |
| `agentRules` | Reminder lines for the calling agent |

Rebuild after adding lessons:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Build-SkillDag.ps1
```

## Topic hubs (Medatech network)

| Topic folder | Use for |
|--------------|---------|
| `install-upgrade` | Client/web install, SSL, bin_95, refresh, AimBetter |
| `system-admin` | Permissions, troubleshooting, DB maintenance |
| `financials` | VAT, COGS, Intrastat, SOX, year-end |
| `integrations` | API, portal, EDI, sync |
| `support-desk` | SP003, BPM service calls |
| `customer-guides` | Customer-ready checked guides + user-guides |
| `sop` | Official Priority SOP markdown |
| `packages` | Installed-as-Standard packs |
| `procedures` / `reports` | Procedure and report packs |
| `training` | Workshops + work-instructions |
| `forms-code` | Forms, common code stubs, Sacred WIZ3 lessons (demoted unless help/WIZ query) |

Existing programming / hours / UAT skill-sources stay under `docs/skill-sources/{programming,hours,uat}/` and remain authoritative for those catalog ids.

## Loop

1. Run `Resolve-SkillDag.ps1` with the user intent.
2. Read each `loadOrder` **skill** path (small).
3. For lessons: read `summary` in the JSON first; open the markdown body only for gaps.
4. If `skipped` lists a needed large doc, re-resolve with `-AllowLarge` or a narrower query.
5. If the lesson reveals a new hard rule, harvest it into the owning catalog skill + skill-sources.
