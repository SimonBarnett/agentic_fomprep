# Feature request — Priority v2 shell compile + install (spec 0.1)

**Source PDF:** [feature-request-shell-compile-install-v2-spec-0.1.pdf](./feature-request-shell-compile-install-v2-spec-0.1.pdf)  
**Date:** 2026-09-18 · **Scope:** v2 only · **Do not change** repo-root v1 (`src\Prepare-NamedForm.ps1`)  
**Status in repo:** implemented on v2 (`23e7e64`+ walker/SQL gate; `v2/config` pins). MRB home: [GitHub issue #6](https://github.com/SimonBarnett/agentic_fomprep/issues/6). Build plan: [build-and-test-plan-shell-compile-install-v2-spec-0.1.md](./build-and-test-plan-shell-compile-install-v2-spec-0.1.md). Live FR §15 / WP0-R* remain proof-host only (`PRIORITY_WP0_INSTANCE`).

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

## Gaps — remaining (post-implementation)

| Item | Status |
|---|---|
| Catalog + plugins + runners | **Done** — `v2/apps/mcp-catalog/catalog/priority-shell-*`, `v2/plugins/priority-shell-*` |
| `compile_shell` / `install_shell` MCP tools | **Done** — separate plugins; catalog host grab-only |
| `Compile-Shell.ps1` / `Install-Shell.ps1` + `v2/lib` | **Done** — sync via `v2/tools/Sync-ShellRunnerLibs.ps1` |
| Parser, path allowlist, DBI refuse | **Done** — fixtures under plugin `fixtures/`; WP0-T7/T8/T13 |
| Medatech pins + SQL gate + handoff | **Done** — `v2/config/pin.json`; WP0-T11/T12; `docs/wp0-recon.md` |
| `v2/tools/Test-WP0.ps1` | **Done** — offline T*; R* when `PRIORITY_WP0_INSTANCE` set |
| `WcfFileStepWorks` / `DbiMarker` | **Open recon** — intentionally null/empty until walk + real `.sh` (not guessed) |
| FR §15 live compile→install→prep | **Proof host** — WP0-R* + operator ATs; off-instance covered by T* only |

**Bottom line:** Product surface is on v2. Merge-ready off-instance gates are green; Bob MRB on issue #6 tracks proof-instance closure and UAT stamp — not declared in this doc.

---

## Implementation reminder (from the PDF)

- Scope **v2 only**; never patch v1 success gate.
- Do not implement Prepare Upgrade and Install Upgrade as one tool.
- Until `PinComplete`, skeleton only: parser, allowlist, WhatIf, schemas, refuse paths, SKILL.md, WP0 fail-fast — **no guessed procedure names**.