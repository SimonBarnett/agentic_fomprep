---
name: priority-service-desk-data-exchange-email-company
description: >
  After a data-exchange upgrade, email participant references must be
  mapped to company identifiers with Update Interface by Email in each
  company. Search Inbox and Outbox by date. Use when data exchange
  Update Interface by Email, or
  /priority-service-desk-data-exchange-email-company.
---

# Data exchange email participants become company identifiers

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/priority-mcp.

Authority: `docs/skill-sources/medatech-network/service-desk/data-exchange-email-company.md`.

Issue type: an upgraded data exchange no longer matches participants by the old email reference. Reinstalling does not restore the link. The participant has to be a company identifier.

Known: internal note 2026-10-30 13:20 GMT: in Define Comps. for Data Exchange add the two companies, and on each run Update Interface by Email for the legacy participant mapping. Do this in each participating company. On 2026-11-02 16:31 GMT the customer searched the inbox and outbox for that day's date and found exchanges. An empty default list had looked like a failure. Support confirmed it was working. Opened 2026-10-27. The call's opened instant in the scan is 2026-10-27; do not invent a company code.

Not proven: a full purchase-order and receipt round trip. Visible exchanges are not that proof. Do not copy company identifiers or email addresses into the skill.

## Prerequisites

The integration owner agrees the company pair. Do the mapping in each company. Test before treating it as live cutover. This harvest does not authorize a reinstall or a service removal.

## Steps

1. Confirm this is an upgraded interface that wants company identifiers, not a failed install. Do not reinstall again as the first action.
2. In each participating company, open Define Comps. for Data Exchange and define both participant companies.
3. On each company, run Update Interface by Email for each legacy email participant that should now be that company. The approved action name is the one in the call. Do not rewrite every participant.
4. Search Inbox and Outbox with an explicit date. A blank default list is not proof of no traffic.
5. With the integration owner, check one representative outbound or inbound document. Stop if that document was not part of the evidence you have. This call confirmed the exchanges were visible, not every document type.

## Verification

Proven: after the company mapping, a date search showed data exchanges and support confirmed they were working (SC263373).

Not proven: full order and receipt lifecycle.

## Stop or escalate

Stop if the companies are not agreed, if the request is to reinstall or remove the service, or if a date search still shows nothing after the mapping. The integration owner owns activation.
