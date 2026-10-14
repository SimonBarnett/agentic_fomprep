# TSMRP_Assemb_Demands

- **Source:** `TSMRP_Assemb_Demands.htm`

Troubleshooting MRP Wizard - Assembly Demands 
 
 
- 
 
 
 
# Demand for Assemblies

 

When the part in question is an assembly component, MRP also takes into account the balance of open orders for parent parts whose due dates fall within the MRP period. 
 

The following are exceptions to the rule, where demand for the parent is ignored. 
 
## The parent part's replenishment type is B:

 

 1 .  Enter the Purchase/MRP Parameters for Part form and retrieve the parent part.   
 

 2 .  Click the General tab and check if the Replenishment Type is B. 
 
## The parent part is flagged for Info Only, or the parent-child ratio is 0:

 

 1 .  Enter the Parts form and retrieve the part in question. 
 

 2 .  Enter the Parent Parts sub-level form and move to the parent in question. 
 

 3 .  Check whether the Info Only column is flagged, and check the value in the Coefficient column. 
 
## The parent operation is Phantom:

 

 ·        In the same form, check if the Parent Operation is Phantom. When this is the case, the parent part is not an actual part, but rather represents a group of parts. In this case, MRP ignores open orders for the direct parent and instead takes into account orders for the phantom's parent (provided the parent's routing is Assembly).
