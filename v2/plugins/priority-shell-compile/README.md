# Grok plugin — priority-shell-compile (execute)

Local MCP tools: `list_instances`, `compile_shell`, `get_last_result`, `get_skill`.

Allowlist: `%USERPROFILE%\.priority-formprep\instances.json` (see `scripts/instances.example.json`).

Runner: `scripts/Compile-Shell.ps1`. Until `v2/config/pin.json` `PinComplete=true`, the runner refuses WCF (`reason=pin_incomplete`). Do not guess the Prepare Upgrade ENAME.

Separate from `priority-shell-install` (`install_shell`) and from `priority-formprep` (`prepare_form`).
