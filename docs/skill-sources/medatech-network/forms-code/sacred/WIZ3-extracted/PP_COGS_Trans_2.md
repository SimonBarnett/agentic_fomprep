# PP_COGS_Trans_2

- **Source:** `PP_COGS_Trans_2.htm`

PP_COGS_Trans_2 
 
 
- 
 
 
 

The list of materials required to complete the work order is recorded in the Kit List form. By default, this list matches the BOM of the work order part, but can be changed in specific work orders. 
 

For issues to the work order, a journal entry is recorded debiting the plant floor's inventory account with material costs based on the work order's kit list. For the end-of-production transaction, a journal entry is recorded crediting the same inventory account and debiting the finished goods warehouse's inventory account with material costs based on the manufactured part's standard BOM. 
 

To deal with this variance, an adjustment entry is recorded for the end of the COGS period that corrects the balance of the floor inventory account, taking into account all work orders for which end-of-production transactions were recorded over the period in question. This entry (code = IT ) debits the Material Efficiency Variance account and credits the floor's inventory account with the difference between actual and standard material costs of the manufactured part.
