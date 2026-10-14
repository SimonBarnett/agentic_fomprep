# PP_Issues_calculating_bulk_demand_bu_open_w_o

- **Source:** `PP_Issues_calculating_bulk_demand_bu_open_w_o.htm`

PP_Issues_calculating_bulk_demand_bu_open_w/o 
 
 
- 
 
 
 

Any part that appears in the work order's kit list and has not been flagged for issue to a kit or manual issue is issued in bulk to the plant floor. The Prepare Issues to Floor Stock program calculates the required quantity of a given child part, in a given floor warehouse. 
 

The program calculates the required quantity according to the defined value of the IFloorInv constant, subtracting the quantity already reduced from inventory, as well as the existing balance in the relevant floor warehouse (of the part itself or an alternate).
