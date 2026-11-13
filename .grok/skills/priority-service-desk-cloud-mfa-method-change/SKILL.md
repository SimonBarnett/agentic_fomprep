---
name: priority-service-desk-cloud-mfa-method-change
description: >
  A cloud customer needed one user MFA method changed from app to email. It could not be done from the partner or tabula side or the management console; the supplier changed it for the user. Use when change user MFA method cloud app email, or
  /priority-service-desk-cloud-mfa-method-change.
---

# A cloud user MFA method could only be changed by the Priority supplier

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/cloud-mfa-method-change.md`.

Issue type: a cloud user needs their MFA method changed (for example from authenticator app to email).

Known: on 2026-09-21 support could not find a way for a tabula user to change a user MFA method and raised it with the supplier. On 2026-09-24 support set up the customer on the Priority Management Console, but the supplier instructions did not match what it showed. On 2026-09-25 09:06 BST support said the supplier had confirmed MFA methods cannot be managed from the partner side, future requests must be raised so they can be passed to the supplier, and the supplier had made the change for the user. At 09:43 BST the customer asked for the call to be closed. User names are not stored.

Do not try to reset a user or edit security settings in the database to change MFA.

## Steps

1. Confirm the user identity and the requested method with the customer system owner.
2. Do not change MFA from tabula, the database or the console unless the supplier documents that route for this version.
3. Raise the request with the supplier support, with the user and the requested method.
4. Ask the user to sign in with the new method and confirm it works.
5. Tell the customer that future MFA method changes go through support to the supplier.

## Verification

Proven: the supplier changed the method and the customer closed the call (SC262870).

Not proven: whether newer versions let the customer do this themselves.

## Stop

Stop if the requester cannot be verified as allowed to ask for the change.
