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

| Mode | HTTP Basic | Notes |
|------|------------|-------|
| User/password | `username:password` | Works when licensed; some cloud SOAP/WCF paths return 403 |
| REST Interface Access Token (PAT) | `username=<token>`, `password=PAT` (literal) | Prefer for cloud REST when WCF SOAP is blocked |

Never log tokens or passwords. CredMan / local password files outside git only.

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

## Investigation checklist (read-only)

1. Confirm allowlist `webBaseUrl` / `tabulaini` / `company` (DNAME).
2. Auth: PAT or CredMan user — never invent.
3. `$metadata` + service root.
4. `FORMLIMITED` RESTFLAG for target ENAMEs.
5. Business GETs with `$filter` + `$top`.
6. Dictionary: `EFORM`/`EPROG` expand for code archaeology.
