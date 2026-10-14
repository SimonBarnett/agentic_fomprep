# PP_COGS_stdship

- **Source:** `PP_COGS_stdship.htm`

PP_COGS_stdship 
 
 
- 
 
 
 

Two additional entry items are recorded for standard shipping expenses, with entry sums determined by definitions in the Financial Parameters for Parts form: 
 

 ·        vendor invoice: debiting the inventory account, crediting the Standard Shipping Costs account. 
 

 ·        multi-GRV invoice: debiting the Purchases Not Yet Billed account, crediting the Standard Shipping Costs account. 
 

If a shipping voucher is linked to the vendor invoice, the two entry items for shipping expenses are recorded when the purchase invoice is finalized. When the expense invoice is finalized, an additional entry is recorded debiting the inventory account that is defined for the accounting family to which the shipping expense items belong. 
 

There are two ways to reflect the variance between actual and standard shipping costs in the ledger: 
 

 ·        Reflect it in the balance of the Standard Shipping Costs account, by having the expense invoice debit that account. That is, assign the expense items to an accounting family whose inventory account is defined (in the Purchases/Inventory column of the Accounts for Families form) as the standard shipping costs account. 
 

 ·        Reflect it in the balance sheet, by linking the accounting family to a different inventory account (e.g., Actual Shipping Costs ) and assigning that account the same balance sheet item as the Standard Shipping Costs account. In this way, the variance between standard and actual costs will be displayed as the balance under this heading in the balance sheet.
