# PurchOrd_10aa_SalesOrder_Auto

- **Source:** `PurchOrd_10aa_SalesOrder_Auto.htm`

Purchase Orders - Recording an Order Automatically Based on a Sales Order.1 
 
 
- 
 
 
 
# Opening Purchase Orders Automatically From Within a Sales Order

 
## Before You Begin

 

 ·        Run the Track POs for Sales Orders report to view those sales order items for which purchase orders have not yet been opened. 
 

 ·        If the PCopyTxtToPO constant is set at its default value of 1 , any remarks recorded for the sales order or its line items are copied automatically into the purchase order. 
 
## To open the purchase orders:

 

 1 .  Enter the Sales Orders form and retrieve the sales order in question. 
 

 2 .  Do one of the following: 
 

 ·              To open a single purchase order for a single chosen vendor, skip to the next step. 
 

 ·              To open a separate purchase order for the preferred vendor of each part, skip to the next step. 
 

 ·              To open separate purchase orders for some of the order items, enter the Order Items sub-level form and fill in the Vendor for PO column for each item that you want to order. To use the part's preferred vendor, flag the Copy Preferred Vend column and the vendor is filled in automatically. 
 

 Note: Preferred vendors are assigned to purchased parts in the Purchase/MRP Parameters for Part form. For details, run the Vendor Parts and Prices Wizard . 
 

 3 .  Select Open Purchase Ord from Sales Ord from the list of Direct Activations of the upper-level Sales Orders form, and select the appropriate option. 
 
## To check and update the purchase orders:

 

 ·        Enter the Purchase Orders form and retrieve the newly created order(s).
 Tip: Retrieve by today's Date .
