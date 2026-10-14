# PP_Backflush_exp_linking_w_o_to_subcont

- **Source:** `PP_Backflush_exp_linking_w_o_to_subcont.htm`

PP_Backflush_exp_linking_w/o_to_subcont 
 
 
- 
 
 
 

When a subcontractor has been assigned to a work order, this indicates that any L or T operations in the routing are to be performed by the subcontractor (rather than in the factory). The Backflush consequently: 
 

 ·        reduces child parts from the subcontractor’s warehouse, even though the work cell in question is linked to a floor warehouse in the factory. 
 

 ·        does not require production reports for L or T operations in the work order’s routing, and does look for a GRV for any T operation. 
 

 Note: There is an exception to this rule: any operation linked (via the work cell) to a specific subcontractor’s warehouse is considered to be performed by that subcontractor, regardless of the subcontractor assigned to the work order.
