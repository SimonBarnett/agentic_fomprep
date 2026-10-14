# COGS_Setup_Constants_2

- **Source:** `COGS_Setup_Constants_2.htm`

COGS (Perpetual) - Defining COGS Constants.2 
 
 
- 
 
 
 

 3 .  Assign the appropriate value to the COGSPeriod constant.
 Notes: 
 

 ·      The Post Cost of Goods Sold program runs for a given range of fiscal periods. In perpetual COGS, there are two ways to record journal entries for the defined range: on a monthly or daily basis. The first option is more efficient, whereas the second is more detailed. A summary journal entry is recorded for each journal entry type for the day or month, according to the value of the constant. For example, if the daily option is defined, a single journal entry is recorded on a given date with the entry code IT . The entry is recorded for all inventory transactions recorded on that date that create journal entries of this type (e.g., GRVs). 
 

 ·      You can record online COGS entries for customer invoices and selected types of inventory transactions (e.g., customer shipments). To do so, first flag those types of inventory transactions in the Record COGS Online column of the Inv. Transaction Documents form; then assign a value of 2 to the COGSPeriod constant. As a result, COGS entries are recorded whenever an invoice/document is finalized. The Post Cost of Goods Sold program then updates the respective accounts according to the latest costing data. For all other inventory transactions, daily entries are recorded. 
 

 ·      Variance entries for transactions on the plant floor are always recorded as summary transactions (for the entire COGS period), regardless of the value of this constant. Click for details. 
 

 4 .  Assign the appropriate value to the COGSPost constant.
 Note: You can record pending journal entries for the inventory transactions or have the system post the entries automatically. By recording pending entries, you can check the results of the COGS program (via the COGS Transactions report) before posting them to the ledger; therefore, it is recommended to use this approach when you first work with COGS. After results have been checked for several runs of the program and you are satisfied with them, you can have the entries posted automatically. 
 

 5 .  Assign the appropriate value to the COGSSubcontractor constant. 
 Note: This constant is used to determine whether standard subcontracting costs should be calculated from the subcontracting cost defined for the part itself ( COGSSubcontracto r = 0 ) or from the subcontracting cost of the part and of its child parts ( COGSSubcontracto r = 1 ). 
 
## Note:

 

Click to return to the main Perpetual COGS screen.
