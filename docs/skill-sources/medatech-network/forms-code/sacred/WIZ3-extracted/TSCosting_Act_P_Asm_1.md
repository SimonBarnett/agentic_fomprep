# TSCosting_Act_P_Asm_1

- **Source:** `TSCosting_Act_P_Asm_1.htm`

Troubleshooting Costing - Actual Cost, Type P.2 
 
 
- 
 
 
 
# Solution – Check the Cost Calculation Data for the Assembled Part

 

The actual cost of an assembled part is determined by calculating the average cost of its existing inventory in the last past balance and the cost of the part’s incoming inventory transactions during the costing period in question. This average is calculated using either the FIFO or the Moving Average method. 
 
## To check the inventory transactions that determine the assembled part’s cost:

 

 1 .  Enter the Product Costing form and retrieve the assembled part. 
 

 2 .  There is a line for each costing run for a past balance in which the part was included, as well as a line for the last costing run performed for the current date. For each date, enter the Product Transactions sub-level form to view the inventory transactions taken into account by the costing program and their transaction costs. 
 

 3 .  Note the date of each costing run whose calculations you wish to analyze further. 
 

 4 .  Click to analyze the calculation of the part’s average cost . 
 
## Notes: 

 

 ·        If no inventory transactions were recorded for the part during the current costing period, its cost is taken from the previous past balance. If no cost was calculated for the part in the previous period, its actual cost is calculated from its standard cost. 
 

 ·        If there is no data for the part, check if it is flagged for inventory control in the Part Catalogue form. If not, the part will not appear in costing forms, and its actual cost will be calculated from its standard cost. 
 

 ·        If the incoming transaction is the result of an assembly, the cost of the transaction is calculated based on the actual costs of issues to the assembly of components. In order to analyze the assembly cost, enter the Audit Trail form. Retrieve by “Issue to Assembly” in the Inv. Transaction column, and by the assembly document number in the Doc/Invoice Number column.
