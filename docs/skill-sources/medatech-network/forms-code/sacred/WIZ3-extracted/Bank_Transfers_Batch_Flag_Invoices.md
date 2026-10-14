# Bank_Transfers_Batch_Flag_Invoices

- **Source:** `Bank_Transfers_Batch_Flag_Invoices.htm`

Bank Transfers - Preparing Batch Transfers.2 
 
 
- 
 
 
 
# To flag outstanding invoices:

 

 1 .  Run the Delete Invoice Payment Flags program. 
 

 2 .  You are about to flag all invoices that are due up to a specified payment date or that were recorded up to a designated invoice date. If there is a particular invoice within that group that you do not want to flag for payment, enter the Flag Invoices for Payment form, retrieve that invoice and flag it in the Checking column. 
 

 3 .  Run the Flag Invoices for Payment program. 
 

 4 .  Enter the Flag Invoices for Payment form to view the outstanding invoices flagged by the program (a check mark will appear in the Prepare Payment column). You can modify the contents of this column, flagging additional invoices and/or deleting flags that were inserted automatically. 
 
## Notes:

 

 ·        The program will not flag invoices from vendors for which payments are blocked (i.e., whose status in the Financial Parameters for Vendors form does not allow for payment), or whose No Payment After date (in the same form) has expired. 
 

 ·        If there are any unused credits from the vendors (e.g., debit memos, unapplied earlier payments), these will be flagged as well. The total that you need to pay will be based on all flagged items - the total sum of invoices to be paid less the total amount of credit. The unused credits and the invoices being paid will be reconciled together (along with the current payment) when the payment documents in question are finalized. 
 

 ·        Leave this form open to adjust payment amounts.
