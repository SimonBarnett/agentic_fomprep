---
name: priority-version-revision-discipline
description: >
  Maintain dedicated Version Revision shells, flag/add TAKE steps (TAKETRIG
  HOWCREATED=M/AFTERPREP=Y), refuse empty UPGNOTES, and verify INSTALLEDUPGTRIG
  after install. Use when shell booked but zero triggers, SQL-patched triggers,
  upgrade packs, or /priority-version-revision-discipline.
---

# Version Revision discipline

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-version-revision-discipline`).

Authority: `docs/skill-sources/programming/VERSION_REVISION.md` and Eshbel
[Installing your Customizations](https://prioritysoftware.github.io/sdk/Installing-Customizations).

## Hard rules

1. One dedicated shell per workstream; Prepare after meaningful batches; do not mix unrelated upgrades.
2. **Revision Steps required:** before Prepare, `UPGNOTES` for the upgrade must list every TAKE/DBI step. Booked `UPGRADES` with zero steps is not shippable.
3. SQL patches to `FORMTRIGTEXT` do **not** auto-flag steps — select unlinked rows or insert manual `TAKETRIG` (`UPGTYPE=2`, `HOWCREATED=M`, `AFTERPREP=Y`, `OPTFLAG` blank).
4. Re-prepare after content / step change is normal on this estate.
5. Verify `INSTALLEDUPGTRIG` / hashes after Install; UI Installed is not enough.
6. Compile/install ENAMEs only from `v2/config/pin.json`.
7. Headless Prepare may fail with "Revision does not exist" while the row exists — human Prepare from Version Revisions is valid; do not trust a pre-existing tiny `.sh` as TAKE emission proof.

## Related

- **priority-shell-compile**, **priority-shell-install**
- **priority-form-engineering**

## Shell DBI new tables

Author `NN.sh` with `DBI CREATE TABLE ... UNIQUE(...);` (see `DICTIONARY_SQL.md` / CE upgrades `8311.sh`). Re-Prepare after content change.
