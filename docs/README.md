# Docs index

Source-of-truth tracking for MRB and feature requests is moving to [GitHub issues](feature-request-git-mrb-intake-source-of-truth-2026-09-20.md) (see issue #8 when filed). This index lists parked markdown on `main`.

## Feature requests

| Document | Notes |
|----------|--------|
| [feature-request-shell-compile-install-v2-spec-0.1.md](feature-request-shell-compile-install-v2-spec-0.1.md) | v2 shell compile/install FR ([#6](https://github.com/SimonBarnett/agentic_fomprep/issues/6)) |
| [feature-request-priority-skills-catalog-2026-09-19.md](feature-request-priority-skills-catalog-2026-09-19.md) | Priority skills catalog |
| [feature-request-ce-priority-dba-skills-2026-09-19.md](feature-request-ce-priority-dba-skills-2026-09-19.md) | CE Priority DBA skills |
| [feature-request-priority-generic-catalog-rename-2026-09-19.md](feature-request-priority-generic-catalog-rename-2026-09-19.md) | `ce-priority-*` → `priority-*` rename |
| [feature-request-git-mrb-intake-source-of-truth-2026-09-20.md](feature-request-git-mrb-intake-source-of-truth-2026-09-20.md) | Issues as MRB/FR home |

## Build and test plans

| Document | Related FR |
|----------|------------|
| [build-and-test-plan-priority-skills-catalog-2026-09-19.md](build-and-test-plan-priority-skills-catalog-2026-09-19.md) | priority-skills-catalog |
| [build-and-test-plan-ce-priority-dba-skills-2026-09-19.md](build-and-test-plan-ce-priority-dba-skills-2026-09-19.md) | ce-priority-dba-skills |
| [build-and-test-plan-priority-generic-catalog-rename-2026-09-19.md](build-and-test-plan-priority-generic-catalog-rename-2026-09-19.md) | priority-generic-catalog-rename |
| [build-and-test-plan-shell-compile-install-v2-spec-0.1.md](build-and-test-plan-shell-compile-install-v2-spec-0.1.md) | shell-compile-install v2 ([#6](https://github.com/SimonBarnett/agentic_fomprep/issues/6)) |

## MRB reviews

| Document | Reviewed SHA / tip | Verdict | Issue |
|----------|-------------------|---------|-------|
| [mrb-2026-09-19-v1.md](mrb-2026-09-19-v1.md) | WP0 skeleton (pre-`23e7e64`) | PASS-with-nits (historical) | — |
| [mrb-2026-09-19-wcf-walker-eshbel.md](mrb-2026-09-19-wcf-walker-eshbel.md) | `23e7e64` (+ catalog on same line) | PASS-nits (off-instance) | [#9](https://github.com/SimonBarnett/agentic_fomprep/issues/9) |
| [mrb-wcf-walker-23e7e64-eshbel-2026-09-19.md](mrb-wcf-walker-23e7e64-eshbel-2026-09-19.md) | — | Pointer only | [#9](https://github.com/SimonBarnett/agentic_fomprep/issues/9) |

## WP0 / operator

| Document | Purpose |
|----------|---------|
| [wp0-recon.md](wp0-recon.md) | Dictionary pins (no invented ENAMEs) |
| [wp0-walker-slice-2026-09-19.md](wp0-walker-slice-2026-09-19.md) | Walker slice scope |
| [OPERATOR_HOWTO_ESHBEL.md](OPERATOR_HOWTO_ESHBEL.md) | Operator notes |
| [GROK_HANDOFF.md](GROK_HANDOFF.md) | Grok handoff |

Committed WP0 run artefact: `v2/tests/wp0-last.json` (offline; R* skipped when `PRIORITY_WP0_INSTANCE` unset).
