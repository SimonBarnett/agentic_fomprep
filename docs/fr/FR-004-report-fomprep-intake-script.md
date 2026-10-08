# FR-004: tools/Report-FomprepIntakeIssue.ps1

**Repo:** SimonBarnett/agentic_fomprep  
**Labels:** feature-request

## Goal

Ship a repo-local reporter that POSTs to Bobiverse intake with default `-Repo SimonBarnett/agentic_fomprep`.

## Deliverables

- `tools/Report-FomprepIntakeIssue.ps1` (PS 5.1): params `-Kind`, `-Title`, `-Body`, optional `-Repo` (default `SimonBarnett/agentic_fomprep`), optional `-IntakeUrl` default `https://irc.ntsa.uk/bob/v1/intake`.
- Offline queue under repo or `~/.grok/bob/report-outbox` with idempotency_key; secret scan refuse.
- Optional: if `BOB_INSTALL_ROOT`/`C:\ai\bob\scripts\Report-BobiverseIntakeIssue.ps1` exists, may delegate with forced `-Repo` default — self-contained POST must still work without bob install (skillbook referral).
- ASCII-safe; no secrets in examples.
- Short `.SYNOPSIS` / `.EXAMPLE` in comment-based help.

## Testable

- `-DryRun` (or equivalent) emits JSON whose `repo` is `SimonBarnett/agentic_fomprep` when `-Repo` omitted.
- `-Kind` accepts issue|fr|skill|harvest; rejects empty title/body.
- Running without network writes a queue file rather than throwing uncaught (documented exit/receipt).
- Unit/fixture test or CAT gate asserts default repo string in script source.

## Out of scope

- Session harvest wrapper (FR-005).
- AGENTS text (FR-001).
