---
name: priority-service-desk-runaway-report-cpu
description: >
  Two manual reports with a broad wildcard drove SQL CPU and blocked
  cleanup. Terminating those identified read-only sessions recovered CPU.
  HEAVYQUERY only logs. Use when runaway report CPU, HEAVYQUERY does not
  stop, or /priority-service-desk-runaway-report-cpu.
---

# Identified read-only runaway report is a mitigation

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/runaway-report-cpu.md`.

Issue type: manually launched reports with a very wide input generate a near-cartesian SQL workload, block cleanup, and push SQL CPU up. This skill is a mitigation. It does not rewrite the report.

Known: the report was Repair History per Serial Number, run twice by hand with a broad wildcard, not from TTS. The infrastructure team terminated those two identified read-only report sessions. Cleanup then finished and SQL CPU returned to normal. The kill time in the source is 26 Oct 11:16 server time. The source does not name that server's time zone. Do not relabel it as GMT. Support on 2026-10-27 10:18 GMT named the report and said the runs were manual. The same note: the HEAVYQUERY system constant logs when a query runs longer than the specified time, and it does not stop the process.

Not done: a narrower input guard, a query rewrite, or an automatic time limit. HEAVYQUERY is not a timeout.

## Prerequisites

An authorized DBA. Evidence that the sessions are the read-only report sessions, who owns them, and what they are blocking. This harvest does not authorize cancellation. No kill-all, no ending netproc.exe, and no sample KILL statement.

## Steps

1. Match recent-process times and the report input to the database workload. Do not assume the server is too small.
2. Confirm the runs were manual if TTS is suspected. In this call they were manual.
3. Identify the exact sessions. Read-only report work can still block cleanup. Get business-owner agreement before cancellation.
4. The DBA cancels only those sessions with the estate's approved method. Verify cleanup completes and CPU returns.
5. Separately, require a narrower input or a report review. Turning on HEAVYQUERY only adds a log. It does not stop or cap the query.

## Verification

Proven: after those two sessions were terminated, cleanup completed and SQL CPU was normal (SC263359).

Not proven: that every CPU spike on the server was this report, or that the report is now safe to run wide open.

## Stop or escalate

Stop if the sessions are not identified, if they are not the read-only reports, or if the proposal is to kill every process. Do not publish a generic kill script. Report redesign stays open.
