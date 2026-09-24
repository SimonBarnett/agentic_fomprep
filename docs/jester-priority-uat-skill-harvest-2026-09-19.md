# Jester testing-skill harvest — CE Priority UAT (2026-09-19)

**From:** Jester via Eshbel  
**Merge into:** docs/feature-request-priority-skills-catalog-2026-09-19.md (sections A + D)  
**Build job:** fold into ionos 5e8ce936 catalog push

## Cross-cutting standing rules (all CE Priority UAT)

**When:** Any CE Priority user-test on DEV or TEST web.

**Hard rules:**
- Tester read-only on product code; CASE to engineering; no Recalc/HTSWAP/Clear Plots unless case says so.
- Max one retry of same failing step without engineering reply; then CASE and park.
- Login `Si` (case-sensitive). If password prefilled, Log In immediately.
- Prefer pickers over free text (Branch, Contract Type, VAT Code).
- Banned sites: PR25000001 / 004 / 010. Avoid Recalc Plots/Types, HT Swap, Clear Plots, Site Bom, Margin unless unparked.

**Evidence:**
- PASS → screen-record; silent pass without video not allowed for formal UAT.
- FAIL → CASE/DOCNO/STEP/ACTION/FIELD/TRIED/ERROR/SCREEN (exact text).
- Human packs: human speed, mouse visible (`ffmpeg x11grab -draw_mouse 1`), click ripples, cut idle, burn-in subtitles. Capture correct Priority display (wrong DISPLAY = empty video).

**Env:**

| Host | Use | Company pitfall |
|------|-----|-----------------|
| prioritydev.clarksonevans.co.uk | Day Works / create-smoke | Usually D / SQL `base` |
| prioritytest.clarksonevans.co.uk | HT-delete | DNAME `base` = UI **T - Clarkson Evans Live - 20251031**; UI **Test** = DNAME `test` (empty PR26*). Confirm company title; USERENV can stick — relogin after change. |

Thick client: CE-PRIORITY-DEV1, SQL 10.220.0.5\DEV. Browser/desktop only (no MCP).

## 1) CE Priority project create smoke (TC-01–05)

New project → team → contract → copy HT → paste plots. New DOCNO each run; Branch/Contract Type via picker; prefer Electrical/PV (EL=5); skip Contract Elements on happy path; prefer .2/.3 SNG-ROW; Paste element **PV system** not DAY WORK. TC-01b Internal Project Team (Si) required or ZGEM_ERR_NOTINTEAM. Gotchas: insertion-failed toast may still commit — refresh; blank HT after logout → refresh; EL mismatch hangs paste.

## 2) Day Works UAT (gates)

Unparked gates only. Work type Extras; Day Works flag on Edit (`ZCLA_DAYWORKS`) not Fix; Quote/COW from History/Neil GUID; do not touch old HT Day Work spine.

### Gate A — Part long-desc + History

Pre-UI STRUCT on DEV1: `wp1_gate_a_struct_assert.ps1` — exit 0 then UI/video only; exit 1 CASE no tab hunt. Path: Part Catalogue → Parts → sibling Long Description (not global search). Forms: PARTLONGDESC / DREV headers / DHIST RTF. Pass: USERLOGIN+UDATE+CURREV headers; drill RTF not TEXTLINE; reopen History after leave. Cases DW-A1–A4. Harden: empty-no-mint; one real edit = one header; fail UDATE 01/01/88 or <1000; FORMJOIN DREV→DHIST PART+REVISIONID keys; no cross-part bleed.

### Gate B — Edit header Day Works + VAT

Nav: Projects → Plots → Element Acts → sub-level Element Edits (not Open Edit for already-open Extra). DW-B1 DAYWORKS=Y; DW-B2 VAT PARTNAME→PART; DW-B3 TOTVAT readonly. Gotchas: T$$ columns + Form Prep; PO/EXTFILENAME stubs; Day Works field POS near INVSEP; avoid mid-save UPDATE clash on same EDITID; SQL assert DAYWORKS/PART/TOTVAT.

### Gates C–G

Parked until UNPARK (parallel DW lines, Quote, COW, Word, full UAT-01..14).

## 3) House-type DELETE smoke (HT-DL)

TEST under concurrent recalc (do not drain Stack). Confirm company title first. Projects F11 DOCNO → House Types → HOUSETYPEID → Ctrl+Delete. Open ZCLA_HTEDIT blocks delete — pick 0-edit fixture. Hang without 1205 = FAIL (PRE-DELETE ELEMENT sign). Pass: HT gone, no hang, no 1205. Learned: `:ELEMENT = - :ELEMENT` before `#INCLUDE ZCLA_ELACT/ZCLA_CHKPNT-DEL`.

## Catalog mapping

| Harvest | Catalog skill |
|---------|----------------|
| Cross-cutting rules | Fold into `priority-uat-orchestrator` (was stub) |
| TC-01–05 | `priority-project-create-smoke` |
| Day Works A–B | `priority-day-works-uat` (C–G parked note) |
| HT-DL | `priority-ht-delete-smoke` (or section under form-engineering + UAT) |
