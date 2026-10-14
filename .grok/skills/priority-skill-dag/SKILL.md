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
2. Prefer **catalog skills** (`v2/apps/mcp-catalog/catalog/*/SKILL.md`) for executable playbooks (formprep, shell install, hours, UAT).
3. Prefer **lessons** under `docs/skill-sources/medatech-network/` for ops/SOP/install guidance distilled from Medatech network docs.
4. CAST IRON: new repeatable procedures learned while using lessons must be harvested back (catalog + skill-sources) via `harvest-priority-skills`.
5. No secrets. CE / Medatech hostnames are examples only.

## Resolve

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "<user intent>" -MaxLessons 8 -MaxSkills 5
```

Output JSON fields:

| Field | Meaning |
|-------|---------|
| `skills` | Ranked catalog skills to load |
| `lessons` | Ranked markdown lessons under medatech-network |
| `topics` | Topic hubs (install-upgrade, sop, …) |
| `loadOrder` | Suggested open order (skills then lessons) |

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
| `forms-code` | Forms, common code stubs, Sacred WIZ3 lessons |

Existing programming / hours / UAT skill-sources stay under `docs/skill-sources/{programming,hours,uat}/` and remain authoritative for those catalog ids.

## Loop

1. Run `Resolve-SkillDag.ps1` with the user intent.
2. `get_skill` / read each `loadOrder` skill path.
3. Read lesson markdown only as needed for gaps the catalog skill does not cover.
4. If the lesson reveals a new hard rule, harvest it into the owning catalog skill + skill-sources (do not leave it only in chat).
