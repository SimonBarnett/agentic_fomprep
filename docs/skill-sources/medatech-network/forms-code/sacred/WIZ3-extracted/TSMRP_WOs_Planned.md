# TSMRP_WOs_Planned

- **Source:** `TSMRP_WOs_Planned.htm`

Troubleshooting MRP Wizard - Production Demands, Planned Work Orders 
 
 
- 
 
 
 
# Planned Work Orders (for the Parent Part)

 

Planned work orders are opened by MRP based on the quantity of the parent part required for sales or production, plus the scrap percentage defined for the parent part, after deducting the quantity of available inventory and production balance from released work orders that MRP takes into account. 
 

If the part in question is produced by a subcontractor , quantities in purchase orders from vendors that are not subcontractors are also taken into account . 
 
## If a demand range has been defined:

 

One work order is opened for all part demands within the chosen time period on the first date of that period. 
 
## If an increment for has been defined:

 

The calculated part demand will be rounded up, according to the designated increment. For example, if the increment is defined as 50 and the required quantity is 35, the work order is opened with a quantity of 50. If the required quantity is 62, the work order is rounded to 100. 
 
## If a minimum for order/work order has been defined:

 

The part demand calculated will be rounded up if less than the designated minimum. 
 
## If a maximum for work order has been defined:

 

A work order is opened for up to the maximum quantity defined. If a balance remains for a given part demand, an additional work order is opened to cover it. 
 
## Planned issues:

 

MRP generates issues based on the parent-child ratio defined in the BOM. If BOM revisions are maintained for the parent part, the parent-child ratio is determined by the BOM revision that is currently in effect. The planned issue for parent part work orders is based on the original demand, minus floor inventory, minus alternate part inventory, plus scrap. 
 
## Note:

 

Use of floor inventory and alternate inventory depends on certain definitions. 
 
## What do you want to do?

 

 Analyze use of floor inventory 
 

 Analyze use of alternate inventory 
 

 Analyze demands resulting from scrap 
 
## Note:

 

Click to return to the main screen .
