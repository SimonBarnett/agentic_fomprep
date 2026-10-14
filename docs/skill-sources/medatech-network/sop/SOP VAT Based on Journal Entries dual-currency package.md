# SOP VAT Based on Journal Entries dual-currency package

- **Source:** `SOP VAT Based on Journal Entries dual-currency package.pdf`

Cat.No. LB110054 1 Ver.1 – Feb. 22,’10 
 
SOP: VAT Based on Journal Entries  
(dual-currency package)* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
The procedure described below will assist your financial officers in setting up and 
producing VAT reports based on journal entries (as required in certain European 
countries). These reports are then used to complete an external form which must be 
sent to the tax authorities. 
Setups 
The following GL accounts should be opened: 
 Separate income accounts for each type of input VAT (VAT code) and VAT rate 
(VAT group). 
 Separate expense accounts for each type of output VAT (VAT code) and VAT rate 
(VAT group). 
 Separate input VAT and output VAT accounts for each VAT rate (VAT group). 
Note: For more details on opening GL accounts, run the Open GL Accounts Wizard. 
Procedure 
Stage I: Setting Up VAT Report Definitions 
1. Enter the Chart of Accounts form. 
2. Assign each income account the relevant VAT Report Item. This column is used 
both to determine the section of the VAT report in which the account's transactions 
appear and to indicate whether or not its transactions are taxable. 
3. Assign each income account the relevant VAT Code (type of input VAT) and VAT 
Group Code (tax rate). 
4. Assign each expense account the relevant VAT Code (type of output VAT) and VAT 
Group Code (tax rate). 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

5. Make sure all VAT accounts (for Output and Input VAT) are assigned the appropriate 
VAT Report Item (i.e., Output VAT, Input VAT), the appropriate VAT Code (e.g., 
Output VAT, Input VAT) and the appropriate VAT Group Code (tax rate). 
Stage II: Running the VAT Based on Journal Entries Report 
1. Run the VAT Based on Journal Entries report. 
2. In the input screen that opens, indicate the range of dates for which to display VAT 
sums. 
3. Flag the View Income/Expenses column to display all income/expense accounts 
that were credited/debited for each invoice and VAT group in the report. 
Otherwise, if multiple accounts were credited/debited for a given invoice and VAT 
group, only the first account will appear in the report, together with the total amount 
of VAT for that invoice and VAT group. 
4. To restrict the report to journal entries recorded for accounts with a specific VAT 
code (or codes), indicate the desired VAT Code(s). 
Notes: 
 This report does not replace any of the existing VAT reports/VAT definitions; rather, it 
supplements them. 
 This report displays data as defined for the account and does not necessarily reflect 
actual amounts. 
 This report is produced based on journal entries, whether these entries were 
recorded automatically for a financial document or recorded manually. In order to 
minimize human error, it is recommended that you work with journal entries that are 
created automatically for financial documents (e.g., customer and purchase 
invoices), as opposed to recording journal entries manually. The system does not 
notify you if the VAT definitions recorded in journal entries do not match those 
defined for the corresponding GL accounts, although the current report can be 
helpful in discovering any such discrepancies. 
Cat.No. LB110054 2 Ver.1 – Feb. 22,’10

Cat.No. LB110054 3 Ver.1 – Feb. 22,’10 
Appendix: The Format of the VAT Based on Journal 
Entries Report 
This VAT report includes the following columns: 
 VAT Code (report items are grouped and sorted by this value) 
 Reference Date 
 Journal Entry Number 
 Reference 
 Reference 2 
 Entry Code 
 Customer/Vendor Number - If the entry in question was recorded for a customer 
invoice, displays the number of the A/R account appearing in the Debit Account 
column of the Entry Journal form; if the entry was recorded for a purchase invoice, 
displays the number of the A/P account appearing in the Credit Account column of 
the Entry Journal form. When entries are recorded manually, customer/vendor 
details should be recorded in the Entry Journal form in the same manner. 
 Customer/Vendor Name 
 Income/Expense Account 
 Income/Expense Account Description 
 VAT Group Code - Displays the VAT group defined for the income/expense account 
(see above: Setting Up VAT Report Definitions) 
 Total Before VAT - Displays the total amount of the income/expense, as recorded 
against the account in the journal entry 
 VAT Amount - Displays the total amount of VAT applied to the account 
 Total - Displays the sum of the Total Before VAT + the VAT Amount
