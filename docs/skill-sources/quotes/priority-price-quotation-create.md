# Priority price quotation (PQ) - create via OData (CPROF)

Harvest date: 2026-10-25
From: Simon Barnett working session (development estimate turned into a PQ via OData; anonymised below)
Catalog: `v2/apps/mcp-catalog/catalog/priority-price-quotation-create`

**When:** A development / consultancy estimate (hours by step) has to become a
Priority **Price Quotation** (form `CPROF`, document numbers `PQyyNNNNN`) for a
customer, entered through OData rather than the screen.

Priority-generic. The instance row below is the Medatech allowlist row Simon
set; any other instance is config. Customer numbers, project codes and requests
in this file are anonymised examples.

## 0. Instance / auth (config - never hardcode the secret)

| Item | Value |
|------|-------|
| OData base (Medatech live) | `https://priority.medatecherp.co.uk/odata/Priority/tabula.ini/live/` |
| User | `SimonB` |
| Password | env `PRIORITY_ODATA_PASSWORD` - read from the environment only; never print, log, echo, or commit it |
| Headers | `Accept: application/json`, `Content-Type: application/json` |

**Gate (CAST IRON):** live writes only after Simon approves the draft.
Order is always: build draft -> show the draft (header, every line with qty /
internal qty / prep time, every line remark, the quote-level Note) -> explicit
approval -> write -> read back. Reads (GETs) are fine without approval.

## 1. Entities and fields (confirmed on the Medatech instance)

| Entity | Path | Notes |
|--------|------|-------|
| Price quotation header | `CPROF` (key `CPROFNUM`) | `CPROF('PQ26xxxxx')` |
| Quote lines | `CPROF('<q>')/CPROFITEMS_SUBFORM` (key `KLINE`) | `LINE` = displayed line no. (read-only in effect) |
| Line remarks ("Quoted Item - Remarks") | `.../CPROFITEMS_SUBFORM(<KLINE>)/CPROFITEMSTEXT_SUBFORM` | single text entity: `TEXT` (HTML), `APPEND`, `SIGNATURE` |
| Quote remarks ("Price Quotations - Remarks") | `CPROF('<q>')/CPROFTEXT_SUBFORM` | same shape |

Header fields used (max lengths from `$metadata`):

| Field | Label | Max | Rule |
|-------|-------|-----|------|
| `CUSTNAME` | Customer Number | 16 | the customer |
| `NAME` | Contact | 37 | customer contact |
| `DOCNO` | Project Number | 16 | customer project, if one exists |
| `PDATE` | Date | - | today |
| `EXPIRYDATE` | Expiry | - | **PDATE + 30 days** |
| `DETAILS` | Details | **24** | short title of the work |
| `REFERENCE` | Cust's Request No. | **12** | customer's request / ticket no, trimmed to 12 (drop punctuation, e.g. `ABCD00000008`) |
| `TYPECODE` | Type of Sale | 3 | copy from recent PQs |
| `AGENTCODE` | Sales Rep | 16 | copy from recent PQs |
| `BRANCHNAME` | Branch Code | 6 | copy from recent PQs |
| `TAXCODE` | Tax Code | 8 | copy from recent PQs |
| `PAYCODE` | Payment Terms Code | 4 | copy from recent PQs |

Do **not** send `PLNAME` (price list) or any price fields - leave defaults.

Line fields used:

| Field | Label | Rule |
|-------|-------|------|
| `PARTNAME` | Part Number | `CONS-HR-MED` (consultancy hours; unit `Hrs` comes from the part) |
| `PDES` | Part Description | **max 59**; `Step N: <short step name>` |
| `TQUANT` | Qty (quoted) | **2 x internal estimate** |
| `ZEMG_INTQUANT` | Internal Quantity | internal estimate hours for that step |
| `ZEMG_QUOTEQUANT` | Prep Quote Time | quote-prep time spread across the lines (e.g. 0.25 h each) |
| `PRICE` | Unit Price | **never sent** |

Read-back-only line fields: `LINE`, `KLINE`, `TUNITNAME`, `PRICE`, `PERCENT`,
`QPRICE` (extended). Header totals: `QPRICE` (net), `DISPRICE` (net after
discount), `VAT`, `TOTPRICE` (gross), `CODE` (currency), `STATDES` (new = `Draft`).

## 2. Copy the header from recent PQs

GET the last few PQs (any customer, most recent first) and copy the house
values rather than guessing:

```
GET CPROF?$orderby=CPROFNUM desc&$top=5&$select=CPROFNUM,CUSTNAME,PDATE,EXPIRYDATE,DETAILS,REFERENCE,TYPECODE,AGENTCODE,BRANCHNAME,TAXCODE,PAYCODE,STATDES
GET CPROF('<recent PQ>')?$expand=CPROFTEXT_SUBFORM,CPROFITEMS_SUBFORM($expand=CPROFITEMSTEXT_SUBFORM)
```

Prefer a recent PQ for the same customer if one exists. Values seen on recent
Medatech PQs (Oct 2026, verify each time): `TYPECODE=REQ`, `AGENTCODE=014`,
`BRANCHNAME=003`, `TAXCODE=510`, `PAYCODE=12`, expiry = PDATE + 30 days.
Keep the recent PQ's `CPROFTEXT_SUBFORM` HTML - it holds the standard terms you
reuse in step 6.

## 3. Break the quote down BY STEPS

- One `CONS-HR-MED` line (unit `Hrs`) **per step** of the estimate, in step
  order (Step 0 / Step 1 / ... as the estimate numbers them).
- `TQUANT` = 2 x internal hours; `ZEMG_INTQUANT` = internal hours.
- `ZEMG_QUOTEQUANT`: spread the quote-prep time across the lines (equal split
  is fine; e.g. 8 lines x 0.25 h = 2 h prep).
- `PDES` <= 59 chars. Assert it before posting.
- No price. Priority's triggers fill the unit price from the customer's
  special price or the price list. Report the price they set on read-back
  (e.g. a customer special price of 75.00/h where the list price on other
  quotes is 100.00/h) - do not "correct" it.

## 4. Line order gotcha (post in REVERSE)

Priority inserts each new `CPROFITEMS_SUBFORM` row at **LINE 1** and pushes the
rest down. Sending `LINE` in the POST or PATCHing `LINE` afterwards has **no
effect**. Therefore:

- POST the lines in **reverse step order** (last step first, Step 0 last).
- After **each** POST, GET `CPROFITEMS_SUBFORM?$select=KLINE,LINE,PDES` and
  check that the order sorted by `LINE` is the expected tail of the step list.
- If the order is wrong, delete the out-of-order lines (with approval - it is
  a live write) and re-add them in reverse; do not leave a half-ordered quote.

Result: the last-posted line (Step 0) has the highest `KLINE` and `LINE 1`.

## 5. Line remarks (`CPROFITEMSTEXT_SUBFORM`) - per line, just that line

Each line's "Quoted Item - Remarks" describes **only that line**:

- one lead sentence: what the work in this step is;
- `Outcome:` what the customer has at the end of the step;
- `Forms/columns:` which Priority forms and columns it touches; mark new
  custom columns as `[new]` (e.g. `DOCSTATS new column XXXX_LAPSED (Y/N) [new]`);
- optional `Test cases:` on the UAT line.

Do **not** use the Background / Customer Requirement / Pre-condition /
Business Process / Post-condition / Development / Validation / Supporting
document template headings, and do not repeat the same generic background on
every line. The part `CONS-HR-MED` carries default `N/A` template text that
Priority copies onto lines added on screen - always overwrite it.

**Replace, never append.** The text entity has an `APPEND` flag: write the new
text so it replaces the old (PATCH the text entity / `APPEND: false`), then GET
it back and confirm it starts with your content and contains none of the old
text or the `N/A` template. If it stacked, rewrite it before moving on.

HTML shape that renders like screen-entered remarks:

```html
<style> p,div,li {margin:0cm;font-size:10.0pt;font-family:'Verdana';}li > font > p {display: inline-block;}</style>
<p>Add a 'Lapsed' tick box to the contract status list and tick the agreed statuses.</p>
<p><b>Outcome:</b> administrators can flag any status as lapsed; this flag drives the automation.</p>
<p><b>Forms/columns:</b> DOCSTATS new column XXXX_LAPSED (Y/N) [new]; Form Preparation on DOCSTATS.</p>
```

**Apostrophes:** escape `<`, `>`, `&` only (Python `html.escape(s, quote=False)`).
Full escaping turns `'` into `&#x27;`, which Priority stores and shows
literally - write plain apostrophes.

## 6. Quote-level text (`CPROFTEXT_SUBFORM`)

Start from the recent PQ's remarks HTML (standard terms). Replace its old
`Note:` paragraph (e.g. "Note: Estimated delivery will be ...") with:

1. `Note: this quotation is based on the following assumptions:` then one
   paragraph per assumption / exclusion (`- ...`): data the work relies on,
   what is out of scope, dependencies on other developments, how it is billed,
   "no build starts until the open questions are agreed".
2. The standard terms exactly as copied from the recent PQ.

Use the same `<p class="MsoNormal" style="margin-bottom: 0pt;">...</p>`
paragraph markup as the copied terms. Same replace-not-append and apostrophe
rules as step 5.

## 7. Idempotency - check before create or retry

- Before the header POST: `GET CPROF?$filter=CUSTNAME eq '<cust>' and DETAILS eq '<details>'`
  (and/or `REFERENCE eq '<ref>'`). If one exists, resume it - do not create a
  second quote.
- Keep a local state file (`state.json`: `q`, per-line `kline` + `text` done,
  `hdrtext` done) and save after every successful write.
- Before each line POST: GET the lines and match on `PDES`; skip lines that
  already exist (record their `KLINE`).
- On any non-2xx: stop, save state, report. Never leave a half-built quote
  silently - either finish it or report exactly what exists.

## 8. Verification (read back and report)

```
GET CPROF('<q>')?$expand=CPROFTEXT_SUBFORM,CPROFITEMS_SUBFORM($expand=CPROFITEMSTEXT_SUBFORM)
```

Report:

- header: `CPROFNUM`, `STATDES`, `CUSTNAME`, `DETAILS`, `REFERENCE`, `PDATE`,
  `EXPIRYDATE`, `TYPECODE`, `AGENTCODE`, `BRANCHNAME`, `TAXCODE`, `PAYCODE`;
- every line sorted by `LINE`: `LINE`, `PDES`, `TQUANT`, `TUNITNAME`,
  `ZEMG_INTQUANT`, `ZEMG_QUOTEQUANT`, `PRICE` (as set by triggers), `QPRICE`;
- line order = step order; sum `TQUANT` = 2 x sum `ZEMG_INTQUANT`;
- each line remark present, line-specific, no template headings, no `N/A`,
  no `&#x27;`;
- quote text: Note + standard terms, once;
- totals: net `QPRICE` / `DISPRICE`, `VAT`, gross `TOTPRICE`, currency `CODE`.

## Anonymised worked example

Estimate: 3 steps, internal 1.5 h / 4 h / 2.5 h, prep 0.75 h.

Header POST (`CPROF`):

```json
{"CUSTNAME":"CS000999","NAME":"A Contact","DOCNO":"PR260099",
 "PDATE":"2026-10-25T00:00:00+01:00","EXPIRYDATE":"2026-11-24T00:00:00Z",
 "DETAILS":"Auto Service Call Dev","REFERENCE":"ABCD00000008",
 "TYPECODE":"REQ","AGENTCODE":"014","BRANCHNAME":"003","TAXCODE":"510","PAYCODE":"12"}
```

Line POSTs, in this order (reverse):

```json
{"PARTNAME":"CONS-HR-MED","PDES":"Step 2: UAT support and fixes","TQUANT":5,"ZEMG_INTQUANT":2.5,"ZEMG_QUOTEQUANT":0.25}
{"PARTNAME":"CONS-HR-MED","PDES":"Step 1: Status trigger creates service calls","TQUANT":8,"ZEMG_INTQUANT":4,"ZEMG_QUOTEQUANT":0.25}
{"PARTNAME":"CONS-HR-MED","PDES":"Step 0: Clarify requirement and map fields","TQUANT":3,"ZEMG_INTQUANT":1.5,"ZEMG_QUOTEQUANT":0.25}
```

then `POST .../CPROFITEMS_SUBFORM(<KLINE>)/CPROFITEMSTEXT_SUBFORM` `{"TEXT":"<html>"}`
for each new line. Read-back: LINE 1 = Step 0, unit `Hrs`, `PRICE` filled by
triggers (e.g. 75.00), `QPRICE` = qty x price, header `QPRICE` 1200.00,
`VAT` 240.00, `TOTPRICE` 1440.00 at 20% VAT.

## Reference script (draft-first; writes only with `--write`)

```python
import os, sys, json, html, requests
B = os.environ.get('PRIORITY_ODATA_BASE', 'https://priority.medatecherp.co.uk/odata/Priority/tabula.ini/live/')
S = requests.Session()
S.auth = (os.environ.get('PRIORITY_ODATA_USER', 'SimonB'), os.environ['PRIORITY_ODATA_PASSWORD'])  # never print
S.headers.update({'Accept': 'application/json', 'Content-Type': 'application/json'})
E = lambda s: html.escape(s, quote=False)          # keeps plain apostrophes
STYLE = "<style> p,div,li {margin:0cm;font-size:10.0pt;font-family:'Verdana';}li > font > p {display: inline-block;}</style>"
def remark(lead, outcome, forms, tests=None):
    p = [STYLE, f'<p>{E(lead)}</p>', f'<p><b>Outcome:</b> {E(outcome)}</p>', f'<p><b>Forms/columns:</b> {E(forms)}</p>']
    if tests: p.append(f'<p><b>Test cases:</b> {E(tests)}</p>')
    return ''.join(p)

P = json.load(open('quote_draft.json'))   # {"header":{...}, "steps":[{"PDES","int","prep","remark"}], "hdrtext":"<html>"}
for s in P['steps']: assert len(s['PDES']) <= 59, s['PDES']
assert len(P['header']['DETAILS']) <= 24 and len(P['header'].get('REFERENCE') or '') <= 12
print(json.dumps(P, indent=1))                    # show the draft
if '--write' not in sys.argv: sys.exit('DRAFT ONLY - get approval, then rerun with --write')

st = json.load(open('state.json')) if os.path.exists('state.json') else {}
save = lambda: json.dump(st, open('state.json', 'w'), indent=1)
def ok(r):
    if r.status_code >= 300: save(); sys.exit(f'{r.status_code} {r.text[:300]}')
    return r
if 'q' not in st:
    h = P['header']
    ex = ok(S.get(B + 'CPROF', params={'$filter': f"CUSTNAME eq '{h['CUSTNAME']}' and DETAILS eq '{h['DETAILS']}'", '$select': 'CPROFNUM'})).json()['value']
    st['q'] = ex[0]['CPROFNUM'] if ex else ok(S.post(B + 'CPROF', json=h)).json()['CPROFNUM']
    st['lines'] = {}; save()
Q = f"{B}CPROF('{st['q']}')"
cur = lambda: ok(S.get(Q + '/CPROFITEMS_SUBFORM', params={'$select': 'KLINE,LINE,PDES'})).json()['value']
for s in reversed(P['steps']):                   # REVERSE: Priority inserts at LINE 1
    have = {x['PDES']: x['KLINE'] for x in cur()}
    if s['PDES'] in have: st['lines'].setdefault(s['PDES'], {})['kline'] = have[s['PDES']]
    else:
        k = ok(S.post(Q + '/CPROFITEMS_SUBFORM', json={'PARTNAME': 'CONS-HR-MED', 'PDES': s['PDES'],
               'TQUANT': 2 * s['int'], 'ZEMG_INTQUANT': s['int'], 'ZEMG_QUOTEQUANT': s['prep']})).json()['KLINE']  # no PRICE
        st['lines'][s['PDES']] = {'kline': k}; save()
    print('order now', [x['PDES'][:7] for x in sorted(cur(), key=lambda x: x['LINE'])])
    L = st['lines'][s['PDES']]
    if not L.get('text'):
        ok(S.post(f"{Q}/CPROFITEMS_SUBFORM({L['kline']})/CPROFITEMSTEXT_SUBFORM", json={'TEXT': s['remark']}))
        L['text'] = True; save()
if not st.get('hdrtext'):
    ok(S.post(Q + '/CPROFTEXT_SUBFORM', json={'TEXT': P['hdrtext']})); st['hdrtext'] = True; save()
# then: read back per section 8 (and confirm remarks were replaced, not appended)
```

## Do not

- Print, log or commit the OData password.
- Write to live without Simon's approval of the shown draft.
- Send `PRICE`, `PLNAME` or a discount; set or "fix" a rate.
- Rely on `LINE` in a POST/PATCH to order lines.
- Use the old template headings in line remarks, or paste the same text on every line.
- Append remarks on top of existing text (or the part's `N/A` template).
- Create a second header or duplicate lines when retrying.
