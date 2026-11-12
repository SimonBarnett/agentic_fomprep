# Vision: Priority Agent client polish

Feature request on SimonBarnett/agentic_fomprep. Gap check: origin/main 1452ecc
(PR #380). Open issues at planning time: 0. This pack does not create a repo.

## Objective

A Priority Agent session can add, edit, and prepare tables, forms, reports,
procedures, and interfaces through one allowlisted client, and the next launch
offers the Medatech USERLOGIN that client identified as the default.

LOCKED

## Success

| id | metric | target | how measured | fail-when |
|----|--------|--------|--------------|-----------|
| S1 | Client identifies the Priority USERLOGIN and the next launcher run offers it as the default | Enter on Priority USERLOGIN [saved] accepts the saved login; --hours-user still overrides; the OS username is never written | launcher.Tests fixture: fake whoami writes %USERPROFILE%\.priority-agent\last-user.json (login and instance id only); a second PriorityAgent --dry-run stdout contains that login as the suggested default | the prompt is blank when a last-user file exists, or the file contains a token or the OS user |
| S2 | One client surface covers the five object kinds | priority-wcf.mjs help lists table, form, report, procedure, and interface verbs, and npm test in v2/apps/priority-saas-wcf exits 0 | npm test plus a help-text fixture that requires those five names | a kind is only documented in a skill and has no verb |
| S3 | Repeated reads do not log in once per verb | a 3-read batch fixture calls login once | v2/apps/priority-saas-wcf/tests/batch-session.test.mjs counts login on a fake SDK | each read calls login |
| S4 | Procedure input does not take the first option by itself | a two-option step with nothing selected returns needs_input and does not call inputOptions | v2/apps/priority-saas-wcf/tests/prepare-proc.test.mjs | the walker selects Options[0] |
| S5 | Prep still fails closed | preparedClaim stays false when the OData gate is unavailable | v2/apps/priority-saas-wcf/tests/prepare-proc.test.mjs gate test stays green | walk success is reported as prepared |

## Shape

Primary: **app**

The product remains the Priority Agent desktop app plus its local Web SDK
client. Catalog MCP and skills are delivery. This request does not change
that shape.

LOCKED

## Stack

Default: the existing Node client (priority-web-sdk plus the OData gate) and
the C# launcher. New verbs stay in v2/apps/priority-saas-wcf. The launcher
gains the saved-user prompt and session metadata.

Why: FR #348 already made priority-wcf.mjs the agent path.

Why-not: a second client in Python or airc. Raw OData and SQL stay inside
this client, behind the allowlist. No new host, no invented procedure ENAME,
no secrets in git.

LOCKED

## Architecture

```
PriorityAgent.exe
  prompt: USERLOGIN [saved] | --hours-user
  last-user.json   (login + instance id, no token)
  session rules -> node priority-wcf.mjs
                      |
                      +-- Web SDK login (Bearer tokenFile)
                      +-- form / prepare / proc / table / interface
                      +-- OData read (prep gate, dictionary, whoami fallback)
                      +-- whoami USERLOGIN -> last-user.json
```

Trust boundary: allowlist file plus C:\passwords token files. last-user.json
lives under the user profile, never in the repo. Live writes still require
allowLive: true. preparedClaim still requires the OData gate.

LOCKED

## Screens

Console wireframes. No PNG.

| id | file | state |
|----|------|-------|
| M1 | docs/mocks/home.html | prompt shows the saved Medatech USERLOGIN; Enter accepts it |
| M2 | docs/mocks/empty.html | no saved user; prompt has no bracket default; non-interactive exits 2 |
| M3 | docs/mocks/error.html | typed login differs from the login the client identified; launch stops |

## LOCKED

- Shape stays app. Repo stays SimonBarnett/agentic_fomprep.
- USERLOGIN persistence is the user-profile last-user file. It stores the
  login the client identified, the instance id, and the company. It does not
  store tokens. The OS user is never a default.
- Five object kinds (table, form, report, procedure, interface) are verbs on
  priority-wcf.mjs, not skills the agent runs by hand.
- allowLive remains the write gate. Prep success remains UPD=N and
  LASTPREPDATE moved, via the OData gate. A walk without a gate does not
  set preparedClaim.
- Interface prepare refuses to call SaaS until config/interface-prep.json
  contains a proc name that was recorded from an allowlisted read.

## UNKNOWN

- The Priority procedure ENAME that prepares an interface. FR-29 refuses
  until that name is already a constant in the repo.
- Whether priority.login returns USERLOGIN, or whoami must read one USERS
  row. FR-01 tries the login result first, then one filtered USERS read.
  If both fail, the reason is user_unidentified.

## Filed issues

Pack ids below are local to this polish set. They do not replace docs/fr/FR-001 through FR-010 (the intake pack).

| pack | issue | title |
|------|-------|-------|
| FR | #383 | FR-001: whoami returns the Priority USERLOGIN |
| FR | #384 | FR-002: save the identified USERLOGIN for the next run |
| FR | #385 | FR-003: launcher suggests the saved USERLOGIN |
| FR | #386 | FR-004: non-interactive launch uses the saved USERLOGIN |
| FR | #387 | FR-005: stop when the flag disagrees with whoami |
| FR | #388 | FR-006: session metadata records where the login came from |
| FR | #389 | FR-007: JSON request file for verb arguments |
| FR | #390 | FR-008: per-verb help text |
| FR | #391 | FR-009: dry-run resolves the instance and does not log in |
| FR | #392 | FR-010: machine-readable retry hint on login failures |
| FR | #393 | FR-011: stable process exit codes |
| FR | #394 | FR-012: list companies for this login |
| FR | #395 | FR-013: form columns without reading rows |
| FR | #396 | FR-014: form rows accepts a filter |
| FR | #397 | FR-015: insert one form row |
| FR | #398 | FR-016: delete one positioned row only with confirm |
| FR | #399 | FR-017: run one named form activation |
| FR | #400 | FR-018: write one subform row |
| FR | #401 | FR-019: do not auto-confirm error dialogs |
| FR | #402 | FR-020: cap the fields file at 1 MiB and reject a BOM |
| FR | #403 | FR-021: procedure inputs come from a file |
| FR | #404 | FR-022: ambiguous procedure options return needs_input |
| FR | #405 | FR-023: proc continue resumes with an explicit option |
| FR | #406 | FR-024: proc and prepare results include report URLs |
| FR | #407 | FR-025: report run is proc start with type R |
| FR | #408 | FR-026: a report with no output is empty, not a failure |
| FR | #409 | FR-027: read procedure body |
| FR | #410 | FR-028: write procedure body through the form |
| FR | #411 | FR-029: prepare interface refuses until the proc name is pinned |
| FR | #412 | FR-030: read dictionary columns for one table |
| FR | #413 | FR-031: table exists is a read |
| FR | #414 | FR-032: dictionary titles longer than 20 characters are refused |
| FR | #415 | FR-033: add one column or refuse on SaaS without SQL |
| FR | #416 | FR-034: create table refuses without a SQL profile |
| FR | #417 | FR-035: list interface names |
| FR | #418 | FR-036: run one interface with an inputs file |
| FR | #419 | FR-037: update one interface mapping row |
| FR | #420 | FR-038: refuse an expired access token before login |
| FR | #421 | FR-039: refresh an expired access token once |
| FR | #422 | FR-040: retry login_connect once |
| FR | #423 | FR-041: cache the tenant probe for one hour |
| FR | #424 | FR-042: batch up to 8 reads on one login |
| FR | #425 | FR-043: form rows stops at a limit |
| FR | #426 | FR-044: login errors do not echo bearer tokens |
| FR | #427 | FR-045: launcher rules show whoami and the saved-user prompt |
| FR | #428 | FR-046: catalog skill lists the same verbs as the client help |
| FR | #429 | FR-047: VISION.md records the last-user file and keeps the prep gate |
