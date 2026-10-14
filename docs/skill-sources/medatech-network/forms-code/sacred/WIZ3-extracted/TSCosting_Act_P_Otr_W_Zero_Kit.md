# TSCosting_Act_P_Otr_W_Zero_Kit

- **Source:** `TSCosting_Act_P_Otr_W_Zero_Kit.htm`

Troubleshooting Costing - Actual Cost, Type P.9 
 
 
- 
 
 
 
# Material Costs

 

Child part costs are added to the work order cost when a Backflush transaction is created as a result of production reports of an operation on the work order, in keeping with the data in the Kit List sub-level of the Work Orders form. 
 

 Note: 
 

To check data for work orders closed since the last past balance, run costing for the current date before checking. 
 
## To check material costs:

 

 1 .  Enter the Work Order Costing form and retrieve each problematic work order in turn. 
 

 2 .  Enter the Issues to Work Order sub-level form to view the child parts recorded in production reports for that work order. The form lists child parts, and the cost of their transactions, which were added to the work order cost. 
 

 3 .  The cost of issue transactions is calculated using either the FIFO or the Moving Average method, according to the defined costing method. To check how the issue cost was calculated, run the Actual Cost Analysis report for the part issued. 
 

 4 .  The child parts appearing in the form are issue of supplies listed for the work order, manual issues to the work order, and kit components listed in the work order’s Kit List sub-level form, that were backflushed when a given operation was reported. To view the type of issue, see the Inv. Transaction column.
 Note: While the transactions are listed together in this form, in the Product Cost Components and Work Order Cost Components forms, the issue of supplies cost is summed up separately from the kit list and manual issue cost. 
 

 5 .  To check the work order's kit list, enter the Work Orders form and retrieve the work order. Then enter the Kit List sub-level form and check the parts appearing in the list. 
 

 6 .  For each part listed in the Kit List form, check the To Operation column and note the operation for which the part is needed. 
 

 7 .  Enter the parallel Routing for the Work Order sub-level form and check the operation’s Inv./Costing Control value. The child part will be backflushed and will therefore affect the work order cost if: 
 

 ·      the value is R , and production reports for this operation appear in the parallel Progress Report sub-level form. 
 

 ·      the value is T , and subcontractor receipts for this operation appear in the parallel Progress Report sub-level form. 
 

 ·      the value is L or C , and production reports or subcontractor receipts appear for the following reported operation (defined as T or R ) in the parallel Progress Report sub-level form. 
 
## Notes:

 

 ·        If production reports are found in keeping with the operation’s Inv./Costing Control method, the Backflush program will deduct the materials. If it is not possible to deduct the material inventory (e.g., there is insufficient material inventory on the production floor), missing issues are created. To check if a Backflush transaction was recorded, enter the Backflush Transactions form. If none was recorded, check for missing issues in the Missing Issues form. 
 

 ·        The cost of the Backflush transaction depends on the child's part type: 
 

 ·      If the child part is Type R , or if it is Type P with an "Assemb" routing, the part cost is added to the work order in keeping with the calculated average cost of the part on the Backflush date, as determined by the FIFO or Moving Average method. 
 

 ·      If the child part is Type P , with another routing, you should analyze its cost in keeping with the value of the DetailedCost constant. 
 

 ·        The system does not backflush parts that are flagged as Extra Issue . This column is flagged automatically when a line is added manually to the kit list. The assumption is that this line is for surplus issue, and the part will be issued to the floor warehouse with the Rejected status. If this is not the case, remove the flag from the Extra Issue column after adding the line.
