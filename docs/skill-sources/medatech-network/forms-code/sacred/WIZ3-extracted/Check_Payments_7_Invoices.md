# Check_Payments_7_Invoices

- **Source:** `Check_Payments_7_Invoices.htm`

Check Payments - Preparing a Single Check.3 
 
 
- 
 
 
 
# Before You Begin

 

 ·        If you work with subsidiaries, the payment may not debit the A/P account recorded in the invoice, but rather another vendor account in a different subsidiary. Similarly, a payment may cover several invoices billing different subsidiaries. In order to reconcile the payment with the invoice(s), click the Check Invoice Data tab and flag the Copy to Journal Entry column. 
 
## To indicate the invoices being paid: 

 

 1 .   In the Flag Invoices for Payment sub-level form, flag any outstanding invoices that you want to pay.
 Note: If the invoice calls for payment in installments, each installment appears on a separate line, according to its payment date. 
 

 2 .  Also flag any unused credits (e.g., previously unapplied payments, debit memos). The total that you need to pay will be based on all flagged items - the total sum of invoices to be paid less the total amount of credit. 
 

 3 .  Enter the parallel Payment Details sub-level form to view the amount of each flagged invoice (and any other flagged financial document). If a given invoice is not being paid in full – whether this is a partial payment or a payment adjustment – move to the line for that invoice and change the amount in the Sum column.
 Notes: 
 

 ·      If you have changed the invoice amount and its balance is now smaller than the value assigned to the MaxReconVar constant, the system will fully reconcile the payment and invoice and transfer the variance to the default Reconciliation Adjustments account (defined in the Default Accounts form). 
 

 ·      Dual-currency users: If the invoice currency differs from the payment currency, the invoice amount will be converted into the payment currency, using the exchange rate in effect on either the invoice or payment date. The default adjustment date is determined by the value of the I nv PayExch constant, but can be revised by flagging the Link to Invoice Date column in the Check Invoice Data tab of the payment form.
