---
name: priority-mcp-procedures
description: >
  Drive Priority procedures/reports via Cloud MCP procedure_start and procedure_continue.
  Use when the user says procedure_start, procedure_continue, MCP report, or /priority-mcp-procedures.
---

# Priority MCP procedures

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-mcp-procedures`).
Docs: https://prioritysoftware.github.io/mcp/procedures/

## When

Running a Priority procedure or report through MCP as a step machine.

## Flow

1. `entity_search` → name + `procedure_type` (`P` or `R`)
2. `procedure_start` → `session` + first `step_type`
3. `procedure_continue` until `end`

## Tools

### procedure_start

| Param | Required |
|-------|----------|
| `procedure_name` | Yes |
| `procedure_type` | Yes (`P`/`R`) |
| `company_name` | Yes |

### procedure_continue

| Param | Required |
|-------|----------|
| `session` | Yes |
| `company_name` | Yes |
| `procedure_name` | Yes |
| `procedure_type` | Yes |
| `step_type` | Yes (current) |
| `action` | Yes (shape depends on step) |

## Step actions

| step_type | action |
|-----------|--------|
| `input` | `fields[]` with **all** fields (`id`, `operator`, `value`, `type`) |
| `choose` | `selected_option` |
| `warning` | `acknowledged: true` |
| `newsaved` / `askprint` | `selected_format`, `mode`, `pdf` |
| `waitprocess` / `waitexecution` | poll same step until type changes |
| `displayurl` / `download` | read URL from response |
| `end` | stop |

"Current Value" on inputs is the **last run**, not a safe default — adjust for this request. Empty-all fields can process everything; do not do that by accident.

## Worked example

```json
{ "company_name": "test", "procedure_name": "ORDERSBYCUST", "procedure_type": "P" }
```

Then continue with format selection / date inputs per step responses until `end` (report URL).

## Gotchas

- Pass the same `session` every continue
- API transactions per call; polling wait steps still costs
- Cloud-only

## Success

Procedure reaches `end` (or delivers display/download URL) without dropping required input fields.

## Do not

- Start without `procedure_type` from search
- Send partial `fields` on `input` steps
