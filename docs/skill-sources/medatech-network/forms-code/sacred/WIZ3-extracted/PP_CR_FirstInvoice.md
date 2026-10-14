# PP_CR_FirstInvoice

- **Source:** `PP_CR_FirstInvoice.htm`

PP_CR_FirstInvoice 
 
 
- 
 
 
 

When using this method, any difference between the amount paid (i.e., the receipt) and the amount owing (i.e., the invoice) leads to the automatic creation of an adjustment entry to cover the variance. This method allows you to view matching debits and credits directly in the ledger, but does not allow for easy tracking of partial payments in the aging reports, as the reconciliation adjustment is displayed as an outstanding debt which is not tied to a particular invoice. 
 

If the variance is smaller than the amount designated in the MaxReconVar constant (in the Financial Constants form), it is recorded automatically against the default Reconciliation Adjustments account. If the amount is larger, it will be recorded automatically as an outstanding debt against the customer`s account. However, if an adjustment account is specified when recording the receipt, reconciliation will occur even if the variance is large.
