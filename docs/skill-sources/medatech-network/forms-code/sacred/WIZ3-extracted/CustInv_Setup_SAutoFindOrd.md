# CustInv_Setup_SAutoFindOrd

- **Source:** `CustInv_Setup_SAutoFindOrd.htm`

Customer Invoices - Sales Invoice Setup: Linking Order Items to Shipped Parts 
 
 
- 
 
 
 
# How the System Determines the Order Items Billed

 

You have several options for recording a sales invoice and linking it to the orders it fills (and thereby reducing the order balance): 
 

 ·        If each shipment fills one or more specific sales orders, you can have the system itemize the invoice automatically with all ordered parts. 
 

 ·        If each shipment partially fills a specific sales order, and you want to determine which of the ordered parts are being shipped and billed, you can designate the order but record the shipped parts manually. The system will fill in the proper order line number for each recorded item. If the order balance is less than the quantity available for shipping, and there is another order for the same part, you can set up the system to open a second line for the surplus and link it to the second order. 
 

 ·        If you are unaware of which orders are being filled by each shipment, you can record the invoice items manually and have the system fill in the proper order number and line number. Again, if the order balance is less than the available quantity, and there is another order for the same part, you can set up the system to open another line for the second order. 
 
## To select the desired option:

 

 1 . Enter the Logistic Constants form. 
 

 2 .  Choose the appropriate value for the SAutoFindOrd constant.
