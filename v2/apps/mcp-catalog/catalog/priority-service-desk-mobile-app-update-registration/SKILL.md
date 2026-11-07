---
name: priority-service-desk-mobile-app-update-registration
description: >
  A mobile service-visit app error cleared after updating the app and
  repeating user registration. The recorded build is historical evidence,
  not a target to install now. Use when mobile app update registration
  login, or /priority-service-desk-mobile-app-update-registration.
---

# Mobile app update plus registration restored login

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/mobile-app-update-registration.md`.

Issue type: the mobile service-visit app errors until the app build is updated and the user is registered again.

Known: on 2026-10-28 16:46 GMT support recorded that after upgrading the version and doing the user registration, the error was not seen and the user logged in. The build named in that upgrade was 183.2.79. Opened 2026-10-28 16:44 GMT.

Unknown: the exact prior version, and whether the update alone or the registration alone was sufficient. They were not isolated. Do not treat 183.2.79 as the build to install on a later date. Check the current supported server and app pair first.

Different incident: after a server move, a regenerated registration QR restored the app (`priority-service-desk-mobile-migration-qr`). Do not skip the version check and only regenerate a QR, or the reverse.

## Prerequisites

Official update and registration only. No third-party package, sideload, or security bypass. Do not collect passwords or registration codes.

## Steps

1. Record the Priority server version, the mobile app version, the exact error, and whether it fails before or after login.
2. Check the supported server and app combination. Do not pick 183.2.79 because it appears in this call.
3. Apply the approved update, then repeat the supported user registration.
4. Retest the same app login. Record whether both steps were done.

## Verification

Proven for SC263416: the user logged in after both the upgrade and the registration.

Not proven: which step was independently sufficient.

## Stop or escalate

Stop if the approved update source is not available, or if the failure is a certificate error (install-upgrade examples) rather than an outdated build. No password reset from this skill.
