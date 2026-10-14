# 13-15-Sales Order from Quote

- **Source:** `13-15-Sales Order from Quote.pdf`

Cat.No. LB10000146 1 Ver.1 – June 6,’10 
 
SOP: Opening a Sales Order  
on the Basis of a Price Quote* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of opening a sales order in the system on the 
basis of a price quote recorded in the system and sent to a customer. Price quotes can 
be linked to an unlimited number of sales orders. 
Procedure 
Stage I: Recording a New Price Quote 
1. Enter the Price Quotations for Customers form. 
2. Specify the Customer No.; the Quote Number appears automatically. 
3. Specify the customer's Contact, if it does not appear automatically. The printed quote 
will be referred to this person. 
4. The current date appears automatically in the Quote Date column. Revise as 
needed. 
5. The quote's Expiration Date appears automatically, as the date 30 days from the 
current date. Revise as needed. 
6. In the Price tab, the Copy All column is flagged automatically. This indicates that all 
items appearing in the Itemized Quotation sub-level form will be copied 
automatically to all sales orders based on the quote. Remove the check mark to 
itemize such orders manually. 
Note: In a manually itemized sales order based on this price quote, prices and 
discounts will be copied from the quote when you record the corresponding part 
number. 
7. Click the References tab and specify the relevant Price List, if any, on which the 
quote is based. 
8. In the Follow-up tab, specify the date by which the quote should be sent to the 
customer in the Send Before column.  
9. In the Payment Info tab, make sure that the Payment Terms are correct. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. LB10000146 2 Ver.1 – June 6,’10 
10. Enter the Itemized Quotation sub-level form. 
11. Record the Part Number of the quoted item. 
12. In the Qty column, specify the minimum order quantity for which the quoted price is 
valid. If you want to offer different unit prices for different quantities, open a separate 
line for each quantity using the same part number. 
13. If the Unit Price appears automatically, make sure it is correct. Otherwise, record it 
manually. The Price Source column displays the source from which the unit price is 
derived (e.g., manual entry, price list). If you want to award the customer a discount 
for a given part, specify the desired percentage in the Discount% column. 
14. Specify the number of Supply Days needed to supply this part to the customer. 
15. After itemizing the price quote, return to the upper-level form and close the quote by 
changing its Status. 
16. To print the quote, click Print Price Quotation from the list of Direct Activations. 
Stage II: Opening a Sales Order Based on a Price Quote 
1. Enter the Sales Orders form. 
2. Specify the Customer No. The Cust. Name, Date and Order No. are filled in 
automatically. The order's opening Status is "Draft". 
3. Enter the  Active Price Quotations sub-level form. This form displays all valid price 
quotations with the appropriate status, on which you can base the order. If a quote is 
flagged in the Copy All column, all of the quoted items will be copied automatically to 
the sales order, with their quantities, prices, dates and so on. If it is not, you can 
choose which quoted items to include in the order, and the corresponding prices and 
discounts will be copied automatically into the order. 
4. Return to the upper-level form. In the References  tab, select the desired Price Quote 
from the Choose list. The same quote can be linked to any number of sales orders. 
5. Record the customer's purchase order number in the Cust's PO  column. 
6. Enter the Order Items sub-level form. 
7. If all quote items were copied automatically  to the order, delete any irrelevant items 
(that were not ordered by the customer). Otherwise, specify the Part Number, 
Quantity and Due Date of every ordered item. The Unit Price and Discount% are 
filled in automatically. 
8. You can review Part Availability  and Latest Part Sales to Customer in the 
appropriate sub-levels of the Order Items form, if desired. 
9. Enter the parallel Sales Orders – Remarks  sub-level form to add comments 
regarding the order, if desired. This text will appear in the printed order confirmation. 
10. Return to the upper-level form and check the order's Total Before Discount . 
11. In the Follow-up tab, change the order's Status. 
12. To print the order confirmation, click Order Confirmation from the list of Direct 
Activations.
