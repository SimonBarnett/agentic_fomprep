# Feature request: Priority Agent hours → bob.ntsa.uk webhook (full cutover)

**Repo:** SimonBarnett/agentic_fomprep  
**Date:** 2026-11-07  
**Shape:** app (PriorityAgent.exe + skills/docs) — reuse existing  
**Plan folder:** `bob/plan/work/plan-20261107-142159`

## Ultimate objective

Priority Agent sessions record billable hours only via the Bob Fleet hours webhook on **bob.ntsa.uk**; the launcher enforces that store on exit; git `hours` branches are no longer the source of truth.

## Success

| id | metric | target | how measured | fail-when |
|----|--------|--------|--------------|-----------|
| S1 | Launcher exit gate uses webhook | `HoursCheck` / `--check-hours` pass only when GET `https://bob.ntsa.uk/bob/v1/hours` shows **one closed** entry for the session | Fixture env override; smoke `--check-hours` | Still fetches `origin/hours` or requires markdown table lines |
| S2 | Agent rules teach webhook | `agent-rules.md` (rules-version bump) instructs create/close on bob.ntsa.uk; no mandatory hours-branch push | Grep `/bob/v1/hours` + `bob.ntsa.uk`; no mandatory `origin hours` push | Rules still mandate git hours branch |
| S3 | README matches code | `launcher/README.md` Hours section matches webhook gate | Doc pins | README still documents hours branch as mandatory store |
| S4 | Session correlation | Closed entry tied via stable `idempotency_key` including session id | Fixture + rules document key pattern | Gate cannot find the session entry |
| S5 | Skills hygiene | No skill teaches git hours branch as the store; hours-* stay on bob.ntsa.uk | Grep `.grok/skills` | Skill still says hours live on git branch |
| S6 | Host hygiene | No skill/docs/code teach HTTP `/bob/v1/*` on `irc.ntsa.uk` | Grep `irc.ntsa.uk` + `/bob/v1` | HTTP Bob path still on irc host |
| S7 | Optional evidence | Project `log.md` remains skill CAST IRON; not required for launcher exit | Skills keep log.md; HoursCheck ignores git | Exit blocked solely on missing log.md |

## Gap (origin/main @ 96bfc92)

- `launcher/Program.cs` `HoursCheck` fetches `origin/hours` and requires `dev`+`test` markdown lines with `session:<short>`.
- `launcher/agent-rules.md` rules-version 4 teaches hours-branch worktree + push.
- `launcher/README.md` documents hours-branch enforcement.
- `.grok/skills/harvest-agent-skills/SKILL.md` lesson still says "hours on hours branch".
- hours-* skills already correctly cite `https://bob.ntsa.uk/bob/v1/hours`.
- Intake/report already use bob.ntsa.uk. `AircSupport.cs` "irc.ntsa.uk" strings are IRC Ergo connectivity — keep.

## Architecture

```
PriorityAgent.exe
  rules: POST https://bob.ntsa.uk/bob/v1/hours (open) / close on exit
  HoursCheck: GET https://bob.ntsa.uk/bob/v1/hours?user=…&status=closed
             pass iff one closed entry with session idempotency_key
  relaunch prompt: close hours on webhook (not push hours branch)
Skills: append {project}/log.md for billing narrative (not the hours DB)
```

**Wire SoT:** bobiverse `jeeves/docs/webhooks.md` (FR #3450 / #3673).  
GET requires `user=`; optional `status`. No session query param — match `idempotency_key` client-side (recommended pattern `priority-agent-<session-uuid>`).

**UNKNOWN for implementers:** launcher source of Priority USERLOGIN for `?user=` (env / connections / prompt) — document in FR-A; do not invent instance URLs or secrets.

## Host rule

- HTTP `/bob/v1/*` → **bob.ntsa.uk**
- IRC Ergo → **irc.ntsa.uk** (do not rewrite airc IRC reason strings)

## Small FRs

See `docs/fr/FR-A-*.md` … `FR-F-*.md` and GitHub issues (one issue per FR).

## Out of scope

- Auto-post to Priority
- Deleting historical customer `hours` branches
- Rewriting IRC Ergo host strings
- Changing bobiverse webhook schema (unless S1 blocked)

## GitHub issues (filed)

| FR | Issue |
|----|-------|
| FR-A HoursCheck webhook | #278 |
| FR-B agent-rules rules-version 5 | #279 |
| FR-C README + template legacy | #280 |
| FR-D skills hygiene | #281 |
| FR-E CAT/hostile pins | #282 |
| FR-F docs park (this PR) | #283 |

