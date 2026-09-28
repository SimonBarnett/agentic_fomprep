---
name: priority-mcp-forms
description: >
  Read and write Priority forms via Cloud MCP form_fetch / form_update.
  Use when the user says form_fetch, form_update, MCP forms, nested subforms, or /priority-mcp-forms.
---

# Priority MCP forms

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-mcp-forms`).
Docs: https://prioritysoftware.github.io/mcp/forms/

Direct Activations / form Actions are **not** supported on MCP — use the Priority UI for those.

## When

Fetching or creating/updating ERP records through Priority Cloud MCP (not local OData).

## Tools

### form_fetch

| Param | Type | Required |
|-------|------|----------|
| `company_name` | string | Yes |
| `form_tree` | object | Yes |

`form_tree`: `form_name`, optional `filters[]`, `sort[]`, `top`, `skip`, `subforms[]` (recursive).

Filter operators: `eq`, `ne`, `gt`, `lt`, `ge`, `le`, `like`, `in`. `like`: `*` = any sequence, `%` = one char.

Default `top` when omitted = **100** with **no** truncation flag — always set `top` explicitly.

Empty/zero/false fields are **omitted** from responses.

Date filter values use Priority formats (e.g. Date8 `DD/MM/YY`), not ISO.

### form_update

| Param | Type | Required |
|-------|------|----------|
| `company_name` | string | Yes |
| `root_form` | object | Yes |
| `subforms` | array | No |

`root_form`: `form_name`, `record_keys[]`, `field_updates[]` (`name`/`value`).

- **Create:** `record_keys: []`; only fields the user specified (triggers fill many mandatories).
- **Update:** **all** key fields in `record_keys`, including Hidden keys from `form_columns` / prior fetch.

HTML text forms: update `TEXT` with HTML as returned by fetch (`_is_html_form`).

Partial success: parent may save while subforms fail — retry from the failed child using returned parent keys; do not recreate the parent.

## Worked example (fetch)

```json
{
  "company_name": "test",
  "form_tree": {
    "form_name": "ORDERS",
    "filters": [
      { "column_name": "ORDNAME", "operator": "eq", "values": ["SO24001234"] }
    ],
    "top": 1,
    "subforms": [
      { "form_name": "ORDERITEMS", "sort": [{ "column_name": "KLINE" }] }
    ]
  }
}
```

## Worked example (create)

```json
{
  "company_name": "test",
  "root_form": {
    "form_name": "ORDERS",
    "record_keys": [],
    "field_updates": [{ "name": "CUSTNAME", "value": "1291005" }]
  }
}
```

## Gotchas

- Hidden keys (e.g. `ORD` beside `ORDNAME`) are still required on update
- API transaction cost on every call
- Cloud-only

## Success

Fetch returns expected rows; update/create returns success without missing-key errors.

## Do not

- Invent mandatory field values the user did not supply
- Omit Hidden keys on update
- Use MCP for Direct Activation workflows
