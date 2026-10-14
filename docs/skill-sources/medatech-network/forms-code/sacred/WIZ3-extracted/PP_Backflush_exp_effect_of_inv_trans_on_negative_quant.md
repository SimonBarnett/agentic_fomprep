# PP_Backflush_exp_effect_of_inv_trans_on_negative_quant

- **Source:** `PP_Backflush_exp_effect_of_inv_trans_on_negative_quant.htm`

PP_Backflush_exp_effect_of_inv_trans_on_negative_quant 
 
 
- 
 
 
 

Inventory control on the plant floor is meant to be managed solely by certain inventory transactions: issues (of various types), automatic transactions recorded by the Backflush program as a result of production reports (reduction of child parts, addition of parent parts and transfer of finished parts from the plant floor), shipments to subcontractors and receipt of goods from subcontractors, as well as rare occasions when finished parts are manually transferred from the plant floor. All other inventory transactions recorded for floor warehouses are unusual and likely to cause discrepancies in inventory calculations. 
 

 Example: Production reports have been recorded for the part "Kitchen Cabinet," for the operation "Door Assembly" and the following operation "Lacquering," both for a quantity of 10 cabinets. In addition, a warehouse transfer has been recorded, in which 4 cabinets were transferred from the floor warehouse, in the "Door Assembly" operation. When the Backflush program records inventory transactions against production reports on the operation "Lacquering," it reduces from floor inventory 10 units of the part "Kitchen Cabinet" in the operation "Door Assembly." However, due to the warehouse transfer the inventory balance of cabinets in the "Door Assembly" operation is, in fact, 6, causing an inventory balance of -4.
