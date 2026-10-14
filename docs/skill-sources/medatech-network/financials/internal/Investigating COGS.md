# Investigating COGS

- **Source:** `Investigating COGS.docx`

Investigating COGS/Perpetual Inventory

Check COGS Constants

Financials > Maintenance of Financials > Basic Data > Financial Attributes > Financial Constants

Search COGS* to bring up the COGS constants and just make a note of what they are.

The main one is COGSMethod. It will be 0, 1, 2, 3 or 4.

0 = COGS is off

1 = COGS by standard costs

2 = an old setting …. Idk what it is! (Perpetual/Actual… so similar to 4?)

3 = periodic COGS

4 = COGS by actual transaction costs

Most will use 1 (e.g., House of Flags). If they don’t manufacture, they should have it set to 4 (e.g., Optimax). A handful use 3 which posts only at the end of the period rather than by transaction (e.g., SMI).

Run COGS Reports

The COGS reports are found here: Financials > Inventory > Perpetual Inventory Posting

These are the two I would run (depends what you are investigating!!):

1. Financials > Inventory > Perpetual Inventory Posting > Perpetual Inventory Transactions

2. Financials > Inventory > Perpetual Inventory Posting > Perp. Inv. Transactions -Details

Look for the transaction in question and answer these questions:

Is the transaction on the report?

Is there an account missing?

Is there a value in the sum?

Otherwise, does it look correct?

Note: the reports will show you journals from inventory transaction (like GRVs) and not necessarily the invoice journals.

Report 1

CTRL F to find the inventory transaction e.g., in this example I am looking for shipment SH23005409:

This gave two results, on for type “COGS” and one for “Cust Shipment”:

The one I am interested in is “Cust Shipment”. “COGS” is related to the invoice.

Both accounts are there and are different:

The transaction has a sum:

At this point, if the transaction looks correct on the report, but the journals look wrong on the system, I would advise the customer to check this report then run COGS: Financials > Inventory > Perpetual Inventory Posting > Post Inventry Accounting Entries

Report 2

Transaction SH23005409 exists on the report

The transaction has a debit and credit account, which are different

The sum is filled out and is correct

So, this looks good!! What to do when something is wrong?

Is the transaction on the report?

If the transaction doesn’t appear at all, check the part in question is marked an inventory controlled:

Inventory > Parts > Part Catalogue

Is there an account missing?

The transaction might not have a debit or credit account OR both are the same. The system will not create a journal in either case.

At this point you should check the account definitions. Some are set globally here:

Financials > Maintenance of Financials > Basic Data > Default Accounts > Default Accounts

There is help text under each definition which gives a useful description of each

Then some are set per part accounting family, warehouse etc. (usually part accounting family, but check the hierarchy Financials > Maintenance of Financials > Basic Data > Default Accounts > Set Up Default Accounts Wizard):

Financials > Maintenance of Financials > Basic Data > Default Accounts > Accounts for Families

Is there a value in the sum?

If the sum is 0, the system will not post a journal. Where this value comes from depends on which COGSMethod the customer uses (you should have a note of this 😉)

COGSMethod = 1

The standard cost at the time of transaction. I think this comes from here: Financials > Cost Analysis for Manufacturers > Standard Costs > Parts - Std Costs

But can be checked here: Financials > Cost Analysis for Manufacturers > Costing Results > Material Costing

OR Financials > Cost Analysis for Manufacturers > Costing Results > Product Costing

COGSMethod = 4

The transaction cost as seen in the Audit Trail: Inventory > Inventory Transactions > Audit Trail

E.g., for my shipment SH23005409:

I ignore the second line on the shipment because it is for a non-inventory part:

Otherwise, does it look correct?

These reports show you a preview of what COGS will post. If the transaction looks OK on the report, re-running COGS should post it as a journal. Advise the customer to do this and advise that they check the Perpetual Inventory Transactions report first:

Financials > Inventory > Perpetual Inventory Posting > Perpetual Inventory Transactions

Financials > Inventory > Perpetual Inventory Posting > Post Inventry Accounting Entries
