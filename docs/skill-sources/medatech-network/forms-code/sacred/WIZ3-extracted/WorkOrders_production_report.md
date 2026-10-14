# WorkOrders_production_report

- **Source:** `WorkOrders_production_report.htm`

Work Orders - Reporting Production 
 
 
- 
 
 
 
# Reporting Production

 

Production reports are used to record the execution of an operation on a certain quantity of parts, for a specific work order. 
 

For each production report, the Backflush program performs two basic operations: 
 

 ·        Reduces the quantities of child parts involved in the operation from the floor inventory (according to their issue type – parts issued to kits are reduced from the kit warehouse; parts issued in bulk are reduced from the relevant floor warehouse). 
 

 ·        Adds the reported quantity of parent parts to the inventory of produced parts (in the reported operation). Example. 
 

Certain production reports affect the status of the work order. For example, the first and last production reports for a work order automatically change its status to that flagged as the First Report and Last Report , respectively. If the latter is also flagged in the Close Work Order column, the last production report will cause the automatic closure of the work order. 
 

For detailed instructions on production reporting, run the Production Report Wizard .
