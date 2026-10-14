# Release Notes 19_1_E

- **Source:** `Release Notes 19_1_E.pdf`

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    1/14 
Release Notes Priority 19.1  
Main Upgrades in the New Version  
User Interface  
Easy Search  
 Search more easily in form columns: You can now search for values in the 
form without having to press F6. Just start typing and the system will filter 
through the records in that and related columns to find your result/choose 
list. For instance, if you are searching for a specific customer, you can enter 
the customer’s ID No., or name in the Customer No. column, and the system 
will do the rest.  
 Do you prefer the old way of opening choose/search lists (i.e., to turn off 
autocomplete when typing)? If so, turn off the Show Results While Typing  
option (in the Options  > Edit  menu).  
o As part of the improvement, we fixed an old bug that prevented the EMPTYSEARCH 
system constant from affecting choose lists. If your choose lists are not functioning 
as expected, check the setting of the constant. 
 You c an now choose to turn off the live suggestion of search results as you 
type by adjusting the new FORMAUTOCOMPLETE  system constant.  
Filters  
Priority has developed a new and simple way to filter the records displayed in 
forms. In List Display mode, simply cl ick on the filter ( ) icon at the top of a 
column to open a window in which you can define the search conditions when a 
filter is activated. Only records containing the defined conditions will be displayed. 
You can set several search conditions per column and set filters on multiple 
columns at once (see image below). In addition, the filters enable you to gradually 
filter through results. That is, if you defined a filter that produced too many results, 
you can add a value, or change the existing search cond ition in order to reduce the 
results, and vice versa.  
 
 To view the search conditions according to which the form was filtered, click 
the icon at the top of the column.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    2/14 
 
 When you enter a form with a defined default search, you can now see the 
search con ditions in play. The filter icon will appear in blue beside the titles 
of the columns that have been searched. Clicking on the icon displays the 
active search conditions for that column.  
 You can see all search conditions in play in the form in the Advanced  
Search  tool, where you can change the search conditions and save the 
search for future use.  
 
 When a search or filters are defined in the form, the  button will 
appear in the Actions bar. You can cancel all active searches/filters by 
clicking it.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    3/14 
Opening a Form  
Forms that have no default search configured will now open empty. Forms with a 
defined default search will continue to open according to those criteria.  
Note: If you do not have a default search, we recommend using the filters, saved 
searches, and Advanced Search to retrieve the desired records.  
 
Form without a defined default search  (in List Display mode)  
System Messages  
We have updated system messages to mak e them friendlier to users, including the 
following:  
 We updated our error, warning, and confirmation messages.  
 We added save messages; now you’ll always know when the system is 
saving your data for you.  
 We changed the look of the message as well as the o rder and content of the 
message buttons for a clearer and more comfortable user experience. Now 
the recommended action is highlighted in blue to prevent mistakes (see the 
image below).  
 From now on, you will be able to reduce the number of system messages 
that you see by flagging the “Don’t Show Again” option.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    4/14 
Additional User Interface Changes  
 You can now select a date format (i.e. DD/MM/YYYY or MM/DD/YYYY) when 
customizing your print options.  
 The “Does Not Equal” search condition option (operator) in the standard 
search and advance search tool is now available in additional fields.  
 We added the  icon to the title bar in the forms. This enables you to easily 
move between List (Multi -Record) Display mode and Full -Record Display 
mode.  
 We updated the Wor d Template Design Tool for  a more streamlined user 
experience, we replaced the icons with the names of the actions that they 
perform and added helpful messages for when you upload and download 
files to keep you informed along the way.  
 The Import All My Des igns  program is now an Action from the Profiles  
form. The user who runs the program can import all design choices to the 
profile, including all form designs, saved searches, and favorites.  
Priority Master  
 When working with Priority  version 19.1 and higher,  you can now sign 
documents without having to print them. From the Actions menu, tap Sign  
and then just sign in the signature pane that appears. The signature will be 
included when printing the document. The signed document will 
automatically be attached to the system document (in the Attachments  sub-
level form). Note : Adding a signature to a document requires defining a Word 
template that allows this option.  
 Now you can choose a print format directly from the application (for those 
who work with Priority version 19.1) and not according to definitions within 
the Priority  system as it worked un til now.   
 We added more predefined applications for Priority  Master, enabling you to 
perform more tasks from your mobile device. You can use the Send Link to 
App program in this menu to send a QR Code to selected users so they can 
load application setting s.  
 You can now share Priority  documents (e.g., send your invoices/orders, 
etc.) directly from your mobile device and share them via  any means defined 
in your device (such as email and WhatsApp).  
 Search:  Tapping the magnifying glass icon allows you to search by fields 
defined in the Application Generator (by flagging the Search  column in the 
form). You can define up to four fields.  
 Forms that have no default search configured will now open as empty, letti ng 
you proactively search/sort through data (e.g. via filters). Forms with a 
defined default search will continue open according to those criteria.  
We added a filter indicator for your default search. Tapping the filter shows 
the search conditions in play .  
Note:  This is only available when using Priority  versions 19.0 and higher.  
 Sorting search results:  Tapping the Sort icon a list of all form fields, letting 
you sort form records by a field of your choice.  
 Searching with Multi -Choose:  When using a filter  in Priority  Master, you 
can search by multiple search criteria by selecting more than one variable in

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    5/14 
the choose list.  
Note:  This is only available when using Priority versions 19.0 and higher.  
 During login, you can now reveal the password you entered.  
 You can now press on Phone /Email /Link  fields to call/email/access a 
website from read -only fields.  
 Single Sign On : You can now sign onto Priority  Master with various single 
sign on services such as google credentials. Simply enable access via 
Google upon sign in and you’ll never have to enter your password again.  
Financials  
Customer Portal  
Priority  is proud to present our new Customer Portal, an e asy solution for your end 
customers to make and view credit card payments, all through the Priority  portal.  
In the portal, you can display all open invoices and pay them using a selected credit 
card. Credit card details can be saved for future use. You c an also display the 
payments you've made, as well as receipts on payments, and print them.  
Your end customers can log in to the Customer Portal using external credentials, 
such as their Google and Windows 365 logins, or they can create an end -user 
account in Priority . 
Digital Banking  
The new digital banking module allows you to make a direct connection between the 
bank account in Priority  and the one in your bank's system. In the first stage, we've 
enabled digital banking for the First International Bank of  Israel. This functionality 
will be expanded to additional banks to the extent that regulations and the banks 
allow. The new module offers:  
 Making a single payment with one click from the Pay by Bank 
Transfer/Credit Card  form.  
 Transmitting multiple payment s from the menu, similar to the current 
payment method.  
 An interface that is directly accessible via API and does not involve files. The 
indication of a successful transmission is immediate.  
Account and Bank Reconciliations  
In response to your requests, Priority  has upgraded the reconciliation experience 
for ledger and bank accounts in the split reconciliation worksheets.  
Pending Reconciliations  
 The new SplitReconMode  financial constant defines how ledger accounts 
and bank statements/accounts should be reco nciled in the split worksheets, 
either in one step or two. According to the new default setting, you create 
pending reconciliations first, either manually or automatically, and finalize 
them in a separate step and clear them from the worksheet.  
Partial Rec onciliations

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    6/14 
 You can now create partial reconciliations when reconciling accounts. Use 
the new Reconcile Partially  button in the split worksheet to partially 
reconcile two or more marked lines that have a variance. When running the 
Prepare for Reconciliati on program to prepare journal entries for account 
reconciliation, use the new Sort Partial Recon.  column to specify how partial 
reconciliations will be sorted in the worksheet, either above or below the 
other unreconciled lines.  
For more information, see the standard operating procedures on account 
reconciliations  and bank reconciliations  in the split worksheets.  
Cost of Goods Sold (COGS)/Perpetual Inventory  
Recording Price Variance from the GRV  
 If you work with standard costs, the new financial constant 
COGSPriceVariance  allows you to record vendor price variances when 
recording the GRV, even if no vendor invoice is recorded yet. This setting 
also affects the Price Variance  report, and it will no w display the purchase 
price variance from GRV and Returns to Vendor  documents.  
 Use the new Sort  column in the Price Variance  report to display the 
difference between the purchase price and the standard cost either by part or 
by document. This update repl aces the Price Variance by Invoice report.  
Miscellaneous in Financials  
 With the addition of a new setting for the TransSumsToVAT  financial 
constant, Priority  now supports working with quarterly VAT reporting 
periods.  
 The new VAT Calculation Details  form,  a sub -level of the Entry Journal  
form, displays the breakdown of components that affect the calculation of 
VAT when the entry is posted, including the tax code, tax group, presiding 
tax rate, etc.  
Attendance  
 Now the system can report hours automatically a lso for hourly workers who 
do not report attendance at all (that is, whose Time Report Method  is No 
Report ).  
o When calculating monthly attendance, the hours will automatically fill in based on the 
standard works hours defined in the Attendance Data per Employee form (or 
detailed in its Work Hours per Employee sub-level). Any full day's hours manually 
reported hours override the automatic reporting on that day. 
o In the Work Hours per Employee form, we've added columns to designate a 
department and branch for the standard hours defined for the line. 
o We've created a standalone Work Hours per Employee form for easy retrieval of all 
employees and the manual revision of standard work hours. 
 The new Show Logins/Logouts  input column in the Monthly Reported 
Hours  repo rt, allows you to specify the number of logins/logouts you want to 
display in the report per day (from two to five).

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    7/14 
Sales, Purchasing, and Inventory  
Sales  
 For users who prefer to report assemblies right before they are shipped, you 
can now open an assembly document from invoices and shipping documents! 
Run the new Open Assembly Based on Invoice  and Open Assembly 
Based on Shipment  programs from the Customer S hipments , Sales 
Invoices , and Over -the-Counter Invoices  forms to open an itemized 
assembly document in which you update the actual quantities assembled.  
We've also added three new columns to the Warehouse Assembly  form that 
display the linked shipping doc /invoice.  
 The new Active Customers  and Active Vendors  reports allow you to view 
those customers and vendors for which invoices (exceeding a specified 
minimum value) have been recorded over a designated period. It includes 
the parallel information for the same period in the previous calendar year.  
 We've added a Parts Not Sold in Period  report to the Part Analysis 
Reports  menu so that you can view all parts that were not sold in a specified 
period based on all sales documents in the system (that is, parts f or which 
an invoice was not recorded in the specified period) .  
 Use the new Return Reasons  form to manage the reasons goods were 
returned from customers or to vendors. You can specify the return reason in 
the new Return Reason Code  column that was added to  the Returned 
Items  sub-level of the customer and vendor returns forms.  
 We've added an Expiration Date  column to the Pallets  form, which allows 
you to assign an expiration date to the entire pallet. This is helpful if you 
move goods that will expire on th e same date.  
 You can now run the Itemize Tracking Doc (Customers)  report for a range 
of shipping document dates (not just a specific date).  
 The Source of Part Catalog Rep. Gen.  now includes the option to display 
an image of the part in some of the report s. 
Inventory  
 We've added two sub -levels to the History of Costing Runs  form: the Run 
Indices  form, a breakdown of the costing run by component and the run time 
for each component, and the Exceptions - Parts  form, which displays the 
parts for which calculat ion ran longer than the defined threshold (longer than 
30 seconds).  
Purchasing and Purchase Planning  
 When running the MRP program for goods whose production process 
includes several operations for different subcontractors, separate lines will 
be opened in the Itemized Purchase Requisitions  form (a sub -level of the 
Purchase Demands  form) for every subcontractor's operation.  
 In the Purchase Requisitions  form, when linking a purchase requisition to a 
purchase order, the line that is added to the order now also takes into 
account the specified quantities by crate.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    8/14 
 We've made improvements to the Prepare RFQs from PRs  program, so that 
when the PAllPartsRFQ  logistics constant is set to 1 and you run the 
program from an itemized purchase requisition, all lines will be copied into 
the RFQ that opens (regardless of whether or not vendors were specified in 
the requisition).  
Warehouse Management System (WMS)  
 We’v e added a new Split by Dist. Route  flag to the Task Splitting Methods  
form. When unflagged, pick tasks for an order with different distribution 
routes will be performed under one warehouse task (and not split up 
according to distribution route).  
Productio n 
 Now the Materials Available for Orders  report includes a new Requirmts 
per Order input column. When flagged, the report goes into details about the 
sales orders that took part in the calculation of the required quantity in the 
report.  
 We've added a new Upd. WO in Ord Items  flag to the Open Work Order for 
Order Item  program (an Action from the Order Items  sub-level of the sales 
order), which gives you the option of automatically updating the work order 
number in the line item of the sales order.  
 In the Work Orders  form:  
o The Order column was renamed Opened for Order to reflect more clearly that the 
column displays the number of the sales order for which the work order was initially 
opened. 
o We added the Reserve for Orders flag, which allows you to lock the link of the work 
order to the sales order lines in the Sales Orders Tied to Work Order sub-level 
form. This ensures that when running the MRP program the work order will not be 
linked again to different sales orders. We also added the flag (read-only) to the  
Work Order for Order Items form (a sub-level of the Order Items form, which is 
itself a sub-level of the Sales Orders form). 
 The new Sets expiration  flag in the Operations in Routing  form (a sub -
level of the Routings  form) gives you the option to ass ign one operation in 
the routing as the one that determines the expiration of the work order. When 
flagged and the operation is completed, the work order will expire.  
 The Parts  form has new sub -level, the Remarks for Work Order  form, in 
which you can enter  text that will be added automatically to the Work Orders 
– Remarks  form (a sub -level of the Work Orders  form) when the work order 
for the part is released.  
 The new Raw Material Traceability  report provides a tool for tracing up lots, 
which is helpful whe n a product recall is required.  
Customer Service  
 We refined the functionality of the CEndWarranty  logistic constant so that it 
determines whether warranty details will be deleted from a serialized part

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    9/14 
after every inventory transaction involving a warehou se that is not included 
in inventory valuations (and not just after returns).  
 For the Maintenance module: When a serialized part in the middle of 
servicing already has an open service call —to ensure that a new service call 
is not opened when running the Prepare Servicing Plan  program —flag the 
new Freeze Service Plan  column in the Exception Definition  form, a sub -
level of the Statuses for Service Calls  form. Freeze the service call by 
changing it to a status for which the flag must be marked.  
 The system now  takes into account scrap defined for a parts issued to a kit 
list in addition to parts issued to the production floor (bulk). The ratio for 
parts issued manually remains as it was before and is dependent on the 
setting of the TakeIsKit  production constant . 
 We added a new Statuses for Customer Surveys form along with a BPM 
Flow Chart program from the form’s list of Actions so you can define and 
track the statuses of customer surveys.  
International  
Europe  
VAT Report Generator  
 The new VAT report generator al lows you to define a VAT report that meets 
the requirements of tax authorities in your country:  
o Use the new VAT Report Boxes form and its sub-level to define VAT report boxes 
and the conditions determining the sums that contribute to the total in the box when 
running the VAT report. We’ve also added the VAT Report Box Definitions form as 
a one-stop worksheet for defining VAT report boxes.  
o The new VAT Calculation Details form, a sub-level of the Entry Journal form, also 
includes VAT report details, in addition to details regarding the calculation of VAT.  
o Run the VAT Report (by Boxes) report to create the VAT report based on the boxes 
you defined and the tax calculation breakdown in the entry journal.  
o Use the new Update Tax Compon. in J. Entries program to update the tax 
calculation of journal entries retroactively if you made changes to any tax 
components, such as the tax code or tax group.  
o We’ve added a VAT Box Code column to the Chart of Accounts form to expense 
accounts to relevant VAT report boxes. This column also appears in the VAT 
Calculation Details sub-level of the Entry Journal form, where you can manually 
define a report box. If you flag a VAT report box as Define by Account, then sums 
(in the tax calculation of journal entries) will contribute to the box linked to the 
account when they meet the conditions defined for the box. 
 
 We’ve added the option to define a dynamic deductible percentage for the 
expense account. Based on this percentag e, the system will split the VAT 
sum in transactions between the VAT account and the expense account. To 
support this development, we renamed the % Deductible -Italy  column (in 
the Expense Types  form and its sub -level) % Deductible to reflect its

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    10/14 
repurposin g for countries throughout Europe to view and record the 
percentage of the expense type that is deductible, as recognized by tax 
authorities.  
 Priority  now supports the calculation of a discount for early payment starting 
from the invoice stage, as per the  financial regulations in some European 
countries: the new financial constant EarlyPaymentDiscount  allows you to 
determine whether to calculate the entire discount when creating the receipt 
on the payment or to calculate the discount on the VAT when creati ng the 
invoice.  
 Priority  now supports working with quarterly VAT reporting periods.  
Belgium  
Note : Developments for Belgium will be released as a special add -on. Below is a 
partial list of programs, forms, and columns that were added to support Priority  
users in Belgium:  
 To create a VAT report for a company in Belgium, use the new VAT report 
generator described above. Run  VAT Report - Belgium (by Boxes)  to 
create a report and also an XML file for submission to tax authorities.  
 The Countries  form now includ es an NIS-Code  column (used in the 281.50 
form) where  you can define this parameter for various countries.  
 The new EC Sales List - Belgium  procedure allows you to easily create the 
EC Sales List report and file for monthly or quarterly submission to the ta x 
authorities.  
 Run the Annual Sales List – Belgium  report to create the annual sales list 
report and file.  
 The Intrastat – Belgium  report allows you to generate the standard or 
extended report and file for monthly submission as required.  
 To accommodate ex tra-long item names in the local language that will 
appear in the balance sheet or P&L report, we’ve added a Long Desc.  
column to the following forms:  
o Bal. Sheet/P&L Items-GL Accounts 
o Bal. Sheet Items - A/P Account 
o Bal. Sheet Items - A/R Account 
o Trial Balance Items 
 For the same reason above, we’ve expanded the possible character count of 
the Item Code  column in the Trial Balance Items  form as well as the 
headers and items in the balance sheet.  
 Form 281.50:  
o Run the Form 281.50 report to create a completed 281.50 form for submission to the 
authorities. 
o To determine the category for which an expense account will be reported in the 
281.50 form, use the new the Form 281.50 Code column in the Chart of Accounts 
form.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    11/14 
o To include a vendor’s financial details over the past year in the 281.50 form, flag the 
Incl. in Form 281.5 column in the Financial Parameters for Vendors form.  
 Support for electronic invoices:  
o The XML File Type for Invoices form lists the file formats in which you can create 
electronic invoices, predefined according to the authorities (PEPPOL, EFFF, UBL). 
You can designate a default format for all invoices in the system. You can also 
designate a default XML File Type for a customer's invoices in the Financ. 
Parameters for Customers form.  
o The tax category code for parts in the tax group is displayed in the Electronic Inv. 
ID column that was added to the List of Tax Groups form. 
 We've added a Payment Terms Cont'd  column to the Payment Terms form 
for an additional de scription of the payments terms in relations to a discount 
for early payment. This string will appear in printouts that display the 
payment terms.  
 Two new programs allow you to generate electronic invoices:  
o Use the Send Electronic Inv. – Belgium program to generate XML and PDF files of 
an invoice and e-mail both as attachments to the customer. 
o Use the Prepare XML for Invoices – Belgium program to generate an XML file of 
invoices (that will not be sent to the customer). 
 To support the regulatory requirement to assign predefined business 
classification codes to customers, in the Business Classification Codes  
form, we've added a long description column and expanded the original 
description column to accommodate longer strings in the local language. 
We've also p reloaded the codes for your convenience.  
 The Load Coda Bank Statements  program allows you to load bank 
statements in XML format into the system.  
 The new VAT Report Creation/Transmit Log  provides a history of VAT 
reports that were created and/or transmitte d to tax authorities.  
 As part of our service to provide basic data for new installations, we have 
created a data template for Belgium. Companies in Belgium will be provided 
a table with predefined data for the forms above, such as business 
classification c odes, category codes for form 281.50, file formats for 
electronic invoices, and so on.  
US 
Integration with Avalara!  
Priority  is a certified partner of Avalara, a leading provider of automated tax 
calculation and tax return solutions. Priority  has now integrated Avalara's tax 
calculation service (AvaTax) so you can reliably calculate sales tax at every stage 
in the sales process. You can download tax groups and exemption reasons from 
Avalara through Priority  and then assign those groups/reasons  to parts and 
customers. When a part is added to a document in the sales process —and you then 
run the Avalara tax calculation program —a calculation based on the most current 
rules across all US taxing jurisdictions is added to the document. When you finali ze

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    12/14 
invoices, the tax is recorded by Avalara, and if you prefer, Avalara can report to tax 
authorities on your behalf.  
The new Integration with Avalara menu (path: Financials  > General Ledger  > 
Financial Statements  > Taxes  > Sales Tax ) houses many of the ne w entities for 
working with Avalara. For example, you can run a program to test the connection 
with Avalara, run error reports if necessary, or run a program to validate an address 
so that sales tax is calculated accurately. For details, see our  standard operating 
procedures  on the subject.  
US - Other Developments  
 The new History of HSBC Payment Files  form allows you to view the 
details of vendor payment files submitted to HSBC. Its sub -level form, HSBC 
Payment Details , provides details on the payments within each file.  
ShipEngine Enhancements  
 Priority  now supports shipments with multiple crates: we've added a Crates 
in Shipment  sub-level to the Customer Shipments  form in which you can 
list the crates in the shipment. These details are transferred to the interface 
where each crate receives a tr acking number. For more information, see our 
standard operating procedures  on the subject.  
Portugal: SAF -T Reporting  
 For full compliance with the latest updates to the SAF -T reporting 
requirements, assign each part a SAFT Part Type (and a Tax Group ) in the 
Financial Parameters for Parts  form. For more information, see our  
standard operating procedures  on the subject.  
 We've added a SAFT Definitions  program so you can configure the SAF -T 
file outputted when running the Create SAFT PT File  program.  
 We've also added an Exempt Reason Code  column to sales, over -the-
counter, multi -shipment, and pro forma invoices (in the Invoice – Add'l 
Details  sub-level ). This allows you to specify the tax exemption that should 
be applied to the invoice.  
 The new SAFT Document Code  column in the Journal Entry Codes  form 
allows you to designate a relevant invoice type for the SAF -T file according 
to the types specified by  the tax authorities.  
 Angola : We now fully support SAF -T reporting in Angola. We added the 
Initial No. for Sig.  column to the Document Numeration Templates  form . 
Here you can specify the first invoice/document number to be finalized 
(digitally signed). On ly later invoices will be digitally signed for SAF -T 
purposes.  
Programming, System Maintenance, and Misc.  
 Due to licensing issues, Priority 's search service will move away from using 
Oracle's Java Standard Edition Runtime Environment (JRE) toward using 
Open JDK.  
 Support for permissions according to parts:  
o You can now limit users’ access to data on specific parts.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    13/14 
 In the Authorization for Parts form (a sub-level of the Company-Specific 
Information form, which is itself a sub-level of the Personnel File), you 
can now define which parts the employee is authorized to view. 
 In the Company-Specific Information (a sub-level of the Personnel 
File), you can flag an employee in the All Parts Auth column so he or she 
can view all parts. 
o In addition, in the Part Catalogue form, we added a Secured Part flag. System 
users will not be able to view secured parts unless they are flagged for Secured 
Parts in the Company-Specific Information form (a sub-level of the Personnel 
File). 
 We upgraded various loading interfaces (for loading data from an external 
source):  
o In the production reporting interface, we added a Load File Definitions-Prod Rpts 
form and Load Prod. Reports by Definition program for defining the structure of 
files to be loaded and for loading files based on those definitions, respectively.  
o In the data migration for open purchase orders, the Check for Errors in Interim Tbl 
report now makes additional checks regarding changes in the part description.  
 We've expanded the length of the part name field in forms t o accommodate 
longer strings of up to 22 characters.  
 Tabula Task Scheduler updates:  
o You can define a maximum number of processes that the Tabula Task Scheduler 
can run simultaneously by changing the value of the new TTSPROCESSES system 
constant. 
o In the Define TTS Tasks form, use the new Max Time (Seconds) column to define 
the maximum number of seconds that a task will remain active. Use the Parallel 
Execution flag to allow multiple instances of the same task to run simultaneously. 
 REST API Updates:  
o The new Personal Access Token form allows you to define authentication tokens 
for users. This is particularly useful if a single API user that is used in multiple 
interfaces, as it removes the dependency of these interfaces on a single username 
and password.  
o We've added support for designating one employee as the API user for all contacts 
who wish to connect to the Web SDK and REST API.  
o Now you can specify whether REST API errors should appear in JSON or XML 
format by changing the setting of the new RESTERRSFORMAT system constant. 
o We've added support for skip$ and batch$ commands. Detailed documentation 
appears in the Developer's Portal.  
 Web SDK Updates : 
o When printing documents, you can use a new object to print according to a Word 
template.

omsoftware.c-www.priority  
Cat.No . LB19000436      Ver.  1 │Oct . 29, '19    14/14 
o When creating a document, you can define it as a document for the customer to 
sign. After a signature is recorded, the signature image file is attached to the relevant 
document. 
 Improvements to adding and replacing users:  
o When running the Add New User program, you can now record the user's e-mail 
address in the program input, and it will be updated automatically in the User 
Permissions form. 
o We've added a new Replace User program that consolidates various processes for 
replacing an existing user with a new one, such as replacing the user in BPM 
workflows, the Groups form, open documents in the system, and copying form and 
menu designs. 
 We've expanded the XML report gen erator to allow programmers to generate 
much more comprehensive files from the system. We ourselves use the 
expanded XML report generator to create all XML files for Belgium. In the 
Form Load Designer  form, after selecting an XML file type, use the  new 
XML Tags for Interface  sub-level to define more complex definitions for 
high -spec XML files.
