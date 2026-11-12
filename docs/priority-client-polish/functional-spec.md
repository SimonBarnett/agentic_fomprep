# Functional spec: priority-wcf verb table

Client: v2/apps/priority-saas-wcf/bin/priority-wcf.mjs
Skill: priority-saas-wcf
Launcher: PriorityAgent.exe

## Already shipped (do not re-file)

| verb | behaviour |
|------|-----------|
| probe | tenant probe, optional token |
| session | login, optional form smoke |
| form start / rows / set / save / subform | data form read and row write |
| prepare form / procedure / report | FORMPREPDRCT2 or REPPREPDIRECT2, OData gate |
| proc start | step walker; auto-picks the first option today |

On-prem runners under src/ and v2/plugins stay in place. SaaS DDL without a
sqlProfile returns table_ddl_needs_sql.

## Verbs this pack adds

| verb | read or write | FR |
|------|---------------|----|
| whoami | read | FR-01 |
| (launcher saved default) | local file | FR-02 FR-03 FR-04 FR-05 FR-06 |
| --request file, help <verb>, --dry-run | local | FR-07 FR-08 FR-09 |
| fail() retryable, exit codes | local | FR-10 FR-11 |
| companies | read | FR-12 |
| form columns / rows --filter | read | FR-13 FR-14 |
| form new / delete / action / subform set | write, allowLive | FR-15 FR-16 FR-17 FR-18 |
| dialog policy, fields-file cap | local | FR-19 FR-20 |
| proc inputs, needs_input, proc continue | read path, no silent choice | FR-21 FR-22 FR-23 |
| urls on proc and prepare | read | FR-24 |
| report run, empty report | read | FR-25 FR-26 |
| proc text, proc text set | read / write | FR-27 FR-28 |
| prepare interface | write, refuses if proc unknown | FR-29 |
| table columns / exists | read | FR-30 FR-31 |
| title length, column add, table create | write or refuse | FR-32 FR-33 FR-34 |
| interface list / run / map set | read / write | FR-35 FR-36 FR-37 |
| token_expired, refresh once, login retry | auth | FR-38 FR-39 FR-40 |
| probe cache, batch reads, row cap, redact | speed and safety | FR-41 FR-42 FR-43 FR-44 |
| launcher rules, skill page, VISION bounds | docs | FR-45 FR-46 FR-47 |

## Saved user

Path: %USERPROFILE%\.priority-agent\last-user.json
Keys: by instance id, value userLogin, company, identifiedAt, source.
Encoding: UTF-8 without BOM.
Prompt: Priority USERLOGIN [<saved>]:
Empty answer accepts the saved login.
--hours-user overrides.
A mismatch between --hours-user and whoami on this launch exits 2 before Grok starts.
