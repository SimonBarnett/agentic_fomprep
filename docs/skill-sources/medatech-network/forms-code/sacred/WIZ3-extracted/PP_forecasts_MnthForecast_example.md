# PP_forecasts_MnthForecast_example

- **Source:** `PP_forecasts_MnthForecast_example.htm`

PP_forecasts_MnthForecast_example 
 
 
- 
 
 
 

A factory has 300 chairs in inventory at the beginning of October. The forecast order for this month is for 500 chairs due on October 15. A customer has ordered 450 chairs due on October 10: 
 

 ·        If the constant is set to 1 (consider all forecast order items due in the same month), MRP will deduct inventory for the sales order from the forecast order as follows: a work order will be opened for the quantity in the sales order (less the amount currently in stock) on the date of the sales order, and an additional work order will be opened on the forecast date for the difference between the two. 
 

 ·        If the constant is set to 0 (consider the exact due date), then inventory will not be deducted; that is, a work order will be opened for the quantity in the sales order (less the amount currently in stock), and an additional work order will be opened for the entire forecast.
