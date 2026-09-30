# Priority UAT WCF (shared kernel)

Authoritative body for catalog `priority-uat-wcf`. Priority-generic — hosts and company codes are examples only.

## When

Running **fast standard** UAT smokes without headed video: project create, Day Works path, house-type delete, and any multi-level form walk over `priority-web-sdk`.

## Pattern (mirror formprep)

1. CredMan (or env) for password — never log or commit secrets.
2. Pin company **DNAME** from instance config (not UI title).
3. Login → `formStart` / `procStart` → filter → set fields → action.
4. Dump JSON of steps/errors.
5. Independent gate (SQL / OData / re-read). **Never** trust SDK "completed" alone.
6. Prefer this path over headed Chrome when the same fields/actions can be asserted.
7. Use a **unique** `appname` / `devicename` per run (timestamp suffix) so parallel seats do not collide.

## Direct `formStart` vs `startSubForm`

| Path | Typical result |
|------|----------------|
| `formStart` on stock parent (`PART`, `DOCUMENTS_p`) | Often works |
| `formStart` on child / some stock children (`PROJACTS`, many `ZCLA_*`) | Often *unprepared* (O11) even when `EXECPREPLOCK.UPD=N` and `LASTPREPDATE` advanced after Named Form Prep |
| Parent → `startSubForm(child)` | Preferred open path when direct open fails |

Still run EFORM search smokes for dictionary visibility. Independent SQL remains required for Form Prep success.

Filter shape example:

```js
await form.setSearchFilter({
  or: 0,
  QueryValues: [{ field: 'PARTNAME', fromval: 'C2000111', toval: '', op: '=', sort: 0, isdesc: 0 }],
});
```

## Multi-level Projects walk (generic)

Typical Project Management tree (ENAME examples):

| Level | ENAME | Notes |
|-------|-------|-------|
| Projects | `DOCUMENTS_p` | Parent of Plots |
| List of Projects | `DOC_p` | Soft check: fixture may appear here when `DOCUMENTS_p` retrieve omits it |
| Plots | `PROJACTS` | Prefer `DOCUMENTS_p` → `startSubForm('PROJACTS')` |
| Element / child activities | site-specific child of Plots | Activate a **plot** row before opening children |

### Plot vs element activity keys

On project trees that nest element activities under plots:

- The **Plots** row key is the plot activity (`PROJACT` / plot column such as `ZCLA_PLOT` on customised estates).
- Edit / element-level children hang off the **element** activity key, which is a different `PROJACT` from the plot.
- Resolving fixture SQL as Edit → element → plot → project `DOC`/`DOCNO` avoids activating the wrong Plots row.

### Retrieve window and sticky filters

1. Prefer **unfiltered** `getRows` + in-memory scan for the fixture `DOCNO` / key.
2. Equality `DOCNO` / `DOC` filters often return **empty** and can stick the form on a zero-row set.
3. After an empty filter, call `clearSearchFilter` (when available) and **reload** the row pack before `setActiveRow`. Stale idxs from the empty pack cause `Invalid row`.
4. If the default retrieve sticks on an older key range, try sorted windows (`DOCNO` desc, or `DOCNO >= fixture`) then scan again.
5. Soft-check `DOC_p` (or equivalent list form) when the Projects form omits a DOCNO that SQL still shows.

### Owner missing

Opening a child with `startSubForm` while the parent has **no active row** (or zero rows) returns `Owner missing.` Activate a parent row that actually has children before probing required levels.

### Multi-parent scan fallback

When the preferred project is missing from the retrieve window, scan other retrieved projects: open Plots, probe the required child for `rowCount > 0`, then continue. Record which `DOCNO` / plot was used.

## Soft vs required levels

Product runners decide which children are exit-0 required. Shared practice:

- **Required:** path that proves the business tree (e.g. parent → mid → edit header).
- **Soft:** attachments, history, optional day-works children — record in evidence JSON; do not fail the suite alone when dictionary stubs or empty POST-FORM bodies leave the form inert.

## Evidence

Write step dumps (`login`, open attempts, per-level probe) under a run-specific out dir. Keep passwords out of dumps.

## Do not

- Invent procedure ENAMEs (pins / Eshbel-supplied only).
- Edit v1 `src\Prepare-NamedForm.ps1` for UAT.
- Require video on this path — video is bob-design-uat `uat-video-pack`.
- Treat SDK “Forms have been successfully prepared” as success without SQL gate.
- Hardcode live OData bases or credentials.
