---
name: priority-version-revision-discipline
description: >
  Maintain dedicated Version Revision shells, TAKETRIG HOWCREATED=M/AFTERPREP=Y,
  and verify INSTALLEDUPGTRIG after install. Use when shell booked but zero triggers,
  upgrade packs, or /priority-version-revision-discipline.
---

# Version Revision discipline

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-version-revision-discipline`).

Authority: `docs/skill-sources/programming/VERSION_REVISION.md`.

## Hard rules

1. One dedicated shell per workstream; Prepare after meaningful batches; do not mix unrelated upgrades.
2. Re-prepare after content change is normal.
3. TAKETRIG steps: `HOWCREATED=M`, `AFTERPREP=Y`, `OPTFLAG` blank Ã¢â‚¬â€ else silent zero-row install.
4. Verify `INSTALLEDUPGTRIG` / hashes; UI Installed is not enough.
5. Compile/install ENAMEs only from `v2/config/pin.json`.

## Related

- **priority-shell-compile**, **priority-shell-install**
- **priority-form-engineering**

## Shell DBI new tables

Author `NN.sh` with `DBI CREATE TABLE ... UNIQUE(...);` (see `DICTIONARY_SQL.md` / CE upgrades `8311.sh`). Re-Prepare after content change.

