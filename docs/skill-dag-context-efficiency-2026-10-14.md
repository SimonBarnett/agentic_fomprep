# Skill DAG context-efficiency (2026-10-14)

Follow-up to the Medatech network skill-book harvest. Tightens resolve so agents stay inside a context budget.

## Changes

1. **`MaxBytes` budget** (default 24000) on `Resolve-SkillDag.ps1` / `resolve_dag.py`
2. **`SingleFileCeiling`** (default 20000) — large lessons go to `skipped` unless `-AllowLarge`
3. **Frontmatter triggers** indexed from each catalog `SKILL.md` description / Use-when
4. **Topic-first gating** — uses `depends_on` / `contains` / `loads_topic` edges
5. **Word-boundary scoring** for short tokens; compound boost (`form prep` → `formprep`)
6. **Rich twin dedupe** at build (`skippedRichDupes`)
7. **Digests** on every hit: `bytes`, `summary`, `weight`
8. **WIZ3 / sacred demotion** (`weight: low`) unless help/WIZ query
9. **Forbid reading `dag.json`** in `priority-skill-dag` skill; slim `dag-index.json` for tooling only
10. Ops hubs default to `-MaxLessons 8 -MaxBytes 24000`

## Smoke (post-change)

| Query | usedBytes | Notes |
|-------|-----------|--------|
| shell install upgrade | ~24k | LB21000002 50–70KB docs skipped |
| VAT Intrastat year end | ~24k | `priority-ops-financials` now ranks |
| form prep EXECPREPLOCK | ~15k | `priority-formprep` in top skills |
| WIZ3 bank transfers | ~9k | sacred unlocked via help intent |

## Rebuild

```powershell
powershell -File tools\priority-skill-dag\Build-SkillDag.ps1
powershell -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "<intent>" -MaxBytes 24000
```
