---
name: priority-service-desk-warranty-auto-raise
description: >
  Custom automatic warranty creation fails on Live when the sale type
  has no Stat After Auto Raise status. Recover the missed shipments
  only with owner approval. Use when Stat After Auto Raise warranty
  contract, or /priority-service-desk-warranty-auto-raise.
---

# Warranty auto-raise needs the post-creation status

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/warranty-auto-raise.md`.

Issue type: a custom process should create a warranty contract when a shipment is finalized, but Live has no status for that new contract because Stat After Auto Raise was not set. Test had been configured. Code deployed to Live did not copy that flag.

Known: on 2026-10-19 08:41 BST support said the sale types were set to create contracts automatically, but the status flag was not ticked, so the 14 October shipments failed. The owner-requested value was Draft. On 16 October, after the owner approved, the developer reran contract creation for those two shipments. Both contracts were Draft, with the configured service contact, and the customer was asked to move them on. The developer accounted for the two contracts on 2026-10-26. The user recorded as creator is the recovery account, because that operator replayed them. A separate trigger change to stop interference was also deployed. Its diff was not retrieved.

Future automatic creation on a new shipment was still awaiting customer confirmation. Do not claim the automatic path is proved. This is a custom implementation, not a standard sale-type feature on every system. Do not copy a customer assignee. Do not approve the contracts from this skill.

## Steps

1. Compare the sale type on Live with the tested environment, including Stat After Auto Raise and the service contact.
2. The service owner names the status new contracts should receive. Draft was this company's choice.
3. List only the shipments that missed a contract. The owner approves a replay. Check for duplicates first.
4. The developer reruns creation for that list. Record that the replay user is not the person who finalized the shipment.
5. The customer moves the Draft contracts through their normal process. Watch the next real shipment before calling the automatic flow healthy.

## Verification

Proven: two historical contracts were created in Draft (SC263216).

Not proven: the next automatic shipment, and the extra trigger diff.

## Stop

Stop if this sale type has no such customization, if the owner has not approved the replay, or if a contract may already exist.
