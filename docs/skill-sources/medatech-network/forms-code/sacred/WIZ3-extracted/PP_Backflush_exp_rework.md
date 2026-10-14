# PP_Backflush_exp_rework

- **Source:** `PP_Backflush_exp_rework.htm`

PP_Backflush_exp_rework 
 
 
- 
 
 
 

The Backflush ignores all production reports flagged as rework, with one exception: it does take into account reports of rework in which the operation and work cell are blank (indicating that this is the final operation, and the part’s processing for this work order is complete). 
 

In the case of a receipt of rework from a subcontractor, the Backflush adds the received part into inventory, but does not reduce child part inventory (under the assumption that child parts were reduced the first time the subcontractor returned the processed part).
