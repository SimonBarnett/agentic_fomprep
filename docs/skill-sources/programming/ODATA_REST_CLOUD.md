# Priority OData — cloud REST patterns (generic)

Authoritative companion to catalog skill `priority-odata-dev`.
Harvested 2026-10-15 from Priority cloud tenant work (company DNAME examples only).

## Base URL and company

```text
{webBaseUrl}/odata/Priority/{tabulaini}/{company}
```

- `company` is the Priority **DNAME**, not the UI company title and not a
  generic label like `LIVE`. Wrong DNAME can return HTTP 500.
- Cloud tenants often use `tab{tenant}.ini` (e.g. `tabc9bda.ini`), not
  on-prem `tabula.ini`.

## Auth variants

| Mode | HTTP Basic / Bearer | Notes |
|------|---------------------|-------|
| User/password | `username:password` | Works when licensed; on many SaaS tenants OData stays **401** even when WebUI login works |
| REST Interface Access Token (PAT) | username is the token; password field is the literal word PAT | Prefer for unattended cloud REST when WCF SOAP is blocked |
| OIDC Bearer (WebUI) | `Authorization: Bearer <access_token>` | Interactive SaaS login + MFA — see `SAAS_OIDC_LOGIN.md` / `priority-saas-oidc-login` |

Never log tokens or passwords. CredMan / local password files outside git only.

Discover `_tabulaini=` via `POST /webui/<tenant>` before guessing `tabula.ini` on SaaS.

## FORMLIMITED / RESTFLAG

- Entity appears in `$metadata` / service root **does not** mean GET works.
- When `FORMLIMITED.RESTFLAG` is null, GETs on that form often return **HTTP 400**
  with an empty or opaque body.
- Audit before blaming filters:

```text
FORMLIMITED?$filter=ENAME eq 'DOCUMENTS_D'&$select=ENAME,RESTFLAG,LIMITFLAG,TITLE
```

- Setting `RESTFLAG=Y` can expose the form to OData. See existing hard rule:
  RESTFLAG without LIMITFLAG can hide UI sibling tabs — confirm pattern before
  leaving RESTFLAG on production UI-tested forms.

## Form trigger source text

Do **not** expect usable trigger bodies from `FORMTRIG` alone.

**Working path:**

```text
EFORM?$filter=ENAME eq '<FORM>'&$expand=FTRIG_SUBFORM($expand=FTRIGTEXT_SUBFORM)
```

`FTRIGTEXT_SUBFORM.TEXT` holds the trigger source (`#INCLUDE`, SQL, WRNMSG, …).

Procedures: prefer `EPROG` → `PROG_SUBFORM` → `PROGTEXT_SUBFORM` (existing skill).

## Typed status forms (DOCSTATS family)

Physical table `DOCSTATS` is often **not** a single OData entity set. Cloud
metadata exposes typed forms such as:

- `ZDOCSTATS` — Statuses for Service Contracts (`TYPE='Z'`)
- `DDOCSTATS`, `NDOCSTATS`, `PDOCSTATS`, …

Query the typed form that matches the document family. Custom columns
(e.g. `ZLYN_AUTOSTAT`) appear on that entity when RESTFLAG allows.

## Extended / shadow tables without EFORM

A custom table referenced in triggers (e.g. `ZLYN_USERS`) may have **no**
`EFORM` row and **no** OData entity. Maintenance is often via a parent form
trigger that INSERTs/UPDATEs the extended table from painted columns
(e.g. `USERS.ZLYN_SERVICECONTACT` → `ZLYN_USERS.SERVICE_CONTACT`).

To read such data over OData, expose the **parent** form (`USERS`) or use
dictionary/SQL where licensed — do not invent an entity name.

## Filter hygiene

- Prefer equality on document numbers (`DOCNO eq 'SH…'`).
- Some forms reject empty `$filter` or overly nested `$select` inside `$expand`
  with HTTP 400; fall back to full expand then project client-side.
- Rate limits: HTTP 429 — back off between probes.

## PATCH writes (when explicitly approved)

Read `$metadata` **EntityType Key** before PATCH. Composite keys use:

```text
PATCH {Entity}(Key1='value',Key2='value')
Content-Type: application/json
Prefer: return=representation

{"FieldName":"Y"}
```

Example shape (status form): `ZDOCSTATS(STATDES='Draft',TYPE='Z')`.
Example shape (shipment): `DOCUMENTS_D(DOCNO='SH…',TYPE='D')`.

- Prefer `Prefer: return=representation` and confirm the returned entity.
- Re-GET with `$filter` after write (do not trust cache).
- **Live / customer tenants:** only after an explicit human approval of the exact write.
- `allowLive=false` on the allowlist row still means stop unless the operator overrides for that one approved change.

### Re-firing POST-UPDATE via a field touch

When a form’s `POST-UPDATE` (or `#INCLUDE` BUF) must run again on an
existing row, a small OData PATCH on an updatable string column (e.g.
`DETAILS`) can fire that trigger path. Proven useful to re-run a create
interface after a config fix when INSERT will not happen again.

Hard rules:

1. Read the live `POST-UPDATE` / BUF text first (`EFORM` → `FTRIG` →
   `FTRIGTEXT`). Know every side effect.
2. Prefer a harmless additive change (append a short marker) over clearing
   business fields.
3. Verify outcome with a follow-up GET (child docs, status flags, lines).
4. Do not use this as a substitute for a proper UI/process re-open unless the
   operator approved that exact approach.

## Investigation checklist (read-only)

1. Confirm allowlist `webBaseUrl` / `tabulaini` / `company` (DNAME).
2. Auth: PAT or CredMan user — never invent.
3. `$metadata` + service root.
4. `FORMLIMITED` RESTFLAG for target ENAMEs.
5. Business GETs with `$filter` + `$top`.
6. Dictionary: `EFORM`/`EPROG` expand for code archaeology.

## Write checklist (approved only)

1. Exact entity + key + fields named in the approval.
2. Read before / patch / read after; keep JSON evidence outside secrets stores.
3. If the goal is trigger re-fire, confirm POST-UPDATE text and post-condition GETs.
