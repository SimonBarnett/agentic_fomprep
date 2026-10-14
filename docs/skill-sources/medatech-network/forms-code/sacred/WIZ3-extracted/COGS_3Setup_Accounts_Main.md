# COGS_3Setup_Accounts_Main

- **Source:** `COGS_3Setup_Accounts_Main.htm`

COGS (Periodic) - Defining GL Accounts.1 
 
 
- 
 
 
 
# Setting Up GL Accounts 

 
## Introduction

 

The Post Cost of Goods Sold program creates journal entries that update inventory accounts. Example. 
 

Before running the program, you must define the appropriate GL accounts which the program will debit or credit when recording those journal entries. This requires the following types of accounts: 
 

 ·        Balance sheet accounts for inventory (one for materials and another for labor and burden) in which opening and closing inventory values are recorded for each fiscal period (i.e., inventory values are considered a company asset). The account's opening balance is equivalent to the opening inventory value. At the end of each fiscal period, the Post Cost of Goods Sold program records a journal entry for the difference between the current closing value and the opening value (i.e., the closing value of the previous period). 
 

 ·        P&L accounts for inventory (one for materials and another for labor and burden) in which the difference between opening and closing values is recorded. The balance of these accounts is reset to zero at the end of each fiscal year. When the Post Cost of Goods Sold program is run, an entry for the difference between opening and closing inventory values debits the relevant balance sheet inventory account and credits the relevant P&L account. The entry amount is determined by changes in inventory values between the previous costing period and the current one. 
 

 ·        Another P&L account for purchases, which is routinely debited on the basis of purchase invoices recorded in the system. It is assumed that this account reflects the cost of goods sold. That is, purchase invoices, which debit this account, reflect the company's expenses. 
 

 ·        A Purchases Not Yet Billed account for unbilled received goods. The Post Cost of Goods Sold program credits this account (and debits the purchases account) with the difference between the value of unbilled GRVs at the end of the previous costing period and at the end of the current period. 
 
## Note: 

 

Use the Bal. Sheet/P&L Items-GL Accounts form to link the P&L accounts (for inventory and for purchases) to the same P&L item (Cost of Goods Sold), so that they appear together in the COGS section of the P&L report. It is the value in this line of the report that represents COGS for the period.
