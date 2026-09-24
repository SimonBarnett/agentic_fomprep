# Version Revision / shell discipline

## One shell per workstream

- Maintain a dedicated Version Revision shell file as work proceeds.
- Prepare after meaningful batches.
- Never mix unrelated features into a shared upgrade shell (CE: Day Works must not enter upgrade 8338).

## Re-prepare is normal

Re-preparing the same Version Revision after content changes is expected practice. Ignore SDK "do not re-prepare" as a hard site rule when content changed.

## TAKETRIG step shape

Working Revision Steps (match known-good shells):

- `HOWCREATED = M`
- `AFTERPREP = Y`
- `OPTFLAG` blank

Wrong shape can produce: shell booked / UI "Installed" but **zero** `INSTALLEDUPGTRIG` / TAKETRIG rows applied (silent miss). Always verify installed trigger rows and form trigger hashes.

## Prepare vs Install

- Compile/Prepare Upgrade and Install Upgrade ENAMEs come only from `v2/config/pin.json` (PinComplete). Never invent.
- Headless takeupgr Prepare may require a linked Version Revisions UI row; human Prepare click can still be needed.

## Cross-links

- Compile: `priority-shell-compile`
- Install: `priority-shell-install`
- Form Prep after trigger text change: named Form Prep / `priority-form-prep-after-sql-change`
