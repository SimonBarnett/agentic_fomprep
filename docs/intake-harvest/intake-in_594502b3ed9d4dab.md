MRB (light triage): is the lesson useful, generalised, non-duplicate, and a fit for this repo's vision/AGENTS.md? PASS -> merge. Not useful / off-vision -> close with a one-line reason (board CLOSED not-useful). Duplicate -> close citing the existing lesson. Wrong owner -> re-file or MOVED (FR #3299); leave OPEN if the owner repo does not exist yet. Plan content only (requirements, designs, product decisions, FR/issue lists from a Plan seat) -> close 'plan content, not a lesson' (never hold it OPEN); move any how-to-plan lesson inside to SimonBarnett/skills-visionary.

# Harvest: FORMCLTRIGTEXT copyps gate + Form Prep after SQL

Session context: Priority Agent on a self-hosted install (customer names stripped).

## Lessons (Priority-generic)

1. **Column-trigger text lives in the dictionary DB** (`system` / equivalent), in
   `FORMCLTRIGTEXT` + `FORMCLTRIG`, not in the company business DB. Searching only
   the company DB for `FORMTRIGTEXT` / `FORMCLTRIGTEXT` will miss the body.

2. **Leftover `GOTO … WHERE SQL.ENV <> 'copyps'`** on a POST-FIELD fill trigger
   skips the SELECT on every non-copy company. Symptom: typing a key field alone
   leaves related bins/warehouses empty; choosing via a CHOOSE that already
   filters by SERIAL can still work. Prefer sibling form TRIG bodies that already
   omit the ENV gate.

3. **Positive balance and optional SERIAL filter** are the usual sibling pattern:
   `WARHSBAL.BALANCE > 0` and `(:$.SERIAL = 0 OR WARHSBAL.SERIAL = :$.SERIAL)` when
   filling From Bin / warehouse / status from an ACT / pallet code.

4. **Form Preparation is still required** after editing `FORMCLTRIGTEXT`. Updating
   dictionary rows alone leaves the prepared objects on the old compiled trigger
   until `TRANSORDER_T` (or the target ENAME) is prepared.

5. **Bins are often `WAREHOUSES.LOCNAME`**, not a LOC column on `WARHSBAL`. Join
   `WAREHOUSES.WARHS = WARHSBAL.WARHS` and select `LOCNAME`.

6. When remote shell has a short command limit and file PUT times out, apply
   dictionary patches as short integrated `sqlcmd` INSERT/DELETE statements
   rather than staging a long .sql file over the wire. Do not send SQL login
   secrets over IRC/airc.

## Suggested catalog follow-up

- Extend `priority-form-prep-after-sql-change` / `priority-form-engineering` with
  the copyps-gate symptom and the FORMCLTRIGTEXT-in-system-DB note.
- Empty findings are not claimed; this session did apply a real dictionary fix
  and still owes Form Prep + UAT on the customer side.
---
_via-intake id=`in_594502b3ed9d4dab` ts=`2026-11-13T16:05:09Z`_
_source machine=`marchhare` agent=`Report-FomprepIntakeIssue` book=`harvest-agent-skills` ver=`-`_
