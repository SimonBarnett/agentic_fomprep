# PP_Subcont_exp_receipt_from_subc_ch_part_reduction

- **Source:** `PP_Subcont_exp_receipt_from_subc_ch_part_reduction.htm`

PP_Subcont_exp_receipt_from_subc_ch_part_reduction 
 
 
- 
 
 
 

The system will reduce the child parts required for the last operation performed by the subcontractor (i.e., the operation designated for the received parent part), as well as those required in any intermediate operations (whose inventory/costing control setting is L ). 
 

Child parts that have been flagged with an N or P in a BOM that has been adapted for a subcontractor are not reduced from inventory: 
 

 ·        If the part is flagged with an N , it is not reduced at all 
 

 ·        If the part is flagged with a P (Phantom), its own child parts are reduced.
