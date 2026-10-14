# 15-17-Over-The-Counter Invoices

- **Source:** `15-17-Over-The-Counter Invoices.pdf`

www.priority -software.com   
1/3 Feb. 19, '15 Ver. 3 Cat.No. LB120252 
 
 SOP: Over-the-Counter Invoices1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record a billing (invoice) and receipt of funds in the same document. In this document, three 
operations are carried out simultaneously: an inventory transaction, a billing transaction and a 
receipt transaction. 
Setups 
 Banks and bank accounts 
 Cashiers 
 Means of payment 
 Payment terms 
 Taxes 
 Warehouses 
 Default ledger accounts and income accounts for accounting families. 
Procedure 
Stage I: Preparing an Over-the-Counter Invoice 
1. Enter the Over-the-Counter Invoices form. 
2. Select the Customer Number. The Customer Name appears automatically. 
3. Make sure that the cashier recorded in the Cashier column in the Cash Receipts & Terms tab is 
appropriate to your needs. When recording a receipt against a bank transfer, use this column to 
specify the number of the bank account to which the payment was made. 
4. If you do not want the invoice to be taken into account during credit calculations, enter the 
Invoice - Add'l Details sub-level form and make sure the Consider Credit column is not 
flagged. 
5. To link the invoice to an order: 
 If the invoice is based on a single order, specify the order number in the Order column in the 
References tab. 
 If the invoice is based on more than one order, enter the Orders for Invoice sub-level form 
and specify the orders in question. 
                                                 
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb. 19, '15 Ver. 3 Cat.No. LB120252 
 
 Alternatively, you can enter the Choose Order Items sub-level form and flag the desired 
lines. The invoice will be itemized according to the open order lines that have a supply 
balance in the selected orders. 
6. Specify the price list from which the prices will be taken (if the desired list differs from the 
customer's standard price list) by selecting a value in the Price List column (in the References 
tab). In the Shipment tab, specify the default warehouse and bin from which inventory is taken 
(you can define a different warehouse for each line; see below). 
7. Specify the parts for which the billing and the inventory transaction are taking place: 
 Enter the Invoice Items sub-level form. This form lists the parts and the quantities supplied, 
their prices and discounts. 
Note: You can choose to specify the total Price Incl. Tax for the full quantity of parts in a 
given line or the Unit Price (before tax) for a single unit of the part. 
 If the warehouse for an item differs from that appearing in the upper-level form, specify the 
Warehouse and Bin from which the current part is issued.  
 The default Income Account appears for each item, but may be revised.  
8. You can record several different types of receipt in each document: 
 Cash – Update the received sum in the Cash Receipts column in the Cash Receipts & 
Terms tab. 
 Checks – Enter the Check Details sub-level form and fill in the necessary data. 
Note for Dual-Currency Users: If the payment consists of several sequentially numbered 
checks, record the details of the first check and then select Create Additional Checks from 
the list of Direct Activations. The program automatically creates additional records for the post-
dated checks. 
 Other types (e.g., bank transfers, credit cards) – Enter the Payment by Credit Card/Coupon 
sub-level form and select the relevant type of receipt in the Payment Code column, then fill in 
the necessary data. 
Stage II: Approving an Over-the-Counter Invoice via Another User 
Aim: To have another user approve an over-the-counter invoice so that it may be finalized. 
Note: If your company does not require that an additional user approve an over-the-counter invoice 
before it may be finalized, you may skip this stage. 
To assign the over-the-counter invoice to another user for approval: 
1. Enter the Over-the-Counter Invoices form and retrieve the document in question. 
2. Assign the document to the user who needs to approve it by selecting their user name in the 
Assigned to column. 
To approve over-the-counter invoices assigned to you: 
1. Enter the Over-the-Counter Invoices form and retrieve all pending documents assigned to you. 
2. Change the status of each document to “Approved”. 
3. If it is company policy to have a third user finalize the document, transfer each over-the-counter 
invoice to a third user by selecting their user name in the Assigned to column. Otherwise, move 
directly to Stage III.

www.priority -software.com   
3/3 Feb. 19, '15 Ver. 3 Cat.No. LB120252 
 
Notes: 
 To restrict over-the-counter invoices from being finalized by the user who created them, enter 
the Financial Documents form and make sure that Disallow Single User is flagged for the 
Over-the-Counter line. 
 To additionally require that a third user finalize the over-the-counter invoice after the second 
user approves it, flag Auth. Can't Finalize as well. 
Stage III: Finalizing and Printing an Over-the-Counter Invoice 
 To finalize a single over-the-counter invoice: 
 Enter the Over-the-Counter Invoices form and retrieve the desired document. 
 Select Finalize Invoice/Memo or Finalize & Print Invoice from the list of Direct Activations. 
Note: The document will only be finalized if the total charges are identical to the total receipts. 
You can view the total receipts and the payment balance in the Cash Receipt & Terms tab. 
 To finalize a batch of over-the-counter invoices: 
 Run the Finalize Invoices program. 
 In the query form that opens, retrieve the invoices that you want to finalize. If other invoices 
were also retrieved, eliminate them from the screen by pressing F7. 
 Close the form. 
 When the program ends, you will receive a system message displaying the number of invoices 
that were finalized. If a problem was encountered while finalizing an invoice, you will receive a 
message referring you to the errors report.  
 To view the errors, run the Finalize Invoices - Errors report. 
Results 
 A journal entry is posted for each over-the-counter invoice. 
 An inventory transaction is recorded in the system. 
 The receipts enter the cashier and its contents are updated (if a cashier was selected). 
Stage IV: Canceling Receipts 
To cancel receipts, you need to delete or cancel the entire invoice. 
1. Enter the Over-the-Counter Invoices form and retrieve the desired invoice. 
2. If the invoice is pending (i.e., not yet finalized in Stage 2), set all item quantities to 0, then return 
to the upper-level form and select Delete Pending Invoice/Memo from the list of Direct 
Activations. 
3. If the invoice is final, select the relevant Direct Activation: Cancel Document (Original Date) or 
Cancel Document For Date (indicating the date in question).
