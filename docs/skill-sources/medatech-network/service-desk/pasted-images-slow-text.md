# Large images pasted into a text form made the record slow

Issue type: one record opens or scrolls slowly, and its text form (for example internal dialogue) has a large email trail with images pasted into it.

Known: on 2026-10-06 10:33 BST support said this can happen when images are pasted into a text form, which is not supported, and that images should be imported with the image button. At 11:28 BST the customer said they had pasted a whole trail of emails with images into that call, had deleted the images, and it was working faster.

This is not a server performance problem and not a network problem. It is limited to the record that has the pasted content.

## Steps

1. Confirm the slowness is on one record, not across the system.
2. Open the text form on that record and look for pasted images or long pasted email trails.
3. The record owner removes the pasted images. Keep the text that is needed.
4. If an image is needed, import it with the text form image button, or attach it, instead of pasting.
5. Reopen the record and confirm it is faster.

## Verification

Proven: removing the pasted images made the record faster, confirmed by the customer (SC263088).

Not proven: image sizes, and whether imported images have any effect on speed.

## Stop

Stop if the slowness is system wide or the record has no pasted images. Then treat it as a performance call.
