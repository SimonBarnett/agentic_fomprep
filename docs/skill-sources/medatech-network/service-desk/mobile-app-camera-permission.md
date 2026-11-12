# The Priority mobile app said camera permission was not given although it was allowed

Issue type: the Priority mobile app says permission has not been given to use the camera, but the phone settings already allow the camera for the app.

Known: on 2026-09-09 a customer reported users could not take and save photos in the app. The phone permissions matched the instructions and a normal reinstall did not help. Priority Software said this is known behaviour: the phone OS can keep a cached "denied" flag that a normal reinstall over the top does not clear. Their steps were: fully uninstall the app, restart the device, then reinstall. On 2026-09-30 the customer wrote "That worked!" and on 2026-10-15 confirmed all working. Device and user names are not stored.

This is not a Priority licence or privilege problem. Re-ticking the permission alone did not fix it.

## Steps

1. Confirm the camera permission is allowed for the Priority app in the phone settings.
2. Fully uninstall the Priority app (remove it, do not just reinstall over it).
3. Restart (power-cycle) the device.
4. Reinstall the Priority app, sign in, and allow the camera when asked.
5. Take and save a test photo.

## Verification

Proven: customer confirmed "That worked!" and later "All working" (SC262769, customer-verified).

Not proven: which phone OS versions are affected.

## Stop

Stop if it still fails after the full uninstall and restart. Then record the app version and a screen recording and escalate to Priority Software.
