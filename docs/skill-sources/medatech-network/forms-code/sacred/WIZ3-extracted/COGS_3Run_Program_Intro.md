# COGS_3Run_Program_Intro

- **Source:** `COGS_3Run_Program_Intro.htm`

COGS (Periodic) - Running the COGS Program 
 
 
- 
 
 
 
# Running the COGS Program 

 

You can run the program at the end of each fiscal period, and you can run it daily. In the former case, the balance of inventory accounts will be equivalent to inventory values at the end of the period only , once the Post Cost of Goods Sold program is run. 
 
## To update inventory accounts each fiscal period: 

 

 1 .  Calculate a past balance for the last day of the fiscal period that precedes the period for which you are running COGS, and run costing. 
 Notes: 
 

 ·      You can view the dates of the fiscal periods defined for a given fiscal year in the Define Fiscal Years form. 
 

 ·      You can view the dates of previous past balances, and the costing runs executed for them, in the Dates of Calculated Balances form. 
 

 2 .  Calculate a past balance for the last day of the last period for which you are running COGs and run costing again. 
 

 3 .  To preview the results of the Post Cost of Goods Sold program without actually recording journal entries, run the following reports: 
 

 ·      COGS Transactions 
 

 ·      COGS Transactions per Account 
 

 ·      COGS Details per Part 
Check that desired results are obtained before continuing. 
 

 4 .  Run the Post Cost of Goods Sold program. 
 
## To update inventory accounts daily:

 

 1 .  Make sure the COGSPeriod constant is set to 1 . 
 

 2 .  Run the Costing for Current Date program. 
 Tip: Run it overnight, using the Task Scheduler. 
 

 3 .  Run the COGS Transactions report and/or the COGS Transactions per Account report to preview the results of the Post Cost of Goods Sold program without actually recording journal entries. Check that desired results are obtained before continuing. 
 

 4 .  Run the Post Cost of Goods Sold program. Entries will be assigned the costing date. 
 
## Notes: 

 

 ·        Click to view COGS results . 
 

 ·        Click to return to the main Periodic COGS screen.
