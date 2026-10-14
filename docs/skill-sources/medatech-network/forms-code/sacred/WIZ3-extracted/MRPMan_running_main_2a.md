# MRPMan_running_main_2a

- **Source:** `MRPMan_running_main_2a.htm`

MRP for Manufacturers - Running MRP: Overview.2 
 
 
- 
 
 
 

When you run MRP, you are given the option of reducing demand against existing inventory of items that have been issued in bulk to the plant floor (that is, parts that are transferred to the floor in large quantities, as recorded in an Shipmt to Subcontr/Issue of Kit document rather than a work order kit list). 
 

Even if you choose this option, the program does not take into account: 
 

 ·        inventory stored in floor warehouses that you have excluded from MRP by flagging their Ignored by Planning column or 
 

 ·        inventory whose status excludes it from planning. 
 

If you have set the MRPSepFloors constant to handle each floor warehouse separately, MRP will prepare separate issues to each of the various warehouses, reducing the demand calculated for each warehouse against the inventory it contains.
