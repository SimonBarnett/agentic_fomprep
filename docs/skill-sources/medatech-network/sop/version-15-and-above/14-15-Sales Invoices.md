# 14-15-Sales Invoices

- **Source:** `14-15-Sales Invoices.pdf`

Cat.No. LB10000420 1 Ver.1 – Sep. 14,’10 
 
SOP: Sales Invoices* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aim 
 To produce a sales invoice, which is used to create both a journal entry and 
inventory transactions for the shipped parts. 
Procedure 
Stage I: Recording a Sales Invoice 
1. Enter the Sales Invoices form. 
2. Specify the Customer Number and appropriate customer Contact. A temporary 
Invoice No. number (with the prefix T) is assigned when you leave the column. 
3. Today's Date appears automatically, but may be revised.  
4. In the Price tab, the customer's default Currency appears automatically, but may 
be revised. 
5. Click the References tab, and link the invoice to the relevant customer Order, if 
any. 
6. If you do not want the invoice to be taken into account during credit calculations, 
enter the Invoice - Add'l Details sub-level form and make sure the Consider 
Credit column is not flagged. 
7. Enter the Invoice Items sub-level form. 
8. If the invoice is linked to a sales order, the order items appear automatically. 
Otherwise, for each billed part, specify the Part Number, Quantity, Unit Price, 
% Item Discount and profit centers, if applicable. 
Notes: 
 For each line item, you can record an Income Account that differs from the 
default (this will be the contra account in the journal entry created for the 
invoice). 
 You can choose to specify the total Price Incl. Tax for the full quantity of parts 
in a given line, rather than recording the Unit Price (before tax) for a single unit 
of the part. 
9. Enter the parallel Shipping Address sub-level form. These details are filled in 
automatically with the customer site address, but may be revised. This address 
appears on the invoice printout. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Cat.No. LB10000420 2 Ver.1 – Sep. 14,’10 
10. If there are special payment terms for this invoice, enter the parallel Payment 
Installments sub-level form and define those terms. 
11. Return to the upper-level form. In the Price tab, check the invoice totals and 
discounts. 
12. Return to the upper-level form. 
13. Finalize and/or print the invoice by selecting Finalize Invoice/Memo or Finalize 
& Print Invoice from the list of Direct Activations. 
Results 
 A journal entry is created for the invoice, and inventory transactions are created 
for the billed parts. 
 The invoice is assigned a permanent number (without the prefix T). 
Stage II: Canceling a Sales Invoice 
 If the invoice is still pending (that is, the Finalize Invoice/Memo program has not 
yet been run - see Step 11 in Stage I), set all item quantities to 0, then return to 
the upper-level form and select Delete Pending Invoice/Memo from the list of 
Direct Activations. 
 To cancel a final sales invoice for the original invoice date, select Cancel 
Document (Original Date) from the list of Direct Activations. 
 To cancel a final sales invoice for a designated date, select  Cancel Document 
For Date from the list of Direct Activations (and indicate the date in question). 
Results (when the invoice was final) 
 The procedure opens a cancellation invoice and a corresponding reversing 
journal entry, dated according to the chosen cancellation program (the original 
invoice date or the date the program was run). 
 In the original invoice, the Canceled column is automatically flagged (in the Price 
tab). 
 Any reconciliations for the original invoice are cancelled.
