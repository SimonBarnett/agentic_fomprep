Kind: harvest
Generic Priority lessons from Toray SO260255 session (strip customer names in reuse):

1) On this self-hosted layout, form trigger dictionary tables (FORMTRIGTEXT, FORMCLTRIGTEXT, FORMCLTRIG, FORMCLMNS, TRIGGERS, INCTRIG, EXECA, EXECPREPLOCK) live in the SQL database named "system", not in the company database. Company DBs may have EXECTEXT only. Always probe system.dbo first for FORMCLTRIGTEXT before concluding triggers are missing.

2) FORMCLTRIGTEXT columns: FORM, NAME, TRIG, TEXT, TEXTLINE, TEXTORD, INCFORM. Column POST-FIELD is TRIG=11; custom triggers use other TRIG ids (e.g. 595) joined to TRIGGERS.TRIGNAME.

3) After editing FORMCLTRIGTEXT, Form Preparation of the ENAME is still required for the prepared .od/.p objects to pick up the change.

4) Airc remote sqlcmd: keep each PRIVMSG under ~400 chars; prefer Action Cmd. PUT to airc\drop may time out — fall back to one-line INSERTs. Do not put SQL passwords in airc/IRC payloads; use trusted auth when the console identity is sysadmin. Named-pipe/shared-memory SQL may have no TCP 1433.

Path evidence: agentic_fomprep harvest from Priority Agent session; no secrets.
---
_via-intake id=`in_90d39621e7fa49be` ts=`2026-11-13T16:02:20Z`_
_source machine=`marchhare` agent=`Report-FomprepIntakeIssue` book=`harvest-agent-skills` ver=`-`_
