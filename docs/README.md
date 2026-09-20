# Docs index

**GitHub issues** are the source of truth for feature requests and hostile MRB verdicts ([FR #8](https://github.com/SimonBarnett/agentic_fomprep/issues/8)). Each parked FR has a `feature-request` issue linking its markdown path. New MRB verdicts are filed as issues with labels `mrb` + `mrb-fail` or `mrb-pass` against the FR (or follow-up push); optional `/docs` copies must link back to that issue. Bob chairs MRB on the FR issue unless a child MRB issue is opened for a specific SHA.

## Feature requests

| Document | GitHub issue | Notes |
|----------|--------------|--------|
| [feature-request-shell-compile-install-v2-spec-0.1.md](feature-request-shell-compile-install-v2-spec-0.1.md) | [#6](https://github.com/SimonBarnett/agentic_fomprep/issues/6) | v2 shell compile/install FR (+ source PDF) |
| [feature-request-priority-skills-catalog-2026-09-19.md](feature-request-priority-skills-catalog-2026-09-19.md) | [#7](https://github.com/SimonBarnett/agentic_fomprep/issues/7) | Priority skills catalog |
| [feature-request-ce-priority-dba-skills-2026-09-19.md](feature-request-ce-priority-dba-skills-2026-09-19.md) | [#5](https://github.com/SimonBarnett/agentic_fomprep/issues/5) | CE Priority DBA skills |
| [feature-request-priority-generic-catalog-rename-2026-09-19.md](feature-request-priority-generic-catalog-rename-2026-09-19.md) | [#4](https://github.com/SimonBarnett/agentic_fomprep/issues/4) | `ce-priority-*` → `priority-*` rename |
| [feature-request-sql-pins-and-composed-sql-gates-2026-09-20.md](feature-request-sql-pins-and-composed-sql-gates-2026-09-20.md) | [#10](https://github.com/SimonBarnett/agentic_fomprep/issues/10) | Pin SQL identifiers; gate composed SQL |
| [feature-request-git-mrb-intake-source-of-truth-2026-09-20.md](feature-request-git-mrb-intake-source-of-truth-2026-09-20.md) | [#8](https://github.com/SimonBarnett/agentic_fomprep/issues/8) | Issues as MRB/FR home (this intake) |

## Build and test plans

| Document | Related FR | GitHub issue |
|----------|------------|--------------|
| [build-and-test-plan-priority-skills-catalog-2026-09-19.md](build-and-test-plan-priority-skills-catalog-2026-09-19.md) | priority-skills-catalog | [#7](https://github.com/SimonBarnett/agentic_fomprep/issues/7) |
| [build-and-test-plan-ce-priority-dba-skills-2026-09-19.md](build-and-test-plan-ce-priority-dba-skills-2026-09-19.md) | ce-priority-dba-skills | [#5](https://github.com/SimonBarnett/agentic_fomprep/issues/5) |
| [build-and-test-plan-priority-generic-catalog-rename-2026-09-19.md](build-and-test-plan-priority-generic-catalog-rename-2026-09-19.md) | priority-generic-catalog-rename | [#4](https://github.com/SimonBarnett/agentic_fomprep/issues/4) |
| [build-and-test-plan-shell-compile-install-v2-spec-0.1.md](build-and-test-plan-shell-compile-install-v2-spec-0.1.md) | shell-compile-install v2 | [#6](https://github.com/SimonBarnett/agentic_fomprep/issues/6) |

## MRB reviews (optional `/docs` archive)

| Document | Reviewed SHA / tip | Verdict (doc) | MRB issue |
|----------|-------------------|---------------|-----------|
| [mrb-2026-09-19-v1.md](mrb-2026-09-19-v1.md) | WP0 skeleton (pre-`23e7e64`) | PASS-with-nits (historical token) | Pre-intake archive; FR [#6](https://github.com/SimonBarnett/agentic_fomprep/issues/6) |
| [mrb-2026-09-19-wcf-walker-eshbel.md](mrb-2026-09-19-wcf-walker-eshbel.md) | `23e7e64` (+ catalog); SQL attempts `c0355d8`, `7db4bcc` | PASS-nits (off-instance); `formlimited_audit` composed gate on [#19](https://github.com/SimonBarnett/agentic_fomprep/issues/19) | [#9](https://github.com/SimonBarnett/agentic_fomprep/issues/9) |
| [mrb-wcf-walker-23e7e64-eshbel-2026-09-19.md](mrb-wcf-walker-23e7e64-eshbel-2026-09-19.md) | — | Pointer only | [#9](https://github.com/SimonBarnett/agentic_fomprep/issues/9) |

## MRB issues without a `/docs` copy (GitHub only)

| Issue | SHA reviewed | Labels |
|-------|--------------|--------|
| [#9](https://github.com/SimonBarnett/agentic_fomprep/issues/9) | `80d8ce4` (docs merge) | `mrb`, `mrb-fail` |
| [#11](https://github.com/SimonBarnett/agentic_fomprep/issues/11) | `7db4bcc` | `mrb`, `mrb-fail` |
| [#20](https://github.com/SimonBarnett/agentic_fomprep/issues/20) | `1285ce7` (PR #16) | `mrb`, `mrb-pass` |

No `docs/mrb-*.pdf` on `main` (MRB PDFs are out of policy).

## WP0 / operator

| Document | Purpose |
|----------|---------|
| [wp0-recon.md](wp0-recon.md) | Dictionary pins (no invented ENAMEs) |
| [wp0-walker-slice-2026-09-19.md](wp0-walker-slice-2026-09-19.md) | Walker slice scope |
| [OPERATOR_HOWTO_ESHBEL.md](OPERATOR_HOWTO_ESHBEL.md) | Operator notes |
| [GROK_HANDOFF.md](GROK_HANDOFF.md) | Grok handoff |

Committed WP0 run artefact: `v2/tests/wp0-last.json` (offline; R* skipped when `PRIORITY_WP0_INSTANCE` unset).
