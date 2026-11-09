# A changed public IP blocked login until it was allowlisted

Issue type: a remote user cannot log in because their public source address changed and is outside the allowlist.

Known: on 2026-10-12 10:35 BST support recorded that the new address was not whitelisted, and after it was added the user logged in. Another new address later needed the same addition. This does not stop address churn. No address, firewall product, or rule text is stored. A cloud move was suggested and was not proved.

This is not a wrong email, an expired session, or a bad password. Do not turn the firewall off, and do not allow every address, to test.

## Steps

1. Confirm the failure is an allowlist denial, not the email-mismatch or inactive-user cases.
2. The access owner checks the requester, the current public egress, and the environment. Do not write the address into a skill or a ticket that will be shared.
3. The network owner adds only that approved address.
4. The user retries the real login. Record that it worked, not the address.
5. If addresses keep changing, that is a separate access design. This call did not settle it.

## Verification

Proven: login succeeded after the new address was allowlisted (SC263173).

Not proven: a permanent fix for the next address change, and the firewall syntax.

## Stop

Stop if the address is not verified, if the request is to open the firewall wide, or if login still fails after the add. Then recheck identity, not the firewall rule size.
