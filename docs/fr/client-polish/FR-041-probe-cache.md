# FR-041: cache the tenant probe for one hour

**Repo:** SimonBarnett/agentic_fomprep
**Pack:** docs/feature-request-priority-client-polish-2026-11-12.md
**Labels:** feature-request

## Goal

Later logins in the same hour skip the tenant probe.

## Deliverables

- After a successful probe, store wcf and tabulaini under %USERPROFILE%\.priority-agent\probe-cache.json keyed by instance id, with cachedAt.
- A later login within 60 minutes uses the cache and does not call the probe.
- Older than 60 minutes probes again.
- The cache stores no token.

## Testable

- Two logins in one test: probe count 1.
- cachedAt older than 60 minutes: probe count 2.
- Cache file text has no access_token key.

## Out of scope

- Does not change login URL selection rules.
- Secrets, tokens, and connection files stay out of git, logs, and filings.


GitHub: #423
