---
name: priority-service-desk-po-approval-restart
description: >
  Approvers cannot act on a purchase order that was moved to Cancel Auth
  even though an approval list exists. Put it back on the status that
  starts approval. Use when purchase order Cancel Auth, restart approval,
  or /priority-service-desk-po-approval-restart.
---

# Restart purchase-order approval from the starting status

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/po-approval-restart.md`.

Issue type: a purchase order still has an approval list, but it was moved to a cancelled-authorization status, so the usual approvers cannot approve it.

Known: on 2026-10-23 09:15 BST support said to change the status first to one that starts the approval process, for example Pending Auth, and then the approvers use the approval action. At 09:31 BST the customer said it was resolved.

Unknown: the status properties and the approval definition. Pending Auth is the example from this call, not a name to type on every company. Do not approve by SQL, do not impersonate an approver, and do not bypass amount limits.

## Prerequisites

A purchasing owner authorizes the status change. Read the current status and the approval list first. This harvest does not authorize the change.

## Steps

1. Read the current status, whether authorization was cancelled, and who is on the approval list. Missing privileges are a different defect.
2. Identify the company's status that starts approval. Use that status. Treat Pending Auth as an example only.
3. An authorized purchasing operator moves the order to that status.
4. The listed approvers run the standard approval action. Confirm the status and that the intended path was used.

## Verification

Proven: the customer said it was resolved after that instruction (SC263332, 2026-10-23 09:31 BST).

Not proven: a universal status code.

## Stop or escalate

Stop if the approval list is empty, if the starting status is not known for this company, or if someone proposes a direct status write. The purchasing owner owns the change.
