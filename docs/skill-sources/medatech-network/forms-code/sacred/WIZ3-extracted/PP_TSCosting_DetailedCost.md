# PP_TSCosting_DetailedCost

- **Source:** `PP_TSCosting_DetailedCost.htm`

PP_TSCosting_DetailedCost 
 
 
- 
 
 
 

When the DetailedCost constant is set to 0 , the cost of all manufactured child parts (sub-assemblies) is added as a lump sum to the material costs of the parent work order. The child costs that are taken into account are those in effect on the issue date. 
 

When the constant is set to 1 , the cost of sub-assemblies is added to each cost component of the parent work order. That is, the material cost of the child parts is added to the parent's material cost, the supply costs of the child parts are added to the parent's supply costs and so forth, using the costs calculated on the last past balance date. In other words, the entire cost of the child parts is added to the parent part cost, but broken down into cost components.
