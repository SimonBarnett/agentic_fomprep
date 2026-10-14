# CMNF_Setup_Standard_Costs_Recording

- **Source:** `CMNF_Setup_Standard_Costs_Recording.htm`

Costing for Manufacturers - Starting: Recording Standard Costs 
 
 
- 
 
 
 
# Recording Standard Costs 

 

Record standard costs for all Type R parts. Standard costs serve as the default for actual costs of purchased parts, when the following conditions are met: 
 

 ·        there are no purchase transactions recorded for a part with purchase prices that can be used as a cost source, and 
 

 ·        no cost was calculated for the part in the previous past balance. 
 

The standard cost of a manufactured part is calculated according to the cost of its child parts in the bill of materials, and serves as the default for the part's actual cost when no warehouse assembly or work order production is reported for it. 
 

If you maintain vendor price lists, you can copy standard costs from vendor prices automatically. You can use the same procedure to copy standard costs from the last recorded purchase prices, if you have already recorded invoices in Priority , or from the part's actual cost as calculated by the costing program. 
 
## Notes: 

 

 ·        Costing does not update the standard costs recorded for Type R parts according to the calculated costs (which include shipping costs), but it does update the standard costs of Type P parts, provided that the UpdStdCost constant is set to 1 . 
 

 ·        Click for an explanation of standard costs as they relate to assembled (Type P ) parts. 
 
## What do you want to do?

 

 Set the value of the UpdStdCost constant 
 

 Record standard costs manually 
 

 Copy standard costs automatically
