---
name: priority-customer-setup
description: >-
  Use when setting up or migrating Priority customer repos and SC/SO folders to
  consume shared agentic_fomprep Priority Agent rules and Bob work reports
  without copying policy into customers.
---

# Priority customer setup

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

## Canonical source, not per-customer policy copies
The Priority Agent's reusable operating and reporting instructions and
implementation belong in this repository ([agentic_fomprep](https://github.com/SimonBarnett/agentic_fomprep)).
Read the current [agent rules](https://github.com/SimonBarnett/agentic_fomprep/blob/main/launcher/agent-rules.md)
and the supported `launcher/customer-setup` implementation at a recorded approved
ref before changing customer repos. This repository owns user identity,
completed-work / human-equivalent reporting, readable narrative, receipt
validation and booking boundaries. This skill coordinates setup; it is not a
second policy specification.

If canonical behavior needs changing, change it here in a review PR. Do not
copy the rule body or duplicate its validation or producer code into customer
`AGENTS.md`, `project.md`, READMEs, scripts or configuration. Customer repos
retain only customer and work-item facts, necessary shared-client consumption
configuration, and minimal references to the canonical rules. Shared templates
must also avoid generating per-customer policy copies. Resolve conflicting
legacy reporting instructions by replacing them with a canonical reference,
not a fresh embedded policy. Preserve unrelated customer-specific constraints.

Hours reports use human-equivalent time and a readable narrative. They do not
use internal numbering. The session user is the Priority Agent runtime session
context; it is not hard-coded in the customer repo or in this skill.

Distinguish an open shared-rule PR, a source build, a distributed release and
an installed client. Do not claim deployed behavior from a PR or pin an
unmerged branch as production. Verify how the actual Priority Agent loads the
approved shared rule version.

## Identify customer and work
1. Find the exact customer through supported read-only Priority `CUSTOMERS`
   access. `contains` is unsupported; retrieve a bounded list and search
   locally if needed. Record `CUSTNAME`, name and account owner. Resolve
   genuinely ambiguous customers with the user.
2. Resolve each authoritative SC service-call or SO sales-order identifier. A
   work-item folder and its report project configuration must match that exact
   identifier. Never substitute ordinal or WBS folders, GitHub issue numbers,
   customer IDs or booking-project IDs.
3. Respect current cancellations and exclusions. Do not recreate cancelled
   environments, tasks or routines.

## Customer repository and connection setup
4. Read connection data only when necessary and authorized through
   `CUSTOMERS('<cust>')/ZEMG_CUSTCONECT_SUBFORM` and `ZEMG_CUSTCONECTD_SUBFORM`.
   Follow vault and sign-in rules. Any documented authorized local fallback
   parses only that customer's block inside scripts and never prints secrets.
   No credentials or support codes in repos, prompts, reports or logs.
5. Use the established lowercase private customer repo and give it the GitHub
   topic `priority-customer`, with existing intake/harvest labels. Creating a
   new repository needs explicit authorization. Repository code investigation
   and changes belong on a branch and review PR. No main push, merge,
   deployment or install without separate authorization.
6. Maintain required customer artifacts from `launcher/customer-setup`:
   `AGENTS.md` (from `AGENTS.snippet.md`), README, `VISION.md`, secret-free
   `connections.md`, root `company.md`, and per-work-item project
   documentation, with minimal shared-rule and skill-book pointers.
   - Every customer repo has a company knowledge file, `company.md`, linked
     from the README. It covers the customer record and code, account owner,
     contacts and roles, Priority version and hosting, servers, environments,
     companies, URLs, named users (no passwords), the booking project and WBS,
     the service-call and sales-order history, and customisations. Agents must
     keep adding what they learn about the company to the repo (in
     `company.md`, or in `connections.md` / the work folder when the fact is
     route- or work-specific).
   - Credentials go in a connections file at
     `C:\passwords\<client>-connections.txt` on MarchHare, never in the
     repo. `connections.md` references that path and does not contain its
     contents. Never dump that file to stdout or to agent tool logs, even when
     intending to print only keys for redaction. Read it into variables only;
     print lengths or boolean found flags. If a secret hits a log, stop and
     tell the operator immediately. (See `harvest-agent-skills` and PRs 377
     and 378.)
   - Local credential writes need an authorized target machine and secure
     handling. Do not invent paths.
7. Order connection routes as follows when more than one exists:
   - An airc console (for example `<HOST>_console`) is the primary agent route
     when one exists.
   - A remote desktop tool (AnyDesk or TeamViewer) is the human route.
   - Web access is a fallback.
   Desktop shortcuts may embed the password only when the user explicitly asks.
   Anyone who can open the shortcut properties can see that password in plain
   text; say so before saving one.
8. Preserve existing Git-event integration independently from hours reports.
   Use the working authorized shared integration or template, not hostname
   guesses. Git events are not the hours store.
9. Keep each work item's artifacts and `project.md` in its exact SC/SO folder.
   Store verified Priority booking project and WBS as distinct customer
   metadata. Inventory before migrating ordinal, WBS or suffixed folders;
   preserve history and update all references in the same review PR. A user
   request for SC/SO naming covers an evidenced reversible branch rename;
   mixed or ambiguous folders stay unchanged pending authoritative mapping.
   Never delete or infer identifiers on a guess.
10. Customer configuration identifies the customer, repo and selected work
    item, not a permanently fixed consultant. Consume user identity from the
    Priority Agent's supported runtime session context according to the
    canonical rules; personal account confirmation is not a global customer
    default. Reuse shared implementation and tests rather than duplicating
    them.
11. Verify actual focus/dispatch registry and any required harvest registry
    using established customer defaults. A topic alone does not prove
    registration.

## Contract and receipt verification
Read the current [Bob hours contract](https://github.com/SimonBarnett/bobiverse/blob/main/jeeves/docs/webhooks.md#hours-webhook-fr-3450--no-secret)
and receiver implementation `common/scripts/bobhours.py` when integrating. The
canonical hours base is `https://bob.ntsa.uk/bob/v1/hours`; use supported
methods, schema and identity matching from the shared implementation, not
invented fields or per-customer copies. No reporting secret is documented;
existing network controls still apply.

Verify the actual shared client and config consumption and canonical rule
version. Use offline fixtures or an explicitly supported nonbillable test mode.
Genuine live delivery requires readback of an existing accepted report with
the intended session owner, customer, work-item and receipt identity.
Documentation, a passing fixture, HTTP success or attempted submission alone
does not prove receipt. Never fabricate work to test delivery.

If blocked by a site or proxy, stop requests and give the service owner the
exact response for supported access. No alternate-host, spoofed-header,
browser/session or credential bypass. Leave receipt blocked and affected
collection paused; independent offline changes may continue. Never poll a
known block or claim reports arrive.

An hours owner's authorized collector reads the canonical rules and contract,
deduplicates stable receipts and proposals, and keeps durable review markers
without editing source reports merely because they were read. A personal
collector may filter that person's verified identity without imposing it on
every Priority Agent user. Reports remain supporting evidence; all actual
Priority bookings still require explicit user approval under the canonical
reporting rules and existing authorization boundaries.

## Deliver verified state
Return customer and repo identity, review-artifact links, exact folder and
distinct booking/WBS mappings, canonical rule and contract refs, actual config
and client consumption, registration and test evidence. State whether real
receipt is verified and what merge, distribution, install, access, identity or
mapping gaps remain. No secrets. Do not equate source changes or PR creation
with deployed behavior, successful delivery or booked hours.
