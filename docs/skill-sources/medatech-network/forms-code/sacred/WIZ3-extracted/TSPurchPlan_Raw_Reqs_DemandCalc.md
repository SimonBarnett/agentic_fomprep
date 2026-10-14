# TSPurchPlan_Raw_Reqs_DemandCalc

- **Source:** `TSPurchPlan_Raw_Reqs_DemandCalc.htm`

Troubleshooting Purchase Planning - Raw Material: Calculation of Demand 
 
 
- 
 
 
 
# Calculation of Demand

 

 Note: Make sure you are in the Projected Balances (buy/sell) (sub-level of the Purchase/MRP Parameters for Part form). 
 
## If no demand range is indicated:

 

Purchase requisitions are generated for the current date based on the following formula: 
 

The quantity of issue items for the current date 
 

plus safety stock 
 

minus the current available inventory balance 
 

minus the quantity of current or prior purchase orders 
 

minus the quantity of later purchase orders which the system has recommended that you expedite. 
 

 Note: If any components of the formula are missing, substitute a 0 . 
 
## If a demand range has been defined:

 

A single purchase requisition is opened for all issues within the demand range for the first issue date in this range. The requisitioned quantity for this first demand range is based on the following formula: 
 

The quantity of issue items for the first demand range 
 

plus safety stock 
 

minus the current available inventory balance 
 

minus the quantity of purchase orders for the first demand range or prior purchase orders 
 

minus the quantity of later purchase orders which the system has recommended that you expedite. 
 

 Note: If any components of the formula are missing, substitute a 0 . 
 
## In both cases:

 

The requisitioned quantity for subsequent issue items equals the total quantity of issue items for that date. 
 

If the result is less than zero, a purchase demand should be generated. Requisitioned quantities will be rounded according to the Increment for Ord/WO and Min for Order/W. Ord parameters defined in the Purchase/MRP Parameters for Part form. 
 

If the result is less than zero, but no purchase demand is generated, check whether there are purchase orders for a future date that purchase planning has recommended expediting, rather than opening a new requisition. In this case, the original date will appear in the Date Expected column, and the recommended date will appear in the Recom. Due Date column. 
 

If no demand is generated for the issue date even though inventory has dropped below safety stock levels, this means the system made up the balance through future purchase orders for which expedition recommendations were issued. The first requisition will be opened after all purchase orders have been executed and can no longer be used to supply the issue. Note that the Bal. Include Demands on the issue date will not reflect projected inventory resulting from expeditable purchase orders. However, in projected balances for the purchase order item, the Date Expected will continue to display the original order date, while the Demand Date will be updated to the date on which inventory is expected to fall below safety stock. 
 
## Notes:

 

 ·        The system generates recommendations to expedite purchase orders according to the Expedited Ord-Onhand date defined for the order. 
 

 ·        In a manufacturing company only: part inventory and purchase orders reduce the requisitioned quantity only if they were not taken into account by MRP. In this case, the form will include a line for MRP Alloc'd . 
 

 ·        Click to analyze additional projected balance items .
