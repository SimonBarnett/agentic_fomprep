# Subcont_receiving_from_subc

- **Source:** `Subcont_receiving_from_subc.htm`

Working With Subcontractors - Receiving Processed Parts from a Subcontractor 
 
 
- 
 
 
 
# Receiving Manufactured Parts from a Subcontractor

 

Parts received from a subcontractor are recorded in the Goods Receiving Vouchers form, in much the same manner in which goods are received from a regular vendor. 
 

If a part is received in a subcontractor operation marked with a T in the Inventory/Costing Control column, or if a part is received with no operation, but the last operation of its standard routing is so marked, the Backflush program will perform the following operations against a subcontractor GRV: 
 

 ·        Add to the inventory of manufactured parent parts in the receiving warehouse. 
 

 ·        Reduce from the inventory of child parts in the subcontractor warehouse. Explanation. 
 
## Note:

 

You can specify that certain parts underwent rework. In this case, the system creates a warehouse transfer for the manufactured part, from the subcontractor warehouse to the raw materials warehouse. The system does not reduce the child parts, on the assumption that these children were already reduced against the first GRV for this parent part.
