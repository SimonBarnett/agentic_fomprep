# TSBackflush_Automatic_Transactions

- **Source:** `TSBackflush_Automatic_Transactions.htm`

Troubleshooting Backflush Wizard - Automatic Inventory Transactions in Floor Warehouse 
 
 
- 
 
 
 
# Automatic Inventory Transactions in the Floor Warehouse for Another Work Order

 

When the Backflush program encounters several production reports for the same parent part since the last past balance date, it generates a single backflush transaction for the child part, on the date of the last report. 
 

Backflushing is performed from the total amount of inventory transferred to the floor (minus "manual" inventory transactions from the warehouse) without taking into account the work order for which the materials were originally issued. This can result in missing issues.
