# PurchasePlanning_Program_2

- **Source:** `PurchasePlanning_Program_2.htm`

Purchase Planning - Running the Purchase Planning Program.2 
 
 
- 
 
 
 
# Handling open purchase demands

 

Purchase demand documents that were opened automatically in a previous run of purchase planning but were never authorized are deleted and replaced when the program is run again. 
 

If, however, an automatic purchase demand was even partially authorized, it is not deleted, even though a new purchase demand is opened to replace it. Instead, the A in the Automatic column is replaced by an O (for “old”). Old purchase demands are not taken into account by purchase planning, but they are still valid in the system. You may base a purchase order on an old purchase demand, but you will receive a warning when you try to do so. 
 
## Handling manual purchase requisitions in open purchase demands

 

If a purchase requisition was added manually to an old purchase demand that was opened automatically but never authorized, or a manual revision was made to any of the purchase requisitions in the document, purchase planning will delete the entire contents of the demand document except for those requisitions . In both cases the lines in question are considered manual purchase requisitions. 
 

Consequently, purchase planning will not take these requisitions into account, and will open new requisitions for the same issues. On the other hand, the old requisitions are still valid in the system. If purchase orders are opened on the basis of both old and new requisitions, the result will be surplus inventory of the required part. It is thus recommended to avoid manually revising automatic purchase requisitions, and to make any necessary revisions in the purchase order.
