---
name: priority-service-desk-invoice-po-column
description: >
  An invoice has a PO reference that does not print because the selected
  format hides that column. Identify the real field before unhiding.
  Use when invoice PO reference hidden print, MC Cust PO, or
  /priority-service-desk-invoice-po-column.
---

# Unhide the invoice print column that holds the PO reference

Foundation: harvest-priority-skills -> report back to https://github.com/SimonBarnett/agentic_fomprep.

Authority: `docs/skill-sources/medatech-network/service-desk/invoice-po-column.md`.

Issue type: the invoice stores a customer PO reference, but the print format the user actually runs hides that column.

Known: internal note 2026-10-22 12:01 BST identified the field as MC Cust PO. At 13:50 BST support said the customer reference is hidden in this format and asked permission to unhide it. At 16:37 BST support had added it and asked if the PO reference was visible. At 16:52 BST the customer said yes. An earlier guess that an account-number change had fixed it was wrong. A previously tested default format was not the failing format. The print actions named were Print Invoice/Credit Memo and Invoice (header).

Do not assume every company uses the same field. Confirm the value is on the document and which format is selected. Do not unhide the column on every format. Do not overwrite the invoice. Do not copy PO numbers into notes.

## Steps

1. Show the PO reference on the invoice itself. Separate it from the account number and from a generic reference.
2. Record the exact print action and the format that failed.
3. With the format owner's permission, unhide or add the populated column in that design only.
4. Print the same invoice and have the customer confirm the reference is visible.

## Verification

Proven: the customer saw the PO reference after that column was unhidden (SC263237).

Not proven: a format code that can be copied to another company.

## Stop

Stop if the document has no PO reference, if the format owner has not agreed, or if the proposal is to change every invoice layout.
