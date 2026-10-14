# TSCosting_Act_P_Otr_Tree_1

- **Source:** `TSCosting_Act_P_Otr_Tree_1.htm`

Troubleshooting Costing - Actual Cost, Type P.13 
 
 
- 
 
 
 
# Solution – Checking the Cost Calculation Data 

 

Under costing option T , the cost of a manufactured part is determined by multiplying the standard quantities of raw materials (Type R child parts) and sub-assemblies (Type P child parts), as defined in the BOM, by their actual costs, and adding standard production costs. 
 

Actual raw material cost is determined by calculating the average cost of each part’s existing inventory in the last past balance and the cost of inventory transactions by which the part was received into inventory during the costing period in question (that is, from the previous past balance until the last one, or from the last past balance until the present date). This average is calculated using either the FIFO or the Moving Average method. 
 
## To check the inventory transactions that determine the cost of raw materials:

 

 1 .  Enter the Material Costing form and retrieve the raw material. 
 

 2 .  There is a line for each costing run for a past balance in which the part was included, as well as a line for the last costing run performed for the current date. For each date, enter the Material Transactions sub-level form to view the inventory transactions taken into account by the costing program and their transaction costs. 
 

 3 .  Note the date of each costing run whose calculations you wish to analyze further. 
 

 4 .  Click to analyze the calculation of the part ’s average cost . 
 
## Notes: 

 

 ·        If no inventory transactions were recorded for the part during the current costing period, its cost is taken from the previous past balance. If no cost was calculated for the part in the previous period, its actual cost is calculated from its standard cost. 
 

 ·        If there is no data for the part, check if it is flagged for inventory control in the Part Catalogue form. If not, the part will not appear in costing forms, and its actual cost is taken from its standard cost.
