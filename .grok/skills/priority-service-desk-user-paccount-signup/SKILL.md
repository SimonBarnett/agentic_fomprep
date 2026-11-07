---
name: priority-service-desk-user-paccount-signup
description: >
  User registration fails either because the linked employee was marked
  former (user becomes inactive) or because an active user has P.Account
  Sign Up unticked. Use when user inactive former employee, P.Account
  Sign Up, registration tick box, or /priority-service-desk-user-paccount-signup.
---

# Inactive user versus missing P.Account Sign Up

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/user-paccount-signup.md`.

Issue type: a person cannot register or sign in. Two different causes were recorded on SC263458. Do not collapse them into "tick the user active".

Branch A, known: the customer reported they had accidentally marked the employee linked to the user as a former employee, which automatically made the user inactive (2026-11-02 14:36 GMT). Reactivating a departed employee is not authorized by this skill. An authorized system manager confirms employment status with HR before any active-flag change.

Branch B, known fix: support found P.Account Sign Up unticked on a user who was otherwise the registration case. On 2026-11-03 12:59 GMT support asked them to try again because that tick box had been unticked. On 2026-11-03 13:14 GMT the customer confirmed it was working.

Unknown: the full menu path and a setting-change audit. Do not invent extra login modes. Never copy usernames, personal emails, or passwords into the skill or the ticket you file from it.

## Prerequisites

System-manager or HR approval before changing employment status or the sign-up flag. Read-only check first. No credential reset and no substitute personal email.

## Steps

1. Read the error. Separate "user is inactive" from "user is active but registration is not authorized".
2. For inactive: check the linked employee's employment status and the user active flag. If the employee is former, stop and confirm with HR and the system manager whether the person should return. Do not clear former status to force a login.
3. For an active user who still cannot register: check the P.Account Sign Up tick box. If it is unticked and the registration is approved, an authorized system manager ticks it.
4. Ask the user to retry the same sign-in or registration flow. Record the result.
5. Ticking the user active, by itself, is not the Branch B fix.

## Verification

Proven for Branch B on SC263458 (opened 2026-11-02 12:01 GMT): customer retry succeeded after the sign-up box was corrected.

Branch A is an identified cause the customer reported. It is not a license to reactivate former employees.

Not proven: every login mode, and an audit row for the tick-box change.

## Stop or escalate

Stop if the employee is former and HR has not approved a return. Stop if the request is a password reset or a mailbox change. Escalate account changes to the system manager. No security bypass.
