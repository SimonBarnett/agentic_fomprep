---
name: priority-recalc-concurrency
description: >
  Edit delete or recalc paths under live Stack load: positive ELEMENT for
  checkpoint deletes, RECALC clear, dependent pre-purge, stale-price consumers.
  Use when HT delete hangs without 1205, CHKPNT-DEL, or /priority-recalc-concurrency.
---

# Recalc concurrency

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-recalc-concurrency`).

Authority: `docs/skill-sources/programming/RECALC_CONCURRENCY.md`.

## Hard rules

1. If PRE-DELETE selected negative checkpoints, flip `:ELEMENT = - :ELEMENT` before `#INCLUDE …/ZCLA_CHKPNT-DEL` (expects positive).
2. Clear `ZCLA_RECALC` for that entity only; pre-purge dependent plot rows; align supporting indexes to live.
3. Open edit children can block deletes by design — use 0-edit fixtures for smoke.
4. Calculators gated only on RECALC/ISBUILD can still show stale prices after HT swap / stuck P/INPROG.

## Related

- UAT smoke: **priority-ht-delete-smoke**
- Deadlock evidence: **priority-ht-delete-deadlock-triage**
- Trigger text: **priority-form-engineering**
