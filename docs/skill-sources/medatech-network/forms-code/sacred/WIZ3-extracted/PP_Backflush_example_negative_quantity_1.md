# PP_Backflush_example_negative_quantity_1

- **Source:** `PP_Backflush_example_negative_quantity_1.htm`

PP_Backflush_example_negative_quantity_1 
 
 
- 
 
 
 

A common cause of negative inventory for a part in the middle of its processing is incomplete production reporting. When you report a particular operation, the Backflush program reduces the inventory of the parent part in the previous operation against the reported quantity. If no production report was recorded for the previous operation, the reduction of inventory causes a negative balance in the previous operation. 
 

 Example: In the production of kitchen cabinets, the operation "Door Assembly" precedes the operation "Lacquering." A production report records "Lacquering" for a quantity of 10 cabinets. By mistake, no production report was recorded for "Door Assembly." As a result, when the Backflush program is run, a balance of 10 appears for the part "Kitchen Cabinet" in the "Lacquering" operation, while a balance of -10 appears in the "Door Assembly" operation.
