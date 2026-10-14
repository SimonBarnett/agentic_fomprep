# 12-17-Holding Invoices

- **Source:** `12-17-Holding Invoices.pdf`

www.priority -software.com   
1/3 Feb. 11,'15 Ver.02 Cat.No. LB09000309 
 
 SOP: Holding Invoices 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To prepare a holding invoice on the basis of an existing sales order, and store the invoiced 
goods in a holding warehouse before they are sent to the customer. 
Setups 
 Define financial parameters for customers in the Financial Parameters for Customers form. 
 Define a holding warehouse: 
1. In the Warehouses form, specify the Warehouse and Warehouse Descrip.. 
2. In the General tab: 
o Specify "W" in the Type (D/F/W) column. The Ignored by Planning column is flagged 
automatically. 
o Leave the Inventory Valued and Transaction Costing columns unflagged. 
o Flag the Inv. by Customer column. 
Procedure 
Stage I: Recording a Holding Invoice Based on a Sales Order 
1. Enter the Sales Invoices form. 
2. Specify a Customer Number. The Customer Name and today's Date are filled in automatically. 
3. Specify the relevant invoice Contact, if desired. 
4. Do one of the following: 
 To base the invoice on one sales order, click the References tab and specify the relevant 
order number. Details are filled in automatically from the order, but may be revised. 
 To base the invoice on multiple sales orders, leave the Order column blank, and enter the 
Orders for Invoice sub-level form. Record a line for each order billed by the current invoice. 
Return to the upper-level form and record a brief remark in the Details column, if desired.  
 To select individual order items to be shipped and billed, enter the Choose Order Items sub-
level form and flag the Choose Item column for each relevant item. Return to the upper-level 
form and record a brief remark in the Details column, if desired. 
5. In the upper-level form, click the References tab and check the Sales Rep No. and Branch 
columns to make sure that the correct sales rep and branch appear. Change if necessary. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb. 11,'15 Ver.02 Cat.No. LB09000309 
 
6. Click the Shipment tab. 
 Select a sending Warehouse and Bin (if necessary). The warehouse description appears 
automatically. 
 Specify the Holding Warehouse where goods will be stored before being sent to the 
customer. The warehouse description appears automatically. 
7. Enter the Invoice Items sub-level form.  
 The ordered parts are filled in automatically from the sales order(s) linked to the invoice. 
 To approve quantities, flag the Approve column for each item.  
8. Enter the parallel sub-level form, Invoice/Memo - Remarks, to record or revise the invoice 
remarks. These remarks will appear in the printout of the invoice. 
9. Return to the upper-level form and click the Price tab. Make sure all columns have been filled in 
correctly. 
10. To finalize the invoice, select Finalize Invoice/Memo from the list of Direct Activations. 
11. To print the invoice, select Print Sales Invoice from the list of Direct Activations. 
Note: When a final invoice is printed, the invoice is flagged as Printed. 
12. To check the status of the sales order, click the References tab, move to the Order column and 
press F6 twice. This will open the relevant order in the Sales Orders form. 
Results 
 After each invoice item is approved, the parallel order item is closed (in part or in full) and the 
inventory in question is transferred to the holding warehouse, receives the relevant customer 
number as its Status, is not available for general sale and is not subject to inventory valuations, 
nor used as a basis for planning. 
 A journal entry is created automatically when the invoice is finalized. 
Stage II: Recording a Holding Invoice Not Based on a Sales Order 
1. Enter the Sales Invoices form. 
2. Specify a Customer Number. The Customer Name and today's Date are filled in automatically. 
3. Specify the relevant invoice Contact, if desired. 
4. Click the References tab: 
 In the Details column, record a brief remark regarding this invoice. 
 Check the Sales Rep No. and Branch columns to make sure that the correct sales rep and 
branch appear. Change if necessary. 
5. Click the Shipment tab. 
 Select a sending Warehouse and Bin (if necessary). The warehouse description appears 
automatically. 
 Specify the Holding Warehouse where goods will be stored before being sent to the 
customer. The warehouse description appears automatically. 
6. Enter the Invoice Items sub-level form and fill in the relevant parts, including quantities and 
prices. 
7. Return to the upper-level form and click the Price tab. Make sure all columns have been filled in 
correctly.

www.priority -software.com   
3/3 Feb. 11,'15 Ver.02 Cat.No. LB09000309 
 
8. To finalize the invoice, select Finalize Invoice/Memo from the list of Direct Activations. 
9. To print the invoice, select Print Sales Invoice from the list of Direct Activations. 
Note: When a final invoice is printed, the invoice is flagged as Printed. 
Results 
 After each invoice item is recorded, the inventory in question is transferred to the holding 
warehouse, receives the relevant customer number as its Status, is not available for general 
sale and is not subject to inventory valuations, nor used as a basis for planning. 
 A journal entry is created automatically when the invoice is finalized. 
Stage III: Manually Recording a Non-billable Shipping Document 
1. Enter the Customer Shipments form. 
2. Specify a Customer Number. The Customer Name and today's Date are filled in automatically, 
and a new Doc. Number is generated. 
3. Click the General tab. A default Sending Warehouse is filled in automatically. Specify the 
relevant holding warehouse instead. 
4. Click the Price tab and make sure the Billable column is not flagged. 
5. Enter the Shipped Items sub-level form. 
6. For each item, specify a Part Number and the Quantity to be shipped. 
7. Make sure the From Status is defined with the relevant customer number, and the To Status is 
defined as "Goods". 
8. Return to the upper-level form and revise the Status in accordance with the BPM flow chart. 
9. To print the shipping document, select Print Shipping Document from the list of Direct 
Activations, choosing the appropriate print format. 
10. To revise a closed shipping document, select Reopen Document from the list of Direct 
Activations. The document's Status reverts to "Draft". When you are finished making the 
necessary revisions, assign the document the next status.
