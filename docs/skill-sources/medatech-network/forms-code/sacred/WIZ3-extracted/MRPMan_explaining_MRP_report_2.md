# MRPMan_explaining_MRP_report_2

- **Source:** `MRPMan_explaining_MRP_report_2.htm`

MRP for Manufacturers - Analyzing MRP Results.2 
 
 
- 
 
 
 

 Demand from Forecast Orders: The quantity of parts recorded in open forecast orders (including stock orders that are not based on forecasts). Forecast orders generate demand when they are not canceled out by actual sales orders, under the conditions defined by the MnthForecast production constant. 
 

 Open Purchase Orders: Inventory ordered from a vendor in an open purchase order (that has not yet been supplied).
 Note: MRP only takes into account purchase orders for manufactured (Type P ) parts from vendors that are not defined as subcontractors. Purchase orders for Type R parts are taken into account during purchase planning. 
 

 Open Purchase Orders for Alternate Parts : Alternate Type P parts ordered from a vendor in an open purchase order.
 Note: Analysis reports display results for alternate manufactured parts under the heading PO for Alt Part . 
 

 Open Work Orders: The quantity of parts that remains to be produced in open and released work orders. 
 Notes: 
 

 ·      MRP only takes open work orders into account if you select the corresponding run-time option. 
 

 ·      Open work orders that are not taken into account during MRP calculations (e.g., due to the rescheduling of a sales order) appear under the heading Surplus Work Order .
