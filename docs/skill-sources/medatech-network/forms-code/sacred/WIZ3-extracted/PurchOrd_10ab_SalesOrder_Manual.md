# PurchOrd_10ab_SalesOrder_Manual

- **Source:** `PurchOrd_10ab_SalesOrder_Manual.htm`

Purchase Orders - Recording an Order Manually Based on a Single Sales Order 
 
 
- 
 
 
 
# Manually Recording a Purchase Order Based on a Single Sales Order

 
## Before You Begin

 

 ·        Run the Track POs for Sales Orders report to view those sales order items for which purchase orders have not yet been opened. 
 
## To open the purchase order:

 

 1 .  Enter the Purchase Orders form.
 Note: At any point in the following process, you can transfer handling of the order to another employee, by specifying his/her username in the Assigned to column (in the Authorization & Follow-up tab). 
 

 2 .  Record the vendor number. The vendor name, date and order number are filled in automatically.
 Note: In the case of a one-time vendor, record the vendor number defined for one-time vendors and revise the name in the Vendor Name column. Then fill in the address and other details in the Purchase Order - Vendor Details sub-level form. 
 

 3 .  In the References tab, choose the desired sales order in the Sales Order column.
 Note: If the PCopyTxtToPO constant is set at its default value of 1 , any remarks recorded for the sale order or its line items are copied automatically into the purchase order. 
 

 4 .  If the purchase order has been opened for an existing blanket order, specify the Blanket Ord. Ordered quantities will be deducted from the balance of that blanket order. 
 

 5 .  Enter the Internal Remarks for PO sub-level form to record any remarks regarding this purchase order that you do not want to appear in the printout to the vendor.
