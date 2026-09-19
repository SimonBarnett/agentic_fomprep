# Grok plugin — priority-odata-dev (execute)

Local MCP tools: `list_instances`, `odata_get`, `odata_query`, `odata_dump_procedure`, `formlimited_audit`, `get_last_result`, `get_skill`.

Allowlist: `%USERPROFILE%\.priority-formprep\instances.json` (see `scripts/instances.example.json`).

Runner: `scripts/Invoke-PriorityOData.ps1`. CredMan / env only — never log passwords.

Catalog MCP at https://mcp-priority.ntsa.uk is grab-only (no OData).

`RESTFLAG=Y` with blank `LIMITFLAG` on `FORMLIMITED` can hide UI sibling tabs. `formlimited_audit` is read-only.
