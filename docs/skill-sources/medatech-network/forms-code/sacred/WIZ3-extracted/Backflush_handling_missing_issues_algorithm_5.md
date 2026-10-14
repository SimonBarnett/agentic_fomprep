# Backflush_handling_missing_issues_algorithm_5

- **Source:** `Backflush_handling_missing_issues_algorithm_5.htm`

Backflush - Troubleshooting Missing Issues.8 
 
 
- 
 
 
 
## VI. If the source of the problem has not been found, you can resolve the missing issues by an inventory count performed immediately prior to recording the past balance:

 

 1 .  Run the Prepare for Inventory Count program for the relevant floor warehouse.
 Note s : 
 

 ·      Inventory counts in plant floor warehouses should only be performed immediately before the past balance is calculated. 
 

 ·      Missing issues of kit components are only adjusted by inventory counts when the past balance is recorded, whereas missing issues of bulk parts are immediately adjusted by the inventory count when the Backflush program is run. Example. 
 

 2 .  In the Inventory Count form, enter the resulting inventory count document. In the itemized inventory count, a negative Calculated Quantity will appear for the part in question. 
 

 3 .  Leave 0 in the Counted Quantity column and approve the line. 
 

 4 .  Rerun the Backflush program. 
 
## Notes:

 

 ·        It is recommended to perform an inventory count for the past balance date on a regular basis. The inventory count creates incoming inventory transactions for the manufactured part in the missing operation, but does not cause a backflush of child parts issued to that operation. The operation’s costs are not added to the general cost of the work order (even if such costs are recorded in the inventory count line). For detailed instructions on performing inventory counts, run the Inventory Count Wizard . 
 

 ·        Click to handle additional missing issues. 
 

 ·        Click to handle negative inventory. 
 

 ·        Click to return to the main screen.
