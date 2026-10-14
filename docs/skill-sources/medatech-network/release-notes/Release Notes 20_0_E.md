# Release Notes 20_0_E

- **Source:** `Release Notes 20_0_E.pdf`

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    1/19 
Release Notes Priority  v20.0* 
Main Upgrades in the New Version  
User Interface  
● Quick Search  
We’ve added the new Quick Search to help you locate a record quickly.  
❏ Start your quick search by clicking on the magnifying glass icon under 
the form title.  
 
❏ The search starts once you type three  characters.  
❏ The search runs on three predefined fields.  
❏ To define the fields of the quick search go to Columns to Search  form 
(a sub -level of Document Types in Search  form) and check three  
fields for Quick Search  (the fields must be checked for Search  as 
well).  
❏ The quick search presents up to 20 results.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    2/19 
 
❏ Clicking on one of the results will open the record in full screen.  
❏ If the quick search d oesn't present the documents you were looking for, 
or if you want to search by other criteria, you can click on the 
Advanced Search  button in the Quick Search tool.  
 
● Search by Name  
You can now search names in the Name/Description  field, as well as in the 
Number  field.  
❏ When looking for a customer, a vendor or a part by its name, type the 
name in the Name  field (Customer Name, Vendor Name etc.) or in the 
Description  field (for parts, serial number, etc.) and choose it from the 
results list.  
 
● Print Dialog Box 
We have renewed the print dialog box in order to provide an easier and 
clearer user experience.  
○ We merged the formats for printing and displaying documents. You can 
now find the Word templates and the HTML formats in one drop -down 
list.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    3/19 
○ After choosing a format , the relevant document’s options  are displayed:  
print, display, mail, or fax.  
■ According to your choice of action, more options will be 
presented, for example , after choosing to send an e -mail you’ll 
be able to choose to send a PDF file.   
○ Need to customize your document before using it? Clicking on 
Customize  in the print dialog box will open the Report Design tool for 
the relevant document.  
 Word Templates  
○ Fields in Word templates are now dynamic. If nothing was recorded in 
the fields, the y will not be presented in the printed documents.  
■ For example,  if you didn’t specify a discount in a purchase order, 
the Discount  field won’t appear in the printed document.  
 
● Report and Document  Design  
The HTML reports and document printouts have a new design.  
❏ The changes apply to the system’s default format.  
❏ The background color is now white.  
❏ Lines in tables are visually separated using different shades of grey.  
❏ There are new icons and a new design fo r the headers.  
❏ As always, you can customize your documents, including the text color 
options, using the Report Design Tool.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    4/19 
 
Priority Mobile  
Priority Master  is now Priority Mobile . Along with the name change, there are 
many new features.  
● Out-of-the-box Priority apps 
Working with Priority Mobile is now easier than ever. New subscription -based 
Priority  customers can access predefined Priority  applications by scanning 
just one QR code.  
○ The applications that are currently included are CRM, Sales, 
Purchas ing, Sales Reps., and Warehouse Management.  
○ To start working with the apps:  
■ Generate a QR code by running the Priority Mobile Scan Code  
program (path : System Management  > Applications ). 
■ Download the Priority Mobile app from the apps store.  
■ Scan the QR code  using the Priority Mobile app.  
● Credit card clearing , which  was previously only available in Priority , is now 
available in the Priority Mobile application by clicking Payment . 
○ Credit clearing via the application is made possible with  PayMe.  
● Push notifications  
Priority Mobile now has push notifications!   
○ You can define push notifications for Priority Mobile in the BPM for the 
relevant form or via Define Business Rules .  
○ Notifications in Priority Mobile can be disabled directly from your 
device.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    5/19 
 
● Search lists  — you can now start your search by just typing ; the search will 
start immediately.  
○ You no longer have to choose the search criterion (name or number). 
Priority  will find results for you in all of them.  
● The Status field  was redesigned and relo cated to a dominant location.  
○ If the statuses were assigned with colors in the BPM in Priority, you’ll 
see them on your mobile as well.  
 
● Record colors  appear in the app.  
○ The color appears in a line above the record (see image above).  
○ Defining the coloring conditions is set in Priority .  
● Files upload to mobile  - Uploaded files and photos over 100kb will now be 
compressed. This will not affect the size and resolution of the files and 
photos.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    6/19 
● The Global Way : As part of our goal to provide  Priority  in our customers ’ 
languages, Priority Mobile is now available in Flemish.  
● Log in  to Priority Mobile  via third -party authentication.  
○ This is relevant to companies that work with third -party authentication, 
such as  OKTA.  
○ Accessing Priority Mobile  via OKTA without Priority’s user  name  and 
password.  
Financials  
Priority Payments  
● We added a Forgot Password  option to the Payments  Portal for users who 
access the system with a username and password and not via Google.  
● You can now get paid against pro forma invoices as well using the Click2Pay 
and Payments Portal .  
● You can now collect payments via the Priority mobile app.  
● Use the new MaxPayments  financial constant to specify the maximum No. of 
installments that your company will accept per transaction performed by the 
customer in the Payments Portal or via the Click2Pay payment link. This can 
be defined per customer by using the new Max.No. Installments  field in the 
Financ. Parameters for Customers  form.  
● Sales order amounts can now be pre -authorized fo r payment via credit card 
up to 48 hour s before the customer decides to finalize the order and you run 
the payment on the credit card. To do so, use the Authorize Amnt for Pri. 
Payments program from the list of actions in  the Account/Credit Card to 
Charge  sub-level of the Sales Orders form.  
● In invoice revisions, you now have the option to delete the credit card details 
of a billing invoice so it can be sent for regular collection (in the 
Account/Credit Card to Charge  sub-level of the Revision of Invoice 
Details  form).  
● Credit cards can be accepted as means of payment when a new rental is 
created (see more about the Rental module below).  
Digital Banking  
● We've added support for payments in foreign currency.  
Account Reconciliations  
● When reconciling multiple one -sided entries within one account that do not 
have matching entries (for example, multiple lines of a customer’s debt with 
another customer’s account that has now taken over that debt) —you now

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    7/19 
have the option to specify whether  you want to create one adjustment entry 
for each  marked line or one entry for all marked lines.  
Bank Reconciliations  
● You can now add comments to bank statement lines. Use the new Remarks  
sub-level of the  Itemized Statement  form (itself a sub -level of the  Record 
Bank/AmEx Statements  form) to record or view remarks regarding the item 
in the upper -level form.  
● We’ve enhanced the automatic creation of transactions in the ledger based 
on the bank transaction code. Those can now be created based on a match in 
the Reference or the Details fields of the bank line. Use the new Reference  
field in the Bank/AmEx Transaction Codes  form to record the reference as it 
appears in the bank statement (in the case of a recurring utility bill, for 
example) or the existing Deta ils field, again, as it appears in the bank 
statement. When running the Record Bank Transactns in Ledger  program, 
which records journal entries against bank transactions for the purpose of 
reconciliations, the program will create entries based on a match b y 
transaction code (as it did before) , but if it doesn’t find a match, it will 
continue to search for a match based on reference and then details.  
Bank Feeds  
A brand new digital banking experience for our customers in the US. From now on, 
you can digitall y link your bank account in Priority  to your account in the bank and 
get your bank feeds seamlessly and easily. No more downloading file statements 
from the bank and uploading into Priority . You simply connect once and your bank 
pages are fed digitally — either on demand or scheduled .  
● In order to initiate digital banking using the Plaid solution, run the new 
Connect Accounts Digitally  program (in the new Connect Accounts 
Digitally  menu) to receive a unique access token from Plaid.  
● Plaid connection details can be viewed and defined in the Plaid Account 
Access Definitions  form.  
● To the Additional Information sub-level of the Bank Accounts  form, we 
added:  
○ an External ID  field which stores a unique identifier that Plaid uses 
when connec ting to the account in the bank.  
○ a Digitally Connected  flag: when marked, it indicates that the account 
in Priority  is digitally connected to the account in the bank via Plaid.  
● The Digitally Import Bank Statements program allows you to import account 
trans action details in order to generate a bank statement in the system for 
reconciliation purposes.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    8/19 
SOX Compliance  
As part of Priority ’s global strategy, we make continuous efforts to make SOX 
compliance easier for our customers. In this version:  
● The Financial  Documents  form has a new History of Changes  sub-level 
form so that you can view changes made to the definitions of financial 
document types in the upper -level form.  
● All fields that can be revised in the finalized invoice are now recorded in the 
change lo g.  
Other Enhancements and Features in Financials  
● Now when running the Set Format -Blank Paper Printouts  program, you can 
flag the new Data frm Items Form  input column if you want the vendor's 
name in the Check Payment - Add'l Details  form (a sub -level of the Check 
Payments  form) to appear in the printout.  
● The Checks Past Due Date  form (a sub -level of Customer Credit  form) now 
displays the cashier holding the check in the At Cashier  and Cashier 
Description  columns.  
● Run the new troubl eshooting report, Check Inventory Upd. in Invoices , to 
make sure that every line in sales, over -the -counter, and vendor invoices has 
a corresponding inventory transaction.  
● In the Purchase Order Items in Voucher form (a sub -level of the Shipping 
Vouchers  form), the Quantity  field was renamed Quantity in Order  to better 
reflect that it displays the ordered quantity of the item linked to the invoice 
included in the voucher in the upper -level form. We also added a  Quantity in 
Invoice  field to display the quant ity of the order item that was actually 
charged in the invoice line.  
● To help you manage your companies' credit cards in the system, you can now 
flag them Inactive  (or active, by removing the check mark) in the Company 
Credit Cards  form.  
● When opening a ret urned payment to a customer (in the Returned Payments  
form), you can now set the default for the value in the Returns Cashier  field 
by defining the new ReturnPayCash  financial constant.  
● Budget item selection was made easier by showing only items from budg et 
versions in effect where relevant throughout the system.  
● We’ve added a new report to show the financial status of purchase orders.  
● Working with prices including tax was now extended to service contract 
payments as well.  
● The Transfer Sums to VAT account  procedure now carries the transaction 
over to the next open period if the period for posting is already closed.  
Meter Reading

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    9/19 
● You can now define complementary meter points per machine.  
● Included meter readings are now taken into account when prepa ring 
payments.  
● The system now takes into account the predefined monthly minimum reading 
for several months combined when preparing payments.  
Sales, Purchasing, and Inventory  
Sales  
Rental Module  
Introducing the new Rental module! For businesses that rent out equipment, this 
module provides all the forms and programs that allow you to optimally manage the 
rental process in your organization, including:  
● Management of the availability of rented equipment — including a new Gantt 
chart display!  
● Easy updating of  the shipment and return of rented equipment  
● Automatic preparation of customer invoices according to the period that the 
equipment was in the customer’s domain, including partial billing of ongoing 
rentals  
● Clearing credit card payments in Priority Payments  as a payment method, 
and the option to clear payments and prepare receipts automatically for 
customers with a standing order (billing)  
● For more information, see our standard operating procedures  on rentals  in 
Priority ’s Xpert Knowledge Base . 
Managing Dropshipping Orders  
You can now manage and easily track dropshipping  orders, in which the customer 
orders from your company while the goods are delivered from your vendor directly 
to the end customer. The work process is as follows:  
● Flag lines in the customer order as items for dropshipping (parts can also be 
defined for dropshipping)  
● When opening a purchase order based on a dropship -type customer order, 
the shipping address is filled in automatically with the end customer’s 
address.  
● When recording a vendor invoice in the system and finalizing it, a shipping 
document or s ales invoice for the customer is opened automatically with the 
end customer’s address.  
● A new Items in Drop Shipping Orders  form displays all order items sold via 
the dropshipping process and where they are in the process, whether a

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    10/19 
purchase order was recor ded for them, a vendor invoice, or a shipping 
document or sales invoice. This form helps you in the management and 
supervision of the various stages in the process.  
For more information, see standard operating procedures on the subject  here  or in 
Priority ’s Xpert Knowledge Base . 
Additional Enhancements in Sales  
● The new % Overall Discount  field in the Choose Order Items and Sales 
Orders for Document  forms displays the overall discount for each sales 
order linked to the document in the upper -level form (either the Customer 
Shipments  or Warehouse Transfer  form). If the % Overall Discount  field in 
the upper -level of the Customer Shipments  form is 0, then the discount will 
be updated according to that of the first order selected in the Sales Orders 
for Document  or Choose Order Items  sub-level forms. The new field allows 
you to link to the shipment orders  with  an identical overall discount.  
Inventory  
● We've expanded the length of the part number, part description, and serial 
number fields to accommodate longer strings.  
● You can set up a safeguard against assigning the same serial number to two 
different par ts. Set the new logistic constant IDoubleSern  to 1  to receive a 
warning message if you assign a serial number in the Serial Numbers in 
Transaction  form (a sub -level of various inventory documents) that is already 
in use by a different part. You can change the warning message into an error 
message in the Privilege Explorer.  
● The Warehouse Inventory Levels  report now allows you to display the 
deviation from maximum inventory, in addition to minimum inventory (for 
example, when you need to limit the permissibl e quantity of dangerous 
materials in a warehouse). If you flag the new Above Maximum Only  option 
in the report input, it will display the items whose warehouse quantities 
exceed the maximum inventory specified in the Warehouse Inventory Levels  
sub-level of  the Warehouses  form. Also, the system will display warning 
messages when the maximum inventory is exceeded for the part in the 
warehouse  in the Order Items  sub-level of the Purchase Orders  form.  
● If you change the status of a part in the Part Catalogue  to one that is defined 
as inactive, the system will check if the part has any inventory, and if so will 
display a  warning message. You can change the warning message into an 
error message in the Privilege Explorer.  
● The itemization of sales invoices and over -the-counter invoices now displays 
the date on which this lot or work order is due to expire in the new 
WkOrd/Lot Expir.Date  field, similar to the shipping document. We've also

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    11/19 
added the new field to the Source of Inv. Transacts Report Generator  and 
Source of Sales Report Generator .  
● For your convenience, we've added a Bar Code  field, which displays the bar 
code of the part, to the following forms:  
○ Assembly Reporting  (a sub -level of the Warehouse Assembly  form)  
○ Assembly Components (a sub -level of Assembly Reporting ) 
○ Inventory Parameters for Parts  
○ Service Parameters for Part  
○ Purchase/MRP Parameters for Part  
● Now, you can use the Auto Recording of Serial Nos. sub-level  form when 
the logistic constant ISerialTrans  is set to 1.  
Purchasing and Purchase Planning  
● Run the new Financial Status of Purch Orders  report to view the financial 
status of orders recorded over a given period, sorted by vendor.  
● You can now link a number of purchase demands to the Purchase Orders  
and the Request for Price Quotations  forms. The new Purchase Demands 
for PO and Purchase Demands for RFQ  sub-levels of the Purchase Orders  
and Requests for Price Quotations  forms, respectively, allow you to link 
multiple purchase demands and automatically itemize the PO or RFQ. The 
demand docu ment No. and demand line No. now appear in the itemization of 
the documents.   
● In the Parts per Vendor  form, you can now record different 
vendor/manufacturer part numbers for the same Priority  part No. and 
manufacturer.  
● When using a list of authorizers, yo u can now authorize purchase orders and 
demands by using the Authorize Purchase Order/Authorize Purchase 
Demand  program from the list of Actions in the Purchase Orders/Purchase 
Demands  forms, respectively, as an alternative to using the Purchase 
Demand/Pur chase  Order Authorization sub -level forms for approvals.  
● When opening a purchase order based on a purchase demand, items in the 
Attachments  sub-level form will automatically be copied over.  
Warehouse Management System (WMS)  
● A new wave is here! The Create Repl. Wave (Issue to Kit) program allows 
you to create replenishment (RIW) tasks in order to transfer inventory to the 
front warehouse to prepare for issues to work orders.  
● The Create Replenish Wave for Order  and Create Replenishment Wave 
(Inv.) programs now take into account expired inventory in the target zone 
when calculating the quantity required for transfer to the target zone.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    12/19 
● The Create Pick Wave for Order  and Create Pick Wave (by Order)  
programs now take into account customer site for the o rder item line. When 
running the wave, if the Task Split Method  is defined as 011 (each customer 
site separately) or 012 (one task per customer site), separate warehouse 
tasks will be opened for each customer site that was defined in the linked 
order item.  The site is taken from the upper -level of the order only if one is 
not specified for the item.  
● When creating a replenishment wave, if you defined the Max No. of Lines  
that can be included in each replenishment task created by this wave, the 
new Group Bin  in Task  flag allows you to instruct the system not to split 
items from the same bin into separate warehouse tasks. This flag appears in 
the following programs:  
○ Create Replenishment Wave (Inv.)  
○ Create Replenishment Wave (Ords)  
○ Create Replenish Wave for Or der 
● The Prepare Documents  program based on warehouse tasks will take into 
account profit centers specified in the sales order itemization.  
● In the Warehouse Tasks form, you can now change the value in the Distrib. 
Route Code  field in the upper -level form, even if there are items in the 
Warehouse Task Items  sub-level form. The distribution route in the upper 
level of the warehouse task will be taken in account when running the 
Prepare Documents  program.   
Production  
● We’ve added an Attachments sub-level form t o the Part Revisions  and 
BOM Revisions forms. When printing work orders with attachments — if you 
flagged the Print Part Attachmts  field in the upper -level of the work order — 
attachments linked to part revisions and BOM revisions for the part in the 
work order (in addition to attachments linked to parts in the Documents for 
Part  sub-level of the Part Catalogue  form, as before) will be printed.  
● We've added a new BPM process to the Reporting Production form.  
● Material Requirements Planning : 
○ When running the  Material Requirements Planning  program, you now 
have the option to specify the date up to which work orders should be 
opened (in the new Open Work Orders to  input field). The program will 
calculate purchase planning up to the date specified in the To Date  
field (as it does today), but will only open work orders up to the date 
specified in the Open Work Orders to  input field. Planned work orders 
(without a work order number) will be opened from the date in the 
Open Work Orders to field up to the date in the  To Date  field in the 
MRP program input.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    13/19 
○ Use the new History of MRP Runs  form and its sub -levels to view a 
history of MRP runs, including information such as the duration of the 
run, the user who ran it, the parameters of the run, and the value of the 
relevant production and planning constants at the time of the run. You 
can also  view parts whose calculation took longer than 30 seconds. 
This form replaces the old View Dates & Chosen Options  program.  
○ In addition to the regular Material Requirements Plannin g program, 
we’ve added the option to run the MRP program with only one input 
window. To do so, run the Material Req. Planning -One Input  program 
(the functionality remains the same).  
Service and Maintenance  
● In the Servicing Requirements of Item  sub-level of the Catalogue of Parts 
w/Serial Nos.  form, you can now assign a frequency for servicing a serialized 
part (in the Frequency (Days)  field) up to four integers (9,999 days).  
Maintenance by Meter Reading  
The Maintenance module, which allows yo u to define a servicing plan for serialized 
parts by frequency, now allows you to also define a servicing plan by meter reading 
or a combination of the two (time, meter reading):  
● For each part/serial number, you can define for each servicing type whether i t 
will be serviced according to time, meter pulses, or a combination of the two.  
○ Servicing according to time – the serial part is serviced according to 
time intervals only. The system will open future service calls according 
to the defined time interval.  
○ Servicing according to meter reading – the serial part is serviced 
according to meter pulses only. The system will open a service call 
when the meter reading reaches the defined number of pulses.  
○ Servicing according to meter reading and time – the serial pa rt is 
serviced according to time and also meter pulses (whichever comes 
first). The system will open future service calls according to the defined 
time interval and in parallel will perform repeated checks of the meter 
pulses to determine if the reading re ached the defined number of 
pulses, and if so, will update the servicing plan accordingly.  
For more information on routine servicing by meter reading, see our standard 
operating procedures on  the subject  here  or in Priority ’s Xpert Knowledge Base .

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    14/19 
Global  
● To automate basic settings and avoid user error on opening new 
customers/vendors, now when opening a new customer or vendor from a 
specific country, the values defined in the following new fields in the Country 
Settings form (a sub -level of the Countries  form ) will be updated 
automatically in the financial definitions for the customer/vendor relative to 
the country of the customer/vendor:  
○ VAT Code - Vendor  
○ VAT Code - Customer  
○ Currency - Vendor  
○ Currency - Customer  
○ Debit EntryCode -Vend  
○ Cred EntryCode -Vend  
○ Debit EntryCode -Cust  
○ Cred Entry Code -Cust  
In countries already localized by Priority , these values will be predefined for 
a new company/installation as part of our service to provide basic data.  
● We extended the service of basic data we provide to installat ions/companies 
to the following entities:  
○ Taxonomy codes (Germany, Portugal)  
○ VAT record types (UK, Germany)  
Europe  
● Use the new VAT Record Types  form to view or define the VAT record types 
that are displayed in the VAT Record Type  field of various forms, such as the  
Box Definitions  sub -level of the Tax Report Boxes  form or the Financ. 
Parameters for Customers form. For new installations, as part of our service 
to provide basic data, in countries where this service is supported, thi s form 
will be prepopulated with data relevant to your company’s country.  
● You can check the validity of the VAT file numbers of your EU customers and 
vendors against the VAT Information Exchange System (VIES) database. To 
do so, run the Validate VAT File No. - EU program (from the 
Customers /Vendors  forms or from the VAT Reports  menu). Each run of the 
program and the response from VIES is saved in the VIES VAT No. 
Validation Log  form.  
● A new financial constant that is due to be set in Europe, makes it manda tory 
to detail tax components for VAT reporting in manual journal entries that 
include VAT accounts .

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    15/19 
● The VAT number of a customer/vendor is now stored in the invoice record so 
that if it is changed in the master data, the invoice remains intact. You can 
also specify this number manually for one -time customers/vendors.  
VAT Report Generator  
● You can now run the VAT Report (by Boxes)  from the list of Actions in the 
VAT Report Creation/Transmit Log  form.  
● The new TaxDetails  financial constant determines whethe r the system will 
check that manually recorded journal entries have at least one sum for a VAT 
income or expense account in the VAT Calculation Details  sub -level of the 
journal entry.  
US 
● If you make payments and perform billing via NACHA from a savings account 
(not a checking account), Priority  now supports this option. We've added an 
Accnt Type to Charge  field to the following forms so you can choose 
whether this account is a checking or savings account:  
○ Additional Information  form, a sub -level of the Bank Accounts  form 
— allows you to define the type of company bank account from which 
transfers to the vendor will be sent, either a checking or savings 
account.  
○ Account/Credit Card to Charg e sub-level of the Customers  form and 
the Account/Credit Card to Charge  worksheet — allows you to define 
the type of customer account with a standing order from which payment 
will be withdrawn to your account, either a checking or savings 
account.  
● Priority  now supports assigning tax codes according to the extended nine -
digit zip code, not only the original five -digit zip code. To do so, change the 
setting of the TaxCodeByZipState financial constant to the new setting ( 2 = 
By extended zip code ).  
● ShipEngine : Do you work with multiple accounts held by the same carrier? 
Priority  now supports you!  
Integration with Avalara  
● If you perform billing, you'll be pleased to see that the Calc. Tax with 
Avalara for Inv.  program now appears in the Avalara submenu to 
accomm odate sending invoices to Avalara for tax calculation in a batch.  
● The Update Tax Codes for Customers program, which overwrites invalid tax 
codeswith valid ones, can now be run also for tax -exempt customers (by 
flagging the Incl exmpt customers  field in th e program input).

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    16/19 
UK 
● In keeping with HMRC's new requirement to provide custom er specifications 
with every API call (anti -fraud headers) , we've enhanced the transmission 
content (st age one and more to follow). This can also be viewed in the new 
sub-level of the VAT Transmission Log (UK)  form, which displays the 
header and header val ue transmitted to HMRC.  
● You can now run the VAT report for a range of dates that do not necessarily 
fall in the same year.  
● Consignment stock movements from the UK to the EU are now reflected in 
the VAT report at cost.  
Belgium  
● The payment reference is now printed in the required structured  format on 
customer invoices.  
● You can reconcile bank statements  (uploaded in CODA format) with customer 
invoices in your system. To do so, run the Prep Receipts for Bank 
Statement  program from the list of Actions in the Record Bank Statements  
form. The system will generate receipts in the background, matching them 
both to the invoices and the bank statement  lines.  
Germany  
Priority  is proud to present the localization to Germany as part of version 20.0. Our 
localization is certified by a leadi ng auditing firm and in accordance to certification 
standard IDW PS 880 for software , as required in Germany. For more information 
on the certification of Priority  in Germany please visit/download the full report 
under www.bdo.de/standardsoftware -priority -version -20-EN.  
● Support for DATEV Accounting Software : You can export financial data in 
a format that meets the requirements of DATEV accounting software. Use the 
new Export in DA TEV Format - Germany  program to create a csv file for 
DATEV; all data exports are logged in the DATEV Load History  form.  
● The new EC Sales List - Germany  procedure allows you to easily create the 
EC Sales List file for monthly or quarterly submission to th e tax authorities.  
● The Intrastat – Germany  report allows you to generate the Intrastat report 
and file for submission to authorities as required.  
● To define and run a VAT report for a company in Germany, use the VAT 
Report Generator (see our standard operating procedures). Then run the new 
VAT Report - Germany (by Boxes)  to create the VAT report. If in addition to 
the report, you wish to generate an XML file for submission to tax authorities, 
flag the relevant box on the report input screen.  
● If you transmit VAT returns electronically from Priority , use the new VAT 
Report - Sums for Germany  form (a sub -level of the VAT Report

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    17/19 
Creation/Transmit Log ) to  display the VAT sums transmitted, broken down 
by VAT report box.  
● Run the new Run Interbank Payables -Fgn.Curr  program to extract bank 
transfers in a foreign currency (flagged in the Flag Bank Transfers for ITP  
form) to a payment transfer file in DTAZV fo rmat.  
● Trial Balance : Run the eBilanz Balance - Germany  program to export 
specific data into a Excel file which can be used to submit an electronic trial 
balance (eBilanz) to tax authorities via third -party software.  
● Priority  supports early payment discoun ts in Germany, where there is no 
impact on the invoice, but the receipt includes retroactive handling of the 
VAT. To enable this option, use the new 2, On payment with VAT handling 
(Germany)  setting for the EarlyPayDiscount financial constant.  
● Use the Import MT940 Bank Statement  program to import MT940 bank 
statements into Priority  in STA format. The statement No. in the bank’s 
system will be displayed in the new External Reference  field in the Record 
Bank/AmEx Statements  form.  
● Priority supports the expor t of data tables in GoBD format, as required by tax 
authorities. Run the GOBD Export - Germany  program to specify the type of 
data you want to download from the system into CSV files.  
See the Germany Localization Map  in Priority ’s Xpert Knowledge Base  to see all 
the standard operating procedures (SOPs) available on the developments above.  
Each SOP  is accessible in Xpert as well.  
Portugal/Angola: SAF -T Reporting  
● Digital signatures:  
○ a new SAFT Document Code  field in the Inv. Transaction 
Documents  form in which you can specify the prefix that will be added 
to the digital signature’s value when an inventory transaction document 
of a certain type is digitally signed.  
○ a new Check Digital Signature  program from the Customer 
Shipments  and Returns to Vendor  forms, which checks the digital 
signature of the shipping/return document.  
○ the Digital Signature  program can now be run also from the Revision 
of Final Shipping Doc.  and the Revision of Final Vendor Return  
forms, to sign the revised version of a finalized (previously signed) 
document.  
● The following new fields in the SAFT Definitions  program input enhance the 
SAF-T file that is generated: Software Validation No. , Product ID , Product 
Version .  
● The logic  for choosing an exemption reason on invoice lines in the SAFT file 
was extended to support line -level exemption codes.

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    18/19 
● Walk -in customers are now handled in accordance to regulation 
requirements.  
System Maintenance and Misc.  
● We’ve added support for the Microsoft Edge browser.  
● The Internet Explorer browser is no longer supported.  
● We've added a Run on Round Hours  flag to the Tabula Task Scheduler  
form. If you define the hour from which recurring tasks should be run, you can 
flag this column to specify that they should begin on the next round hour.  
● The new Replace User in Authorizer List  program allows you to replace a 
former user with a new user in a list of authorizers, in order to ensure 
continuity with existing authorizer lists. This is useful when an employee 
leaves the company, or for any other reason that might require a change in 
users.  
● The Replace User  program input now allows you to copy  more settings from 
a former user to a new user. You can flag these additional fields to select the 
settings to copy over to the new user: Replace in Auth [orizer]  List, Replace 
in Bus [iness]  Rules , and  Replace in Data Gen [erator].  
● The new NETFILESAUTH  system constant allows you to block the possibility 
to view an attachment via the URL without authentication.  
● The new Print Formats for Report  form (a sub -level of Procedure Steps , 
which is itself a sub -level of the Procedure Generator  form) displays the 
print formats in which the report in the upper -level form appears.  
● Now there is no need for each user to define his or her e -mail settings (Web 
or Mobile). See the documentation on the SENDMAILBY  system constant.  
● Start working with our out -of-the-box Priori ty apps (if your license includes 
Priority Mobile): The Add New User  program has a new Priority Mobile  input 
field. This field is checked by default; therefore, when adding a new user, the 
user is added automatically to the Users for Application  (sub -level  of the 
Applications for License  form).  
● The name of the service for the Application Server was changed to Priority 
App Server (formerly priority.net).  
● We have updated the behavior of search lists in key fields . 
○ Now, when typing a value in a key field, the search list will only open 
by clicking the arrow icon/pressing the space bar/pressing F6 (and not 
automatically as in other fields).  
■ Example: the search list in the Customer Number  field will open 
automatically when you start typing, if the field is not a  key field 
(as in the Sales Orders  form), but will not open automatically 
when the field is a key field (as in the Customers  form).

omsoftware.c-www.priority  
Cat.No . LBI2000227          Ver.  1 │ March  16, '20    19/19 
○ When you actively open the search list after typing characters, the 
relevant characters will appear in bold in the search list.  
● The "between" operator can now be applied in the Advanced Search and 
column filter on alphanumeric columns, not just numeric columns. For 
example, if you want to search from invoice No. INV100 to INV200 (i.e., an 
alphanumeric document number), use t he "between" operator and specify the 
range.  
● As part of our efforts to streamline and maintain clarity in our system 
language, “columns” are now be referred to as “fields.”  
Programming  
● The new OAuth2 Data  form (a sub -level of the OAuth2 Definitions  form) 
allows you to define and view settings for the OAuth 2.0 protocol. The form 
has two sub -levels that store the access token and refresh token. For more 
information, refer to the SDK for Priority .  
REST API  
● When connecting to the REST API, you can now limit the response to records 
that were revised starting from a specific date.  
● We fundamentally changed the way to work with text forms: there is no need 
to break up text into separate lines, and we included th e option to add text to 
the existing text (and not just to replace it).  
● You can make REST API calls with a Personal Access Token (PAT).  
Web SDK  
● We made changes to the Web SDK in order to support working with secure 
attachments via the new NETFILESAUTH  system constant.
