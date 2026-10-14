# COGSIssue

- **Source:** `COGSIssue.docx`

The problem we have found is that COGS duplicates the Credit of Unbilled Shipments, when the shipment has a mix of billable and non-billable lines.

The problem has been brought to our attention by customer Spectrum Medical who are on version 16.3. I was then able to replicate the problem on my local 17.1 installation.

I set up accounts for the warehouse

My COGS constants are:

I created two parts and gave them each a standard cost.

I then ran a past balance and costing for end of October

Then I GRV’d in some of the parts to the warehouse.

I then made a shipment and invoice dated in November. This shipment had one line as billable and one line as not billable.

I did a multi shipment invoice for the shipment also dated in November.

I then ran a past balance and costing for the end of November.

I then ran Post Cost of Goods Sold.

The duplicated line is only apparent in the transactions, not in the COGS reports.

The entry which has the COGS material as debit and Purchases/Inventory as the debit is the one which shows the mistake.

If you look at the suspect journal entry above

1) The first two lines correctly credit Inventory and debit COGS Material for the non-billable element of the transaction.

2) The second two lines incorrectly credit unbilled shipments and debit Inventory, reversing out the billable element of the transaction.
