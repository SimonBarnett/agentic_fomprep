# Backflush_setup_clean_inventory

- **Source:** `Backflush_setup_clean_inventory.htm`

Backflush - Setup: Inventory Cleaning 
 
 
- 
 
 
 
# Setting Up Inventory Cleaning

 

Inventory discrepancies can occur in closed work orders, in the case of partially processed parts that were never completed , negative inventory in closed work orders or inexact issues to a kit. 
 

You can define an inventory cleaning percentage for each parent part, which represents the margin of error within which the Backflush program will ignore extra or missing inventory. Beyond the defined percentage, the program will record surplus or missing inventory as usual. 
 
## Note:

 

The Backflush program does not update inventory balances in keeping with the inventory cleaning percentage. Inventory cleaning only affects inventory when past balances are calculated. 
 
## To define inventory cleaning for a part:

 

 1 .  Enter the Inventory Parameters for Parts form. 
 

 2 .  Retrieve the desired processed part. This definition will affect inventory in progress (WIP) of the part itself, as well as all child parts that are issued to kits. 
 

 3 .  Record the appropriate percentage in the Clean Inventory (%) column. 
 
## To view the quantities that will be deleted when the past balance is recorded:

 

 ·        For issued child parts in closed work orders, run the Clear Surplus Floor Inventory report. 
 

 ·        For partially processed parts, run the Disposable WIP in Closed Wk Ords report. 
 
## Notes:

 

 ·        This definition does not affect child parts that are issued in bulk. 
 

 ·        If the extra or missing inventory falls within the defined percentage, it is completely deleted. If it exceeds the percentage, all of the surplus remains in inventory; that is, nothing is deleted. 
 

 ·        The deleted inventory is not treated as backflushed inventory; that is, its cost is not added to the cost of the work order.
