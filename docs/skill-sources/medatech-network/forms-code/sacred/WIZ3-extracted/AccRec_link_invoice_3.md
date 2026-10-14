# AccRec_link_invoice_3

- **Source:** `AccRec_link_invoice_3.htm`

Account Reconciliation - Reconciliation Adjustments 
 
 
- 
 
 
 
# Setting Up Reconciliation Adjustments

 

Sometimes there is a small discrepancy between the amount of the invoice (or invoices) and the payment. Priority allows you to define a threshold for such discrepancies, below which the system will automatically proceed with reconciliation. 
 

To do so, you must specify the maximum variance that will still allow reconciliation and define a default account for reconciliation variances. Consequently, when you record a receipt or vendor payment whose sum is slightly different from the invoice(s) to which it is linked, the system will reconcile the journal entries and record the variance in the default account. 
 
## To define the maximum variance for reconciliations:

 

 ·        Enter the Financial Constants form and record the desired sum as the value of the MaxReconVar constant. 
 
## To define a default Reconciliation Adjustments account:

 
## Note:

 

If the Account Initialization or Account Initialization-Intl program was run, the default account has already been set up for you. In that case, skip this section. 
 

 1 .  Enter the Chart of Accounts form and define the account.
 Tip: For more information, run the Open GL Accounts Wizard . 
 

 2 .  Enter the Default Accounts form and move to Reconciliation Adjustments . 
 

 3 .  In the Account No. column, select the number of the GL account into which reconciliation variances are to be transferred. 
 Tip: For more information, run the Set Up Default Accounts Wizard .
