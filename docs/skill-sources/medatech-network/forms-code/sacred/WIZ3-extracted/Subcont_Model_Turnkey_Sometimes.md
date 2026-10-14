# Subcont_Model_Turnkey_Sometimes

- **Source:** `Subcont_Model_Turnkey_Sometimes.htm`

Working With Subcontractors - Modeling Production for Turnkeys.3 
 
 
- 
 
 
 
# Modeling Production of a Part That is Sometimes Purchased from a Turnkey

 

When a given part is sometimes purchased from a turnkey subcontractor and sometimes manufactured in the factory, the following general solution is recommended: 
 

 1 .  Define a phantom part (having the Phanto routing). 
 

 2 .  Create a bill of materials for the phantom that includes all children of the part whose production you are modelling. 
 

 3 .  Define two separate parts (both of which represent the same product): one of type R (used when the part is manufactured by a turnkey) and one of type P (used when it is produced in the factory). 
 

 4 .  Assign the phantom part as the child of each of these parts. 
 

When you report production in the factory, the system ignores the phantom child, instead deducting inventory from its own child parts. When the part is produced by a turnkey subcontractor, the system ignores all child parts (since this is a type R part). 
 
## Notes:

 

 ·        Define the parts (i.e., the R and the P ) as alternates of each other, so that MRP will also take into account the inventory of the other part when calculating available inventory. 
 

 ·        Calculations of inventory and of costs are performed separately for each of the two parts. 
 

 ·        Click to return to the main screen.
