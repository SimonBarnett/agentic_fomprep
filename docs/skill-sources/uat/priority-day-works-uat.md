# Priority Day Works UAT (source)

## When

Day Works UAT on Priority DEV web. **Unparked gates only.** Work type **Extras**. Day Works flag lives on the **Edit** (`ZCLA_DAYWORKS`), not on Fix. Do **not** touch the old HT Day Work spine (`ZCLA_DAYWORK` / `OPENDAYWORK` / `ELDAYWORK`). Follow `priority-uat-orchestrator`.

Quote/COW gates use History/Neil GUID when those gates unpark â€” do not invent GUIDs.

## Gate A â€” Part long-desc + History

### Pre-UI STRUCT

On the instance DEV jump box, run the structural assert script if the UNPARK names it (CE example: `wp1_gate_a_struct_assert.ps1` on CE-PRIORITY-DEV1).

- Exit 0 STRUCT PASS â†’ continue fast path (UI optional) (RTF, leave-field, Components as named).
- Exit 1 STRUCT FAIL â†’ CASE engineering; **no tab hunting**.
- Do not invent that script in this repo; if missing on the jump box, CASE.

### UI path

Part Catalogue â†’ Parts â†’ sibling **Long Description** (not global search into the wrong focus).

Forms: PARTLONGDESC / DREV headers / DHIST RTF.

### Pass criteria (DW-A1â€“A4 family)

- History shows USERLOGIN + UDATE + CURREV headers (not old TEXTLINE-only grid).
- Drill child is **RTF** Long Desc Revision Text, not TEXTLINE.
- Reopen History after leave-field to confirm mint.
- Harden: empty Long Desc open = **no** new History header (empty-no-mint).
- One real edit = one new History header; fail if UDATE is `01/01/88` or nonsense `<1000`.
- FORMJOIN DREVâ†’DHIST must key PART+REVISIONID (no cross-part bleed of Revision Text).
- Wrong path (Child Parts / Part Spec 2) can throw inventory-control toast â€” navigate back to Long Description sibling.

### Form Prep dependency

If History is unprepared / missing headers / mint skipped: CASE (often EXECPREPLOCK UPD=Y or missing FORMKEYS/EXPRESSION). Tester does not Form Prep unless UNPARK says so â€” see `priority-form-engineering`.

## Gate B â€” Edit header Day Works + VAT

### Nav (hard-won)

Projects â†’ Plots â†’ Element Acts â†’ drill the active act â†’ sub-level **Element Edits** â†’ Enter the existing EDITID.

**Never** use Open Edit / Re-Open Edit / Close Edit for an already-open Extra. Those paths cause â€œalready openâ€, read-only fields, or wrong form.

Prefer one clean browser tab / fresh login when stuck on â€œRecord already exists in formâ€.

### Cases

- **DW-B1** Day Works? = Y (`ZCLA_DAYWORKS`)
- **DW-B2** VAT code via picker (CE example VAT20 â†’ PART e.g. 552)
- **DW-B3** Total VAT (`TOTVAT`) **readonly** (verify expected amount when UNPARK gives it)

Day Works field POS is often near INVSEP after Form Prep / FORMCLMNS fixes.

### Gotchas

- Missing T$$ columns / unprepared `ZCLA_ELEDIT` â†’ CASE Form Prep (engineering).
- Save may require PO / EXTFILENAME stubs (â€œExtra must have a purchase orderâ€).
- Mid-save UPDATE on same EDITID â†’ â€œRecord has been modified/deletedâ€ â€” stop, CASE; do not thrash Ctrl+Enter.
- Optional SQL assert DAYWORKS/PART/TOTVAT when engineering asks; structured/SQL assert is the standard-path evidence; video only via uat-video-pack.

## Gates Câ€“G â€” PARKED

Parallel DW lines, Quote, COW, Word, full UAT-01..14, ELEDITDW remarks/quote: **do not run** until UNPARK with CASE/DOCNO/steps.

## Pass / fail

PASS: structured result; screenshots only on full PASS (optional); no mandatory video. FAIL: CASE pack. One retry then park. Human video â†’ bob-design-uat uat-video-pack.
