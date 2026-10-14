# 13-17-Journal Entry Codes

- **Source:** `13-17-Journal Entry Codes.pdf`

www.priority -software.com   
1/4 ‏Feb. 03, '15 Ver.04 Cat.No. A8000057 
 
 SOP: Defining Journal Entry Codes 
Customer:   Company Inc. 
Assigned to: Dept./Position 
 
Aims 
 To define codes for journal entry types for the general ledger – codes for manual entries, as well 
as special codes for entries created via financial documents recorded for a given customer, 
vendor or branch. 
 To define an existing entry code as inactive. 
Procedure 
Stage I: Defining Journal Entry Codes for Manual Entries 
In journal entries recorded manually in the Entry Journal form, there is one column for the total 
entry sum. This sum is divided by a defined ratio among the accounts in the entry, as defined in the 
entry pattern. 
1. Enter the Journal Entry Codes form. 
2. Open a line for each new type and record its Entry Code. 
3. Record a description of the entry type in the Transaction column. 
4. In the Source of Details column, select from the Choose list the method by which a brief remark 
regarding entries of this type will be filled in (for example, select "Invoice Details" to copy the 
remark from the Details column of the original invoice). 
5. In the Details column, record a remark that will appear by default in entries of this type. 
Note: To use this column, you must select "Code Details" or "Month + Code Details" in the 
Source of Details column. 
6. In the Transaction Descrip. column, record an extended description of the type of financial 
transaction to which this code applies. 
7. Flag the following columns, as needed: 
 Negative Entry – This is intended solely for financial documents. When an entry code is 
flagged in this column, accounts in the "credit" pattern are debited by a negative amount, and 
accounts in the "debit" pattern are credited by a negative amount. 
 Auto Balance Affils – When posting a journal entry involving accounts in different affiliates, 
lines are automatically added for the transfer accounts in order to balance the lines for each 
affiliate. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/4 ‏Feb. 03, '15 Ver.04 Cat.No. A8000057 
 
 In Withhd Tax Rep't (for dual-currency users) – Journal entries with such a code will appear 
in the Withheld Taxes report, even if they do not otherwise meet the conditions for appearing 
in the report. 
8. Enter the Entry Patterns sub-level form. 
9. In the Account/Pattern column, select the GL account affected by entries of this type: 
 If the same account is always used for entries of this type, select a specific account from the 
Choose list. 
 If the account is to be filled in manually when the entry is recorded, specify ?. 
Note: You must confine entry codes for manual journal entries to this account pattern. 
10. Select the value 1 or 4 in either the Debit Code or Credit Code column. 
11. In the % of Credit/Debit column, specify the percentage of the entire sum (i.e., the amount 
appearing in the Sum column in the Journal Entry form) to be debited/credit against the 
account in this line. 
Note: The total of debit percentages must equal the total of credit percentages. 
12. When you are finished filling in the lines, exit the form. 
Result 
 The entry code you defined will appear in the Choose list for the Entry Code column in the 
Journal Entry form. 
Stage II: Using Entry Codes in Manual Journal Entries  
User-defined entry codes appear in a Choose list in the Journal Entry form. Select one when you 
begin recording an entry. 
Tip: If you record many journal entries manually, you can use the Display Order column in the 
Journal Entry Codes form to change the order in which they appear in the Choose list. 
1. Enter the Entry Journal form. 
2. Record the Transaction Date. A temporary number with the prefix T is assigned to the entry. 
3. The value M appears in the Transaction column (indicating a simple entry). Replace this value 
with the desired entry code from the Choose list. 
4. Record the transaction sum in the Sum column. 
Notes: 
 For dual-currency users: Use the Sum (Trans. Curr) column to record the sum in a foreign 
currency. 
 If you are recording a complex journal entry, or an entry in which sums need to be recorded 
manually for the various accounts, record the sums in the Itemized Entry sub-level form 
instead. 
5. Enter the Itemized Entry sub-level form. The entry items are displayed as defined in the 
selected entry code. 
6. If certain accounts were defined for manual entry in the entry code, specify those accounts. 
7. Add or delete account lines, or revise the percentage by which the entry sum is split among the 
accounts, as needed. 
8. When you finish recording the entry, return to the upper-level form and select Post Journal 
Entry from the list of Direct Activations.

www.priority -software.com   
3/4 ‏Feb. 03, '15 Ver.04 Cat.No. A8000057 
 
Stage III: Defining Entry Codes for Entries Recorded Automatically from 
Financial Documents  
Most journal entries are created automatically from financial documents. You can define special 
entry codes that are applied to specific vendors, customers or branches. 
1. Repeat Steps 1-8 in Stage I. 
2. In the Account/Pattern column, select the GL account affected by entries of this type: 
 If the same account is always used for entries of this type, select a specific account from the 
Choose list. 
 If the account is determined when the entry is recorded, select an account pattern indicating 
that a certain type of account is to be used (e.g., A/P, A/R), or that the account will be 
specified manually (i.e., ?). 
Tip: Select Account Patterns from the list of Direct Activations to view pre-defined account 
patterns and their codes. 
3. In the Debit Code or Credit Code column, specify the code representing the column in the 
relevant financial document from which to copy the sum into the current account line. 
4. In the % of Credit/Debit column, do one of the following: 
 Specify 100% to record the total sum of the financial transaction for a single account. 
 Specify a different percentage if you intend to split the sum among several accounts, provided 
that the value 1 is recorded in the Debit Code or Credit Code column. 
Note: The total of debit percentages must equal the total of credit percentages. 
5. When you are finished filling in the lines, exit the form. 
Stage IV: Linking Entry Codes to Customers or Vendors  
You can define a special entry code for transactions that debit or credit a specific customer or 
vendor. Entry codes are linked to customers/vendors in the Financial Parameters for Customers 
or Financial Parameter for Vendors form, respectively. 
1. Enter the Financial Parameters for Customers or Financial Parameter for Vendors form. 
2. Do one of the following: 
 For customers, click the Invoices tab and select the desired Debit Entry Code and Credit 
Entry Code from the Choose list. 
 For vendors, click the Invoice Data tab and specify the desired Entry Code-Invoice and 
Entry Code-Credit Memo from the Choose list. 
Note: In both cases, different entry codes should be used for credits and debits. 
Result 
 When financial documents for the customers/vendors in question are final, journal entries will be 
recorded according to the defined entry code. 
Stage V: Linking Entry Codes to Branches 
You can define a special entry code for transactions recorded for specific branches, in order to use 
separate accounts for each branch. Entry codes are linked to branches in the Financial 
Documents form. 
1. Enter the Financial Documents form.

www.priority -software.com   
4/4 ‏Feb. 03, '15 Ver.04 Cat.No. A8000057 
 
2. Enter the Journal Entry Codes for Branch sub-level form. 
3. Select the desired Entry Code for each branch from the Choose list. 
Result 
 When financial documents for the branches in question are final, journal entries will be recorded 
according to the defined entry code, provided that the branch is recorded in the document. 
Note: The branch appears automatically as defined previously in the system for the 
customer/vendor or the employee recording the document, or it is assigned manually.  
Stage VI: Linking Entry Codes to Financial Documents Manually 
An Entry Code column appears in all financial documents. For certain documents it appears in the 
upper-level form, and for others it appears in the Invoice - Add'l Details sub-level form. 
 You can manually assign an entry code to any financial document before it is final. 
Stage VII: Defining Journal Entry Codes as Inactive 
If a given entry code is not in use, you can define it as inactive. 
1. Enter the Journal Entry Codes form and retrieve the entry code in question.  
2. Flag the Inactive column. 
Result 
 Users will not see this entry code in any Choose list and will receive a warning message if they 
assign it to any transactions.
