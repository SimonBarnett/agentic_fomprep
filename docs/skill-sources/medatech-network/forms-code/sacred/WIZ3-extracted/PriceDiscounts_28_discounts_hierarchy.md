# PriceDiscounts_28_discounts_hierarchy

- **Source:** `PriceDiscounts_28_discounts_hierarchy.htm`

Prices and Discounts - Hierarchy of Discounts 
 
 
- 
 
 
 
# Hierarchy of Discounts

 

 Priority supports three types of discounts: part discount, family discount and overall discount. The first two types apply to line items in any sales document, thereby serving as item discounts . The last type affects the entire document and is applied on top of the item discount. 
 

You can assign each type of discount to a customer. You can also assign discounts to a representative customer, which then apply to all customers linked to the representative. 
 

When the SAddDiscount constant is set at 0 , only a single item discount and a single overall discount can be used in a given sales document, based on a predefined hierarchy. 
 
## The hierarchy determining the item discount is as follows (in order of precedence):

 

 ·        The discount set for the component in a product bundle on which the current document is based.
 Note: For details, run the Product Bundles Wizard . 
 

 ·        The part discount defined for the customer 
 

 ·        The family discount defined for the customer 
 

 ·        The part discount defined for the representative customer 
 

 ·        The family discount defined for the representative customer. 
 

 ·        The part discount defined for the general representative. 
 

 ·        The family discount defined for the general representative. 
 
## The hierarchy determining the overall discount is as follows:

 

 ·        The overall discount defined for the customer 
 

 ·        The overall discount defined for the representative customer. 
 

 ·        The overall discount defined for the general representative.
