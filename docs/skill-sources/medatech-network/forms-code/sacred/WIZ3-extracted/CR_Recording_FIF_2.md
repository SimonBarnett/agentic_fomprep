# CR_Recording_FIF_2

- **Source:** `CR_Recording_FIF_2.htm`

Customer Receipts - Recording a Receipt "First Invoice First".3 
 
 
- 
 
 
 
# To flag invoices for payment:

 

 1 .  Enter the Flag Invoices for Payment sub-level form. This form lists all invoices recorded for this customer that contain a payment balance (i.e., have not yet been completely reconciled).
 Note: Financial documents crediting the customer also appear in this form, and can be flagged for reconciliation with this receipt (e.g., credit memos, advance payments that were not linked to an invoice). The total payment due consists of the sum total of the flagged invoices less the sum total of customer credit. 
 

 2 .  Flag all invoices paid for by this receipt in the Paid column.
 Note: If an invoice is split into a number of payment installments, each installment will appear on a separate line, sorted by date of payment. 
 

 3 .  Enter the parallel Invoice Amounts Being Paid sub-level form to view the amount of each flagged invoice (and any other flagged financial document). If a given invoice amount differs slightly (i.e., less than the value assigned to the MaxReconVar constant) from the received amount, move to the line for that invoice and change the amount in the Sum column to match the received amount. The system will fully reconcile the receipt and invoice and transfer the variance to the default Reconciliation Adjustments account (defined in the Default Accounts form).
 Note to dual-currency users: If the invoice currency differs from the receipt currency, the invoice amount will be converted into the receipt currency, using the exchange rate in effect either on the invoice date or the receipt date. The default adjustment date is determined by the value of the I nv PayExch constant, but can be revised by flagging the Link to Invoice Date column in the Check Invoice Data tab of the receipt.
