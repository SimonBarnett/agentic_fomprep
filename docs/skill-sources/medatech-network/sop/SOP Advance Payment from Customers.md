# SOP Advance Payment from Customers

- **Source:** `SOP Advance Payment from Customers.pdf`

Cat.No.A8000106 1 Ver.2 – Oct.27,’11 
 
SOP: Advance Payment from Customers* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To document an advance payment on the basis of a multi-shipment invoice, link the 
payment to a sales order, and deduct the advance from the invoice amount. 
Working Assumptions 
 The shipped goods will be documented in a customer shipment document (rather 
than a sales invoice). 
 Only multi-shipment invoices are used to bill the customer in question. 
Procedure 
Stage I: Recording the Prepay Percentage to be Deducted from the 
Invoice 
1. Enter the Sales Orders form. 
2. Retrieve the order in question. 
3. Click the Payment Info tab. In the % Advance Payment to Deduct column, specify 
the amount to deduct. This is the amount to deduct from all multi-shipment invoices 
opened for this sales order, until the balance of the advance payment is reduced to 
0. 
4. Make sure the  Status of the sales order allows shipment to the customer. 
Stage II: Recording an Invoice for the Advance Payment 
1. Enter the Multi-Shipment Invoices form. 
2. Specify the Customer No. 
Note: The invoice is assigned a temporary number (beginning with "T"). When the 
invoice is finalized, it will receive a permanent number. 
3. Click the References tab. In the Order column, specify the sales order for which the 
advance payment was received. 
4. Click the Financial Terms tab and flag the Advance Payment column. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No.A8000106 2 Ver.2 – Oct.27,’11 
5. Enter the Invoice Items sub-level form. A single invoice line appears automatically 
with the value "Prepay" in the Part Number column. 
6. In the Unit Price column, specify the prepaid amount. Make sure the Taxable 
column is flagged. 
7. Return to the upper-level form and select Finalize Invoice/Memo from the list of 
Direct Activations. 
Stage III: Recording a Multi-Shipment Invoice for the Shipped Goods 
Working Assumption: The shipped goods were recorded in a customer shipment 
document. 
1. Enter the Multi-Shipment Invoices form. 
2. Specify the Customer No. 
3. Click the References tab. In the Document Column, specify the relevant customer 
shipment document. 
Note: The invoice can only be based on a single shipping document. 
4. Enter the Invoice Items sub-level form. The invoice is itemized automatically on the 
basis of the specified shipping document. In addition, an extra line appears with the 
value "Prepay" in the Part Number column, and a Quantity of "-1". The Unit Price 
column displays the amount of the advance payment to be deducted from the 
invoice, calculated by multiplying the defined percentage by the invoice amount. The 
system automatically reduces the balance of the advance payment until it reaches 0. 
5. After you finish filling in the invoice items, return to the upper-level form and finalize 
the invoice. 
Stage IV: Tracking the Advance Payment Balance 
1. To view the remaining balance of the advance payment, enter the Sales Orders 
form. 
2. Retrieve the order in question.  
3. Click the Payment Info column. The Advance Payment Balance column displays 
the sum that remains to be deducted.
