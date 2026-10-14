# TSCosting_Act_P_Otr_W_Blank_Qty

- **Source:** `TSCosting_Act_P_Otr_W_Blank_Qty.htm`

Troubleshooting Costing - Actual Cost, Type P.7 
 
 
- 
 
 
 
# If work orders were recorded for the part:

 

 1 .  Enter the Work Order Costing form and retrieve the work orders in question. 
 

 2 .  In each work order, check the Finished Qty column. 
 

 3 .  Do one of the following: 
 

 ·      If a quantity is recorded, return to the Work Orders form and check the Rework column (in the Inventory/Costing Data tab). If the column is flagged, the work order will not appear in costing forms or have any effect on the part’s cost. 
 

 ·      If no quantity is recorded, enter the Routing for the Work Order sub-level of the Work Orders form and determine the last operation in the work order routing, and its Inv./Costing Contro l value. The work order will have no effect on the part cost if: 
 

 ·      the value is R , and no production reports appear in the parallel Progress Report sub-level form. 
 

 ·      the value is T , and no production reports or subcontractor receipts appear in the parallel Progress Report sub-level form. 
 

 ·      the value is L or C , or there is no value.
