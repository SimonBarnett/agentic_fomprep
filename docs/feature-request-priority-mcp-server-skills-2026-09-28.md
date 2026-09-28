# Feature request: Priority MCP server skills

**Issue:** https://github.com/SimonBarnett/agentic_fomprep/issues/51  
**Date:** 2026-09-28  
**Source PDF:** none

## Summary

Add six catalog skills so agents can connect to Priority Software's official Cloud MCP Server and use its tools correctly. Docs: https://prioritysoftware.github.io/mcp/

## Catalog ids

| Id | Area |
|----|------|
| `priority-mcp-setup` | Prerequisites, endpoint, PAT/OAuth2, cloud-only |
| `priority-mcp-discovery` | `companies`, `entity_search`, `form_columns`, `form_tree` |
| `priority-mcp-forms` | `form_fetch`, `form_update` |
| `priority-mcp-procedures` | `procedure_start`, `procedure_continue` |
| `priority-mcp-search` | `enterprise_search` vs `entity_search` |
| `priority-mcp-help-and-skills` | `help`, `skill_list`, `skill_fetch` |

## Acceptance

| ID | Gate |
|----|------|
| A1 | Each skill has SKILL.md with when-to-use, tool args + worked example, gotchas |
| A2 | Listed in catalog (CAT-T1) |
| A3 | No secrets/PATs/tenant credentials committed |
| A4 | Offline catalog gates CAT-T45–T47 |

## LOCKED

- Cloud-only MCP; on-prem IIS has no endpoint
- Public OAuth client ids from Priority docs may appear in setup skill
- Live `skill_list` enumeration needs a cloud tenant (follow-up)

## UNKNOWN

- Concrete in-product AI skill codes per tenant (needs authenticated `skill_list`)
