# Handoff from Bob (Grok Bot) — you own this work

Do not wait on Bob for Form Prep execution. You are the builder/runner on CE-PRIORITY-DEV1.

## Own end-to-end
1. Finish/drive `agentic_fomprep` on DEV1 (`M:\py\agentic_fomprep`).
2. Write concise operator how-to for **Eshbel** (engineering agent) — how to run, preconditions, exits, OPEN-park repair, hard rules. Put it at `M:\py\agentic_fomprep\docs\OPERATOR_HOWTO_ESHBEL.md`.
3. Keep a short feedback log of what broke / what you fixed (mutex, CredMan, cookies, LASTPREPDATE, park restore) in that docs folder or session plan.

## Constraints already true
- CredMan `CE/Priority/Si` present; cookies at `C:\Priority\tmp\agent-formprep\si-web-state.json`.
- Mutex `Global\CE-DEV-FORMPREP` — one prepare at a time. OPEN parks must be 0 before a new prepare (RepairOpenParks).
- Never SQL-flip UPD=N; never leave OPEN parks; web is success path; CLI only counts if LASTPREPDATE moves.
- After reboot: desktop shortcut "Resume Grok agentic_fomprep" or `grok --resume 01a0a96c-2677-7c61-bf65-3ce9e16e4d3b` from `M:\`.

Bob will only pick up the finished how-to to send Eshbel, and only ping you if Simon asks.
