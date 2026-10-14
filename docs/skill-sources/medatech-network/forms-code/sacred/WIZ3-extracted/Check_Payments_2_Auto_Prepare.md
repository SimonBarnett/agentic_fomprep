# Check_Payments_2_Auto_Prepare

- **Source:** `Check_Payments_2_Auto_Prepare.htm`

Check Payments - Reviewing Batch Payments.1 
 
 
- 
 
 
 
# To review check payments:

 

 1 .  Enter the Check Payments form and retrieve all prepared payment documents by their payment date. 
Note s : 
 

 ·      The name that appears in the Vendor Name column determines what will appear on the printed check (the company or individual to whom the check will be made payable). This can be revised if necessary. 
 

 ·      To assign handling of a document to another employee, specify his/her username in the Assigned to column. If you have done so for all prepared documents, you can exit the form and ignore the following instructions. 
 

 2 .  For each document, check that all data in that form and in the following sub-level forms is correct. Make changes where needed. 
 

 ·      Payment Details – this affects the amount of the check payment and the journal entry for the payment 
 

 ·      Flag Invoices for Payment – the invoices that will be reconciled with the payment 
 

 ·      Check Payment - Add'l Details – the vendor name and address that will appear on the printed check, as well as the Form 1099 category for this payment. 
 

 3 .  If this is a partial payment, and you want to cancel the remainder of your debt, how you proceed depends on how invoices and payments are reconciled (determined by the value of the AutoRecon constant): 
 

 ·      If you reconcile "By Invoice", in the Payment Details form, specify the number of the Adjustment Account for the invoice in question. 
 

 ·      If you reconcile "First Invoice First", enter the parallel Adjustment Entry Details sub-level form and specify the desired reconciliation account in the Adjustment Entry column. 
 

 Note s : 
 

 ·      If the invoice balance is smaller than the value assigned to the MaxReconVar constant, the system will fully reconcile the payment and invoice and transfer the variance to the default Reconciliation Adjustments account (defined in the Default Accounts form). 
 

 ·      If the payment currency differs from the invoice currency, the invoice amounts will appear in this form in the payment currency, adjusted according to either the payment or invoice date; the date used is determined by the InvPayExch constant, but it may be overridden by flagging the Link to Invoice Date column in the upper-level form (in the Check Invoice Data tab).
