# TSMRP_WOs_Released2

- **Source:** `TSMRP_WOs_Released2.htm`

Troubleshooting MRP Wizard - Why Released Work Orders are Ignored 
 
 
- 
 
 
 
# Why Released Work Orders are Ignored by MRP

 

There are a number of reasons that MRP will not take released work orders for parents into account, and hence will not plan issues for them: 
 

 ·        When MRP was run, it was not defined to take released work orders into account. 
 

 ·        The work order's production end date falls after the MRP run date. 
 

 ·        There is no demand for the work order; it is not needed for any sales orders or for production. 
 

 ·        The work order is flagged as Ignore When Planning . 
 

 ·        The work order has been partially produced and it has been flagged as Plan by Reported Qty . Details. 
 
## To check MRP run definitions:

 

 1 .  Run the View Dates & Chosen Options report and check if the last run of MRP took released work orders into account. Also note the MRP run date. 
 

 2 .  Run the Work Ords to Execute by WorkCell report and check if the work order's production end date falls after the MRP run date. 
 
## To check work order demand:

 

 1 .  Enter the Purchase/MRP Parameters for Part form and retrieve the parent part in question. 
 

 2 .  Enter the MRP Analysis - Processed Parts sub-level form and check if the work order in question was used by MRP for the planning of sales orders for the current part or for production. 
 
## To check work order definitions:

 

 1 .  Enter the Work Orders form, and retrieve the work order in question. 
 

 2 .  Click the Inventory/Costing Data tab and check if the work order is flagged as Ignore When Planning or Plan by Reported Qty .
