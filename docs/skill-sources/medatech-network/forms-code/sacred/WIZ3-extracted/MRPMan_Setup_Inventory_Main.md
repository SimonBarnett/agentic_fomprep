# MRPMan_Setup_Inventory_Main

- **Source:** `MRPMan_Setup_Inventory_Main.htm`

MRP for Manufacturers - Setting Up Inventory Parameters 
 
 
- 
 
 
 
# Setting Up Inventory Parameters

 

You can choose to have MRP take into account existing floor inventory of bulk parts when planning purchase requisitions for raw materials. That is to say, if demand has been generated for such a part, MRP reduces that demand against any existing balances of that part that were issued in bulk to the plant floor. Most of the following setups are only relevant when this option is selected. 
 

First, you need to make sure that warehouses and inventory statuses, which affect the way MRP handles inventory balances, are correctly defined. 
 

You can then choose one of two options: to reduce the demand from a specific floor warehouse against inventory found in the same warehouse, or to reduce it against inventory found in all floor warehouses in the factory. The first option is appropriate when production is shared with subcontractors; one subcontractor's floor inventory is not usually available to another subcontractor. The second option is appropriate when the various floor warehouses are in close proximity, and parts can be transferred among them easily. 
 

Third, bulk parts are issued to the plant floor or to subcontractors, usually in large quantities, in an Issues to Floor Stock or Shipmt to Subcontr/Issue of Kit document, respectively. One of the ways in which the system can determine the quantities to issue is on the basis of the MRP issues plan. 
 

Finally, you can define whether MRP uses existing inventory of alternate parts to reduce demand.
