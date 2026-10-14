# 16-17-Customer Shipments and Returns

- **Source:** `16-17-Customer Shipments and Returns.pdf`

www.priority -software.com   
1/3 Feb. 26, '15 Ver. 2 Cat.No. LB140064 
 
 SOP: Customer Shipment and Return1 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To record the shipment of goods to a customer either on the basis of a sales order or manually. 
 To record the return of goods from a customer, thus restoring the shipped goods to inventory. 
Procedure 
Recording a Customer Shipment on the Basis of a Sales Order 
1. Enter the Customer Shipments form. 
2. Specify the Customer No. The Customer Name, Date and Doc. Number are filled in 
automatically. 
3. In the General tab, the default Sending Warehouse appears, as defined for shipping 
documents in the Inv. Transaction Documents form. Revise as needed. 
4. Do one of the following: 
 To link the shipping document to a single sales order, click the References tab and select the 
Order from the Choose list. 
Note: The list displays all open orders from the customer in question with the appropriate 
status. 
 To link the document to multiple orders, enter the Sales Orders for Shipment sub-level form 
and select the relevant orders. 
Note: The Order column Choose list displays all open orders from the customer in question 
with the appropriate status. 
 To link the document to specific lines in one or more sales order, enter the Choose Order 
Items sub-level form after linking the relevant order(s), and flag the desired lines in the 
Choose Item column. 
5. Enter the Shipped Items sub-level form. All of the selected items from the linked orders are 
displayed. 
6. For each line, check the quantity appearing in the Warehouse Balance column, and do one of 
the following: 
 If the balance is sufficient to supply the ordered quantity and you want to fill the entire order, 
flag the Approve column. The value in the Balance to Ship column is then copied into the 
Quantity column. 
Note: By default, the system uses the lower of the two values in the Balance to Ship and 
Warehouse Balance columns. 
                                                
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/3 Feb. 26, '15 Ver. 2 Cat.No. LB140064 
 
 If the warehouse balance is not sufficient, or you do not want to ship the entire ordered 
quantity, fill in the Quantity column manually. If you specify a quantity larger than the 
available inventory balance, the system will display a warning regarding negative inventory. 
 To approve all lines in the order simultaneously, return to the upper-level form and run the 
Approve All Items program from the list of Direct Activations. 
7. In the sub-level form, the Unit Price is taken from the linked order item, as can be seen in the 
Price Source column. You can revise the price as needed. 
8. If the inventory is pallet controlled, specify the number of the Pallet from which to ship the 
current item. 
9. Return to the upper-level form and change the Status to the next one defined in the BPM 
workflow for shipping documents. 
10. To make revisions to the document after it is final, choose one of the following options:  
 Select Reopen Document from the list of Direct Activations. The program returns the 
document to the "Draft" status. Make the necessary revisions and change the status to the 
next one in the workflow. 
 Enter the Revision of Final Shipping Doc. or Revision of Final Ship Doc Items form and make 
the necessary revisions. 
Note: You cannot update any columns that have been grayed out in these forms. 
11. To print the document, select Print Shipping Document from the list of Direct Activations. 
Results 
 An inventory transaction is recorded in the system even before the shipping document is 
finalized. The inventory balance in the sending warehouse is reduced according to the shipped 
quantity. 
 The supply balance in the linked sales order is updated automatically, and any order items that 
have been fully supplied as a result are flagged as Closed. If all items in the order are now fully 
supplied, the order itself is flagged as Closed. 
Recording a Customer Shipment Manually 
1. Enter the Customer Shipments form. 
2. Specify the Customer No. The Customer Name, Date and Document No. are filled in 
automatically. 
3. In the General tab, the default Sending Warehouse appears, as defined for shipping 
documents in the Inv. Transaction Documents form. Revise as needed. 
4. Enter the Shipped Items sub-level form.  
5. For each shipped item, specify the Part Number and Quantity. 
6. If the part is listed in the Base Price List, or if the customer is linked to a specific price list, the 
Unit Price appears automatically, and the source is displayed in the Price Source column. If no 
price appears, record it manually. 
7. If the inventory is pallet controlled, specify the number of the Pallet from which to ship the 
current item. 
8. Return to the upper-level form and change the Status to the next one defined in the BPM 
workflow for shipping documents. 
9. To make revisions to the document after it is final, choose one of the following options:

www.priority -software.com   
3/3 Feb. 26, '15 Ver. 2 Cat.No. LB140064 
 
 Select Reopen Document from the list of Direct Activations. The program returns the 
document to the "Draft" status. Make the necessary revisions and change the status to the 
next one in the workflow. 
 Enter the Revision of Final Shipping Doc. or Revision of Final Ship Doc Items form and make 
the necessary revisions. 
Note: You cannot update any columns that have been grayed out in these forms. 
10. To print the document, select Print Shipping Document from the list of Direct Activations. 
Recording a Customer Return 
1. Enter the Customer Returns form. 
2. Specify the Customer No. The Customer Name, Date and Document number are filled in 
automatically. 
3. In the General tab, indicate the Receiving Warehouse into which the customer goods are 
returned. 
4. To link the return document to a sales order, service call or customer shipment, click the 
References tab and specify the document number in the relevant column. 
5. If the current document is linked to a customer shipment and the shipped items are defined for 
pallet control, flag the Return to Pallet column if you want the inventory to be returned to the 
pallets from which they were originally shipped.  
6. Enter the Returned Items sub-level form. 
7. If the return is linked to another document, all of the items in the linked document are displayed. 
If the returned quantity is identical to that appearing in the Shipped Quantity column, flag the 
Approve column. The shipped quantity is then copied into the Quantity column. If not, record 
the returned quantity manually. 
8. If the return is not linked to another document, it must be itemized manually. For each returned 
item, specify the Part Number and Quantity. 
9. Return to the upper-level form and change the Status to the next one defined in the BPM 
workflow for customer returns. 
10. To make revisions to the document after it is final, choose one of the following options:  
 Select Reopen Document from the list of Direct Activations. The program returns the 
document to the "Draft" status. Make the necessary revisions and change the status to the 
next one in the workflow. 
 Enter the Revision of Final Return Doc. form and make the necessary revisions. 
Note: You cannot update any columns that have been grayed out in this form. 
Results 
 If the document is linked to a sales order, the supply balance of each returned part is updated 
automatically in the order, according to the value of the SOpenOrder constant (defined in the 
Logistic Constants form). 
 The inventory of each returned part in the receiving warehouse is increased according to the 
returned quantity.
