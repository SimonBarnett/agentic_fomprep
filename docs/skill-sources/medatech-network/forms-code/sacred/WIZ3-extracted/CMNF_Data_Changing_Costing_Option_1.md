# CMNF_Data_Changing_Costing_Option_1

- **Source:** `CMNF_Data_Changing_Costing_Option_1.htm`

Costing for Manufacturers - Data: Updating the Calculation Method of Actual Costs.1 
 
 
- 
 
 
 
# Changing the Costing Option of Manufactured Parts

 

The transition between calculation methods W (by work orders) and T (by BOM) for a given part is usually necessitated by an actual change in the factory's method of production management. 
 

When performing such a transition, you must first record a past balance and run costing for the date of the transition. Otherwise, some of the data for the current costing period will relate to work orders and some will not, and the costing program will simply ignore any data that does not relate to work orders. Similarly, if method T was assigned to a part that is actually produced in work orders (due to problems resulting in unreliable production reporting), and was later replaced by W (after the problems were solved), the costing program will take into account all data from the entire period – including the unreliable reports. 
 

You must therefore be sure to conclude the use of a calculation method with a costing run.
