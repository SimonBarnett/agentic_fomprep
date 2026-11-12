# App login said the user was not an API user until added to Applications for License

Issue type: a user logs in to a custom or mobile Priority app and gets a message that they are not an API user.

Known: on 2026-10-02 12:43 BST support recorded, after working with the customer, that when the user logged in to the app they got a message that they were not an API user. The customer added the user to System Management > System Maintenance > Software Licences > Applications for License, and login was then successful. The customer also expected work orders in the app procedure dropdown; the work orders had to be released to appear, and once released they appeared. The app and user names are not stored.

This is not a password problem or a server outage. Adding a user may use a licence; check entitlement first.

## Steps

1. Confirm the exact message says the user is not an API user (or similar), not a wrong password.
2. Open System Management > System Maintenance > Software Licences > Applications for License and check whether the user is listed for that app.
3. If not, and a licence is available, an authorised administrator adds the user. Do not take a licence from another user without the owner agreeing.
4. The user logs in to the app again and confirms it works.
5. If expected documents (for example work orders) are missing from an app list, check their status. Here they had to be released first.

## Verification

Proven: login worked after the user was added, and released work orders appeared (SC263067, support note after the session).

Not proven: the licence count impact, and a customer-written confirmation.

## Stop

Stop if no licence is available, or if login still fails after adding the user. Then check the user and app setup with the licence owner.
