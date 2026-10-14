# TSBackflush_Transferred_To_Floor1_1_1_1_4

- **Source:** `TSBackflush_Transferred_To_Floor1_1_1_1_4.htm`

Troubleshooting Backflush Wizard - Reported Quantity Exceeds Work Order Quantity 
 
 
- 
 
 
 
# The Reported Quantity Exceeds the Work Order Quantity

 

The program will attempt to backflush child parts according to the following formula: Reported Quantity * Parent/Child Ratio as defined in the work order. 
 

This ratio is calculated based on the quantity of the child part recorded in the Kit List form divided by the Work Order Quantity in the Work Orders form. 
 

Even if the part was issued in full, if the reported quantity is greater than the work order quantity, the program will backflush a quantity greater than that listed in the kit list and missing issues will be generated.
