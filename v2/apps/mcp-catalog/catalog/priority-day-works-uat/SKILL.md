---
name: priority-day-works-uat
description: >-
  Priority Day Works UAT gates Aâ€“B (fast path). Gates Câ€“G parked until UNPARK. Prefer WCF/SQL;
  no mandatory video. Use for Day Works UAT, DW-A, DW-B, ZCLA_DAYWORKS, or /priority-day-works-uat.
---

# Priority Day Works UAT

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-day-works-uat`).
This catalog does not drive the UI or WCF.

Follow **priority-uat-orchestrator** (fast standard test). Unparked gates only. Work type **Extras**. Day Works flag on Edit (`ZCLA_DAYWORKS`), not Fix. Do not touch old HT Day Work spine. Source: `docs/skill-sources/uat/priority-day-works-uat.md` (2026-09-28).

## Gate A â€” Part long-desc + History

Pre-UI STRUCT on DEV1 when UNPARK names it (CE example `wp1_gate_a_struct_assert.ps1`): exit 0 â†’ continue fast path; exit 1 â†’ CASE, no tab hunt. Do not invent the script in this repo.

Path: Part Catalogue â†’ Parts â†’ sibling **Long Description** (not global search). Prefer WCF/SQL asserts over headed UI when STRUCT already covers the gate.

Pass: USERLOGIN+UDATE+CURREV headers; child RTF not TEXTLINE; reopen History after leave; empty-no-mint; one edit = one header; fail bad UDATE; FORMJOIN DREVâ†’DHIST PART+REVISIONID; no cross-part Revision Text bleed.

Dictionary (DEV `system` / company `base`): parent columns on **FORMJOINS** —
`PART` PART→`ZCLA_PARTLONGDREV`; `PART`+`REVISIONID` DREV→`ZCLA_PARTLONGDHIST`.
**FORMKEYS.NAME** is the form's own key (`REVISIONID` on DREV; `TEXTLINE` on
DESC/DHIST) — it is **not** `PART`. Do not assert `FORMKEYS.NAME = 'PART'`.

Cases DW-A1â€“A4. Unprepared / mint skip â†’ CASE Form Prep (engineering).

## Gate B â€” Edit header Day Works + VAT

Nav: Projects â†’ Plots â†’ Element Acts â†’ sub-level **Element Edits** â†’ Enter existing EDITID. **Never** Open Edit / Re-Open / Close Edit for an already-open Extra.

- DW-B1 `DAYWORKS=Y`
- DW-B2 VAT via picker (PARTNAMEâ†’PART)
- DW-B3 TOTVAT readonly

Gotchas: T$$ + Form Prep; PO/EXTFILENAME stubs; Day Works POS near INVSEP; mid-save â€œRecord has been modified/deletedâ€ â†’ CASE; optional SQL assert.

## Gates Câ€“G â€” PARKED

Parallel DW lines, Quote, COW, Word, full UAT-01..14, ELEDITDW: do not run until UNPARK.

## Pass / fail

- **PASS:** structured result; screenshots only on full PASS (optional). **No** mandatory video.
- **FAIL:** CASE pack. One retry then park.
- Human video â†’ bob-design-uat **`uat-video-pack`** only.
