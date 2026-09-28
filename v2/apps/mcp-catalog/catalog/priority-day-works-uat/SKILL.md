---
name: priority-day-works-uat
description: >-
  Priority Day Works UAT gates A–B (fast path). Gates C–G parked until UNPARK. Prefer WCF/SQL;
  no mandatory video. Use for Day Works UAT, DW-A, DW-B, ZCLA_DAYWORKS, or /priority-day-works-uat.
---

# Priority Day Works UAT

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-day-works-uat`).
This catalog does not drive the UI or WCF.

Follow **priority-uat-orchestrator** (fast standard test). Unparked gates only. Work type **Extras**. Day Works flag on Edit (`ZCLA_DAYWORKS`), not Fix. Do not touch old HT Day Work spine. Source: `docs/skill-sources/uat/priority-day-works-uat.md` (2026-09-28).

## Gate A — Part long-desc + History

Pre-UI STRUCT on DEV1 when UNPARK names it (CE example `wp1_gate_a_struct_assert.ps1`): exit 0 → continue fast path; exit 1 → CASE, no tab hunt. Do not invent the script in this repo.

Path: Part Catalogue → Parts → sibling **Long Description** (not global search). Prefer WCF/SQL asserts over headed UI when STRUCT already covers the gate.

Pass: USERLOGIN+UDATE+CURREV headers; child RTF not TEXTLINE; reopen History after leave; empty-no-mint; one edit = one header; fail bad UDATE; FORMJOIN DREV→DHIST PART+REVISIONID; no cross-part Revision Text bleed.

Cases DW-A1–A4. Unprepared / mint skip → CASE Form Prep (engineering).

## Gate B — Edit header Day Works + VAT

Nav: Projects → Plots → Element Acts → sub-level **Element Edits** → Enter existing EDITID. **Never** Open Edit / Re-Open / Close Edit for an already-open Extra.

- DW-B1 `DAYWORKS=Y`
- DW-B2 VAT via picker (PARTNAME→PART)
- DW-B3 TOTVAT readonly

Gotchas: T$$ + Form Prep; PO/EXTFILENAME stubs; Day Works POS near INVSEP; mid-save “Record has been modified/deleted” → CASE; optional SQL assert.

## Gates C–G — PARKED

Parallel DW lines, Quote, COW, Word, full UAT-01..14, ELEDITDW: do not run until UNPARK.

## Pass / fail

- **PASS:** structured result; screenshots only on full PASS (optional). **No** mandatory video.
- **FAIL:** CASE pack. One retry then park.
- Human video → bob-design-uat **`uat-video-pack`** only.
