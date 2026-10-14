# COGS_Setup_Accounts_Main

- **Source:** `COGS_Setup_Accounts_Main.htm`

COGS (Perpetual) - Defining GL Accounts 
 
 
- 
 
 
 
# Defining GL Accounts

 

The Post Cost of Goods Sold program creates journal entries in keeping with the inventory transactions recorded in the system. These entries update inventory accounts with the transaction values. 
 

As a preliminary step before running the program, you must define the appropriate GL accounts that the program will debit or credit when recording those journal entries. 
 

Since the program handles standard costs of raw materials and shipping, and in the Manufacturing package, labor and burden, several different accounts must be defined. Additional accounts are necessary to hold any variance between the balance of inventory accounts and the standard inventory value calculated by costing. 
 

Accounts can be defined at several levels. The hierarchy is as follows, in ascending order: 
 

 ·        company-wide (in the Default Accounts form). Details. 
 

 ·        per warehouse (in the Accounts for Warehouses form). Details. 
 

 ·        per customer group (COGS account only, in the Accounts for Customer Groups form). Details. 
 

 ·        per accounting family (in the Accounts for Families form) 
 

 ·        per accounting family within a given warehouse (in the Accounts for Warehouses form and its sub-level, Acc'ts for Families in Warehouse ). 
 

If no accounts are defined at any of these levels, journal entries will not be posted. 
 
## Notes: 

 

 ·        When dealing with inventory transactions to and from the plant floor, the system ignores inventory accounts that are defined per accounting family (or accounting family within a warehouse). Thus, for floor warehouses, you must assign inventory accounts per warehouse (or company-wide). 
 

 ·        On opening GL accounts, see the Open GL Accounts Wizard wizard; on defining default accounts, see the Set Up Default Accounts Wizard wizard. 
 

 ·        Click to determine whether to define accounts for warehouses not included in inventory valuations .
