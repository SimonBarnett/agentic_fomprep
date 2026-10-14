# Sales_Tax_6a_Reporting_VAT

- **Source:** `Sales_Tax_6a_Reporting_VAT.htm`

Taxes Wizard - Transferring to VAT Account 
 
 
- 
 
 
 
# Crediting Adjustment Entries for VAT Sums

 

 Priority allows you to create adjustment entries that transfer sums from VAT accounts to the VAT (Debit and Credit) account. 
 

The Transfer Sums to VAT Account program runs through all unreconciled journal entries posted in the defined time period and performs the following actions: 
 

 ·        Debits the Output VAT account, credits the VAT account. 
 

 ·        Credits the Input VAT account, debits the VAT account. 
 

The program also performs internal reconciliations between the debits and credits in the aforementioned journal entries. 
 
## Note:

 

If there are unreconciled manual journal entries whose contra account is the VAT (Debit and Credit) account, you must first perform an account reconciliation against the manual entries. 
 
## To transfer VAT sums:

 

 1 .  Run the Check for Correct VAT report. Correct any journal entries which are discovered to be problematic. 
 

 2 .  Run the Sums for Transfer to VAT Account report to check results in advance. 
 

 3 .  Once report results are satisfactory, run the Transfer Sums to VAT Account program. 
 
## Notes:

 

 ·        The program transfers sums for one month only. 
 

 ·        In the rare case where sums in the VAT (Debit and Credit) Account diverge from data in the VAT report, you should check to see if there are any VAT reconciliations where the entries in question are not in the same VAT period. To do so, run the Check Reconciliations for VAT report. For each pair of entries appearing in the report, retrieve them in the Entry Item Revisions form and change the VAT report period of one of them to match the other.
