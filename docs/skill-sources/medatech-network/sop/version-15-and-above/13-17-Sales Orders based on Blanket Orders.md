# 13-17-Sales Orders based on Blanket Orders

- **Source:** `13-17-Sales Orders based on Blanket Orders.pdf`

www.priority -software.com   
1/3 Feb.16,'15 Ver. 02 Cat.No. LB10000119 
 
 SOP: Opening Sales Orders 
on the Basis of Blanket Sales Orders 
Customer:   Company Inc. 
Assigned to:  Dept./Position 
Aims 
 
A blanket sales order provides the customer with special part prices, in exchange for the customer's 
commitment to order certain quantities of the parts within a given time period. When an order is 
opened on the basis of an existing blanket order, order prices are determined according to the 
blanket order. Sales orders that are linked to a blanket order automatically update the order balance 
in the blanket order, according to the part quantities in those orders. 
You can also record a blanket order based on monetary value, in which you do not specify the 
quantities or parts to be sold but rather the total monetary value of sales to the customer in question 
within a given time period. Sales orders that are linked to a blanket order automatically update the 
order balance in the blanket order, according to the total monetary value of those orders. The 
blanket order balance is calculated based on the sales order itself, rather than the accompanying 
shipping document(s) or invoice(s). 
Procedure 
Stage I: Opening a Blanket Sales Order 
1. Enter the Blanket Sales Orders form. 
2. Specify the Customer Number. Today's date appears automatically in the Date column, and 
serves as the start date of the order agreement. Revise as needed. 
3. Specify the agreement's Expiration Date. 
4. Click the Follow-up tab and flag the Disable Auto Copy column, or leave it blank, as desired. If 
this column is not flagged, all parts in the blanket order are copied to the linked sales order; if 
flagged, parts must be recorded manually in the sales order. 
5. Click the Payment Info tab and indicate the Payment Terms and Price List assigned to this 
blanket order, as well as the Billing Customer (if this differs from the customer's usual billing 
customer). These definitions are copied automatically to any sales orders based on this blanket 
order. 
6. Enter the Itemized Blanket Order sub-level form and do one of the following: 
 If this blanket order is based on quantity, for each part included in the blanket order, record 
the Part Number, Quantity (for the entire agreement), Unit Price and Discount%, if any. 
 If this blanket order is based on monetary value, specify the Part Number “000” and the 
Quantity “1”. In the Unit Price column, specify the total monetary value of the blanket order. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb.16,'15 Ver. 02 Cat.No. LB10000119 
 
Note: You can get assistance from various sub-levels of the Itemized Blanket Order 
sub-level form as needed (e.g., Part Availability, Part Price Options, Latest Part Sales to 
Customer and Sales Order for This Item). 
7. Enter the parallel Blanket Sales Orders - Remarks sub-level form and record any additional 
remarks or instructions pertaining to the blanket order. 
8. Return to the upper-level form and change the Status to the next status, as defined in BPM 
workflow rules. 
9. Select Blanket Order Confirmation from the list of Direct Activations to print the order. 
Stage II: Opening a Sales Order on the Basis of a Blanket Order 
1. Enter the Sales Orders form. 
2. Specify the Customer Number. Today's date and an order number are filled in automatically. 
3. Click the References tab and specify the Type of Sale. 
4. Select the relevant Blanket Order. The Choose list displays all blanket orders opened for this 
customer that are still valid and have the appropriate status. 
5. Enter the Order Items sub-level form. 
6. Do one of the following: 
 If the Disable Auto Copy column was flagged in the blanket order, specify the Part Number, 
Quantity and Due Date for each order item. If the part is included in the designated blanket 
order, the Unit Price will be taken from there, but may be revised. 
 If the column was not flagged, the order has been itemized automatically. Specify the 
Quantity and Due Date for each part, revise the Unit Price as needed and delete any 
unnecessary lines. 
7. If the designated blanket order is based on quantity, the sales order is itemized automatically; 
otherwise, it must be itemized manually. 
8. Before executing the order, you can get assistance from various sub-levels of the Order Items 
form: 
 The Part Availability form displays the expected inventory levels of the ordered part, 
including open transactions. 
 The Latest Part Sales to Customer form displays the quantities and prices recorded in 
previous orders. 
9. In the Sales Orders – Remarks sub-level form, you can record text that will appear in the 
printed order confirmation. 
10. In the Attachments sub-level form, you can attach any relevant document files to the sales 
order. 
11. Return to the upper-level form and change the Status to the next status, as defined in BPM 
workflow rules. 
12. Select Order Confirmation from the list of Direct Activations to print the order. 
Results 
By linking the sales order to the blanket sales order: 
 The Value of Balance in the upper-level of the blanket order is reduced according to the total 
monetary value of the sales order.

www.priority -software.com   
3/3 Feb.16,'15 Ver. 02 Cat.No. LB10000119 
 
 In the sub-level form, Itemized Blanket Order, the Balance to Order of each part in the blanket 
order is reduced according to the quantity of that part recorded in the sales order. 
 You can view those sales orders opened for any given part in the blanket order in the next sub-
level form, Sales Orders for This Item. 
 The blanket order is closed automatically when the order balance of each item reaches 0.
