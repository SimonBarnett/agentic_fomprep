---
name: priority-mcp-setup
description: >
  Connect an MCP client to Priority Cloud MCP Server. Use when the user says Priority MCP,
  MCP setup, PATOKENS, oauth-authorization-server, /mcp/erp/, or /priority-mcp-setup.
---

# Priority MCP setup

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Grab from catalog MCP `https://mcp-priority.ntsa.uk/mcp` (`get_skill` with `name=priority-mcp-setup`).
Official docs: https://prioritysoftware.github.io/mcp/setup/

This skill configures a **client** to talk to Priority Software's cloud MCP. It does **not** replace local OData (`priority-odata-dev`) or Form Prep.

## When

First-time MCP connect, auth failures (`401 Missing authentication`), picking host/tenant, or deciding cloud vs on-prem.

## Prerequisites

| Requirement | Notes |
|-------------|--------|
| Priority Cloud | v26.0+ |
| Modules | API module + transaction buckets |
| User | API licence |
| Auth | PAT (Basic) or OAuth2 |

**On-prem / IIS** (example `priority.medatecherp.co.uk`) has **no** MCP endpoint (404). Do not invent one.

## Endpoint

```
https://<host>/mcp/erp/<tenant_name>
```

Tenant = last segment of the Priority web UI path (`/webui/<tenant>/`). Example: `https://p.priority-connect.online/webui/bt23u/` → tenant `bt23u`.

| Environment | URL pattern | OAuth2 client id (public) |
|-------------|-------------|---------------------------|
| Production EU/ME | `https://p.priority-connect.online/mcp/erp/<tenant>` | `7a99d127-66f7-49a8-9d35-44a9ecc194b4` |
| Production US | `https://us.priority-connect.online/mcp/erp/<tenant>` | `73614aa6-3888-4f81-b76d-9fc90f2199c8` |
| Testing EU/ME | `https://t.eu.priority-connect.online/mcp/erp/<tenant>` | `3d7498cd-bc97-44fb-8067-1bb34d109cdd` |
| Testing US | `https://t.us.priority-connect.online/mcp/erp/<tenant>` | `95703909-7aea-410e-a97e-f598b9e17b51` |

OAuth discovery: `https://<host>/mcp/erp/.well-known/oauth-authorization-server`

## Authentication

### PAT (Personal Access Token)

1. In Priority, open **PATOKENS**, create a token, copy once.
2. Credential string: `<PAT_TOKEN>:PAT` (password literal is `PAT`).
3. Header: `Authorization: Basic <base64(credential)>`.

PowerShell encode example (replace the sample token):

```powershell
[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("<PAT_TOKEN>:PAT"))
```

Never commit PATs, Base64 of real PATs, or tenant passwords. Put tokens only in the MCP client secret store / local config outside git.

### OAuth2

Clients with browser OAuth (e.g. Claude) use the public client id for the environment plus `authServerMetadataUrl` above. No PAT needed.

## Worked example (Claude Code PAT)

```json
{
  "mcpServers": {
    "priority-mcp": {
      "type": "streamableHttp",
      "url": "https://p.priority-connect.online/mcp/erp/bt23u",
      "headers": {
        "Authorization": "Basic <ENCODED_PAT_NOT_IN_GIT>"
      }
    }
  }
}
```

Timeout: 60s recommended. Transport: streamable HTTP.

## Gotchas

- Every read/write consumes **API transactions**.
- Unauthenticated → `401 Missing authentication`.
- Cloud-only; on-prem 404 is expected.
- Prefer a test company or testing host before production writes.

## Success

Client lists Priority MCP tools without 401/404. Tenant and host match the user's environment.

## Do not

- Commit secrets, PATs, or live Authorization headers
- Point MCP at on-prem IIS and treat 404 as a product bug
- Invent hosts or tenants

## Related

- Discovery tools: `priority-mcp-discovery`
- Forms / procedures / search / help: sibling `priority-mcp-*` skills
