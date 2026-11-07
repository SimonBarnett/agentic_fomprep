# Inactive user versus missing P.Account Sign Up

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


## Third branch: login email does not match the user record (SC263378)

Issue type: cloud sign-in fails because the email used to log in is not the email on the intended Priority user. Cache clearing did not fix it.

Known: on 2026-10-29 11:34 GMT the customer said there was a different email address, they changed it, and login was good. Opened 2026-10-27 11:44 GMT. Which side changed (the typed address or the stored user email) was not recorded. Do not prescribe one field for every case. Do not write the addresses down.

This is not Branch A (former employee) and not Branch B (P.Account Sign Up unticked). Compare the identity email with the user definition before clearing cache again.

Steps: an authorized system manager or the user corrects the intended mapping through the approved account flow, then retries the same login. Do not sign in as someone else, share a password, or substitute an arbitrary mailbox.

Proven: the customer could log in after aligning the email. Not proven: which field was edited.


## Reactivation restored access only (SC263260)

Issue type: the person cannot sign in because the user is inactive. An owner-approved seat change allowed reactivation.

Known: on 2026-10-19 09:57 BST support recorded that the user was inactive, it was made active again after the owner confirmed, and access was sorted. Opened 2026-10-19 09:56 BST.

Not this fix: missing tiles were attributed to American versus British English. No language change and no tile recovery were recorded. Do not say language correction restored the tiles.

Do not deactivate someone else to free a licence. Do not share a login. This is not the email-mismatch branch and not the P.Account Sign Up branch.
