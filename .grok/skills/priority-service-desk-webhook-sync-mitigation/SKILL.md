---
name: priority-service-desk-webhook-sync-mitigation
description: >
  Status-change or save slowness where a synchronous webhook blocks the
  user while outbound TLS fails. Temporary disable restores speed only.
  Use when synchronous webhook 20 seconds, WebhookProcess, business rule
  webhook turned off, or /priority-service-desk-webhook-sync-mitigation.
---

# Synchronous webhook slowness is a temporary disable only

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/webhook-sync-mitigation.md`.

Issue type: a user action is slow because a synchronous business-rule webhook waits on a failing outbound TLS handshake. The permanent endpoint or network repair was not completed.

This skill is a mitigation playbook. It is not a repaired integration.

Known: the supplier trace said the webhook runs synchronously inside the business rule, so the user waits until it finishes. About 20 seconds were spent in WebhookProcess, out of roughly 21 seconds for the whole request (recorded 2026-11-06 09:11 GMT). Internal note 2026-11-06 09:51 GMT: the affected rules were turned off and must be turned back on once fixed. The forms named in that inventory were ORDERS, PART, SHIPMENT, INVOICE, and CUSTOMER. Customer at 2026-11-06 12:00 GMT: "Yes, it's working fine now thanks!" Support at 2026-11-06 16:59 GMT: the webhook stayed off while they confirmed with Priority that traffic to the target address is open and allowed.

Unknown: whether the handshake failed because of the target service, a firewall, or an invalid endpoint. No endpoint address belongs in this skill. Restored delivery and re-enabled rules are not proven.

Distinct from custom work-order close balance changes (`priority-service-desk-record-modified-custom-close`). Do not mix the two.

SC263439 is not a separate unresolved guess anymore. SC263405 (opened 2026-10-28 11:40 GMT) is the same allowlist story with the change actually made, and it is a different endpoint from SC263461. Do not call 461 repaired because 405's host connects.

On SC263405 the vendor recorded, 2026-11-02 13:54 GMT: immediate Part Catalogue webhook rules blocked saves because the target hostname was not on the Priority Cloud outbound allowlist. Each webhook call waited about 39 seconds before it failed, which was the about 41 second "App" time. That was not database or network timing. The hostname was added to the outbound allowlist on 2026-11-01 at 11:31 UTC. A test HTTPS connection from the cloud then completed in under 0.1 seconds. The vendor said the root cause was found and fixed for that connection.

Not proven on SC263405: the customer has not retested the save, and the missed changes were not resynced. Supplier connectivity is not customer acceptance. Do not record the hostname or tenant. Do not send a firewall or resync request from this skill. The integration owner approves any resync and watches for duplicates.

Scheduled-report mail (SC263444, SC263512) still has no known final intervention and is not this skill.

## Prerequisites

Business-owner approval before any rule is disabled, plus an inventory of which rules, an audit note, a catch-up plan, and a rollback. This harvest does not authorize the disable, a firewall change, an endpoint call, or a TLS bypass.

## Steps

1. Compare the user's operation time with trace time inside synchronous WebhookProcess. Subjective "cloud is slow" is not enough.
2. List the exact business rules and forms, and the integration owner. Do not record the target URL in the skill or in a public note.
3. Have authorized admins check endpoint validity, outbound HTTPS, and TLS-path restrictions. Read-only from the agent's side.
4. If, and only if, the business owner approves a temporary disable: record every rule turned off and what downstream events will be missed. Retest the slow action.
5. Keep a separate task for the permanent repair and for controlled re-enable plus reconciliation. Fast UI with the rules still off is not closure.
6. Turn the same rules back on only after that repair is confirmed. The source note says they need to be turned back on once fixed.

## Verification

Proven for SC263461 (opened 2026-11-02 14:43 GMT): customer-confirmed performance after the temporary disable, and support's explicit statement that the webhook remained off during the traffic investigation.

Not proven: the network root cause, delivered webhook events, or a successful re-enable.

## Stop or escalate

Do not disable rules without the business owner. Do not close the integration defect because the screen is fast. Do not change firewalls or bypass TLS. Escalate the endpoint to the integration owner and to Priority support for the traffic question, as this call did.


## Different endpoint: replay a bounded invoice backlog (SC263337)

Issue type: after a cloud move, new invoices flow again but invoices missed during the outage do not. Restoring the path does not replay history.

Known: on 2026-11-04 13:17 GMT the customer said a newly finalized invoice appeared on the portal by itself. The same day at 15:12 GMT support posted one payload per missed invoice to the configured receiver and each result was "Webhook received & Processed". On 2026-11-05 08:43 GMT the customer said the backlog looked good. SC263431 was the duplicate of this call and is the same evidence, not a second repair.

Unknown: the permanent network change. The repair subform returned HTTP 500, so that text was not read. Do not describe an allowlist, a firewall rule, or an authentication scheme for this endpoint. It is not SC263461 and it is not the SC263405 host.

Do not publish the receiver, the payload, or credentials. Do not POST from this skill. An authorized integration owner replays only the enumerated missed invoices, checks which ones already arrived, records the acknowledgement, and reconciles with the customer. No replay of every document. No second financial document if the target already has it.

Proven: new invoices resumed, the bounded replay was acknowledged, and the customer accepted the backlog. Not proven: the network edit, idempotency rules, and the receiver schema.
