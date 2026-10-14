# PP_Backflush_exp_negative_balance

- **Source:** `PP_Backflush_exp_negative_balance.htm`

PP_Backflush_exp_negative_balance 
 
 
- 
 
 
 

 Negative Inventory 
 

For every production report, the Backflush program records the entry into inventory of the part produced in the reported operation, in the reported quantity, and deducts from floor inventory the same quantity of the part produced in the previous operation in the routing. If, due to problems in production reporting or for some other reason, insufficient inventory is found in the previous operation, a negative inventory balance is created for this operation. 
 

This is the most common reason for the creation of negative floor inventory. In addition, negative inventory in floor warehouses can occur for the same reasons that it occurs in regular warehouses; that is, from inaccuracies in the recording of inventory transactions. Finally, negative inventory can actually result from missing issues: when past balances are calculated, any child part quantities that cannot be reduced from parents are given negative inventory balances.
