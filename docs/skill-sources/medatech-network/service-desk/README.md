# Service-desk resolutions

Confirmed service-call repairs. This topic is not the SP003 / BPM hub
(`support-desk`, catalog `priority-ops-support-desk`).

## Rules

1. One documented resolution per catalog skill. Id prefix
   `priority-service-desk-`. Do not use the `priority-ops-` prefix (that
   suffix becomes the DAG topic id).
2. No skill when the call has no documented resolution. Holds and skips stay
   in the harvest checkpoint issue.
3. If an existing catalog skill already owns the procedure, add the example
   there. Do not open a twin skill.
4. State observed cause separately from what is still unknown. Do not invent
   trigger names, SQL, certificate commands, or supplier patch ids.
5. De-identify names, contacts, secrets, remote-access material, prices, and
   bank details. Keep the service-call reference and date.
