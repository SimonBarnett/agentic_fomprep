# TSBackflush_Not_Production

- **Source:** `TSBackflush_Not_Production.htm`

Troubleshooting Backflush Wizard - Missing Issues for Parts Produced by Subcontractors 
 
 
- 
 
 
 
# Missing Issues of Child Parts Issued to Parts Produced by Subcontractors

 

 Child parts of parts produced by subcontractors are backflushed not only as a result of production reports, but also as a result of other inventory transactions of the parent part on the plant floor, such as receipts from vendors onto the floor or warehouse transfers to the floor. 
 

If such an inventory transaction was not meant to affect production transactions (i.e., no work order was recorded for the transaction), this can create missing issues for work order 0. 
 

 Note: If the inventory transaction was recorded without a work order number, the part will appear in the Missing Issues form without a work order number in the For Work Order column, and the For Operation column will display the operation linked to the subcontractor warehouse. 
 
## To resolve this:

 

 1 .  Move to the line in question in the inventory document. 
 

 2 .  Flag the Rework column. 
 
## Note:

 

If, on the other hand, this was meant to be a production transaction, then there is actual missing inventory which needs to be transferred to the plant floor.
