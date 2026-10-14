# WareTrans_setup_LinkOrd

- **Source:** `WareTrans_setup_LinkOrd.htm`

Warehouse Transfers - Setup: Linking to a Sales Order 
 
 
- 
 
 
 
# Linking a Warehouse Transfer Document to a Sales Order

 

There are several ways to record a warehouse transfer document and link it to the sales orders that it supplies (thus causing a decrease in the order balance): 
 

 ·        If each transfer supplies one or more specific sales orders, you can set up the system to itemize the transfer document automatically, with all of the ordered parts. 
 

 ·        If each transfer only supplies part of a specific order, and you want to determine which of the ordered parts will be transferred, you can specify the order in the transfer document, but record the transferred items manually. The system will fill in the appropriate line number of each specified item in the original order. If the order balance is less than the quantity available for shipping, and there is another order for the same part, you can set up the system to open a second line for the surplus and link it to the second order. 
 

 ·        If you do not know which orders are supplied by any warehouse transfer, you can record the warehouse transfer lines manually, and set up the system to fill in the appropriate order number and order lines. Again, if the order balance is less than the available quantity, and there is another order for the same part, you can set up the system to open another line for the second order. 
 
## To selected the desired option:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Check the value of the SAutoFindOrd constant and change it, if necessary.
