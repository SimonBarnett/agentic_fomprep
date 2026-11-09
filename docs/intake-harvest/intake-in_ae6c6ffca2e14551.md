MRB (light triage): is the lesson useful, generalised, non-duplicate, and a fit for this repo's vision/AGENTS.md? PASS -> merge. Not useful / off-vision -> close with a one-line reason (board CLOSED not-useful). Duplicate -> close citing the existing lesson. Wrong owner -> re-file or MOVED (FR #3299); leave OPEN if the owner repo does not exist yet. Plan content only (requirements, designs, product decisions, FR/issue lists from a Plan seat) -> close 'plan content, not a lesson' (never hold it OPEN); move any how-to-plan lesson inside to SimonBarnett/skills-visionary.

## Ask
Fold into .grok/skills/harvest-agent-skills/SKILL.md under Harvested lessons (non-draft lesson tip).

## Lesson
Never dump customer connections files (e.g. `C:\passwords\<repo>-connections.txt` / hillier-connections.txt) to stdout or agent tool logs â€” even when intending to print only keys for redaction. A PowerShell pass that Get-Content / writes the file can leak PASSWORD values into the log.

Rule: read connections files into variables only; print lengths or boolean found flags; never Get-Content the file to the console. If a secret hits a log, stop and tell the operator immediately.

## Why
VISION/AGENTS already say never commit or echo secrets; this pins the concrete Get-Content/stdout failure mode from a live agent session (marchhare / Report-FomprepIntakeIssue in_229c5131ab054796). Prior MRB #377 was a draft receipt-only tip and was CLOSED unmerged.

## Acceptance
- Contiguous bullet in harvest-agent-skills Harvested lessons
- ASCII / no-BOM skill edit
- No secrets in the bullet text
---
_via-intake id=`in_ae6c6ffca2e14551` ts=`2026-11-09T21:47:48Z`_
_source machine=`redqueen` agent=`Report-FomprepIntakeIssue` book=`harvest-agent-skills` ver=`-`_
