---
name: priority-service-desk-ssl-acme-renewal-firewall
description: >
  An automatic (ACME) certificate renewal on a hosted web server failed. The scheduled renewal task had stale Windows credentials, and after that was fixed the ACME port 80 check timed out because of the IP lockdown. Network support let the renewal through, renewed the certificate and locked the server down again. Use when SSL certificate not renewing ACME firewall IP lockdown, or
  /priority-service-desk-ssl-acme-renewal-firewall.
---

# Automatic SSL renewal failed because the firewall lockdown blocked the ACME check

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/ssl-acme-renewal-firewall.md`.

Issue type: a hosted Priority web server certificate is close to expiry and the automatic ACME (for example Lets Encrypt) renewal is not happening.

Known: on 2026-10-07 support found the Windows scheduled task that runs the renewal was failing because the Windows credentials it used had recently changed. The credentials were updated; the task then started but did nothing. Its log showed the ACME http-01 check on port 80 timing out with a likely firewall problem. On 2026-10-08 08:48 BST the network provider said the IP lockdown stopped ACME getting in; they renewed the certificate (new expiry January 2027) and locked the server down again. On 2026-10-12 11:11 BST support told the customer the addresses the renewal task contacts had been added to the firewall allowlist. On 2026-11-09 13:31 GMT the customer said everything seemed OK. Host names, addresses, credentials and log links are not stored.

This is not a reason to leave the firewall open, and not a reason to buy a different certificate. Fix the renewal path.

## Steps

1. Check the certificate expiry date and when the automatic renewal last succeeded.
2. Check the scheduled task that runs the renewal. If it fails to start, check whether the account or credentials it runs as have changed. The server owner updates them; never store them in a ticket or skill.
3. Read the renewal log. A connection timeout on the ACME validation (port 80, likely firewall problem) means the lockdown is blocking the check.
4. The network owner allows only what the renewal needs (the validation path, and the addresses the task contacts), runs the renewal, then confirms the lockdown is back in place.
5. Confirm the new expiry date on the live site, and that the next automatic renewal will be able to run.

## Verification

Proven: the certificate was renewed with a new expiry and the customer confirmed all was OK (SC263074).

Not proven: the exact firewall rule, and whether the following automatic renewal ran without help. The network provider and support describe the firewall step slightly differently (temporary unlock versus allowlisting the task addresses).

## Stop

Stop if the request is to remove the IP lockdown, or if the renewal fails for a reason other than the firewall or credentials. Then escalate to the network owner.
