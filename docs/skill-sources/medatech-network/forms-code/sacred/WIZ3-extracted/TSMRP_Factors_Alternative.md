# TSMRP_Factors_Alternative

- **Source:** `TSMRP_Factors_Alternative.htm`

Troubleshooting MRP Wizard - Analyzing Use of Alternate Parts 
 
 
- 
 
 
 
# Analyzing Use of Alternate Part Inventory

 

MRP takes alternate part inventory into account only when the following conditions are met: 
 

 ·        The UsePartAlt constant is set to 1 . 
 

 ·        The inventory is stored in a Type D warehouse. 
 

 ·        The inventory's status is defined as Available Inventory . 
 

 ·        The inventory's status is not P acked . 
 

 ·        The inventory is completely processed; that is, there is no operation attached to it. 
 
## To check the constant value:

 

 ·        Enter the Planning Constants form and move to the line for the UsePartAlt constant. 
 
## To check available inventory:

 

 1 .  Enter the Inventory Statuses form, and note which statuses are flagged in the Available Inventory column. 
 

 2 .  Enter the Parts form and retrieve the alternate part in question. 
 

 3 .  Enter the sub-level form, Inventory Balance for Part . Check the warehouse type and inventory status, and make sure there is no operation recorded in the O peration /Pallet column. 
 
## Notes:

 

 ·        If MRP is defined to consider floor inventory, it will take into account alternate parts on the part floor that are issued in bulk, regardless of the issue type of the original part it is substituting for. 
 

 ·        If there is also demand for the alternate part itself, MRP will first fill that demand before using alternate part inventory to meet demand for the original part.
