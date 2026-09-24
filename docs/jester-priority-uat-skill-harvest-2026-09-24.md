# Jester testing-skill harvest — Priority UAT (2026-09-24)

**From:** Jester  
**Supplements:** [jester-priority-uat-skill-harvest-2026-09-19.md](jester-priority-uat-skill-harvest-2026-09-19.md)  
**Authoritative procedure sources:** `docs/skill-sources/uat/`  
**Catalog targets:** `v2/apps/mcp-catalog/catalog/priority-{uat-orchestrator,project-create-smoke,day-works-uat,ht-delete-smoke}/`

## Why this harvest

Simon asked to harvest all Priority testing skills Jester learned into `agentic_fomprep`. The 2026-09-19 doc was a summary folded into thin catalog stubs. Local Grok workflow leaflets (`ce-priority-*`) are gone from the box. This pack is the full learned UAT procedure, Priority-generic.

## Skills harvested

| Skill | Coverage added vs 1.0 stubs |
|-------|-----------------------------|
| `priority-uat-orchestrator` | Human video pack rules; DISPLAY capture; company/DNAME; UNPARK/CASE; Priority-generic wording |
| `priority-project-create-smoke` | Full TC-01–05 sequence, team/contract/HT/plot gotchas, banned sites pointer |
| `priority-day-works-uat` | Gate A STRUCT + leave-field mint + History/RTF harden; Gate B Element Edits nav (no Open Edit), T$$/PO/Form Prep gotchas; C–G parked |
| `priority-ht-delete-smoke` | Company title pitfall; HTEDIT block; hang=FAIL; no Stack drain; PRE-DELETE pointer |

## Status at harvest time (2026-09-24)

- Gate A: green (demo READY)
- Gate B: closed PASS
- HT-DL-1e: closed PASS
- Gate C+ / ELEDITDW: parked awaiting WP3–4 UNPARK

## MRB

Bob chairs on the PR. Jester: hostile UAT after merge only if asked / UNPARKed.
