# TSMRP_Order_Demands

- **Source:** `TSMRP_Order_Demands.htm`

Troubleshooting MRP Wizard - Order Demands 
 
 
- 
 
 
 
# Demand for Part Orders

 

MRP takes into account sales orders according to the balance and due dates of open order items. 
 

 ·        It only takes into account order items with a positive balance and with a due date that falls within the MRP period. 
 

 ·        It uses the order balance and due date to calculate the quantity of projected demand. 
 

 ·        It creates an issue (for the part itself, if the part in question is a Type R part, or for its direct child part, if the part in question is a Type P part) for the order’s due date and balance. All order demands for the same due date are combined into a single issue quantity. 
 
## To detemine why an order item is ignored by MRP:

 

 1 .  Run the View Dates & Chosen Options program and note the last date for which MRP was run. 
 

 2 .  Enter the View Open Order Items form and retrieve all open sales order items for the part in question. 
 

 3 .  Check the following possible reasons the order item is ignored: 
 

 ·                The order item is not open or the supply balance is zero (or less). 
 

 ·                The order item is not flagged for participation in MRP . 
 

 ·                The order item's due date is later than the date for which MRP was run. 
 
## Manufacturing package only – If the issue/work order quantity does not match the order balance:

 

 1 .  Enter the Sales Orders form and retrieve the orders in question. 
 

 2 .  Check if any of the orders is marked S or F in the Forecast/Stock Order column. In the Manufacturing package, MRP handles forecast orders and orders to stock differently than it handles regular sales orders. Specifically, it handles them according to the value of the MnthForecast constant (as defined in the Production Constants form).
