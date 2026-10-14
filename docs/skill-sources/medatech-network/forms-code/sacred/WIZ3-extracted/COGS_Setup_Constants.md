# COGS_Setup_Constants

- **Source:** `COGS_Setup_Constants.htm`

COGS (Perpetual) - Defining COGS Constants.1 
 
 
- 
 
 
 
# Defining COGS Constants

 

Three constants affect the functionality of the Post Cost of Goods Sold program. They determine the method by which COGS is calculated, the level at which COGS entries are created (periodic totals, daily totals, online COGS) and whether or not journal entries are posted automatically to the ledger. 
 
## To define COGS constants:

 

 1 .  Enter the Financial Constants form. 
 

 2 .  Assign a value of 1 to the COGSMethod constant. 
 Notes: 
 

 ·      The Post Cost of Goods Sold program creates journal entries for inventory accounts according to the standard value of recorded inventory transactions. 
 

 ·      Make sure the costing parameter of Std Material Cost has been selected for cost analysis. That is, the calculation of standard costs for processed parts should be based on the standard costs of child parts. To set this parameter, run the Set Costing Parameters program. 
 

 ·      Perpetual COGS makes use of variance accounts. Click for an explanation of entries for variance .
