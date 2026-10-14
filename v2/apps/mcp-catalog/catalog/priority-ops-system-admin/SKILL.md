---
name: priority-ops-system-admin
description: >
  Priority system admin / troubleshooting. Lazy-load markdown lessons from
  docs/skill-sources/medatech-network/system-admin/ via priority-skill-dag.
  Use when the user says Priority permissions, troubleshooting, error 9002, database maintenance, antivirus Priority, /priority-ops-system-admin.
---

# Priority system admin / troubleshooting

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. Resolve lessons with `priority-skill-dag` / `tools/priority-skill-dag/Resolve-SkillDag.ps1` — do not dump the whole `system-admin` tree into context.
2. Lessons are distilled from Medatech network docs. Prefer catalog executable skills (formprep, shell-install, hours, UAT) when the task is automation.
3. Priority-generic: hosts and company codes in lessons are examples only.
4. New hard rules learned from lessons must be harvested (CAST IRON).

## Load

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "system-admin <detail>" -MaxLessons 10
```

Lesson root: `docs/skill-sources/medatech-network/system-admin/`

## Related catalog skills

Use `Resolve-SkillDag.ps1` to pick overlapping executable skills (shell-install, formprep, mcp-*, backup-*, etc.).
