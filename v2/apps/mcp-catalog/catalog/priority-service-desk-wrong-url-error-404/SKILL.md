---
name: priority-service-desk-wrong-url-error-404
description: >
  Some users got an Error 404 when logging in. The supplier said this is the message for the wrong URL. The affected user had a different URL and logged in once she used the correct one. Use when Error 404 login wrong URL, or
  /priority-service-desk-wrong-url-error-404.
---

# Error 404 at login was the user using the wrong URL

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/wrong-url-error-404.md`.

Issue type: one or two users get Error 404 when opening Priority while others log in normally.

Known: on 2026-10-06 the call was escalated to the supplier. On 2026-10-07 11:39 BST support said the supplier reports this is the message you get when using the wrong URL, and asked the customer to confirm the users were connecting with the correct address. At 13:32 BST the customer said the user had a different URL and could now log in without the error. The URLs are not stored.

This is not an outage, a licence problem, or a password problem. Do not reset the user or restart services for it.

## Steps

1. Check whether only some users get the 404. If everyone does, treat it as an outage instead.
2. Ask the affected user for the address they open (bookmark or shortcut). Compare it with the address the working users open. Do not paste addresses into shared skills or tickets.
3. Give the user the correct address and ask them to update their bookmark or shortcut.
4. Ask the user to log in again and confirm the 404 has gone.

## Verification

Proven: the user logged in without the error after using the correct URL (SC263091).

Not proven: which part of the URL was wrong, and how the user got it.

## Stop

Stop if the user is on the correct URL and still gets 404. Then escalate to the supplier with the time it happened.
