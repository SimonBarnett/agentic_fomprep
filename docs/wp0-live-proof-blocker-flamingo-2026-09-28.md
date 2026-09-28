# WP0 live §15 proof — blocker (flamingo 2026-09-28)

**FR:** https://github.com/SimonBarnett/agentic_fomprep/issues/56  
**Parent:** #6 (offline WP0-T* shipped; live R* still open)

## Attempt

Seat `flamingo` (`FLAMINGO`) was assigned the live proof. Required proof host per `docs/wp0-recon.md`:

| Need | Observed on flamingo |
|------|----------------------|
| `PRIORITY_WP0_INSTANCE=ce-priority-dev` | Not set (would skip R* until allowlist + CredMan exist) |
| Allowlist + CredMan | `%USERPROFILE%\.priority-formprep\instances.json` **missing** |
| Dictionary SQL `10.220.0.5\DEV` | TCP 1433 from flamingo: **failed** |
| Web `prioritydev.clarksonevans.co.uk` | TCP 443: reachable (not sufficient alone) |
| `AllowedComputer` CE-PRIORITY-DEV1 | This host is **FLAMINGO**, not DEV1 |
| Digest `ce-priority-dev1` | `online=false` at attempt time |

## Offline gates (this seat)

`powershell -File v2/tools/Test-WP0.ps1` **without** `PRIORITY_WP0_INSTANCE`:

- All WP0-T* / PARSE / refuse gates: **PASS**
- `WP0-R-SKIP` — R1..R7 skipped (expected)
- `WcfFileStepWorks` remains `null` in `v2/config/pin.json` (do **not** invent)
- `DbiMarker` remains empty (do **not** invent)

## Required next step (not this seat)

On **CE-PRIORITY-DEV1** (or another AllowedComputer with CredMan + integrated SQL + upgrades dir):

1. Set `PRIORITY_WP0_INSTANCE=ce-priority-dev`
2. Run live compile → install → truncated parse_failed → observe WCF file step / DBI marker from real walks
3. Capture evidence; set `WcfFileStepWorks` / `DbiMarker` only from observation
4. `Test-WP0` WP0-R1..R7 green
5. PR with pin updates + evidence JSON (no guessed ENAMEs; do not patch v1 Prepare-NamedForm)

## Do not

- Merge invented `WcfFileStepWorks` / `DbiMarker` from flamingo
- Stamp ready for human UAT
