# FR-B — agent-rules.md webhook hours (rules-version bump)

## Goal

Mandatory hours section teaches webhook create/close on bob.ntsa.uk with session `idempotency_key`; no mandatory hours-branch push.

## Deliverables

- Edit `launcher/agent-rules.md` Hours section to match hours-log-work-session wire.
- Bump `rules-version` from 4 to 5.
- Keep harvest / secrets / airc rules intact.
- Point at `https://bob.ntsa.uk/bob/v1/hours` and project `log.md` evidence (log.md not the hours DB).

## Testable

- Existing rules-version pins updated to `>= 5`.
- Needles: `bob.ntsa.uk/bob/v1/hours` present; mandatory `origin hours` / hours-branch worktree absent.
