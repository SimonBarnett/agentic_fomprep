---
name: priority-uat-wcf
description: >
  Shared WCF / priority-web-sdk walker notes for fast Priority UAT smokes.
  Use when the user says UAT WCF, formStart, getRows, fast UAT, or /priority-uat-wcf.
---

# Priority UAT WCF (shared kernel)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-uat-wcf`).
Catalog leaflet only — execute where WCF is reachable (same pattern as formprep).

## When

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Running **fast standard** UAT smokes (`priority-project-create-smoke`, `priority-day-works-uat`, `priority-ht-delete-smoke`) without headed video.

## Pattern (mirror formprep)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

1. CredMan for password — never log or commit secrets.
2. Pin company **DNAME** from instance config (not UI title).
3. Login → `formStart` / `procStart` → filter → set fields → action.
4. Dump JSON of steps/errors.
5. Independent gate (SQL / OData / re-read). **Never** trust SDK "completed" alone.
6. Prefer this path over headed Chrome when the same fields/actions can be asserted.

## Do not

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

- Invent procedure ENAMEs (pins / Eshbel-supplied only)
- Edit v1 `src\Prepare-NamedForm.ps1` for UAT
- Require video on this path — video is bob-design-uat `uat-video-pack`
