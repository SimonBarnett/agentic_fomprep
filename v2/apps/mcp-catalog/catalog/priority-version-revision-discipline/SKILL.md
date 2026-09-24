---
name: priority-version-revision-discipline
description: >
  Maintain dedicated Version Revision shells, TAKETRIG HOWCREATED=M/AFTERPREP=Y,
  and verify INSTALLEDUPGTRIG after install. Use when shell booked but zero triggers,
  upgrade packs, or /priority-version-revision-discipline.
---

# Version Revision discipline

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-version-revision-discipline`).

Authority: `docs/skill-sources/programming/VERSION_REVISION.md`.

## Hard rules

1. One dedicated shell per workstream; Prepare after meaningful batches; do not mix unrelated upgrades.
2. Re-prepare after content change is normal.
3. TAKETRIG steps: `HOWCREATED=M`, `AFTERPREP=Y`, `OPTFLAG` blank — else silent zero-row install.
4. Verify `INSTALLEDUPGTRIG` / hashes; UI Installed is not enough.
5. Compile/install ENAMEs only from `v2/config/pin.json`.

## Related

- **priority-shell-compile**, **priority-shell-install**
- **priority-form-engineering**
