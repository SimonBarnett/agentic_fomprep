---
name: priority-ht-delete-deadlock-triage
description: >
  Triage Priority house-type Ctrl+Delete SQL 1205 deadlocks: deadlock graph, FORMTRIGTEXT
  PRE-DELETE compare DEV vs TST, PROJACT indexes. No blind auto-fix. Use when HT delete
  deadlock, error 1205, FORMTRIGTEXT, or /priority-ht-delete-deadlock-triage.
---

# Priority HT delete deadlock triage (ops + evidence)

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-ht-delete-deadlock-triage`).

When UI **Ctrl+Delete** on house types surfaces **SQL error 1205**, collect evidence before changing triggers or indexes. UAT smoke procedure remains **priority-ht-delete-smoke**; trigger sign lives in **priority-form-engineering**. Hang with no 1205: check ELEMENT sign via **priority-recalc-concurrency**, not only deadlock graphs.

## When

HT delete hangs or 1205 under concurrent recalc; after trigger edits suspected.

## Checklist (read-only first)

1. **Deadlock graph** — Extended Events or `system_health` session; save `.xdl` / graph XML to `reportRoot`.
2. **FORMTRIGTEXT** — Compare PRE-DELETE trigger bodies **DEV vs TST** for the form involved (often HT / checkpoint family). Document diff; do not deploy without Eshbel/Jester review.
3. **Indexes** — Check `PROJACT`, `ZCLA_SMALLWORKSPLOT` (and related) for missing or conflicting indexes referenced in deadlock resource list.
4. **Form Prep gate** — After any trigger SQL change, run **priority-form-prep-after-sql-change** before retrying UAT.
5. **UAT** — Retry **priority-ht-delete-smoke** on TEST with correct company title (DNAME vs UI).

## Do not

- Auto-deploy index or trigger changes from this skill.
- Put SQL passwords in evidence bundles.

## Success

Root cause hypothesis documented with graphs + text diff; owners assigned (Eshbel/Jester); Form Prep completed before next smoke.

## Fail / escalate

Persistent 1205 with no graph — escalate with CASE fields per **priority-ht-delete-smoke** (DOCNO, STEP, ERROR).
