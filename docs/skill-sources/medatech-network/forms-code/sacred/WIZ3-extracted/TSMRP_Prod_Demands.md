# TSMRP_Prod_Demands

- **Source:** `TSMRP_Prod_Demands.htm`

Troubleshooting MRP Wizard - Production Demands 
 
 
- 
 
 
 
# Production Demands

 

Production demands are calculated according to the open, released work orders and planned work orders recorded for the part's direct parent. 
 

There are two exceptions to the rule: 
 

 ·        If the parent part is flagged for Info Only or the parent-child ratio is 0, demand for the parent is ignored. 
 

 ·        When the direct parent is a phantom, production demands are calculated according to the released and planned work orders recorded for the first parent part that is not a phantom. 
 
## To check Info Only and the parent-child ratio:

 

 1 .  Enter the Parts form and retrieve the parent part in question. 
 

 2 .  Enter the Parent Parts sub-level form and move to the parent in question. 
 

 3 .  Check whether the Info Only column is flagged, and check the value in the Coefficient column. 
 
## To check if the parent is a phantom:

 

 ·        In the same form, check if the Parent Operation is Phantom. If it is, check if its parent is also a phantom. Continue searching through the BOM until you locate the first parent that is not defined as a phantom. Demand will be calculated for that parent.
