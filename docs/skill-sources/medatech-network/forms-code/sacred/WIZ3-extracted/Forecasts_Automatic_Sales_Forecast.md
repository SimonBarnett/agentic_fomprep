# Forecasts_Automatic_Sales_Forecast

- **Source:** `Forecasts_Automatic_Sales_Forecast.htm`

Demand Forecasts - Itemizing a Forecast Automatically 
 
 
- 
 
 
 
# Itemizing a Demand Forecast Automatically

 

The Prepare Demand Forecast program allows you to itemize a forecast automatically by indicating the parts to be included rather than recording each one manually. When the program is finished, you simply fill in forecasted monthly quantities for each part. 
 
## To itemize a demand forecast automatically:

 

 1 .  Run the Prepare Demand Forecast program. 
 

 2 .  Fill in the relevant input columns. Pay particular attention to the Part Number , as this determines the parts that will appear in your forecast.
 Note: If you prepare a demand forecast for a specific customer, when you open a forecast order based on this forecast, it will automatically be recorded for this customer. However, the customer appearing in forecast orders is informative only and does not affect MRP. MRP takes forecast orders into account as a general demand for inventory (which can be used to fill sales orders for any customer). 
 

 3 .  When the program is completed, you will receive a message indicating the number of the new forecast and the amount of lines included in it. Copy the forecast number and click OK . 
 

 4 .  Enter the Demand Forecasts form and retrieve the newly created forecast. 
 

 5 .  The Order Due Date determines the due date of the forecast order that will be opened. It is filled in automatically on the basis of the SFcastOrdDay constant. Revise as necessary.
 Note: The due date of individual forecast order items can be revised manually in the order itself. 
 

 6 .  Enter the sub-level form, Itemized Forecast . 
 

 7 .  For each part appearing in the form, designate forecasted monthly quantities.
 Note: The total quantity (per month and for the entire year) of expected demand for all parts appears in the upper-level form. These totals are only of interest when all parts share the same unit.
