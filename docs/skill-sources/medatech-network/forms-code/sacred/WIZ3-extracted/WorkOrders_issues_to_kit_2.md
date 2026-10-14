# WorkOrders_issues_to_kit_2

- **Source:** `WorkOrders_issues_to_kit_2.htm`

Work Orders - Issuing to the Work Order Kit.2 
 
 
- 
 
 
 
# To issue parts to a kit:

 

 1 .  Enter the Work Orders form and retrieve the desired work order. 
 

 2 .  Enter the Kit List sub-level form. If the list contains an item that is not required for the current work order, delete the line. If there is a part that is not included in the original BOM, but is required for this work order, add a new line for it. 
 

 3 .  Enter the Issues to Kits sub-level form. For each line item in the Kit List form that is flagged for issue to the kit, one or more lines appear automatically. 
 

 4 .  Revise each line as needed (e.g., issuing warehouse, lot number). 
 

 5 .  If the part to be issued is an alternate part, make sure that the alternate part is acceptable for this particular work order. 
 

 6 .  Make sure that the From Warehouse and Bin columns display the warehouse and bin from which you want to issue the part.
 Notes: 
 

 ·              If several inventory balances are available for the part, the system chooses the balance(s) from which to issue the part according to a defined order of precedence . 
 

 ·              You cannot issue parts from a plant-floor warehouse. 
 

 ·              If you have added an issue manually, you must fill in the columns manually. 
 

 7 .  The To Warehouse column displays the floor warehouse to which parts are expected to be issued. Make sure that this value is correct for the current issue.
 Note: When the operation is performed in the factory, this is the warehouse linked to the work cell in which the operation is performed. When performed by a subcontractor, this is the subcontractor's kit warehouse (for more information, run the Working w/Subcontractors Wizard ).
