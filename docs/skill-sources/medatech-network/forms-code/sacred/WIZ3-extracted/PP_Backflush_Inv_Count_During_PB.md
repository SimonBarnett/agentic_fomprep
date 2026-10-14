# PP_Backflush_Inv_Count_During_PB

- **Source:** `PP_Backflush_Inv_Count_During_PB.htm`

PP_Backflush_Inv_Count_During_PB 
 
 
- 
 
 
 

Inventory counts in plant floor warehouses should only be performed immediately before the past balance is calculated. Missing issues of kit components are only adjusted by inventory counts when the past balance is recorded, whereas missing issues of bulk parts are immediately adjusted by the inventory count when the Backflush program is run. 
 

 Example: 
 

Missing issues have been recorded for a part issued in bulk to Work Order X . In an inventory count performed from the Prepare Count for Past Date menu, a counted quantity of 0 was approved. When production was reported for Work Order Y , which requires the same part, missing issues were again recorded for Work Order X . This is because the automatic reduction of child parts calculated by the Backflush program is not performed in the order in which production reports are recorded.
