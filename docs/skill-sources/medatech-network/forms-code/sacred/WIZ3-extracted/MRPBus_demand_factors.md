# MRPBus_demand_factors

- **Source:** `MRPBus_demand_factors.htm`

MRP for Distributors - Factors Affecting Demand 
 
 
- 
 
 
 
# Factors Affecting Demand

 

 ·        Sales orders and f orecast/stock orders : For parts with replenishment type R (i.e., dynamic demand ), the program takes into account open orders with a positive supply balance that are flagged for participation in MRP, and whose due dates fall within the planning period. This includes orders for the part itself, or for its direct parent parts. 
 Note: If orders have been received for a part with replenishment type B (i.e., static demand ), the order quantity will appear in the MRP issues plan; however, purchase planning will ignore these issues, and plan purchase requisitions based on the demand parameters defined for the part in the Purchase/MRP Parameters for Part form. 
 

 ·        Existing inventory: When calculating the required quantities of assembled parts, MRP takes into account existing inventory in type D warehouses, reducing the calculated demand accordingly. 
 Note: MRP for Businesses does not take existing inventory into account when calculating the demand for purchased parts. This is handled directly by purchase planning, at a later stage.
