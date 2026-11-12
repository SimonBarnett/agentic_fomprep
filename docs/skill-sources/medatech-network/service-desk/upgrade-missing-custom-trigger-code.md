# After an upgrade, errors came back because custom code in a standard trigger was lost

Issue type: after an upgrade (or a move), a form that used to work raises errors on insert or stops filling a field, and the system has customisations.

Known: on 2026-09-16 the customer reported an error when adding a second line to a new service contract. On 2026-10-06 support found that custom code previously added to the standard triggers was missing; it had not been recorded as a standard-trigger change, so it was missed in the upgrade. Support added it back; the errors stopped and the code that fills the engineer worked again (internal note 14:39 BST). On 2026-10-07 08:07 BST the customer said it looked resolved and they would keep testing. Trigger and variable names are customer-specific and not stored.

This is not a standard Priority bug to escalate first. Check the customisation record before raising it with the supplier.

## Steps

1. Confirm when the problem started. If it began after an upgrade or move, suspect lost customisation.
2. Compare the form triggers in the affected system with a copy taken before the upgrade, or with the customisation record.
3. Look for custom lines inside standard triggers. These are easy to miss in an upgrade if they are not recorded.
4. A developer restores the missing code in Test, checks it, then applies it to Live with the owner agreeing.
5. Retest the original action, and record the code as a standard-trigger change so the next upgrade keeps it.

## Verification

Proven: after the code was restored, the errors stopped and the customer said it looked resolved (SC262879).

Not proven: how many other forms lost code in the same upgrade.

## Stop

Stop if the code differs between the old copy and the record, or if no customisation exists. Then escalate to the developer who owns it.
