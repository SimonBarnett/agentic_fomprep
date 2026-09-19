# Build-and-test plan: Priority-generic catalog rename (strip ce-priority-*)

**FR:** `docs/feature-request-priority-generic-catalog-rename-2026-09-19.md`  
**Repo:** SimonBarnett/agentic_fomprep  

## Steps

1. Inventory `ce-priority-*` under `v2/apps/mcp-catalog/catalog/` and references in tests/README/orchestrator.
2. `git mv` the three catalog folders to `priority-*` targets in the FR table.
3. Update `SKILL.md` frontmatter `name`, `meta.json` id, and body copy to Priority-generic; CE only as example.
4. Fix `Test-PriorityCatalog.ps1`, marketplace.json, docs/skill-sources/README.md, and cross-skill links.
5. Soft-update DBA FR text that proposed `ce-priority-*` skill ids → `priority-*`.
6. Run offline catalog tests; `rg` gate for catalog path.
7. Commit/push. Bob hostile-MRBs; Eshbel/Jester smoke that skill paths still findable.

## Success

Acceptance criteria in the FR all green on main.
