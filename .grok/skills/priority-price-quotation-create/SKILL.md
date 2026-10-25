---
name: priority-price-quotation-create
description: >-
  Create a Priority Price Quotation (PQ, form CPROF) via OData from a step-by-step estimate: copy header from recent PQs, one CONS-HR-MED line per step posted in REVERSE (Priority inserts at LINE 1), quoted qty = 2x internal, never send a price, line-specific remarks, Note + standard terms, draft-first approval, duplicate checks, read-back of lines and totals.
  Use when /priority-price-quotation-create, "create a quote / PQ / price quotation", or turning an estimate into a Priority quote.
---

# Priority price quotation (PQ) create via OData

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-price-quotation-create`).

Authoritative harvest: `docs/skill-sources/quotes/priority-price-quotation-create.md` (2026-10-25, entity/field tables, anonymised example, reference script).

## Auth / endpoint (do not hardcode secrets)

- Medatech OData base: `https://priority.medatecherp.co.uk/odata/Priority/tabula.ini/live/` (other instances: operator allowlist).
- User `SimonB`; password from env `PRIORITY_ODATA_PASSWORD` - never printed, logged or committed.
- **Live writes only after Simon approves the draft.** Draft -> show it -> approval -> write -> read back.

## Entities

- Header `CPROF` (key `CPROFNUM`, e.g. `PQ26xxxxx`).
- Lines `CPROF('<q>')/CPROFITEMS_SUBFORM` (key `KLINE`; `LINE` = display order).
- Line remarks ("Quoted Item - Remarks") `.../CPROFITEMS_SUBFORM(<KLINE>)/CPROFITEMSTEXT_SUBFORM` `{TEXT}`.
- Quote remarks `CPROF('<q>')/CPROFTEXT_SUBFORM` `{TEXT}`.

## Header - copy from recent PQs

GET the latest PQs (same customer first) and copy `TYPECODE`, `AGENTCODE` (sales rep), `BRANCHNAME`, `TAXCODE`, `PAYCODE`; set `CUSTNAME`, `NAME` (contact), `DOCNO` (project), `PDATE` = today, `EXPIRYDATE` = **PDATE + 30 days**, `DETAILS` (max **24**), `REFERENCE` = customer request no (max **12**). Do not send `PLNAME` or prices. Keep the recent PQ's `CPROFTEXT_SUBFORM` for the standard terms.

## Lines - BY STEPS

- One `CONS-HR-MED` line (unit `Hrs`) per estimate step, in step order; `PDES` = `Step N: ...` (max **59**).
- `TQUANT` (quoted) = **2 x** internal estimate; `ZEMG_INTQUANT` (Internal Quantity) = internal hours; `ZEMG_QUOTEQUANT` (Prep Quote Time) = quote-prep time spread across the lines.
- **Never send `PRICE`.** Priority's triggers fill the customer special price or price list price. Read it back and report it.
- **Order gotcha:** each new line is inserted at **LINE 1** and setting `LINE` via OData does nothing. POST in **reverse step order** (last step first) and GET `KLINE,LINE,PDES` after each add to check the order.

## Line remarks (`CPROFITEMSTEXT_SUBFORM`)

- Describe **just that line**: lead sentence (what the work is), `Outcome:`, `Forms/columns:` (forms and columns touched; mark new custom columns `[new]`), optional `Test cases:`.
- **No** Background / Customer Requirement / Pre-condition / ... template headings; no generic text repeated across lines.
- **Replace, don't append** (text entity has an `APPEND` flag). `CONS-HR-MED` carries default `N/A` template text that Priority copies onto lines added on screen - overwrite it. Read back to confirm.
- Escape only `<>&` (`html.escape(s, quote=False)`): apostrophes can be stored as `&#x27;`, so write plain apostrophes.

## Quote-level text (`CPROFTEXT_SUBFORM`)

`Note: this quotation is based on the following assumptions:` + one `- ...` paragraph per assumption / exclusion, then the standard terms copied from a recent PQ (replace that PQ's old Note paragraph).

## Before creating or retrying

- GET `CPROF` filtered on `CUSTNAME` + `DETAILS` (and/or `REFERENCE`) - resume an existing quote, never create a second.
- Keep `state.json` (quote no, per-line `KLINE` + text done, header text done); match existing lines on `PDES` before each POST. Stop and report on any non-2xx - nothing half-built or doubled.

## Verify (read back)

`GET CPROF('<q>')?$expand=CPROFTEXT_SUBFORM,CPROFITEMS_SUBFORM($expand=CPROFITEMSTEXT_SUBFORM)` and report: header fields and `STATDES`; each line by `LINE` with `PDES`, `TQUANT`, `TUNITNAME`, `ZEMG_INTQUANT`, `ZEMG_QUOTEQUANT`, trigger-set `PRICE`, `QPRICE`; remarks per line (line-specific, no template, no `N/A`, no `&#x27;`); quote Note + terms once; totals net `QPRICE`/`DISPRICE`, `VAT`, gross `TOTPRICE`, `CODE`.

## Do not

- Print or commit the password; write live without approval of the shown draft.
- Enter a price, rate, price list or discount.
- Rely on `LINE` to order lines; append remarks; create duplicate quotes or lines.
