# Medatech network docs → skill lessons

Markdown lessons converted from the cleaned Priority-Agent docs tree (Medatech internal network dump).

## CAST IRON

Harvest is non-negotiable. New repeatable Priority procedures found while reading these lessons must be promoted via `harvest-priority-skills` into:

1. This tree or `docs/skill-sources/{programming,hours,uat}/`
2. `v2/apps/mcp-catalog/catalog/<id>/SKILL.md` + `meta.json`
3. Optional `.grok/skills/<id>/SKILL.md` mirror

## Lazy load (DAG)

Do **not** load the entire corpus into an agent context.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "<intent>"
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Build-SkillDag.ps1
```

DAG index: `_dag/dag.json`  
Loader skill: `priority-skill-dag`

## Topics

| Folder | Contents |
|--------|----------|
| `install-upgrade/` | Install, upgrade, refresh, SSL, bin_95 |
| `system-admin/` | Admin, troubleshooting |
| `financials/` | VAT, COGS, costing |
| `integrations/` | API, portal, EDI, sync |
| `support-desk/` | SP003, BPM |
| `customer-guides/` | Customer-ready + user-guides |
| `sop/` | Official SOP (incl. version-15) |
| `packages/` | Installed-as-Standard |
| `procedures/` / `reports/` | Packs |
| `training/` | Workshops + work-instructions |
| `forms-code/` | Forms, code stubs, Sacred WIZ3 HTML→md |
| `sales-crm/` / `inventory-mrp/` / `production/` / `purchasing/` | Thin topic stubs + pointers |
| `release-notes/` | Release notes |
| `restored-from-xx-invalid/` | Restored unique guides (review currency) |

Customer-specific packs are **excluded** (quarantined outside this skill book).

## Convert / verify

```powershell
powershell -File tools\priority-skill-dag\Convert-MedatechDocsToMarkdown.ps1
powershell -File tools\priority-skill-dag\Verify-SkillsAgainstDocs.ps1
```

Source originals on the build box: `d:\Priority-Agent\docs\` (binary packages, CHM, PDF).
