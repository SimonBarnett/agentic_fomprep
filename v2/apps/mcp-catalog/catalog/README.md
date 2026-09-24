# Adding a skill to mcp-priority

Drop a folder here. The Amplify MCP lists every directory that contains `meta.json`. No catalog code change required.

```
catalog/<skill-name>/
  meta.json              # required: name, title, description, version
  SKILL.md               # required: agent method
  instance-schema.json   # optional: JSON Schema for user config
  runner/                # optional: files get_runner_files returns
```

`meta.json` example:

```json
{
  "name": "my-skill",
  "title": "My skill",
  "description": "One line for list_catalog and the landing page.",
  "version": "1.0.0"
}
```

Do not put passwords, CredMan secrets, or `prepare_form` / `compile_shell` / `install_shell` / `odata_get` / `odata_query` / `odata_dump_procedure` / `formlimited_audit` execution in this Amplify app.

## DBA skills (Priority SQL / backup / health)

| Skill id | Role |
|----------|------|
| `priority-backup-standard` | Target backup policy reference |
| `priority-backup-audit` | Read-only gap audit vs standard |
| `priority-backup-cutover` | Phased cutover procedure (human-gated) |
| `priority-sunday-backup-check` | Weekly overnight verification + Haitch signal |
| `priority-instance-health-collect` | sqlcmd health pack |
| `priority-post-move-health` | Post-cutover smoke |
| `priority-disk-mount-layout-report` | IT mount/path report |
| `priority-ht-delete-deadlock-triage` | HT 1205 evidence checklist |
| `priority-form-prep-after-sql-change` | Form Prep gate after trigger SQL |
| `priority-hours-handoff-haitch` | Hours/WBS handoff process |

Harvest scripts: `docs/skill-sources/dba/`. Config: `%USERPROFILE%\.priority-dba\instances.json` (see `priority-backup-audit/runner/instances.example.json`). Windows integrated SQL auth only.

## Programming skills (triggers, UDATE, Form Prep, shells)

| Skill id | Role |
|----------|------|
| `priority-procedure-style` | Trigger/SQLI banners, debug includes, dedicated TRIG |
| `priority-sql-udate-user` | UDATE minutes-since-1988 and USERLOGIN |
| `priority-formprep-shadow-tables` | pritempdb T$$ shadows and EXECPREPLOCK success gate |
| `priority-recalc-concurrency` | ELEMENT sign, RECALC clear, stale-price consumers |
| `priority-version-revision-discipline` | Dedicated shells, TAKETRIG shape, install-row verify |

Harvest: `docs/skill-sources/programming/`. FR: `docs/feature-request-eshbel-priority-programming-harvest-2026-09-24.md`.
