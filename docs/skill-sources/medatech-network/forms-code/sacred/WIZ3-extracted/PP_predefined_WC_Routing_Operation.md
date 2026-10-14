# PP_predefined_WC_Routing_Operation

- **Source:** `PP_predefined_WC_Routing_Operation.htm`

PP_predefined_WC_Routing_Operation 
 
 
- 
 
 
 

  
 
 
 
 

 Work Cell 
 
 

 Routing 
 
 

 Operation in Routing 
 
 
 

Assemb 
 
 

Assembly: Warehouse assembly – the default routing for processed (type P ) parts 
 
 

Assemb 
 
 
 

Issue 
 
 

Issue: Issue of raw materials to the plant floor – the default routing for purchased (type R ) parts 
 
 

Issue 
 
 
 

Phanto 
 
 

Phanto: For a virtual type P part that represents a group of child parts (issue plans, Backflush and production reports ignore phantoms, and relate directly to their components) 
 
 

Phanto 
 
 
 

Releas 
 
 

  
 
 

Releas (appears automatically as the first operation in every routing, when the WorkOrdNum constant is set at 1 ) 
 
 
 

Byprod 
 
 

Byprod: For parts that create byproducts during their production 
 

Note: This routing requires special modeling 
 
 

Byprod (the main operation in the routing for byproducts, in which the part joins its parent part, the byproduct)
