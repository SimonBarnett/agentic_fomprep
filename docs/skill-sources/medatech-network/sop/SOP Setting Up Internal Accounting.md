# SOP Setting Up Internal Accounting

- **Source:** `SOP Setting Up Internal Accounting.pdf`

Cat.No. LB10000708 1 Ver.1 – Oct. 18,’10 
 
SOP: Setting Up Internal Accounting * 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To set up definitions required for working with  internal accounting. 
Note: Not all stages of this procedure are mandatory. You may want to define an 
internal customer or vendor without defining the various departments as branches or 
warehouses, or you may want to define both without setting up special entry codes 
for the customer/vendor. 
Procedure 
Stage I: Defining a Department as an Internal Customer or Vendor 
1. Enter the Customers form. 
2. Open a new record for each department in the organization that receives goods 
or services from other departments. 
3. Select Financ. Parameters for Customers from the list of Direct Activations and 
retrieve the new customer record. 
4. In the Customer tab, flag the Internal Customer column. 
5. Enter the Vendors form. 
6. Open a new record for each department in the organization that provides goods 
or services to other departments. 
7. Select Financial Parameters for Vendors from the list of Direct Activations and 
retrieve the new vendor record. 
8. In the General tab, flag the Internal Vendor column. 
Stage II: Defining a Department as an Internal Branch 
1. Enter the Branches form and record a branch code and branch name for the 
department. 
2. In the Internal Customer column, specify the number of the internal customer 
that represents the department. 
3. In the Internal Vendor column, specify the number of the internal vendor that 
represents the department. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Stage III: Defining Entry Codes for Internal Transactions 
1. Enter the Journal Entry Codes form. 
2. Define entry codes for transactions involving internal customers or vendors (for 
detailed instructions, see the SOP for defining journal entry codes). 
Sample entry code for internal purchase invoices: 
 On the credit side of the entry, specify the A/P account pattern, representing 
the vendor recorded in the invoice. 
 On the debit side of the entry, specify the LINES account pattern, representing 
the expense account for the invoice item. 
 On the credit side of the entry, specify the A/P account pattern again. 
 On the debit side of the entry, specify the A/R account pattern, representing 
the account of the branch recorded in the invoice (i.e., the branch in which the 
invoice was opened). 
Sample entry code for internal customer invoices: 
 On the debit side of the entry, specify the A/R account pattern, representing 
the customer recorded in the invoice. 
 On the credit side of the entry, specify the LINES account pattern, 
representing the income account for the invoice item. 
Stage IV: Linking Entry Codes to Internal Customers or Vendors  
1. Enter the Financial Parameters for Customers form. 
2. Retrieve all customers that are flagged as an Internal Customer . 
3. Click the  Invoices tab and, for each customer, select the Debit Entry Code and 
Credit Entry Code defined for internal customers in Stage III. 
4. Enter 
the Financial Parameter for Vendors form. 
5. Retrieve all vendors that are flagged as an Internal Vendor. 
6. Click the  Invoices tab and, for each vendor, select the Entry Code-Invoice and 
Entry Code-Credit Memo defined for internal vendors in Stage III. 
Stage V: Defining Warehouses for a Department 
1. Enter the Warehouses form. 
2. For each department, specify a warehouse code and description. 
Stage VI: Defining Income/Expense Accounts for a Department 
Warehouse 
If internal accounts are billed based on inventory transactions to and from various 
departments, you can define income and expense accounts to be credited/debited 
automatically by any inventory transaction document recorded for a given 
warehouse. 
1. Enter the Accounts for Warehouses form. 
Cat.No. LB10000708 2 Ver.1 – Oct. 18,’10

Cat.No. LB10000708 3 Ver.1 – Oct. 18,’10 
2. Choose the desired Warehouse and assign an Income and a 
Purchases/Inventory account. These accounts will be debited/credited based on 
invoices recorded for transactions in the designated warehouse. 
3. If the Purchases/Inventory account to be debited/credited depends on the part 
family assigned to the part in the transaction, enter the Acc'ts for Families in 
Warehouse sub-level form and record a separate line for each part family and 
the corresponding accounts. 
Stage VI: Defining Numeration Templates for Internal Financial 
Documents 
1. Enter the Document Numeration Templates form. 
2. For each of the following document types, specify the desired Prefix and Column 
Width: 
 Internal Multi-Shipment Invoice 
 Internal Multi-GRV Invoice 
 Internal Vendor Invoice 
 Internal Sales Invoice 
 Internal Export Invoice (dual-currency users only).
