---
name: priority-service-desk-quote-order-duplicate-lines
description: >
  Custom triggers copied from standard quote-to-order logic add the lines
  twice when they also call the standard line-add. Remove only the redundant
  call. Use when duplicate sales order lines from quotation, copied BUF6,
  or /priority-service-desk-quote-order-duplicate-lines.
---

# Copied quote-to-order trigger duplicated lines

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/quote-order-duplicate-lines.md`.

Issue type: Open Order from a sent quotation creates duplicate order lines because a custom trigger copied the standard line-adding logic and also calls it again.

Known: internal note 2026-10-30 09:57 GMT says the custom code is a copy and includes BUF6, which adds the lines from the quote to the order. The redundant buffer call was removed or commented out of the copied custom triggers, including the quote-to-order path, while the intended custom logic was kept. On 2026-10-30 09:55 GMT, in the copy company, Open Order from a sent quotation created an order without duplicate lines. The regression had been introduced while fixing another call. Opened 2026-10-28 15:18 GMT.

Unknown: the exact diff, trigger names, and customer live acceptance. Customer production test was still pending. Do not invent the commented lines. This is not the work-order close balance mismatch (`priority-service-desk-record-modified-custom-close`).

## Prerequisites

Copy-company or authorized Test. A developer who can read the custom trigger. Deployment still needs the estate's normal review. This harvest does not authorize a live trigger edit. No bulk line deletion and no disabling of every trigger.

## Steps

1. In Test, run the quotation-to-order action and count source lines against target lines.
2. If the counts match, stop. This defect is duplicate lines, not a pricing issue.
3. Inspect custom triggers recently copied from the standard quote-to-order path. Look for the standard line-add (the source called it BUF6) being invoked again by the copy. Do not assume the user entered the lines twice.
4. The developer removes only that redundant call, after tracing the order of the intended custom logic. Preserve the behavior the earlier fix was meant to keep.
5. Retest insert and update, and retest the original feature that the earlier fix changed, in the copy company. Confirm the new order has no duplicate lines.
6. Customer live acceptance is a separate step. The copy-company pass is not that acceptance.

## Verification

Proven: copy-company Open Order produced no duplicate lines (SC263415).

Not proven: the exact edit and live customer use.

## Stop or escalate

Stop if the duplicate is data entry, if the redundant call cannot be identified, or if removing it would drop the earlier fix. The customization owner reviews the diff. No undocumented patch and no mass delete of order lines.
