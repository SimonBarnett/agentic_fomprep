# 14-15-Incoming Shipping Vouchers

- **Source:** `14-15-Incoming Shipping Vouchers.pdf`

Cat.No. LB10000464 1 Ver.1 – Sep. 14,’10 
 
SOP: Working With Shipping Vouchers* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aim 
Shipping vouchers link expenses related to shipments to specific purchase invoices, 
allowing the costing program to distribute these expenses among the costs of the 
purchased goods. 
Working Assumption 
 Dual-currency users only: Multi-GRV invoices have been recorded in the system 
for customs agents (see the Standard Operating Procedure for multi-GRV 
invoices). 
Setups 
Defining Expenses (Shipping, Insurance, etc.) 
1. Open a part number for each expense (see the Standard Operating Procedure 
for opening parts). 
2. Enter the Part Catalogue. 
3. Retrieve the expense parts you have opened. 
4. For each part, click the Additional Details tab and make sure the Inv. Control 
column is not flagged. 
5. Make sure the Change Desc.  column is flagged. 
6. Select  Financial Parameters for Parts from the list of Direct Activations. 
7. Click the Shipping Expenses tab. In the Burden Type column, select the 
appropriate distribution method for that expense; that is, the parameter (e.g., 
weight, volume, price) by which the expense will be distributed among purchased 
parts. 
Defining Burden Parameters for Purchased Parts 
1. Enter the Part Catalogue. 
2. Enter the  Financial Parameters for Parts from the list of Direct Activations, and 
retrieve the purchased parts. 
3. Click the Shipping Expenses tab. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

4. Choose one of the following options, in keeping with the burden type assigned to 
expenses: 
 If a Volume burden type has been defined, make sure that the Volume and 
Volume Unit columns are recorded. 
 If a Weight burden type has been defined, make sure that the Weight and 
Weight Unit columns are recorded. 
 If a Price burden type has been defined, nothing else needs to be recorded. 
Expenses will be distributed on the basis of the price appearing in the purchase 
invoice. 
Defining Standard Shipping Costs for Purchased Parts 
1. Enter the Part Catalogue. 
2. Enter the  Financial Parameters for Parts from the list of Direct Activations. 
3. Retrieve those parts for which you want to define shipping costs. 
4. In the Shipping Expenses tab, record appropriate values in the Air Cost (%), 
Sea Cost (%) and/or Land Cost (%) columns, according to the ways in which 
each part is shipped. 
5. Select the Shipping Cost Type that represents your usual method of shipping 
the part in question. This value is used to calculate the part's standard shipping 
cost, which the costing program adds to the part's calculated cost whenever no 
actual costs have been defined for a shipment of purchased parts in a shipping 
voucher. 
Dual-Currency Users Only:  
Defining Customs Data 
1. Enter the Countries form. 
2. For each country from which you import goods, select the appropriate Customs 
Category. 
3. Enter the Itemized Customs Rates form. 
4. Record a line for each relevant customs item, defining its customs percentage (in 
the relevant column). 
Tip: To define a different customs percentage for specific countries, use the 
Special Customs Rates sub-level form. 
5. Enter the Part Catalogue and retrieve the purchased part in question. 
6. Enter the Financial Parameters for Parts from the list of Direct Activations. 
7. In the Shipping Expenses tab, select the appropriate Customs Item. 
8. Enter the Vendors form. 
9. Retrieve all vendors from which you import goods, and make sure a Country has 
been recorded for each one in the Address and Phone tab. 
Defining VAT from Customs Duty 
1. Enter the Value Added Tax form. 
2. Move to the "VAT from Customs Duty" line. 
Cat.No. LB10000464 2 Ver.1 – Sep. 14,’10

3. Make sure that the relevant account appears in the  Account No. and Acct#:Tax 
on Expense columns. 
4. Enter the Chart of Accounts form. 
5. Retrieve the VAT from Customs Duty account. 
6. Make sure the corresponding value appears in the VAT Report Item column.  
7. Make sure this is the only account linked to this item. 
Note: See the Standard Operating Procedure for defining GL accounts for detailed 
instructions. 
Defining Shippers and Customs Agents as Vendors 
 See the Standard Operating Procedure for opening vendors. 
Set the Currency Conversion Date for Shipping Vouchers 
1. Enter the Financial Constants form. 
2. Move to the  ImpFileDates constant. 
3. Select the appropriate value to suit your company: whether expenses are 
converted according to the exchange rate on the date the goods entered 
inventory, or on the date of the purchase invoice. 
Procedure 
Stage I: Opening a Shipping Voucher 
1. Enter the Shipping Vouchers form. 
2. Record the Date Opened. 
3. In the Vendor No. column, specify the main vendor in the shipping voucher. 
4. Click the References tab. In the Currency column, specify the main currency in 
the shipping voucher. 
5. If the shipping voucher is for a single purchase order, specify its number in the 
Order column. 
6. For dual-currency users, select the relevant Customs Agent Code.  
7. Click the Shipment tab to record shipping details. You can fill them in now or at a 
later date. 
8. Click the Contacts tab to link any relevant contacts to this shipping voucher.  
9. For dual-currency users, fill in the Customs Manifest Date and the Customs 
Manifest No. (in the References tab). 
10. Assign the appropriate Status, according to the workflow defined for shipping 
vouchers. 
Stage II: Linking Invoices and Memos to a Shipping Voucher 
Linking the Two When Recording the Invoice or Memo 
 In the Vendor Invoices form, click the References tab and record the number of 
the shipping voucher in the Shipping Voucher column. 
Cat.No. LB10000464 3 Ver.1 – Sep. 14,’10

 To link a debit memo: In the Debit Memos form, click the References tab and 
record the number of the shipping voucher in the Shipping Voucher column. 
Linking the Two After the Invoice or Memo is Recorded 
1. Enter the Invoices in Shipping Vouchers form. 
2. Retrieve the desired purchase invoice or debit memo. 
3. Specify the Shipping Voucher.  
4. For dual-currency users, specify the Customs Manifest No. 
5. Enter the  Invoice Items sub-level form. 
6. For dual-currency users, make sure the Country is correctly recorded. 
7. To define a special method of expense burdening for purchased items in a 
specific invoice (a different burden type than the default defined in Setups): 
 Enter the Manual Distribution of Expenses sub-level form from the expense 
item line. The form displays the purchased parts from the invoices included in 
the shipping voucher.  
 Use the Proportion of Burden  column to define the relative burden for each 
part. 
Stage III: Expense Burdening for a Shipping Voucher 
1. Enter the Shipping Vouchers form. 
2. Retrieve the desired shipping voucher. 
3. Select Calculate Expense Burdening from the list of Direct Activations. 
Note: You can perform expense burdening multiple times (e.g., each time a new 
invoice is linked to the shipping voucher). 
Stage IV: Closing a Shipping Voucher 
1. Enter the Shipping Vouchers form. 
2. Retrieve the desired shipping voucher. 
3. Select Close Shipping Voucher from the list of Direct Activations. 
Notes 
 The costing program only takes closed shipping vouchers into account.  
 Until the voucher is closed, costing calculates part costs on the basis of the 
standard shipping costs defined in the Setups section. 
 If an additional invoice is linked to the shipping voucher after costing has been 
run, the calculated cost of the purchased parts is only updated when the costing 
program is run again. 
 If you want to link an additional invoice to a closed shipping voucher, you must 
first reopen the voucher. That is, retrieve it in the Shipping Vouchers form and 
select Reopen Shipping Voucher from the list of Direct Activations. After linking, 
close the voucher again. 
 The cancellation of an invoice linked to a shipping voucher does not affect the 
shipping voucher. You need to enter the shipping voucher and delete the invoice 
manually, or link the voucher to a credit memo. 
Cat.No. LB10000464 4 Ver.1 – Sep. 14,’10

Cat.No. LB10000464 5 Ver.1 – Sep. 14,’10 
Results 
 By linking invoices to a shipping voucher and running the Calculate Expense 
Burdening program, you can view the actual cost of the purchased parts included 
in the voucher. Select the Shipping Expense Burden report from the list of Direct 
Activations from the Shipping Vouchers form. 
 By linking invoices to a shipping voucher and closing the voucher, the costing 
program distributes the additional expenses included in the voucher among the 
purchased parts. The calculated cost is displayed in the Cost column of the Audit 
Trail form as the cost of the entry transaction for that part. This is used to calculate 
the part's average actual cost.
