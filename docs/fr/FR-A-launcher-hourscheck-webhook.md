# FR-A --- Launcher HoursCheck -> bob.ntsa.uk webhook

## Goal

PriorityAgent exit and `--check-hours` pass only when GET `https://bob.ntsa.uk/bob/v1/hours` shows **one closed** entry for this session.

## Deliverables

- Rewrite `HoursCheck` in `launcher/Program.cs` to call bob.ntsa.uk hours GET (not `git fetch origin/hours`).
- Session correlation via `idempotency_key` (recommended `priority-agent-<session-uuid>`); GET with `user=` + day range + `status=closed`, then match key.
- Env/fixture override for tests (mirror airc `PRIORITY_AGENT_AIRC_REPORT_JSON` pattern).
- Update relaunch / brief prompts: close webhook entry, not push hours branch.
- Document USERLOGIN source for `?user=` (env or explicit flag; no secrets in logs).

## Testable

- Fixture with one closed matching entry -> pass.
- Missing / open-only / wrong key -> fail.
- Gate path does not fetch `origin/hours`.
