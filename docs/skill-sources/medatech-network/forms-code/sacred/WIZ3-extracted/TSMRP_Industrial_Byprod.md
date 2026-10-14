# TSMRP_Industrial_Byprod

- **Source:** `TSMRP_Industrial_Byprod.htm`

Troubleshooting MRP Wizard - Unexpected Work Orders From Byproducts 
 
 
- 
 
 
 
# Unexpected Work Orders From Byproducts 

 

A normal work order operation usually results in the addition of a single part into inventory. However, the system also provides a special predefined operation (and routing) called Byprod , which results in the creation of a set of different parts, called byproducts, from a single part, called the source part. The source part appears as the child of each of its byproducts. Reporting the Byprod operation in a work order for the source part will automatically create inventory for the resulting byproducts. 
 

MRP generates work orders for all byproducts, even if there is only demand (e.g., a sales order) for a single byproduct. It is therefore possible that a work order will be generated for one byproduct as a result of demand for a different byproduct, created from the same source part. 
 
## To check whether the part is a byproduct:

 

 1 .  Enter the Parts form and retrieve the parent part. 
 

 2 .  Enter the Child Parts sub-level form and check whether the Child Operation of any of the child parts is listed as Byprod .
