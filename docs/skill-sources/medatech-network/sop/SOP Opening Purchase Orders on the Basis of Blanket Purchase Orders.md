# SOP Opening Purchase Orders on the Basis of Blanket Purchase Orders

- **Source:** `SOP Opening Purchase Orders on the Basis of Blanket Purchase Orders.pdf`

Cat.No. LB10000136 1 Ver.1 – June 17,’10 
 
SOP: Opening Purchase Orders 
on the Basis of Blanket Purchase Orders* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Procedure 
A blanket purchase order represents a commitment made to a vendor to order certain 
quantities of parts within a given time period, in exchange for special prices. Actual 
purchases are recorded in purchase orders, which are linked to the blanket order and 
which automatically update its balance. 
Stage I: Opening a Blanket Purchase Order  
1. Enter the Blanket Purchase Orders form. 
2. Specify a Vendor Number. The start Date of the order agreement is filled in 
automatically with today's date, but may be revised. Specify the agreement's 
Expiration Date. 
3. Enter the Itemized Blanket Order sub-level form. 
4. For each part included in the blanket order, record the Part Number, Quantity (for 
the entire agreement) and Unit Price. 
5. Return to the upper-level form and change the Status to the next status, as defined 
in BPM workflow rules. 
Stage II: Opening a Purchase Order on the Basis of a Blanket Order 
1. Enter the Purchase Orders form. 
2. Specify the Vendor No. The Date is filled in automatically. 
3. Click the References tab: 
 Specify the Order Type. 
 Select the relevant Blanket Ord.  The Choose list displays all blanket orders 
opened for this vendor that are still in effect and have the appropriate status. 
 In the Details column, record a brief remark pertaining to the order. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. LB10000136 2 Ver.1 – June 17,’10 
4. Click the Payment Info tab to view the payment terms for the order (as defined in 
the Financial Parameters for Vendors form). Revise them as necessary. 
5. Enter the  Order Items sub-level form.  
6. For each ordered item, specify the Part Number, Quantity and Due Date. If the part 
is included in the designated blanket order, the Unit Price will be taken from there, 
but may be revised.  
7. Before updating the order's status, you can get assistance from the various sub-
levels of the Order Items form: 
 The Part Availability form displays the expected inventory levels of the ordered 
part, including open transactions. 
 The Latest Part Purchases from Vend  form displays the quantities and prices 
recorded in previous orders. 
8. In the Purchase Orders – Remarks sub-level form, you can record text that will 
appear in the order printout. 
9. In the Attachments sub-level form, you can attach any relevant document files to 
the purchase order. 
10. Return to the upper-level form and change the Status to the next status, as defined 
in BPM workflow rules. 
11. Select Print Purchase Order from the list of Direct Activations to print the order. 
Results 
 
By linking the purchase order to the blanket order, the system updates the Value of 
Balance and Balance to Order of the relevant line items in the blanket order. When 
a given blanket order item has been supplied in full, its Balance to Order will be 0 
and the item will be closed. 
 You can view these details in the sub-level form of the blanket order, Itemized 
Blanket Order. 
 You can view all purchases orders opened for any given part in the blanket order in 
the next sub-level form, PO's for This Blanket Order.  
 The blanket order will be closed automatically when the order balance of each item 
reaches 0. 
Stage III: Maintaining Versions of a Purchase Order 
1. Enter the Purchase Orders form and retrieve the desired order. 
2. To save a version of the order, select Save Version from the list of Direct 
Activations. 
Results 
 
The number of the Current Version is updated in the upper-level form. 
 Details of the saved order version are copied into the Purchase Order Versions 
sub-level form and its sub-levels. You can use these forms to view details of all 
previous versions of the current purchase order.
