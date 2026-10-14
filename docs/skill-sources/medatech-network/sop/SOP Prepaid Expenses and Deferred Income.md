# SOP Prepaid Expenses and Deferred Income

- **Source:** `SOP Prepaid Expenses and Deferred Income.pdf`

Cat.No.A8000240 1 Ver.1 – Jun.26,’08 
 
SOP: Prepaid Expenses and Deferred Income* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
• To automatically record prepaid expenses or deferred income when preparing 
customer or purchase invoices against the target account defined for this purpose in 
the system. 
Setups 
Defining a prepaid expenses/deferred income account 
1. Enter the Chart of Accounts form. 
2. Open or retrieve the relevant account. 
3. Flag the Prepaid Exp/Income column. 
4. In the Default Target Acct column, specify the account to which prepaid expenses 
or deferred income will be transferred. If no default account is defined, leave this 
column empty. 
Procedure 
Stage I: Recording an Invoice 
To record an invoice for prepaid expenses: 
1. Enter the Vendor Invoices or Multi-GRV Invoices form, and open a new invoice (see 
the relevant standard operating procedures). 
2. For each invoice item, fill in the following details: 
• Expense Account – The number of the account defined for prepaid expenses 
(see above). 
• From Expense Date and To Expense Date. 
• TargetAcc-PrepaidExp – If the defined prepaid expenses account is already 
linked to a default target account, leave this column empty. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Result: 
• When the invoice is finalized, and a journal  entry is recorded, the prepaid expenses 
account is debited, with the expense divided according to the number of months in 
the date range defined in the invoice line. Each line is debited by the proportional 
amount, and is automatically assigned a due date at the end of that month. 
To record an invoice for deferred income: 
1. Enter the Sales Invoices or Multi-Shipment Invoices form, and open a new invoice 
(see the relevant standard operating procedures). 
2. For each invoice item, fill in the following details: 
• Income Account No. – The number of the account defined for deferred income  
(see above). 
• From Income Date and To Income Date. 
• Target-DeferredInc – If the defined deferred income account is already linked to a 
default target account, leave this column empty. 
Tip: If your company charges customers in a service contract (requires purchase of the 
Customer Service module), service contract invoices can be recorded automatically as 
deferred income invoices for the billing period defined in the service contract. 
Result: 
• When the invoice is finalized, and a journal entry is recorded, the deferred income 
account is debited, with the income divided according to the number of months in the 
date range defined in the invoice line. Each line is debited by the proportional 
amount, and is automatically assigned a due date at the end of that month. 
Stage II: Recording a Manual Journal Entry for Prepaid Expenses or 
Deferred Income. 
1. Enter the Entry Journal form. 
2. In the Transaction column, select the entry code you defined (see above). 
3. The value "?" appears automatically in the Debit Account or Credit Account 
column. Replace it with the relevant customer or vendor account. 
4. Record the transaction sum in the Sum column. 
Note for dual-currency users: Use the Sum (Trans. Curr) column to record the 
sum in a foreign currency. 
5. Enter the  Itemized Entry sub-level form and make sure the entry details are correct. 
6. Return to the upper-level form and select Post Journal Entry from the list of Direct 
Activations. 
Stage III: Recording Actual Prepaid Expenses or Deferred Income 
1. Run the Transfer PrepaidExp/DeferredInc program. 
2. In the Transfer From input screen, select either the All Accounts or Selected 
Accounts option. 
Cat.No.A8000240 2 Ver.1 – Jun.26,’08

Cat.No.A8000240 3 Ver.1 – Jun.26,’08 
3. If the fiscal period for which you want to record the payments is closed, select the 
appropriate Paymts in Closed Per option: 
• Postpone to Open Period 
• Record Pending Entry 
4. If you chose the Selected Accounts option, select the relevant accounts in the 
Prepd/Deferred Acct column. 
5. In the To Date column, specify the date until which to transfer prepaid 
expenses/deferred income to the ledger. 
Result: 
When prepaid expenses/deferred income are transferred, a journal entry is recorded in 
the following manner: 
• Prepaid expenses: The prepaid expenses account is credited and the expense 
account (the default account or the account defined manually when the invoice was 
prepared) is debited. 
• Deferred income: The deferred income account is debited, and the income account 
(the default account or the account defined manually when the invoice was prepared) 
is credited.
