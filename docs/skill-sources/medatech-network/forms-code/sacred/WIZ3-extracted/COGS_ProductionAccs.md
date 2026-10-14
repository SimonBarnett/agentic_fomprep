# COGS_ProductionAccs

- **Source:** `COGS_ProductionAccs.htm`

COGS (Perpetual) - How Production Affects COGS Entries 
 
 
- 
 
 
 
# How Production Affects COGS Entries

 

Costs of reported production are calculated based on quantities and times that were reported during the COGS period. 
 

When COGS is run, journal entries recorded for issues and production reports debit three separate plant-floor inventory accounts – for materials, labor and burden, based on reported quantities and times. Transactions of completed production then credit the plant-floor inventory accounts according to the standard quantities and times defined for the manufactured part, again broken down into the components of materials, labor and burden. Consequently, if reported quantities or time spans differ from the part's standard cost definitions, the plant-floor inventory account will contain residual amounts once production is completed. At the end of the COGS period, adjustment entries are recorded to deal with this variance, so that the balances of plant-floor inventory accounts match the standard inventory valuations of the plant-floor warehouse. 
 

Specifically, the Post Cost of Goods Sold program updates the accounts of the plant floor as follows: 
 

 ·        Issues: A journal entry debits the Purchases/Inventory account of the floor warehouse for any inventory transaction involving issues to that warehouse. The entry sum is the cost of the materials ; its transaction date is the issue date. 
 

 ·        Reported Production (Labor): A journal entry debits the Inventory – Labor account of the plant floor warehouse and credits the Labor Offset account for the total labor cost on the end date of the COGS period, based on production reports recorded during that period. 
 

 ·        Reported Production (Burden): A journal entry debits the Inventory – Burden account of the plant floor warehouse and credits the Burden Offset account for the total burden on the end date of the COGS period, based on production reports recorded during that period. 
 

 ·        Completed Production: A journal entry credits the plant-floor inventory account and debits the finished goods warehouse's inventory account for all transactions of completed production. The sum of each entry is the standard cost of the manufactured part (for the cost component in question). Details. 
 

 ·        Adjustments: Three variance entries are recorded for the end date of the COGS period. Click for an explanation of entries for variance 
 
## Note:

 

The Post Cost of Goods Sold program does not create entries for Backflush transactions.
