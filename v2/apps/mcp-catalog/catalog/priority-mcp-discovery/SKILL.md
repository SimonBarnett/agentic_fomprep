---
name: priority-mcp-discovery
description: >
  Discover companies, entities, form columns, and form trees via Priority Cloud MCP.
  Use when the user says companies tool, entity_search, form_columns, form_tree, or /priority-mcp-discovery.
---

# Priority MCP discovery

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-mcp-discovery`).
Docs: https://prioritysoftware.github.io/mcp/tools/

Requires a working cloud MCP connection (`priority-mcp-setup`). Cloud-only; each call costs API transactions.

## When

Need company **Name** (not Title), form/procedure names, column metadata, or subform hierarchy before fetch/update.

## Tools

### companies

| Param | Type | Required | Notes |
|-------|------|----------|-------|
| `one_only` | boolean | No | Limit to one company |

Returns **Name** (use as `company_name` elsewhere) and **Title**. Call first.

### entity_search

| Param | Type | Required | Notes |
|-------|------|----------|-------|
| `company_name` | string | Yes | From `companies` Name |
| `name_search` | string | One of name/title | Faster; names often UPPERCASE |
| `title_search` | string | One of name/title | English titles only |
| `search_category` | string | No | `forms`, `procedures_and_reports`, or empty |

At least one of `name_search` or `title_search` is required. Procedures/reports include `procedure_type` (`P` / `R`) for `procedure_start`.

### form_columns

| Param | Type | Required | Notes |
|-------|------|----------|-------|
| `root_form_name` | string | Yes | Root form |
| `form_name` | string | No | Descendant; empty = root columns |
| `company_name` | string | Yes | |

Flags when true: Key, Mandatory, Readonly, Hidden, IsStatus. Use **all** Key fields (including Hidden) before `form_update`.

### form_tree

| Param | Type | Required | Notes |
|-------|------|----------|-------|
| `root_form_name` | string | Yes | |
| `company_name` | string | Yes | |

Shows nested subforms for `form_fetch` / `form_update`.

## Worked example

1. `companies` → pick Name `test`
2. `entity_search` `{ "company_name":"test", "name_search":"ORDERS", "search_category":"forms" }`
3. `form_columns` `{ "company_name":"test", "root_form_name":"ORDERS" }`
4. `form_tree` `{ "company_name":"test", "root_form_name":"ORDERS" }`

## Gotchas

- `company_name` = **Name**, never Title
- File/attachment ops not supported yet
- Permissions filter which companies appear

## Success

Agent has company Name, entity names, keys, and subform list before mutating data.

## Do not

- Guess company titles as `company_name`
- Skip Hidden key fields when planning updates
