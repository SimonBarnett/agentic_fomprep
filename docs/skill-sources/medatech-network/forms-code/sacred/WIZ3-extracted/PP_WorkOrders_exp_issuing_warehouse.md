# PP_WorkOrders_exp_issuing_warehouse

- **Source:** `PP_WorkOrders_exp_issuing_warehouse.htm`

PP_WorkOrders_exp_issuing_warehouse 
 
 
- 
 
 
 
# Order of Precedence for Issues

 

 1 .  Inventory of the desired part revision (as recorded in the kit list) takes precedence over other part revisions. 
 

 2 .  Lots/work orders with earlier expiration dates take precedence over those with later dates. 
 

 3 .  Inventory from closed work orders takes precedence over that from open work orders. 
 

 4 .  Work orders with earlier closure dates take precedence over those with later dates. 
 

 5 .  Work orders with earlier opening dates take precedence over those with later dates. 
 

 6 .  Inventory from a warehouse with a shorter lead time takes precedence over that from a warehouse with a longer lead time. 
 
## Notes: 

 

 ·        If an issuing warehouse has been assigned to the plant floor, the order of precedence will only apply to the inventory in that warehouse. 
 

 ·        If no inventory of the part is recorded in the system, the Main warehouse appears automatically.
