# 16-17-Opening PO from Sales Order

- **Source:** `16-17-Opening PO from Sales Order.pdf`

www.priority -software.com   
1/2 Feb. 19, '15 Ver. 2 Cat.No. LB130511 
 
 SOP: Opening Purchase Orders 
on the Basis of Sales Orders1 
Customer:   Company Inc.  
Assigned to:  Dept./Position  
Aim 
 To open a purchase order automatically from within a sales order, or to link a purchase order 
manually to an existing sales order. 
Working Assumptions 
 It is assumed that there are sales orders recorded in the system. 
 Run the Track POs for Sales Orders report to view open sales order items for which purchase 
orders have not yet been opened. 
Procedure 
Stage I: Opening a Purchase Order Automatically from a Sales Order 
1. Enter the Sales Orders form and retrieve the desired order. 
2. Select Open Purch Ord from Sales Ord from the list of Direct Activations. You can choose 
between opening an order for the preferred vendor defined for each part in the sales order, and 
opening an order for a designated vendor. 
3. Skip to Stage III to check the new purchase order and record additional details. 
Result 
 The system opens a new purchase order, itemized according to the sales order, with the sales 
order number appearing in the References tab. A message notifies the user of the new 
purchase order's number. 
Stage II: Opening a Purchase Order Manually on the Basis of a Sales Order 
1. Enter the Purchase Orders form. 
2. Record the Vendor No. The Vendor Name, Date and Order No. are filled in automatically. 
Note: For a one-time vendor, record the vendor number defined for one-time vendors and 
change the vendor name. Record the vendor's contact info and other details in the Purchase 
Order – Vendor Details sub-level form. 
3. Click the References tab and select the desired Sales Order.  
Result 
 The purchase order is itemized automatically according to the sales order. 
                                                 
1 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Feb. 19, '15 Ver. 2 Cat.No. LB130511 
 
Stage III: Checking and Revising the Purchase Order 
1. Enter the Purchase Orders form and retrieve the new purchase order. Make sure the details that 
are already recorded are correct. 
2. The vendor's default purchase order contact appears in the Contact column. Revise as 
necessary. 
Tip: To define new contacts for the vendor, or a default contact for purchase orders, use the 
Vendor Contacts sub-level of the Vendors form. 
3. Click the References tab and fill in the necessary details, such as Details, the Warehouse and 
Bin into which the ordered goods are to be received, Shipment Mode and Type of Order. 
Note: The warehouse defined here affects the shipping address that appears on the order 
printout. 
4. Click the Payment Info tab and check the Payment Terms for the order. Revise them as 
necessary. 
Note: To define more detailed payment terms, use the Payment Terms for Order sub-level 
form. 
5. Dual-currency users: Check the VAT Code defined for the order (in the Payment Info tab) and 
revise as necessary. 
6. Enter the Order Items sub-level form. The order is itemized automatically according to the 
linked sales order. Delete any unnecessary lines, or add new ones. 
7. For each line item, make sure the Quantity is correct. To check existing and expected inventory 
balances, enter the Inventory for Part and Part Availability sub-level forms. 
8. Make sure the recorded price and discount are correct.  
Notes:  
 You can compare these to prices in other recent orders, displayed in the Latest Part 
Purchases from Vend sub-level form. 
 If the Cost column in the sales order item was filled in manually, that value is used as the unit 
price in the purchase order. Otherwise, the price is filled in according to the standard vendor 
price hierarchy. 
9. The Due Date is taken automatically from the corresponding sales order item, but may be 
revised. 
10. Enter the Order Items – Remarks sub-level of the Order Items form, and check the recorded 
text. Revise it as needed. 
11. To split the expense of a given item between several profit/cost centers, use the parallel sub-
level form, Split Among Profit/Cost Centers. 
12. Return to the upper-level form and click the Price tab. Check the purchase order's Final Price. 
13. If the purchase order needs to be authorized before it is sent to the vendor, prepare the order for 
authorization: 
 Click the Authorization & Follow-up tab and assign the appropriate Status. 
 Copy the name in the Next Signature column to the Assigned to column. 
14. When the order is fully authorized according to the company procedure, send it to the vendor, by 
fax or mail.
