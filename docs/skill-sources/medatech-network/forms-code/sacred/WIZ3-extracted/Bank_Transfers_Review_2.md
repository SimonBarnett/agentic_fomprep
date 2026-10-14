# Bank_Transfers_Review_2

- **Source:** `Bank_Transfers_Review_2.htm`

Bank Transfers - Reviewing Batch Documents.2 
 
 
- 
 
 
 

 3 .  If this is a partial payment, and you want to cancel the remainder of your debt, how you proceed depends on how invoices and payments are reconciled (determined by the value of the AutoRecon constant): 
 

 ·      If you reconcile “By Invoice”, in the Payment Details form, specify the number of the Adjustment Account for the invoice in question. 
 

 ·      If you reconcile “First Invoice First”, enter the parallel Adjustment Entry Details sub-level form and specify the desired reconciliation account in the Adjustment Entry column. 
 

 ·      Note: If the invoice balance is smaller than the value assigned to the MaxReconVar constant, the system will fully reconcile the payment and invoice and transfer the variance to the default Reconciliation Adjustments account (defined in the Default Accounts form). 
 

 4 .  Set text appears in the Bank Transfer - Remarks sub-level form. You can revise or add to it, as desired. These remarks will appear on printed notifications to the bank and to the vendor. 
 

 5 .  If a given bank transfer needs to be checked before notification is sent to the bank, return to the upper-level form and assign it the Checking status (in the References tab). In the Assigned to column, specify the username of the person who is responsible for checking the document. The transfer cannot be finalized until this status is changed.
 Tip: You can define work flow rules so that the assigned user changes automatically when the status is assigned. 
 
## Notes:

 

 ·        Click to finalize the bank transfer documents . 
 

 ·        Click to return to the main screen.
