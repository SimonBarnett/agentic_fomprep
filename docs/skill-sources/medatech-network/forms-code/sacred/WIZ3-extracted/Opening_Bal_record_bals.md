# Opening_Bal_record_bals

- **Source:** `Opening_Bal_record_bals.htm`

Opening Balances - Recording Account Balances 
 
 
- 
 
 
 
# To record account balances:

 

Once you've opened the necessary fiscal years and periods, you need to record the balance of each account as of December 31 of the previous year. Balances are recorded manually in the entry journal against the predefined system account, Opening Balance , and then transferred as opening balances to the first period of the current fiscal year. 
 

For most GL accounts, the entire balance is recorded in one journal entry. However, there are certain types of accounts (e.g., A/R accounts, A/P accounts, prepaid expenses) in which transaction dates are important for future reconciliations. For accounts such as these, you need to manually record a journal entry that lists the sum of each transaction, its reference number and its due date. Example. 
 

 Dual-currency users: If you work with postdated checks, you need to transfer them along with their full details (e.g., due date) from the previous system to Priority , in order to be able to post them to the ledger at the proper time. To do so, you need to record a manual journal entry, for each bank account, that includes all the details of every postdated check (that is, the amount of each transaction, its reference and its due date) in each postdated account (incoming and outgoing) opened for that bank account. 
 

Once balances have been recorded, you need to transfer them to the current fiscal year. (As the process of recording balances tends to take a long time, the transfer can be made more than once.) 
 
## Notes:

 

 ·        Before recording entries, run the Manual Journal Entries Wizard to make sure you fully understand the process. 
 

 ·        Before recording balances in a foreign currency, make sure that exchange rates have been recorded for December 31. For details, see the Currencies Wizard . 
 

 ·        If the balances of some accounts are not yet final, you can update them later and transfer opening balances again. 
 

 ·        You can also load account balances automatically from an external file. 
 

 ·        For the dual-currency package: To record indexed opening balances, use the Debit (Adjusted) or Credit (Adjusted) columns in the Itemized Entry form, along with the nominal sums recorded in the local currency. To correct for errors in indexed amounts (without revising nominal sums), open a new entry with the EXC (Exchange Rate Adjustment) entry code; record the corrections only in the columns for adjusted values.
