---
name: priority-mcp-search
description: >
  Choose enterprise_search vs entity_search on Priority Cloud MCP.
  Use when the user says enterprise_search, MCP search, document search, or /priority-mcp-search.
---

# Priority MCP search

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-mcp-search`).
Docs: https://prioritysoftware.github.io/mcp/search/ and tools reference.

## When

Finding **menu entities** (forms/procedures) versus **indexed document** full-text.

## entity_search (catalog of forms/procs)

Use to resolve ENAMEs and procedure types. See `priority-mcp-discovery`.

- Fast path: `name_search` (UPPERCASE names)
- Title path: English `title_search` only
- Not a document corpus search

## enterprise_search (indexed documents)

| Param | Required | Notes |
|-------|----------|-------|
| `company_name` | Yes | |
| `query` | Yes | Free text |
| `form_name` | No | Facet filter e.g. `ORDERS` |
| `from_date` / `to_date` | No | **ISO** `YYYY-MM-DD` (unlike form tools) |
| `start` / `rows` | No | Pagination; default rows 10, max 50 |

Only document types configured in Priority "Document Types in Search" are indexed. Broad search first for facets, then filter `form_name`.

## Worked example

```json
{
  "company_name": "test",
  "query": "open order ACME",
  "rows": 20
}
```

Then narrow with `form_name` from facet counts.

## Gotchas

- Wrong tool: using `enterprise_search` to find a procedure name (use `entity_search`)
- Date format mismatch vs forms (`YYYY-MM-DD` here)
- API transaction cost; cloud-only

## Success

Agent picks the right search tool and returns usable hits or entity names.

## Do not

- Assume every form is indexed for enterprise search
- Use form date formats (`DD/MM/YY`) on enterprise_search dates
