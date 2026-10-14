# Add_Expenses_Setup_Std_Shipping_Costs

- **Source:** `Add_Expenses_Setup_Std_Shipping_Costs.htm`

Shipping Expenses - Setup: Standard Shipping Costs.1 
 
 
- 
 
 
 
# Defining Standard Shipping Costs

 

You can define standard costs for shipment by air, land or sea, and designate a default shipping cost type . If actual expenses have not been linked to a purchased part, the costing program automatically uses the standard shipping cost instead. 
 

Standard shipping costs can be defined on three levels: 
 

 Part family – use this option when all parts in the family have the same shipping cost. The shipping cost defined for a given part family serves as the default cost for all parts that are newly assigned to the family. 
 

 Part – use this option for parts whose shipping costs differ from those of other parts in the same family (but do not vary according to vendor). 
 

 Vendor part – use this option when the cost of shipping the part from a particular vendor differs significantly from the part's standard shipping cost. 
 

When you open a GRV, the default shipping cost type appears automatically, though it may be revised. The system then takes the corresponding shipping cost from the vendor part; if the cost was not defined for the vendor part, it takes the cost defined for the part. 
 

 Important: Standard costing only takes into account standard shipping costs defined for parts (either manually or automatically, when the part is added to a part family), but not vendor parts. It is therefore imperative to ensure that standard shipping costs are defined for all parts (in the Financial Parameters for Parts form). 
 

In addition, you can set up the system so that no standard shipping expenses are calculated for selected parts when ordered from a certain vendor (despite their part definitions).
