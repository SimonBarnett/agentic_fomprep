# Backflush_handling_negative_quantities_algorithm_4

- **Source:** `Backflush_handling_negative_quantities_algorithm_4.htm`

Backflush - Troubleshooting Negative Inventory.6 
 
 
- 
 
 
 
## IV. If the source of the problem has not been found, you can resolve the negative balance by adjusting inventory in the relevant floor warehouse by an inventory count performed prior to recording the past balance:

 

 1 .  Run the Prepare for Inventory Count program for the relevant floor warehouse.
 Note s : 
 

 ·      Inventory counts in plant floor warehouses should only be performed immediately before the past balance is calculated. 
 

 ·      Missing issues of kit components are only adjusted by inventory counts when the past balance is recorded, whereas missing issues of bulk parts are immediately adjusted by the inventory count when the Backflush program is run. Example. 
 

 2 .  In the Inventory Count form, enter the resulting inventory count document. In the itemized count, a negative Calculated Quantity will appear for the part in question. 
 

 3 .  Leave 0 in the Counted Quantity column and approve the line. 
 

 4 .  Rerun the Backflush program. 
 
## Notes:

 

 ·        It is recommended to perform an inventory count for the past balance date as a routine procedure for handling missing issues. The inventory count creates incoming inventory transactions for the manufactured part in the missing operation, but does not cause a backflush of child parts issued to that operation. The operation’s costs are not added to the general cost of the work order (even if such costs are recorded in the inventory count line). For detailed instructions on performing inventory counts, run the Inventory Count Wizard . 
 

 ·        Click to handle additional negative balances. 
 

 ·        Click to handle missing issues. 
 

 ·        Click to return to the main screen.
