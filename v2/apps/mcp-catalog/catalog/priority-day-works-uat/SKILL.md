---
name: priority-day-works-uat
description: >
  Priority Day Works UAT gates A-B (part long-desc History; Edit header Day Works
  plus VAT). Gates C-G stay parked until UNPARK. Use when the user says Day Works UAT,
  DW-A, DW-B, ZCLA_DAYWORKS, or /priority-day-works-uat.
---

# Priority Day Works UAT

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-day-works-uat`). Browser/desktop only.

Follow **priority-uat-orchestrator** standing rules. Web host from instance config. **Unparked gates only.**

## When

Day Works UAT on DEV web. Work type **Extras**. Day Works flag on Edit (`ZCLA_DAYWORKS`), not Fix. Quote/COW from History/Neil GUID when those gates unpark — do not invent GUIDs. Do not touch the old HT Day Work spine.

Source: Jester harvest 2026-09-19.

## Gate A -- Part long-desc + History

Pre-UI STRUCT on DEV1: `wp1_gate_a_struct_assert.ps1` -- exit 0 then UI/video only; exit 1 CASE, no tab hunt. Do not invent that script in this repo; if it is missing on DEV1, CASE.

Path: Part Catalogue -> Parts -> sibling **Long Description** (not global search).

Forms: PARTLONGDESC / DREV headers / DHIST RTF.

Pass: USERLOGIN + UDATE + CURREV headers; drill RTF not TEXTLINE; reopen History after leave.

Cases: DW-A1-A4.

Harden: empty-no-mint; one real edit = one header; fail UDATE 01/01/88 or <1000; FORMJOIN DREV->DHIST PART+REVISIONID keys; no cross-part bleed.

## Gate B -- Edit header Day Works + VAT

Nav: Projects -> Plots -> Element Acts -> sub-level **Element Edits** (not Open Edit for an already-open Extra).

- DW-B1 `DAYWORKS=Y`
- DW-B2 VAT PARTNAME -> PART
- DW-B3 TOTVAT readonly

Gotchas: T$$ columns + Form Prep; PO/EXTFILENAME stubs; Day Works field POS near INVSEP; avoid mid-save UPDATE clash on the same EDITID; SQL assert DAYWORKS/PART/TOTVAT.

## Gates C-G -- PARKED

Parked until UNPARK: parallel DW lines, Quote, COW, Word, full UAT-01..14. Do not run them. If asked, point at this section and the orchestrator UNPARK protocol.

## Pass / fail

PASS: screen-record. FAIL: CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN. One retry then CASE.
