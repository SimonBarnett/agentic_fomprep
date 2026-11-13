# FR-046: catalog skill lists the same verbs as the client help

**Repo:** SimonBarnett/priority-mcp
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

The skill page matches help output.

## Deliverables

- Update v2/apps/mcp-catalog/catalog/priority-saas-wcf/SKILL.md so it names whoami, prepare interface, table, and interface.
- Sync the .grok/skills mirror.
- Add a Test-PriorityCatalog.ps1 gate for those needles.
- Highest Add-Gate id on origin/main at park time is CAT-T74. Allocate the next free id when implementing (CAT-T75 only if T74 is still the max). Do not reuse an id.

## Testable

- The new gate fails when whoami is removed from that SKILL.md.
- Add-Gate ids in the file stay unique.

## Out of scope

- Do not add execute tools to the catalog MCP.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #428
