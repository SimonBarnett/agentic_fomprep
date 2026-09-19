# Grok plugin — priority-shell-install (execute)

Local MCP tools: `list_instances`, `install_shell`, `get_last_result`, `get_skill`.

Allowlist: `%USERPROFILE%\.priority-formprep\instances.json` (see `scripts/instances.example.json`).

Runner: `scripts/Install-Shell.ps1`. Parses `.sh` and path-allowlists before WCF. DBI without `-AllowDbi` is `dbi_refused`. Until `v2/config/pin.json` `PinComplete=true`, the runner refuses WCF (`reason=pin_incomplete`). Do not guess the Install Upgrade ENAME.

`fixtures/` is parser-test only — live `install_shell` of those paths is refused.

Separate from `priority-shell-compile` (`compile_shell`) and from `priority-formprep` (`prepare_form`).
