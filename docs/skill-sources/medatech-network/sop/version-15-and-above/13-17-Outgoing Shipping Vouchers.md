# 13-17-Outgoing Shipping Vouchers

- **Source:** `13-17-Outgoing Shipping Vouchers.pdf`

www.priority -software.com   
1/5 ‏Feb. 04, '15 Ver.03 Cat.No. A8000071 
 
 SOP: Outgoing Shipping Vouchers 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
Outgoing shipping vouchers serve to track the outgoing shipment process and to distribute 
expenses (e.g., shipping insurance) among sold parts, so as to provide an accurate picture of their 
profitability in sales reports. 
Setups 
Defining Additional Expenses 
1. Define a part for each additional expense (e.g., shipping, insurance). For instructions, see the 
standard operating procedures for defining parts. 
2. Enter the Part Catalogue. 
3. Retrieve the expense parts. 
4. Click the Additional Details tab and make sure the Inv. Control column is not flagged. 
5. Make sure the Change Desc. column is flagged. 
6. Select Financial Parameters for Parts from the list of Direct Activations. 
7. In the Burden Type column (Shipping Expenses tab), select the appropriate distribution 
method for that expense – that is, the parameter (e.g., weight, volume, price) by which the 
expense will be distributed among the sold parts linked to this expense. 
Defining Weight and Volume for Expense Distribution 
1. In the Part Catalogue, retrieve all sold parts. 
2. Select Financial Parameters for Parts from the list of Direct Activations and click the Shipping 
Expenses tab. 
3. Choose one of the following options, in keeping with the burden type assigned to expenses: 
 If a Volume burden type has been defined, make sure that the Volume and Volume Unit 
columns are recorded. 
 If a Weight burden type has been defined, make sure that the Weight and Weight Unit 
columns are recorded. 
 If a Price burden type has been defined, nothing else needs to be recorded. Expenses will be 
distributed on the basis of the part price appearing in the invoice. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 ‏Feb. 04, '15 Ver.03 Cat.No. A8000071 
 
Defining Standard Shipping Costs for Sold Parts 
Standard shipping costs can be defined on several levels: the part family (whereby all parts in the 
family "inherit" the same standard cost), the part or the vendor. The cost percentage and the 
shipping cost type are used to calculate the part's standard shipping cost, which the costing 
program adds to the part's calculated cost whenever there is no closed outgoing shipping voucher.  
Defining Standard Shipping Costs per Part Family 
1. Enter the Part Families form. 
2. Retrieve the family for which you want to record standard shipping costs. 
3. Fill in the appropriate values in the Air Cost (%), Sea Cost (%) and/or Land Cost (%) columns, 
according to the ways in which parts in this family are shipped. 
4. Select the Shipping Cost Type that represents your usual method of shipping parts in this 
family (air/sea/land).  
Defining Standard Shipping Costs per Part  
1. Enter the Financial Parameters for Parts form. 
2. Retrieve the part for which you want to record standard shipping costs. 
3. In the Shipping Expenses tab, fill in the appropriate values in the Air Cost (%), Sea Cost (%) 
and/or Land Cost (%) columns, according to the ways in which this part is shipped. 
4. Select the Shipping Cost Type that represents your usual method of shipping the part.  
Defining Standard Shipping Costs per Vendor 
1. Enter the Financial Parameters for Vendors form and retrieve the vendor in question. 
2. Enter the Shipping Costs per Part sub-level form and fill in the appropriate values in the Air 
Cost (%), Sea Cost (%) and/or Land Cost (%) columns, according to the ways parts appearing 
in this form are shipped. 
Note: The parts listed are those defined in the vendor's list of parts (recorded in the Vendor 
Parts form). 
3. Select the Shipping Cost Type that represents your usual method of shipping each part.  
Dual-Currency Users: Defining Customs Data 
1. Enter the Countries form. 
2. For each country from which you import goods, select the appropriate Customs Category. 
3. Enter the Itemized Customs Rates form. 
4. Record a line for each relevant customs item, defining its customs percentage (in the relevant 
columns). 
Tip: To define a different customs percentage for specific countries, use the Special Customs 
Rates sub-level form. 
5. Enter the Part Catalogue and retrieve the purchased part in question. 
6. Select Financial Parameters for Parts from the list of Direct Activations. 
7. In the Shipping Expenses tab, select the appropriate Customs Item. 
8. Enter the Vendors form. 
9. Retrieve all vendors from which you import goods, and make sure a Country has been recorded 
for each one in the Address and Phone tab.

www.priority -software.com   
3/5 ‏Feb. 04, '15 Ver.03 Cat.No. A8000071 
 
Defining Shippers as Vendors 
 See the Standard Operating Procedure for opening vendors. 
Procedure 
The Outgoing Shipping Voucher module allows you to link purchase invoices (or purchase invoice 
items) recorded for shipping expenses to customer invoices. This allows you to obtain an accurate 
picture of the profitability of sold parts. 
Stage I: Opening an Outgoing Shipping Voucher 
1. Enter the Outgoing Shipping Vouchers form. 
2. Record the Date Opened. 
3. In the Customer No. column, specify the main customer in the shipping voucher. 
4. Click the References tab. In the Currency column, specify the main currency in the shipping 
voucher. 
5. If you opened the shipping voucher for a single sales order, specify its number in the Order 
column. 
6. Dual-currency users: Select the relevant Customs Agent Code from the list of vendors. Fill in 
the Customs Manifest Date and Customs Mainfest No.  
7. Click the Shipment tab and fill in the shipment data. You can also do this at a later date. 
8. Assign the appropriate Status, according to the workflow defined for shipping vouchers. 
Stage II: Linking Purchase Invoices to an Outgoing Shipping Voucher 
Linking the Two When Recording the Invoice 
 In the invoice form, in the References tab, specify the number of the outgoing shipping voucher 
in the Shipping Voucher column.  
Linking the Two After the Invoice is Recorded 
1. Enter the Purch Invs for Outgoing Shipmts form. 
2. Retrieve the desired purchase invoice.  
3. Specify the Shipping Voucer. 
4. For dual-currency users, specify the Customs Manifest No., if necessary. 
5. Enter the Invoice Items sub-level form 
6. For dual-currency users, make sure the Country of Origin is correctly recorded. 
7. If you want to define a special method of distributing an expense item among the sold items 
billed in a specific invoice (i.e., a different method than the default defined in the Setups 
section): 
 Enter the Manual Distribution of Expenses sub-level form from the expense item line. The 
form displays the sold items recorded in the shipping voucher.  
 Use the Proportion of Burden column to define the relative burden of each item. 
 To view the results of manual distribution, leave this form open and, for the outgoing shipping 
voucher in question, run the Calculate Expense Burdening program from the list of Direct

www.priority -software.com   
4/5 ‏Feb. 04, '15 Ver.03 Cat.No. A8000071 
 
Activations. Refresh the Manual Distribution of Expenses form (Ctrl+F11). The correct 
burden amount for each part will now appear in the Expenses column. 
Linking Individual Purchase Invoice Items to the Voucher 
If the vendor has sent a single invoice for services that affect several shipping vouchers, you can 
link each invoice item to a different shipping voucher. 
1. Enter the Purch Invs for Outgoing Shipmts form. 
2. Retrieve the desired purchase invoice.  
3. Enter the Invoice Items sub-level form and, for each line, specify the correct Shipping 
Voucher. 
Stage III: Linking Customer Invoices to an Outgoing Shipping Voucher 
Linking the Two When Recording the Invoice 
 In the invoice form, in the References tab, specify the number of the outgoing shipping voucher 
in the Shipping Voucher column. 
Note: Dual-currency users should generally use the Export Invoices form.  
Linking the Two After the Invoice is Recorded 
1. Enter the Cust Invs for Outgoing Shipmts form. 
2. Retrieve the desired customer invoice. 
3. Specify the Shipping Voucher.  
Tip: To view all customer invoices linked to a given voucher, enter the Customer Invoices sub-
level of the Outgoing Shipping Vouchers form. 
Stage IV: Calculating Expense Burdening in an Outgoing Shipping Voucher 
1. Enter the Outgoing Shipping Vouchers form. 
2. Retrieve the desired shipping voucher. 
3. Select Calculate Expense Burdening from the list of Direct Activations. 
Note: You can run this program numerous types (e.g., each time a new invoice is linked to the 
shipping voucher). 
Stage V: Closing an Outgoing Shipping Voucher 
1. Retrieve the desired shipping voucher in the Outgoing Shipping Vouchers form. 
2. Select Close Shipping Voucher from the list of Direct Activations. 
Notes 
 If you want to link an additional invoice to a closed shipping voucher, select Reopen Shipping 
Voucher from the list of Direct Activations, link the invoice and close the voucher again. 
 The cancellation of an invoice linked to a shipping voucher does not affect the shipping voucher. 
You need to enter the shipping voucher and delete the invoice manually, or link the voucher to a 
credit memo.

www.priority -software.com   
5/5 ‏Feb. 04, '15 Ver.03 Cat.No. A8000071 
 
Results 
 After linking invoices to an outgoing shipping voucher and running the Calculate Expense 
Burdening program, you can view the actual cost of the sold parts included in the voucher. To 
view this, run the Outgoing Shipping Burden report by Direct Activation from the Outgoing 
Shipping Vouchers form. 
 By linking invoices to a shipping voucher and closing the voucher, you allow profitability reports 
to calculate a part's true profitability – after the relevant expenses have been allocated.
