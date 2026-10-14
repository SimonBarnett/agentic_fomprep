# Forecasts_Update_Quantites_in_Order

- **Source:** `Forecasts_Update_Quantites_in_Order.htm`

Demand Forecasts - Explanation: Deducting Forecast Order Inventory 
 
 
- 
 
 
 
# Deducting Forecast Order Inventory When Calculating Sales Order Demand

 

MRP aims to ensure that ordered quantities of parts will be ready in their entirety on the designated due dates, whether this involves forecast orders or regular sales orders. However, whereas sales orders reflect a genuine demand for goods that need to be delivered to customers, forecast orders prepare inventory in anticipation of actual orders, so that production or assembly of the parts is completed in advance and goods are available for immediate supply. Thus, the demand for a part in a forecast order reflects an expected increase in inventory, whereas the demand for a sales order item reflects an expected decrease in inventory. 
 

When calculating production quantities and dates, if both actual sales orders and forecast orders exist for the same month, MRP deducts the sales orders from the forecast orders. The way in which this is carried out is determined by the value of the MnthForecast constant. 
 
## Note:

 

Click for an explanation of the MnthForecast constant.
