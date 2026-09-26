# Build-and-test plan — Priority v2 shell compile + install (spec 0.1)

**FR:** [feature-request-shell-compile-install-v2-spec-0.1.md](./feature-request-shell-compile-install-v2-spec-0.1.md)  
**GitHub:** [issue #6](https://github.com/SimonBarnett/agentic_fomprep/issues/6)  
**Repo:** SimonBarnett/agentic_fomprep  
**Scope:** v2 only — do not change repo-root `src\Prepare-NamedForm.ps1`

## Goal

Ship two sibling skills on the existing v2 platform (catalog grab-only + allowlisted local execute):

| Catalog | Tool | Runner |
|---------|------|--------|
| `v2/apps/mcp-catalog/catalog/priority-shell-compile/` | `compile_shell` | `Compile-Shell.ps1` |
| `v2/apps/mcp-catalog/catalog/priority-shell-install/` | `install_shell` | `Install-Shell.ps1` |

Slogan: **red before WCF** — refuse paths, incomplete pins, missing cred, and live instances before any WCF attempt.

## Phases

### P0 — Platform (already on v2)

- Catalog folders: `meta.json`, `SKILL.md`, `result-schema.json`, `instance-schema.json`, `runner/` tree
- Grok plugins: `v2/plugins/priority-shell-compile/`, `v2/plugins/priority-shell-install/` with local MCP (`compile_shell` / `install_shell` separate from `prepare_form`)
- Shared kernel: `v2/lib/` (allowlist, cred, sql, parse-sh, gate, pin, wcf, result)
- Sync copies: `v2/tools/Sync-ShellRunnerLibs.ps1` after editing `v2/lib` or plugin scripts

### P1 — WP0 offline gates (CI / any Windows box)

Run in order:

1. `powershell -NoProfile -ExecutionPolicy Bypass -File v2\tools\Test-WP0.ps1`  
   - WP0-T1..T13: catalog, schemas, pins, parser fixtures, refuse paths, WhatIf, SQL gate unit, truncated shell, no auto-prep  
   - Writes evidence: `v2/tests/wp0-last.json`  
   - WP0-R-SKIP when `PRIORITY_WP0_INSTANCE` is unset (expected on sandboxes)
2. `powershell -NoProfile -ExecutionPolicy Bypass -File tools\Test-Pack.ps1` (includes WP0 first among v2 checks)

**Pass:** exit 0; no `wcfAttempted=true` on refuse/WhatIf gates; v1 `src\Prepare-NamedForm.ps1` has no git diff.

### P2 — Pins and dictionary recon (human / proof host)

- Set `PRIORITY_WP0_INSTANCE` to an allowlist id (e.g. `ce-priority-dev` per `docs/wp0-recon.md`)
- Fill `v2/config/pin.json` + `pin.psd1` from dictionary titles only — no guessed ENAMEs
- `WcfFileStepWorks` stays `null` until a WCF walk transcript proves file-step vs WINRUN; `DbiMarker` stays empty until observed on a real `.sh`
- Re-run `Test-WP0` for WP0-R1..R7 (allowlist, CredMan, `T$EXEC`, pinned ENAMEs, upgrades dir, web host, walk contradiction)

### P3 — Live slice (proof instance only)

On a host with allowlist row, Windows CredMan, MSSQL integrated auth (no SQL passwords in git), upgrades dir, and reachable WCF:

1. Dummy revision **compile** (`compile_shell` / `Compile-Shell.ps1`) → `NN.sh` under build-set root  
2. **Install** that shell (`install_shell`) with SQL gate (install log advanced; `TAKESINGLEENT` → `T$EXEC`)  
3. **Truncated** `.sh` → `parse_failed`, no WCF  
4. Caller runs `prepare_form` for names in `postInstall.formsUnprepared[]` (install must not auto-prep)

Capture walk transcript under proof `agentWork` as `last-wcf-walk.json` when pinning `WcfFileStepWorks`.

### P4 — MRB / UAT boundary

- Bob chairs MRB on [issue #6](https://github.com/SimonBarnett/agentic_fomprep/issues/6)
- Do **not** mark ready for human UAT until Bob re-stamps after P3 green on proof instance
- Off-instance PASS is **not** a claim of live compile/install success

## Non-goals

- Combined compile+install tool
- WINRUN executor when `WcfFileStepWorks=false`
- WCF/SQL on Amplify catalog host (`mcp-priority.ntsa.uk` is grab-only)
- Secrets in git (`password=`, `XAI_API_KEY=`, SQL passwords)

## Success (this FR)

| Criterion | Evidence |
|-----------|----------|
| Two catalog skills + two MCP tools | `Test-WP0` T1–T2; marketplace.json plugins |
| Refuse + WhatIf before WCF | `Test-WP0` T5, T5b, T8, T13 |
| Install SQL gate + handoff | `Test-WP0` T11–T12; install result schema |
| Pins from recon | `v2/config/pin.json`, `docs/wp0-recon.md` |
| v1 frozen | `Test-WP0` T9 |
| Live §15 ATs | WP0-R* on proof host only — [issue #56](https://github.com/SimonBarnett/agentic_fomprep/issues/56) (not required for off-instance merge) |

## Done offline (2026-09-26 / FR #6 seat)

- `Test-WP0` T1–T13 **PASS**; `WP0-R-SKIP` when `PRIORITY_WP0_INSTANCE` unset (expected)
- Catalog + plugins `priority-shell-compile` / `priority-shell-install` present
- Live proof + `WcfFileStepWorks` / `DbiMarker` evidence → **#56**
