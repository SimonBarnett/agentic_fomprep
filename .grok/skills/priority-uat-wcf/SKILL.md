---
name: priority-uat-wcf
description: >
  Shared WCF / priority-web-sdk walker notes for fast Priority UAT smokes:
  formStart vs startSubForm, parent warningConfirm during startSubForm,
  PARTNAME filters, sibling sub-forms, retrieve windows, sticky filters,
  Owner missing. Use when the user says UAT WCF, formStart, getRows,
  Projects hierarchy, startSubForm, or /priority-uat-wcf.
---

# Priority UAT WCF (shared kernel)

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-uat-wcf`).
Catalog leaflet only - execute where WCF is reachable (same pattern as formprep).
Source: `docs/skill-sources/uat/priority-uat-wcf.md` (2026-10-02).

## When

Running **fast standard** UAT smokes (`priority-project-create-smoke`, `priority-day-works-uat`, `priority-ht-delete-smoke`, multi-level Projects walks) without headed video.

## Pattern (mirror formprep)

1. CredMan for password - never log or commit secrets.
2. Pin company **DNAME** from instance config (not UI title).
3. Login -> `formStart` / `procStart` -> filter -> set fields -> action.
4. Dump JSON of steps/errors.
5. Independent gate (SQL / OData / re-read). **Never** trust SDK "completed" alone.
6. Prefer this path over headed Chrome when the same fields/actions can be asserted.
7. Unique `appname` / `devicename` per run.

## Direct `formStart` vs `startSubForm`

| Path | Typical result |
|------|----------------|
| `formStart` on stock parent (`PART`, `DOCUMENTS_p`) | Often works |
| `formStart` on child / some stock children (`PROJACTS`, many `ZCLA_*`) | Often *unprepared* (O11) even after Named Form Prep (`UPD=N`, `LASTPREPDATE` advanced) |
| Parent -> `startSubForm(child)` | Preferred when direct open fails |

For custom / Day Works forms: prefer **parent -> startSubForm**. Still run EFORM search for dictionary visibility. SQL gate required for Form Prep.

Filter shape (prefer **name** fields over numeric ids):

```js
await form.setSearchFilter({
  or: 0,
  QueryValues: [{ field: 'PARTNAME', fromval: 'C2000111', toval: '', op: '=', sort: 0, isdesc: 0 }],
});
```

Numeric id filters (e.g. `PART=554`) often return **Invalid filter**. Blank `getRows` before a filter can return 0 rows even when data exists.

## Warnings during `startSubForm`

Confirm `warning` / `information` / `error` on the **parent** when the child form handle is not assigned yet (`ref?.f || parent`). Confirming only on the child hangs the walk.

## Sibling sub-forms

History / text children under one parent may be **siblings** (both `startSubForm` from PART), not nested. Close or soft-skip one before opening the other. Open hard-path siblings before revise-text locks. WCF `getRows` may return 0 after a successful open - SQL remains data authority.

## Multi-level Projects walk

| Level | ENAME | Open tip |
|-------|-------|----------|
| Projects | `DOCUMENTS_p` | Parent of Plots |
| List of Projects | `DOC_p` | Soft: fixture may show here when Projects retrieve omits it |
| Plots | `PROJACTS` | `DOCUMENTS_p` -> `startSubForm('PROJACTS')` |

**Plot vs element:** Plots row = plot activity; element edits hang off a **different** element `PROJACT`. Resolve Edit -> element -> plot -> `DOC`/`DOCNO` in SQL before activating.

**Retrieve / filters:** Prefer unfiltered `getRows` + scan. Equality `DOCNO`/`DOC` filters often empty and sticky - `clearSearchFilter`, reload pack, then `setActiveRow` (stale idxs -> `Invalid row`). Try `DOCNO` desc / `>=` windows when default sticks on older keys. Scan other projects for a plot with required children when the fixture DOCNO is missing from the window.

**Owner missing:** activate a parent row that has children before `startSubForm`.

## Soft vs required

Product runners mark required vs soft children. Soft levels (attachments, history, optional stubs) go to evidence JSON without failing the suite alone.

## PowerShell 5.1

ASCII-only punctuation in `.ps1` string literals unless UTF-8 BOM (`--`, `->`). Em-dashes break Windows PowerShell 5.1 parsing under the default code page.

## Do not

- Invent procedure ENAMEs (pins / Eshbel-supplied only)
- Edit v1 `src\Prepare-NamedForm.ps1` for UAT
- Require video on this path - video is bob-design-uat `uat-video-pack`
- Treat SDK "Forms have been successfully prepared" as success without SQL gate
