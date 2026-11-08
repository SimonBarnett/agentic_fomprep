# Refresh restores attachments after quote conversion

Issue type: immediately after converting a price quotation to a sales order, the attachment paperclip cannot be used. Refreshing and opening that new order again allows the attachment.

Known, customer mail 2026-10-13 08:45 BST: convert a quote to a sales order, the paperclip is unavailable, refresh, go back into the new sales order, and the paperclip works. The cause is unknown. No build fix was recorded. A note that a general disappearing-icon issue seemed fixed did not include a release. This skill is only the residual workaround.

This is not a missing browser extension and not a failure on every form. Do not convert the quote again. Do not delete cache. Save other work before refresh. Do not refresh while an upload is running.

## Steps

1. Confirm the conversion saved and note the new sales-order number.
2. Save or set aside any unsaved work.
3. Refresh the application and open that same order. Do not create a second order.
4. Attach through the paperclip and confirm the file is actually on the order.
5. If it keeps happening, escalate the UI defect. Do not record the refresh as a product fix.

## Verification

Proven: the customer could attach after refresh and reopen (SC263161).

Not proven: a code change or a release that removes the need to refresh.

## Stop

Stop if the paperclip fails on orders that were not just converted, or if the proposal is another conversion or a cache wipe.
