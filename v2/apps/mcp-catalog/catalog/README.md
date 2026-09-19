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
