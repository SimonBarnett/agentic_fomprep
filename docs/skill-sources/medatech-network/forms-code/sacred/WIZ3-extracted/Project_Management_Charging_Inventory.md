# Project_Management_Charging_Inventory

- **Source:** `Project_Management_Charging_Inventory.htm`

Project Management - Charging the Project for Inventory 
 
 
- 
 
 
 
# Charging the Project for Inventory

 

 Priority tracks the inventory that is used by each project. This inventory is charged to the project and its costs added to the actual costs of the project. How it is charged depends on the type of transaction and the warehouse involved: 
 

 ·        Transactions where inventory is received are only charged to the project when the receiving warehouse is linked to the project. If not, the received goods are charged to the project when they are issued to it.
 Note: Parts ordered from a vendor are charged to the project even before they arrive at the warehouse, if the purchase order is linked to the project. Nonetheless, if the ordered goods are then received in a non-project warehouse, the project is credited for those goods. 
 

 ·        Transactions where inventory is shipped are charged to the project only when the sending warehouse is not a project warehouse.
 Note: Parts belonging to families that have been flagged in the Production for Proj column are not taken into account when calculating the cost of customer shipments or returns. Such parts were produced for a specific project, and so were already charged to the project during production. 
 

 ·        Warehouse transfers are charged to the project only when the receiving warehouse is a project warehouse and the sending warehouse is not. 
 

It is important, therefore, to make proper use of project warehouses. Specifically, make sure you receive inventory intended for a project into one of the project warehouses. This ensures that when you ship goods to the project (e.g., via issues of supplies or shipments to customer), they are not charged again to the project. 
 
## Notes:

 

 ·        Click to assign a warehouse to a project . 
 

 ·        Run the Check Transact'ns Linked to Proj report to view inventory transactions with potential problems (e.g., a problem might result when a GRV is linked to the project and the goods were not received into a project warehouse). To pinpoint and correct the actual problems, you will need to access the transaction document itself. 
 

 ·        Click to return to the Project Implementation menu.
