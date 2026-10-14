# Vendor_Parts_Wizard_define_constant

- **Source:** `Vendor_Parts_Wizard_define_constant.htm`

Vendor Parts/Prices - Setup: Last Price Search 
 
 
- 
 
 
 
# Defining the Search Period for Last Prices

 

When itemizing a purchase order or requisition, the system can fill in the part prices automatically according to various sources, as defined in the system. When no other price source is found, the system searches for the last price paid for that part to any vendor. Use the PPriceDays constant to define the number of days within which the system can search back for the last recorded vendor price. If no purchase was recorded within the defined period, the system leaves the price blank. 
 
## To define the search period:

 

 1 .  Enter the Logistic Constants form. 
 

 2 .  Move to the PPriceDays constant and specify the desired number of days.
