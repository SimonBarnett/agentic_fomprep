# Grok plugin — priority-shell-install (execute)

Local MCP tools: `list_instances`, `install_shell`, `get_last_result`, `get_skill`.

Allowlist: `%USERPROFILE%\.priority-formprep\instances.json` (see `scripts/instances.example.json`).

Runner: `scripts/Install-Shell.ps1`. Parses `.sh` and path-allowlists before WCF. DBI without `-AllowDbi` is `dbi_refused`. Reads Install Upgrade ENAME and install-log table from `v2/config/pin.json`. Incomplete pins still refuse WCF (`reason=pin_incomplete`). SQL gate + `postInstall.formsUnprepared[]` handoff to `prepare_form` (does not auto-prep). Do not guess the Install Upgrade ENAME.

`fixtures/` is parser-test only — live `install_shell` of those paths is refused.

Separate from `priority-shell-compile` (`compile_shell`) and from `priority-formprep` (`prepare_form`).
