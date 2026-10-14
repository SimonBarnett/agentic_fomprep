# PP_MRPMan_Negative_Inventory

- **Source:** `PP_MRPMan_Negative_Inventory.htm`

PP_MRPMan_Negative_Inventory 
 
 
- 
 
 
 

Negative balances are created as a result of inaccurate documentation of inventory transactions within the system. 
 

One of the reasons for a negative balance is missing issues. When the Backflush program creates a transaction receiving the manufactured part into inventory, it creates a complementary transaction removing the raw materials, for each production report. 
 

If the report is recorded before the materials required for the operation have been issued to the plant floor, or if the materials were not issued to the correct warehouse (i.e., the warehouse linked to the work cell in which the operation is performed), Backflush fails to identify the required materials, resulting in missing issues. If the materials are not issued by the time past balances are calculated, negative inventories remain for those parts that Backflush failed to find on the plant floor. 
 

Another reason for a negative balance is a missing report for an intermediary operation. When a later operation is reported, Backflush creates a negative balance on the plant floor for the part in the missing operation. 
 

Furthermore, inventory count or warehouse transfer transactions can cause inaccuracies in inventory balances on the floor and cause the creation of negative inventory.
