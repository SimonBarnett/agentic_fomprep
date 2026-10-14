# AccRec_retroactive_2

- **Source:** `AccRec_retroactive_2.htm`

Account Reconciliation - Retroactive Reconciliation.7 
 
 
- 
 
 
 
# Reconciling the Entry Amounts

 

 1 .  For each unreconciled entry item, enter the Flag Invoices for Payment sub-level form. This form lists all invoices recorded for this customer that contain a payment balance (i.e., have not yet been completely reconciled). Flag all invoices paid for by this receipt, whether fully or partially, in the Paid column.
 Note: If an invoice is split into a number of payment installments, each installment will appear on a separate line, sorted by date of payment. 
 

 2 .  Move to the adjacent sub-level form, Split Amount . A line has been recorded for each of the flagged invoices. 
 

 3 .  Change the value of the Sum column for any invoice that is not fully paid. The invoices will continue to appear in the aging reports until the entire sum is paid.
 Tip : Whenever you record a due date, the balance of the entry is automatically filled in, in the Sum column, for your convenience. Change this as necessary. 
 

 4 .  If there is variance between the receipt amount and the sum total of invoice amounts (beyond the small discrepancy covered by the MaxReconVar constant ), move to the next line and flag the Remainder column. The unreconciled balance will appear in the Sum column. 
 

 5 .  To record an adjustment entry for the variance, which will be automatically reconciled with the receipt and flagged invoices, specify the number of the reconciliations adjustment account in the Adjustment Account column. 
 

 6 .  The changes you have made are still temporary. To actually update the reconciliation data, return to the upper-level form and select Update Reconciliation Amounts from the list of Direct Activation s . 
 

 7 .  Retrieve all records in this form again. If you are working in the ledger, the reconciled items will no longer appear. If you are working in the entry journal, they appear with a reconciliation number. 
 
## Notes:

 

 ·        Click to undo the update of reconciliation data if you are not satisfied with results. 
 

 ·        Click to return to the main screen .
