---
name: priority-ops-reports
description: >
  Priority report packs. Lazy-load markdown lessons from
  docs/skill-sources/medatech-network/reports/ via priority-skill-dag.
  Use when the user says Priority report pack, age debt, on time delivery, trace lot, /priority-ops-reports.
---

# Priority report packs

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. Resolve lessons with `priority-skill-dag` / `tools/priority-skill-dag/Resolve-SkillDag.ps1` — do not dump the whole `reports` tree into context.
2. Lessons are distilled from Medatech network docs. Prefer catalog executable skills (formprep, shell-install, hours, UAT) when the task is automation.
3. Priority-generic: hosts and company codes in lessons are examples only.
4. New hard rules learned from lessons must be harvested (CAST IRON).

## Load

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "reports <detail>" -MaxLessons 10
```

Lesson root: `docs/skill-sources/medatech-network/reports/`

## Related catalog skills

Use `Resolve-SkillDag.ps1` to pick overlapping executable skills (shell-install, formprep, mcp-*, backup-*, etc.).
