# COGS_Setup_Accounts_for_NonInvVal_Warhs

- **Source:** `COGS_Setup_Accounts_for_NonInvVal_Warhs.htm`

COGS (Perpetual) - Defining Accounts for Non-Inventory Valued Warehouses 
 
 
- 
 
 
 
# Defining Accounts for Warehouses not Included in Inventory Valuations

 

When an inventory transaction involves a warehouse that is not included in inventory valuations (i.e., the Inventory Valued column in the Warehouses form is not flagged), the journal entry recorded for it debits or credits the Purchases/Inventory account linked directly to that warehouse in the Accounts for Warehouses form. 
 

If the warehouse is not linked to a Purchases/Inventory account, the Post Cost of Goods Sold program does not record any journal entries for it, even if there is a default Purchases /Inventory account, or one for the accounting family involved. 
 

Consequently, the question whether to link an account to such a warehouse, and, if so, which account, depends on whether the inventory transactions taking place is meant to affect inventory valuations. 
 

Consider the following two cases: 
 
## An external warehouse that is not included in inventory valuations

 

The company does not want goods received into this warehouse to affect the value of the inventory, yet at the same time wants inventory transfers from this warehouse to a company warehouse to debit the latter's Purchases/Inventory account, as in a regular GRV. 
 

The solution is to link the Purchases Not Yet Billed account to the company warehouse as its Purchases/Inventory account. 
 

An entry created by the Post Cost of Goods Sold program for a GRV usually credits the Purchases Not Yet Billed account and debits the warehouse's Purchases/Inventory account. In this case the credit and debit accounts are the same and no journal entry will be recorded. 
 

When you record a warehouse transfer for these goods between the external warehouse and the company warehouse, the journal entry created by Post Cost of Goods Sold credits the Purchases Not Yet Billed account and debits the Purchases/Inventory account of the company warehouse. 
 
## A warehouse that receives and ships parts without charge 

 

In other words, these are items with no cost that have no influence on inventory value. 
 

The solution is not to link any Purchases/Inventory account directly to this warehouse in the Accounts for Warehouses form. 
 

In this manner no journal entry will be recorded for any inventory transactions taking place there.
