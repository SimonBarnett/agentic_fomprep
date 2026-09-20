# Feature request — Priority v2 shell compile + install (spec 0.1)

**Intake issue / MRB home:** [GitHub issue #6](https://github.com/SimonBarnett/agentic_fomprep/issues/6)  
**Source PDF:** [feature-request-shell-compile-install-v2-spec-0.1.pdf](./feature-request-shell-compile-install-v2-spec-0.1.pdf)  
**Date:** 2026-09-18 · **Scope:** v2 only · **Do not change** repo-root v1 (`src\Prepare-NamedForm.ps1`)  
**Status in repo:** parked in `/docs` for later — build agent not started.

## What the request asks for

Two new executable skills beside `priority-formprep`:

| Catalog folder | Local tool | Priority entity | Caller supplies |
|---|---|---|---|
| `catalog/priority-shell-compile` | `compile_shell` | Prepare Upgrade [ENAME: WP0] | `instance_id`, `revision` |
| `catalog/priority-shell-install` | `install_shell` | Install Upgrade [ENAME: WP0] | `instance_id`, `shell`, optional `allow_dbi` |

Plus: `Compile-Shell.ps1` / `Install-Shell.ps1`, shared `v2/.../lib` (allowlist, sql, cred, parse-sh), WP0 pins + `Test-WP0.ps1`, SQL/file gates (§6), result JSON aligned with FormPrep v2. Slogan: **red before WCF**.

---

## What v2 already addresses (do not rebuild)

Checked against `main` @ `24f71b7` (`v2/` tree):

| Spec need | Already in v2? | Where |
|---|---|---|
| Catalog MCP grab-only (`mcp-priority.ntsa.uk`); no WCF/SQL on Amplify | **Yes** | `v2/apps/mcp-catalog/` |
| Add skill by dropping `catalog/<name>/` with `meta.json` + `SKILL.md` (no handler edit) | **Yes** | `v2/apps/mcp-catalog/catalog/README.md` |
| Local plugin execute against user allowlist | **Yes** | `v2/plugins/priority-formprep/` |
| Tools: `list_instances`, `prepare_form` (+ `get_last_result`, `get_skill`) | **Yes** (formprep only) | `mcp/server.mjs` |
| Allowlist `%USERPROFILE%\.priority-formprep\instances.json` / `PRIORITY_FORMPREP_INSTANCES` | **Yes** | plugin + SKILL |
| `instance_unknown`, `live_refused`, CredMan / `no_cred`, `windows_only` | **Yes** (formprep path) | SKILL + runner |
| Result JSON on stdout; no passwords in logs | **Yes** (formprep) | `Prepare-NamedForm.ps1` pattern |
| One unit of work per call | **Yes** (one ENAME) | formprep |
| Shared kernel seeds: allowlist-ish, cred, sql helpers | **Partial** | `scripts/lib/sql.ps1`, `Get-WinrunCredential.ps1` |
| Freeze v1 / do not change repo-root `src\Prepare-NamedForm.ps1` | **Yes** | `v2/README.md` explicit |
| Marketplace / plugin packaging | **Yes** | `.grok-plugin/marketplace.json`, plugin folder |

---

## Gaps — not in v2 yet (this feature request)

| Gap | Notes |
|---|---|
| `catalog/priority-shell-compile/` + `catalog/priority-shell-install/` | Missing entirely |
| Tools `compile_shell` / `install_shell` | Not in plugin MCP |
| `Compile-Shell.ps1` / `Install-Shell.ps1` | Missing |
| Shell `.sh` parser, path allowlist, DBI refuse (`allow_dbi`) | Missing |
| WP0 pins for Prepare Upgrade / Install Upgrade ENAMEs + file-step / SQL gate | Missing (`pin.json` / `pin.psd1` for shell) |
| `v2/tools/Test-WP0.ps1` shell fail-fast suite (WP0-T* / WP0-R*) | Missing (only `v2/tools/parse-check.ps1` today) |
| Install SQL gate (revision row / TAKESINGLEENT → T$EXEC) | Missing |
| `postInstall.formsUnprepared[]` handoff to `prepare_form` | Missing |
| Fixtures for sanitized `.sh` parser tests | Missing |

**Bottom line:** v2 already has the **platform** (catalog MCP + allowlisted local execute + formprep skill). This feature request is **new product surface on that platform** — compile/install shell skills — not a redo of formprep or the catalog host.

---

## Implementation reminder (from the PDF)

- Scope **v2 only**; never patch v1 success gate.
- Do not implement Prepare Upgrade and Install Upgrade as one tool.
- Until `PinComplete`, skeleton only: parser, allowlist, WhatIf, schemas, refuse paths, SKILL.md, WP0 fail-fast — **no guessed procedure names**.