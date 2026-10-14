# TSCosting_Act_R_Avg

- **Source:** `TSCosting_Act_R_Avg.htm`

Troubleshooting Costing - Analyzing the Calculation of Average Cost 
 
 
- 
 
 
 
# Analyzing the Calculation of the Average Cost

 

You can analyze the method used to calculate the average cost of a part by running the Actual Cost Analysis report for the costing date. This report displays each inventory transaction for the part and its effect on the average cost according to the calculation method (FIFO or Moving Average) used by the costing program: 
 

 ·        The first line – titled "Previous FIFO" or "Previous Average" – refers to the part’s inventory balance in the previous past balance. 
 Note: To analyze the cost of the previous past balance, run the report for its corresponding costing date. 
 

 ·        The cost of the transaction, which is calculated for the total amount of the part in the transaction, is displayed in the Transaction Cost column. 
 

 ·        When using the FIFO method, the cost per unit is displayed in the FIFO column. The cost of a part’s outgoing transactions in FIFO costing is calculated from the cost of the oldest inventory still located in company warehouses. Explanation. 
 

 ·        When using the Moving Average method, the average cost per unit is displayed in the Moving Average column. This value is determined by calculating a weighted average of the cost of the previous balance and that of the current transaction. The cost of a part’s outgoing transactions is identical to the average cost of the part as calculated after the last entry of the part. Example. 
 
## Note:

 

If there is no data for the part, it could be for any of the following reasons: 
 

 ·      The part is not flagged for inventory control in the Part Catalogue form. 
 

 ·      The part is actually Type O , for which costs are not calculated. 
 

 ·      The part has the "Phantom" routing.
