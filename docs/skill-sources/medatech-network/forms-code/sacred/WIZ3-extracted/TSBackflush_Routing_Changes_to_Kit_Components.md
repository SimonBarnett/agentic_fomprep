# TSBackflush_Routing_Changes_to_Kit_Components

- **Source:** `TSBackflush_Routing_Changes_to_Kit_Components.htm`

Troubleshooting Backflush Wizard - Routing Changes to Processed Parts Issued in Bulk 
 
 
- 
 
 
 
# Routing Changes to Processed Parts Issued in Bulk

 

You define the operation at which each child part is incorporated into its parent part. If this occurs at the last operation in the child part's routing (or the only operation, e.g., when the routing is Assembly ), then when it is transferred or issued to the floor, the balance will sometimes appear without an operation. 
 

When the Backflush program is run, the system attempts to locate parts at the child operation for a given reported parent operation, according to definitions at the time the work order was released. If there is inventory in the floor warehouse without an operation for processed child parts issued in bulk, the system treats this as inventory in the last operation of the current part routing. If this routing was changed after the work order was released, the system will not backflush the inventory.
