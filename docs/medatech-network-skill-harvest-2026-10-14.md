# Medatech network skill book harvest (2026-10-14)

CAST IRON harvest into `SimonBarnett/agentic_fomprep`.

## What landed

1. **Markdown corpus** — `docs/skill-sources/medatech-network/`  
   - Converted from `d:\Priority-Agent\docs` (cleaned Medatech dump)  
   - ~5546 lesson `.md` files (~14 MB text)  
   - 5324 text conversions + 510 stubs for binaries (`.sh`/`.rv`/`.xlsx`/…)  
   - Customer-specific packs excluded

2. **DAG lazy loader** — `tools/priority-skill-dag/`  
   - `build_dag.py` / `Build-SkillDag.ps1`  
   - `resolve_dag.py` / `Resolve-SkillDag.ps1`  
   - `verify_skills.py` / `Verify-SkillsAgainstDocs.ps1`  
   - Index: `docs/skill-sources/medatech-network/_dag/dag.json` (~5615 nodes)

3. **Catalog skills**  
   - `priority-skill-dag` (loader)  
   - `priority-ops-*` topic hubs (install-upgrade, system-admin, financials, integrations, support-desk, customer-guides, sop, packages, procedures, reports, training)  
   - `priority-help-wizards` (WIZ3 English lessons)  
   - `.grok/skills/` mirrors for the above

4. **Verification** — `docs/medatech-skill-verify-2026-10-14.md`  
   - Existing formprep / shell / MCP / hours / UAT skills cross-checked against lessons  
   - Cross-links added on `priority-formprep`, `priority-shell-install`, `priority-mcp-setup`, `priority-post-move-health`

## How agents must load

Do not dump the corpus. Resolve first:

```powershell
powershell -File tools\priority-skill-dag\Resolve-SkillDag.ps1 -Query "<intent>"
```

## Rebuild

```powershell
powershell -File tools\priority-skill-dag\Convert-MedatechDocsToMarkdown.ps1
powershell -File tools\priority-skill-dag\Build-SkillDag.ps1
powershell -File tools\priority-skill-dag\Verify-SkillsAgainstDocs.ps1
```
