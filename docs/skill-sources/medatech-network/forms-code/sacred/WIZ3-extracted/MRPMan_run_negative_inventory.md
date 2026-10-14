# MRPMan_run_negative_inventory

- **Source:** `MRPMan_run_negative_inventory.htm`

MRP for Manufacturers - Running MRP: Handling Negative Inventory 
 
 
- 
 
 
 
# Handling Negative Inventory

 

Choosing to include floor inventory automatically activates the Backflush program, which calculates and updates floor inventory data. Accordingly, you need to choose one of four methods for handling any negative inventory balances that may be received as a result of Backflush : 
 

 ·        Not at All: The program ignores negative balances, and considers them as balances of zero; it thus has no influence on demand calculations. 
 

 ·        Same Warehouse Only: Negative balances will be reduced against existing positive inventory balances of the same part in the same warehouse (albeit with different statuses or work order numbers). 
 

 ·        All Floor Warehouses: Negative balances will be reduced against existing positive inventory balances of the same part in any floor warehouse. 
 

 ·        All Warehouses: Negative balances will be reduced against existing positive inventory balances of the same part in any company warehouse included in planning (i.e., that is not flagged in the Ignored by Planning column). 
 
## Note:

 

Although this parameter affects the method of calculating inventory balances for planning purposes, it has no effect on actual inventory balances in the warehouses. To identify and correct the problems causing the negative inventory, run the Backflush Wizard .
