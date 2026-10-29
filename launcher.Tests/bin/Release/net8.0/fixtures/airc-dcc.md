### Reverse DCC for large replies (bobiverse FR #5003 / #5008)

Source: `SimonBarnett/bobiverse` commit `7372500933ba10c725219334a33e4bba41f1eca8`, `airc/docs/airc-remote-control.md`.

- Keep IRC as the control plane. For a large command reply, use `New-AircDccToken` and `New-AircDccListenOffer` from `airc/scripts/Invoke-AircRemote.ps1`, then send `DCCLISTEN id=<job> host=<ip> port=<n> token=<hex> tls=1` to `{{AIRC_CONSOLE}}` before or with the shell command using the same job id. Use `relay=<host:port>` when both sides are behind NAT.
- Verify the reply with `Test-AircDccDoneSha256` and require `DONE ... via=dcc` with the expected byte count and SHA-256. Keep the ephemeral token local; never print it into logs or share it.
- If DCC fails or is blocked, accept `dcc failed ...; falling back to IRC` and continue with `CONT` / `RESUME` paging. Do not retry-loop DCC.
- DCC is console-to-caller bulk output only; it does not upload files to the console. Use `PUT` chunks over IRC for uploads. For downloads, use `GET <path> fetch=chunk` followed by `GETCHUNK`; use allowlisted HTTPS or a share when appropriate. Never dump multi-KB base64 over PRIVMSG.
