# TSCosting_Act_P_Otr_W_Zero_SubCon

- **Source:** `TSCosting_Act_P_Otr_W_Zero_SubCon.htm`

Troubleshooting Costing - Actual Cost, Type P.10 
 
 
- 
 
 
 
# To check subcontractor costs:

 

 1 .  Enter the Work Orders form and retrieve the work orders in question. 
 

 2 .  For each work order, enter the Progress Report sub-level form and move to the Recv/Sent to Subcont column. 
 

 3 .  If a positive value is recorded in this column in one of the lines, select the Document Number column in that line and press F6 . The relevant subcontractor receipt will open. 
 

 4 . For each part listed in the Received Items sub-level form, enter the Invoices/Credit Memos for Item sub-level and check the cost recorded in the subcontractor’s invoice. 
 
## To check supply costs:

 

 1 .  Enter the Audit Trail form. 
 

 2 .  Retrieve all transactions with the Inv. Transaction type “Issue of Supplies”, where the work order in question appears in the For Work Order column, and check the transaction cost appearing in the Cost column. 
 
## To check non-standard costs:

 

 1 .  Enter the Audit Trail form. 
 

 2 .  Retrieve all transactions with the Inv. Transaction type “GRV”, where the work order in question appears in the For Work Order column, and check the transaction cost appearing in the Cost column.
 Note: The parts whose cost is loaded in this fashion are not subject to inventory control. The cost loaded is their standard cost.
