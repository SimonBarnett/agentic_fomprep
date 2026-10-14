# SOP Perpetual COGS

- **Source:** `SOP Perpetual COGS.pdf`

Cat.No. LB09000008 1 Ver.1 – May 5,’09 
 
SOP: Perpetual COGS* 
 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To set up definitions required for perpetual COGS. 
 To run COGS in order to update the balance of inventory accounts, so as to reflect 
the inventory value calculated by the costing program. Perpetual COGS enables you 
to record journal entries for inventory transactions recorded between two consecutive 
past balances (assuming that costing was run for both). As a result, inventory 
transactions are reflected in default accounts. 
Procedure 
Stage I: Preliminary Steps for Working with COGS 
1. Define the costing method (FIFO or Moving Average), using the Set Costing 
Parameters program. 
2. In the same program, define standard costing for parts based on standard material 
costs (Std Material Cost). 
3. Define the method by which COGS is calculated (by standard costs). That is, in the 
Financial Constants form, assign the value “1” to the COGSMethod constant. 
4. Define the method used to record journal entries, so that daily entries will be 
recorded for each transaction type. In the Financial Constants form, assign the value 
“1” to the COGSPeriod constant. 
5. Define the method used to post journal entries, so that only pending journal entries 
will be created for inventory transactions when COGS is run. In the Financial 
Constants form, assign the value “0” to the COGSPost constant. 
6. Define the default accounts to be debited or credited by the program when journal 
entries are recorded for inventory transactions. These accounts can be defined at the 
company or part family level:  
 Company-wide: Accounts at this level are defined in the Default Accounts form. A 
list of relevant accounts appears in the Appendix. 
                                        
         
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

 For parts in the same accounting family: 
a. Define accounting families in the Accounting Families form. 
b. Assign parts to accounting families in the Financial Parameters for Parts form. 
c. Define default accounts for accounting families in the Accounts for Families 
form. 
Stage II: Running the COGS Program 
Setups 
1. Set up costing – see the Standard Operating Procedure for setting up costing for 
manufacturers. 
2. Record a past balance for the last day of the preceding fiscal period – see the 
Standard Operating Procedure for standard costing for manufacturers. 
3. Run costing for the past balance – see the Standard Operating Procedure for 
standard costing for manufacturers. 
Procedure 
1. Run 
the COGS Transactions report, which displays the journal entries that will be 
opened for the inventory transactions recorded during the COGS period, without 
actually recording them. This enables you to preview COGS results and correct any 
anticipated problems before recording journal entries. 
2. Run the Details of COGS Transactions report. The report displays, by date, the 
journal entries that will be opened for the inventory transactions recorded during the 
COGS period, as well as details of the transactions themselves. The report can be 
run for specific parts, inventory documents and transaction types, for a detailed 
analysis of results. 
3. Run the COGS Transactions per Account report, which displays journal entry items 
for each account. 
4. Run the COGS Details per Part report, which displays the variance entries that will 
be recorded to cover any variance between the expected closing balance of 
inventory accounts and standard inventory valuations recorded by costing. 
5. Run the  Post Cost of Goods Sold program. This program will create journal entries 
according to the definitions recorded in Stage I. 
Appendix: Accounts Used by COGS for Journal Entries 
 Purchases/Inventory: For standard material costs of parts in inventory transactions 
to or from the warehouse. 
 Inventory – Labor: For standard labor costs of parts in inventory transactions to or 
from the warehouse. 
 Inventory – Burden: For standard burden of parts in inventory transactions to or 
from the warehouse. 
 COGS – Materials: For standard material costs of parts in customer invoices. 
Cat.No. LB09000008 2 Ver.1 – May 5,’09

Cat.No. LB09000008 3 Ver.1 – May 5,’09 
 COGS – Labor: For standard labor costs of parts in customer invoices. 
 COGS – Burden: For standard burden of parts in customer invoices. 
 Price Variance: For variance between the actual price in the vendor invoice and the 
standard cost of the inventory transaction. 
 Inventory Count Variance: Serves as a contra account to the inventory account, for 
recording the standard cost of inventory count variance. 
 Inventory Disposal: Serves as a contra account to the inventory account, for 
recording the standard cost of the disposal transaction. 
 Part Sampling: Serves as a contra account to the inventory account, for recording 
the standard cost of sampling transactions. 
 Production Costs: Serves as a contra account to the inventory account, for 
recording the standard value of issues to supply. 
List of Accounts at the Company-Wide Level 
The following accounts can only be defined at the company-wide level (in the Default 
Accounts form): 
 Unbilled Shipments: For shipping documents for which a multi-shipment invoice has 
not yet been issued. 
 Purchases Not Yet Billed: For recorded GRVs which have not yet been linked to a 
multi-GRV invoice. 
Important Note: These account levels are hierarchical. The system will first apply 
account definitions according to accounting families. If an appropriate account cannot be 
located, company-wide account definitions will apply. If no accounts are defined at any 
of these levels, journal entries will not be posted.
