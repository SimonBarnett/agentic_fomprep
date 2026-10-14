# PP_CMNF_WO_child_part_cost

- **Source:** `PP_CMNF_WO_child_part_cost.htm`

PP_CMNF_WO_child_part_cost 
 
 
- 
 
 
 

The cost of a child part is determined as follows: 
 

 ·        If the part is a raw material with a lot number (and the costing program is set up to calculate lot costs), its cost is based on the lot cost. 
 

 ·        If the part is a raw material without a lot number, its actual cost is used. 
 

If the part is itself a manufactured part, its cost is based on the cost of its work order. If the part is issued to the plant floor without a work order number (work order numbers are often removed from completed parts before they enter inventory), the cost of the Backflush transaction is calculated by Moving Average, even when costing is run by FIFO.
