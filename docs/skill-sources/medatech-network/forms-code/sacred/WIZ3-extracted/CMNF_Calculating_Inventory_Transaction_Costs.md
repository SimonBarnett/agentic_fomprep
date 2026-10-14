# CMNF_Calculating_Inventory_Transaction_Costs

- **Source:** `CMNF_Calculating_Inventory_Transaction_Costs.htm`

Costing for Manufacturers - Calculating Inventory Transaction Costs 
 
 
- 
 
 
 
# Calculating Inventory Transaction Costs 

 

The costing program calculates a weighted average part cost from all of the part's inventory transactions (according to either the FIFO or Moving Average method). 
 

Every transaction recording the entry of parts into inventory (e.g., GRV, vendor invoice) affects the cost of the part. Transactions recording the removal of parts from inventory (e.g., customer shipments, sales invoices) only affect the cost of the part if you are using the FIFO method. Example. 
 
## Notes:

 

 ·        When the cost of an inventory receipt transaction cannot be calculated according to any of the available cost sources, the part's average cost is calculated, according to the FIFO or Moving Average method, as of the transaction date. 
 

 ·        When manufactured parts leave inventory without a work order number, their transaction cost is calculated according to the Moving Average method, even if you are working with FIFO . In such a case, FIFO is still used to calculate the part cost. 
 

 ·        Inventory entering or leaving warehouses flagged as not participating in costing does not affect part cost. However, if inventory is transferred from such a warehouse into a regular warehouse, this transaction is considered entry into inventory and affects part cost. Similarly, the transfer of inventory from a regular warehouse into such a warehouse is considered removal from inventory, and affects part cost if you are using FIFO . 
 

 ·        Click to return to the main screen .
