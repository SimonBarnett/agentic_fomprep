# CR_Setup_Recon_2

- **Source:** `CR_Setup_Recon_2.htm`

Customer Receipts - Setup: Reconciliation Adjustments 
 
 
- 
 
 
 
# Reconciliation Adjustments

 

Sometimes there is a small discrepancy between the amount of the invoice (or invoices) and the receipt recording its payment. Priority allows you to define a threshold for such discrepancies, within which the system will automatically proceed with reconciliation. 
 

To do so, you must specify the maximum variance that will still allow reconciliation and define a default account for reconciliation variances. Consequently, when recording a customer receipt, if you change an invoice amount slightly to match the received amount, the system will nevertheless reconcile the journal entries (ignoring the small balance in the invoice) and record the variance in the default account. 
 
## To define the maximum variance for reconciliations:

 

 ·        Enter the Financial Constants form and record the desired sum as the value of the MaxReconVar constant.
 Note: This constant also affects reconciliations between payments to vendors and purchasing invoices. 
 
## To define a default Reconciliation Adjustments account:

 
## Note:

 

If the Account Initialization program (or the Account Initialization-Intl program, for dual-currency users) was run, the default account has already been set up for you. In that case, skip this section. 
 

 1 .  Enter the Chart of Accounts form and define the account.
 Tip: For more information, run the Open GL Accounts Wizard . 
 

 2 .  Enter the Default Accounts form and move to Reconciliation Adjustments . 
 

 3 .  In the Account No. column, select the number of the GL account into which reconciliation variances are to be transferred. 
 Tip: For more information, run the Set Up Default Accounts Wizard . 
 
## Note: 

 

Click to perform additional setups .
