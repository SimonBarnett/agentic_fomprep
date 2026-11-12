---
name: priority-service-desk-inactive-user-login-error-500
description: >
  A user got Error 500 when logging in. Another user had marked them inactive. Marking them active again let them log in. Use when Error 500 login user inactive, or
  /priority-service-desk-inactive-user-login-error-500.
---

# Error 500 at login was because the user had been made inactive

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/inactive-user-login-error-500.md`.

Issue type: one user gets Error 500 when logging in while others can work.

Known: on 2026-09-24 09:24 BST support recorded that a user had called to report Error 500 when logging in. Support found the user had been marked inactive by another user on 2026-09-15. Support marked the user active, the user could log in, and the customer contact confirmed. Names are not stored.

This is not a cloud outage. If many users get Error 500 at once, treat it as an outage instead.

## Steps

1. Check whether only this user is affected.
2. Look at the user record: is the user marked inactive? Check history to see who changed it and when.
3. Confirm with the customer that the user should be active, and that a licence is available.
4. An authorised administrator marks the user active.
5. The user logs in again and confirms it works.

## Verification

Proven: after marking the user active, the user logged in and the customer confirmed (SC262976).

Not proven: why the user was made inactive, and whether the same message appears in every version.

## Stop

Stop if the user is already active, or the customer says they should stay inactive.
