# Costing_Initializing_Standard_Costs

- **Source:** `Costing_Initializing_Standard_Costs.htm`

Costing for Businesses - Initialization: Standard Costs 
 
 
- 
 
 
 
# Recording Standard Costs 

 

Record standard costs for all Type R parts. Standard costs serve as the default for actual costs of purchased parts when the following conditions are met: 
 

 ·        There are no purchase transactions recorded for a part containing purchase prices that can be used as a cost source, and 
 

 ·        No cost was calculated for the part in the previous past balance. 
 

The standard cost of assembled parts is calculated according to the cost of its child parts in the bill of materials, and serves as the default for the part's actual cost when no warehouse assembly is recorded for it. 
 

If you maintain vendor price lists, you can copy standard costs from vendor prices automatically. You can use the same procedure to copy standard costs from the last recorded purchase prices, if you have already recorded invoices in Priority , or from the part's actual cost as calculated by the costing program. 
 

If you maintain vendor price lists, you can copy standard costs from vendor prices automatically. If you have already been working in Priority and recorded purchase invoices, you can use the same procedure to copy standard costs from the last recorded purchase prices or from the part's actual cost as calculated by the costing program. 
 

Standard costs recorded at this stage for Type R parts serve as the basis of standard cost calculations by the costing program, together with the standard shipping costs. 
 

 Notes: 
 

 ·        Costing does not update the standard costs recorded for Type R parts according to the calculated costs (which include shipping costs), but it does update the standard costs of Type P parts, provided that the UpdStdCost constant is set to 1 . 
 

 ·        Click for an explanation of standard costs as they relate to assembled (Type P ) parts. 
 
## What do you want to do?

 

 Set the value of the UpdStdCost constant 
 

 Record standard costs manually 
 

 Copy standard costs automatically
