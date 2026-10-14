# TSPurchPlan_Industrial_Prod

- **Source:** `TSPurchPlan_Industrial_Prod.htm`

Troubleshooting Purchase Planning - Manufacturing, Processed Part 
 
 
- 
 
 
 
# Requisitioned Quantities for Processed Parts

 

Purchase planning opens requisitions for parts that are defined as produced by subcontractors (according to the work orders included in MRP). These include parts whose standard production operations include an operation performed at a work cell linked to a subcontractor warehouse, and work orders that have been assigned to a subcontractor (in the upper-level Work Orders form). 
 

 Note: The value assigned to the Inv./Costing Control column for the operation or work cell is irrelevant in this case. 
 
## To check if a part is meant to be produced by a subcontractor:

 

 1 .  Enter the Parts form, and retrieve the part in question. 
 

 2 .  Move to the Routing column (in the General tab) and press F6 twice. 
 

 3 .  Enter the Operations in Routing sub-level form. 
 

 4 .  For each operation, move to the Work Cell column and press F6 . 
 

 5 .  Make a note of the values in the Warehouse column linked to the work cells for each operation. 
 

 6 .  Enter the Vendors form, and execute a query for vendors for which one of the previously noted warehouses appears in the Subcontractor Warehouse column. If a vendor record is retrieved, this indicates that the vendor is a subcontractor that performs an operation in the part’s routing.
