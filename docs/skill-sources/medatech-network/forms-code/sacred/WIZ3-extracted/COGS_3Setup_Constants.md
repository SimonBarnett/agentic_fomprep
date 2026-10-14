# COGS_3Setup_Constants

- **Source:** `COGS_3Setup_Constants.htm`

COGS (Periodic) - Defining COGS Constants 
 
 
- 
 
 
 
# Defining COGS Constants

 

Three constants affect the functionality of the Post Cost of Goods Sold program. They determine the method by which COGS is calculated, the level at which COGS entries are created (periodic totals, daily totals) and whether or not journal entries are posted automatically to the ledger. 
 
## To define COGS constants:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Assign a value of 3 to the COGSMethod constant. 
 

 3 .  Assign the appropriate value to the COGSPeriod constant.
 Note : The Post Cost of Goods Sold program runs for a given range of fiscal periods. If you work with periodic entries, inventory accounts will be updated at the end of each fiscal period in accordance with the latest inventory values calculated by costing. If you work with daily entries, inventory accounts will be updated daily. In the former case, the balance of inventory accounts is equivalent to inventory values at the end of the period only, once the Post Cost of Goods Sold program is run. Any financial statement that is run on a date falling within that fiscal period will not reflect the correct inventory value or cost of goods sold for that date. 
 

 4 .  Assign the appropriate value to the COGSPost constant.
 Note: You can record pending journal entries for the inventory transactions or have the system post the entries automatically. By recording pending entries, you can check the results of the COGS program (via the COGS Transactions report) before posting them to the ledger; therefore, it is recommended to use this approach when you first work with COGS. After results have been checked for several runs of the program and you are satisfied with them, you can have the entries posted automatically.
