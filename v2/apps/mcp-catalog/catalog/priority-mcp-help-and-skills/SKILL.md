---
name: priority-mcp-help-and-skills
description: >
  Priority Cloud MCP help text and in-product AI skills (skill_list / skill_fetch).
  Use when the user says MCP help, skill_list, skill_fetch, or /priority-mcp-help-and-skills.
---

# Priority MCP help and AI skills

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-mcp-help-and-skills`).
Docs: https://prioritysoftware.github.io/mcp/skills/

## When

Need authoritative Priority help for an entity/field, or to load **in-product** AI skill definitions from a cloud tenant.

## help

| Param | Required | Notes |
|-------|----------|-------|
| `company_name` | Yes | |
| `name` | Yes | e.g. `ORDERS`, `WWWSHOWORDER` |
| `entity_type` | Yes | `F` form, `P` procedure, `R` report |
| `field_name` | No | Field-level help (forms) |

## skill_list

| Param | Required |
|-------|----------|
| `company_name` | Yes |

Returns `skill_code`, `skill_description`, `from_sync`.

## skill_fetch

| Param | Required |
|-------|----------|
| `company_name` | Yes |
| `skill_code` | Yes | From `skill_list` |

Returns full `skill_content`.

## Workflow: list → pick → fetch → follow

1. `skill_list` for the company
2. Pick a `skill_code` that matches the user task
3. `skill_fetch` that code
4. Follow the returned instructions (still obey cloud/API/secret rules)

## Worked example

```json
{ "company_name": "test" }
```
→ choose a code →
```json
{ "company_name": "test", "skill_code": "<code_from_list>" }
```

## Gotchas

- Live `skill_list` needs an authenticated cloud tenant — cannot enumerate offline in this repo
- Help/skills calls cost API transactions
- Cloud-only

## Success

Agent returns help text or follows a fetched skill without inventing codes.

## Do not

- Invent `skill_code` values
- Commit fetched skill dumps that contain secrets
- Treat catalog `priority-mcp-*` leaflets as substitutes for tenant `skill_list` content

