---
name: priority-ops-support-desk
description: >
  Priority support desk / BPM service calls. Lazy-load markdown lessons from
  docs/skill-sources/medatech-network/support-desk/ via priority-skill-dag.
  Use when the user says support desk, SP003, service call BPM, handovers, /priority-ops-support-desk.
---

# Priority support desk / BPM service calls

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Hard rules

1. Resolve lessons with `priority-skill-dag` / `tools/priority-skill-dag/Resolve-SkillDag.ps1` — do not dump the whole `support-desk` tree into context.
2. Lessons are distilled from Medatech network docs. Prefer catalog executable skills (formprep, shell-install, hours, UAT) when the task is automation.
3. Priority-generic: hosts and company codes in lessons are examples only.
4. New hard rules learned from lessons must be harvested (CAST IRON).

## Load

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "support-desk <detail>" -MaxLessons 8 -MaxBytes 24000
```

Lesson root: `docs/skill-sources/medatech-network/support-desk/`

## Related catalog skills

Use `Resolve-SkillDag.ps1` to pick overlapping executable skills (shell-install, formprep, mcp-*, backup-*, etc.).
