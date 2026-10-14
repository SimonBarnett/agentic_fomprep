# TSBackflush_Changing_the_Warehouse_Attached_to_the_Work_Center

- **Source:** `TSBackflush_Changing_the_Warehouse_Attached_to_the_Work_Center.htm`

Troubleshooting Backflush Wizard - Change in Warehouse Linked to Work Cell 
 
 
- 
 
 
 
# Change in the Warehouse Linked to the Work Cell

 

If the warehouse linked to the work cell of the part's operation is changed after the work order was released, this can cause missing issues. The Backflush program attempts to locate parts according to the new work cell definitions, but the parts were issued according to the old definitions. Thus, the inventory in question cannot be found.
