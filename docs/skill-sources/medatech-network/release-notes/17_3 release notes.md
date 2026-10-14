# 17_3 release notes

- **Source:** `17_3 release notes.pdf`

www.priority -software.com   
1/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
 
Release Notes Priority  17.3 
User Interface  
All changes in the user interface relate to the Priority web interface only. 
Improvements to Choose and Search Lists 
Improvements to Choose and Search lists aim to make Priority more intuitive and easier to use: 
 The  
  and  
  icons allow you to select a value from the list and access the source form in 
order to view more details or select another value. 
 In program and report input screens in which a Search list opens during the input procedure, 
you can use the 
  option to access the source form. 
 The source form accessed from an input screen opens in Query mode. After retrieving you can 
use the Choose Value tool to copy a single value into the input (F8), or all the retrieved records 
(Esc). 
 In Search lists, the new Create Record button enables you to add a value to the list, and the 
new Advanced Search button allows you to access the source form in Query mode in order to 
find the desired value. 
 In the source form, the Choose Value tool allows you to copy the value in the current record 
back into the form in which you are working (F8). 
 You can use the new scroll bar to scroll through a Choose/Search list (which replaces the 
Previous Page/Next Page tabs).  
More… 
General 
 For Mac users: You can now export data from Priority to Word. 
Note: Due to Word limitations for Macintosh users, you cannot create new templates in Word. 
 In forms, the New Line 
  icon and the Query/Clear Form 
  icon in the row of shortcuts have 
been enlarged for easy access. The latter will appear in green when you are in Query mode. 
 Improved horizontal and vertical scrollbars allow for faster and easier scrolling within forms.  
 Tabs within forms have been redesigned to help differentiate them from sub-level forms.

www.priority -software.com   
2/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
 On the homepage, when hovering over a form tile with your mouse, a magnifying glass 
  and 
plus sign 
  appear. Clicking the former opens the form in Query mode; clicking the latter opens a 
new record. 
 From Office 2007, Word has changed the internal structure of the documents it creates to Open 
XML (.docx). This method allows opening and saving Word files in various tools and adds 
numerous capabilities. To support these capabilities, from Priority 17.3 of the web interface, the 
file structure of Word templates has changed to .dotx. Any .dot file templates must therefore be 
converted before moving to version 17.3. 
Payroll , Time and Attendance  
Payroll Reporting 
 From now on, creating payroll reports has become simpler and faster with the new Batch 
Payroll Reporting form. More… 
 If you are starting to work in Priority in the middle of the calendar year, you can use the new 
Payroll Reporting Migration form to record in Priority pay slips prepared in the previous 
system since the beginning of the year. You can have Priority use the tax calculations of the 
migrated pay slips, as calculated by the previous program, or you can have Priority recalculate 
taxes. More… 
 In all payroll reporting forms, you can now record the number of hours or days in the Quantity 
column and the system will fill in the relevant columns (hours or days) automatically. 
Employee Loans 
 You can now easily manage and track loans given to employees in your company: 
o Use the new Employee Loans form to record and view employee loan details. Loan 
payments are deducted from the employee's salary. 
o Create an amortization schedule of payments deducted from the employee's salary by 
running the Prepare Amortization Schedule program by Direct Activation from the 
form. 
o View amortization schedule details in the Amortization Schedule sub-level form or run 
the Amortization Schedule report by Direct Activation from the upper-level form. 
o You can record early repayment of the entire balance of the loan by running the Redo 
Schedule for Early Repayment program by Direct Activation from the form. 
o Run the Employee Loan Balance report to view the balance owed by each employee as 
of a specific date.

www.priority -software.com   
3/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
o Run the Employee Loan Payments report to view details of loan payments made during 
a specific period by designated employees. 
Sending Password Protected Pay Slips by E-mail 
You can now send password protected pay slips to employees by e-mail via the items in the new 
Pay Slip Passwords menu: 
 The Generate Employee Passwords program allows you to generate passwords for 
employees, which will be used to access the password-protected pay slips. The passwords will 
appear in the Pay Slip Password column of the Payroll Data per Employee form. 
 You can send the generated pay slip passwords to employees by e-mail or text message, via 
the Send Passwords to Employees program. 
 The Delete Employee Passwords program deletes pay slip passwords of specific employees 
when necessary. 
Financial s 
Journal Entries 
 You can now revise the Reference 2 column in the Entry Journal and Entry Revisions forms 
for entries based on any type of purchase invoice. 
 You can now split a journal entry for customer or purchase invoices into separate lines for each 
project linked to the invoice. More… 
Accounts Receivable 
 Use the new Cust Receipt Report Generator to create custom reports for receipts. 
 In multi-shipment invoices (and, for non-US users, in export invoices) printed for billing 
customers in the regular print format, the name of the customer receiving the goods will now 
appear on the invoice in addition to the name of the billing customer. 
 You can now print invoices, in all print formats, with details of work hours (for users who work 
with the Projects module). To access this feature, use the report design tool. 
 Non-US users:  
o You can now prepare one receipt for multiple invoices when running the Prep Receipts 
for Standing Order program. 
o You can now send digitally signed e-invoices when printing a multi-shipment invoice 
together with a receipt. 
o When printing customer invoices, a new print format, W/Extended Part Desc.-Sums, 
displays the invoice sum in both the local currency and the second currency in adjacent 
columns.

www.priority -software.com   
4/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
Accounts Payable 
 Non-US users:  
o You can use the new VATMonthsBack financial constant to determine the number of 
months back (up to 24) for which you are permitted to report VAT expenses in the 
current VAT report period. 
o Italy: The VAT report period can now be set according to the transaction date in the Set 
VAT Report Period program (valid only for companies whose country in the Company 
Data form is Italy). 
o In the Create Additional Checks program (run by Direct Activation from the Check 
Payment (Details) form, sub-level of the Receipts form and the Over-the-Counter 
Invoices form), the number of checks for which you can duplicate details was increased 
to 60. 
General 
 The new Initial Procedure column, in the Financial Documents form, allows you to record the 
name of a custom procedure defined in the Procedure Generator that checks the financial 
document prior to its finalization. 
 The Hide From Choose List flag was added to the Statuses for Shipping Vouchers and 
Statuses-Outgoing Ship Vouchers forms. When this column is flagged, shipping 
vouchers/outgoing shipping vouchers with this status will not appear in Choose lists. 
Warehouse Management System (WMS)  and Other Field Modules   
 The new Inv Storage Age (Mos) column in the Part Catalogue form allows you to determine 
the maximum number of months permitted between the oldest and newest lot/work order items 
stored in a given bin. More… 
 A new Limit to Part's Bins flag was added to the Bins in Storage Zones and Bins in 
Warehouse forms. When a bin is flagged, the system will limit the parts that can be stored in 
that bin to those parts that have the bin listed in the Possible Warehouse Bins for Part form 
(sub-level of the Part Catalogue form). 
 In putaway and replenishment tasks, the new IPutInv constant (in the Logistics Constants 
form) determines whether the system, when recommending high-velocity bins for storage or 
replenishment, will take into account planned inventory that is meant to be picked from the bin 
even if it has not yet been reported as removed from it.  See Setting Up WMS for more 
information.

www.priority -software.com   
5/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
 When running the Create Replenishment Wave (Inv.) program, you can use the new Retrieval 
Type input column to choose between replenishing all parts, selected parts and selected sales 
order items. See Replenish Inventory Tasks for more information. 
 You can use the new Count Frequency-Days column in the Aisles in Storage Zone form (sub-
level of the Storage Zones form) to define the desired frequency for counting parts in specific 
aisles. More… 
 The new Unpacked flag in the Statuses for Order Items form enables you to flag order items 
that have been unpacked for a double check (DCH) task. 
 Detailed help has been added to the Pick Algorithm form (sub-level of the Pick Strategies 
form). 
 Field reps can now open receipts from mobile devices.1 
Sales  
 You can use the new Customer Part Desc column that was added to the Customer Parts form 
to record a description assigned to the part by the customer. This description will appear in 
printouts of the relevant sales documents. 
 In various sales documents (e.g., sales invoices), flagging the new Print Part Attachments 
column will add to the document printout all those documents attached to the parts themselves 
(in the Documents for Part sub-level form of the Part Catalogue form). 
Purchasing  
 The new MRPForecast production constant enables you to have MRP for Manufacturers take 
the customer name in forecast orders into account when deducting forecast order quantities 
from order demands. See Running MRP for Manufacturers and Purchase Planning for more 
information. 
 The new InvExpiry planning constant allows you to define whether to take into account 
expiration dates when running the Material Requirements Planning and the Purchase 
Planning programs. See Running MRP for Manufacturers and Purchase Planning for more 
information. 
 The Block Double Signing flag, added to the Authorizer Lists for PRs form, prevents the 
same person from signing a purchase demand twice. 
 In printouts of purchase orders, the following is now displayed: 
o For each order item, the balance appears as well as the quantity ordered. 
o Each item's barcode appears. 
                                                
1This option will soon be available. Run the Renew License program before using it.

www.priority -software.com   
6/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
o The document number barcode appears in the additional details section of the printout. 
 In the Additional Contacts for Task form (sub-level of the Tasks form), you can now record an 
additional contact associated with the vendor (as you can already do for customers). 
Inventory  
 The Analysis Results form is now also a sub-level of the Packed Items form, enabling you to 
document the results of quality control tests performed on the packed items. 
 You can use the new Inventory Transactions Rept Gen. to design custom inventory 
transaction reports based on the Audit Trail form. 
 You can now revise the Customer Name in the Catalogue of Serialized Parts form in the case 
of a walk-in customer. 
 You can now sort the Choose list in the Work Order/Lot column of various inventory documents 
according to expiration date. The sort method is determined by the new ILotWOSort logistics 
constant. 
 A new Parts With No Inventory report displays all parts with 0 inventory balances in designated 
warehouses. 
 To prevent transactions that would result in negative inventory balances for parts in specific 
warehouses, flag the new Block Neg. Balance column in the Warehouses form. 
Production  
 The History of Changes form (sub-level form of the Parts form) now displays changes in the 
Kit Component and Manual Issue columns in the upper-level form. 
 When the Backflush program is run, you can now clean inventory for closed work orders 
(similar to the adjustments that are made when past balances are calculated), in keeping with 
the value of the new CleanWOBal constant  in the Production Constants form. 
Miscellaneous  
 The new E-mail Reply Address column in the Personnel File form allows you to define an e-
mail address for automatic replies that differs from the employee's regular e-mail address. 
 You can now run the Open Appointment Calendar program by Direct Activation from the 
Tasks form. See Working with the Appointment Calendar for more information. 
 New log reports can be run by Direct Activation from the Planning Constants, Logistics 
Constants and Productions Constants forms. Each report displays the changes made to the 
constant form during the specified period. 
 You can now send text messages as XML messages via a supplier's web service. More…

www.priority -software.com   
7/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
 The Not in Use flag was added to the Service Terms form. Anything that is flagged in the new 
column will not appear in Choose lists. 
 The Customer Data Migration interface now supports migration of the branch linked to the 
customer. 
System  Maintenance  
 When running the Send Program Activation Link program, you now have the option of 
sending users the service root URL required for programming with Priority's API.  
 A new sub-level form, History of Changes, added to the System Constants form, allows you 
to view changes made to system constants. 
 Outlook users can now use the Compose Mail form (in the Priority web interface). More… 
 Improvements to the View License Details report: You can now view a list of all the modules 
included in your license as well as the number of API and interface transactions used against 
your licensed quota. 
Programming  
 The new EXL2TXT program converts Excel files to tab-delimited .txt files.  
 The new XMLPARSE program reads and parses XML files. 
 You can now keep track of changes in triggers, procedure steps and loads via the new 
Previous Versions sub-level form and its Direct Activation, Track Changes. 
For more information, see SDK for Priority v17.3.

www.priority -software.com   
8/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
More Information  
User Interface 
 After selecting a value from a Choose list, the 
 search icon changes to  
  . You can press 
the left icon (More Information) to access the source form and view details regarding the 
selected value. The breadcrumbs at the top of the form display the hierarchy of the forms you  
viewed prior to the current form, helping you to keep track of your location and serving as links 
back to previous forms. 
 In the source form you can search for or retrieve a value and insert it into the form you were in 
by clicking Choose and Return (F8).  To leave the source form and return to the form you were 
in previously without copying any value, select Back (Esc). 
For more information on new features in the user interface, see the Data Entry and Parameter 
Input chapters in the User Interface Guide for version 17.3. Back… 
Payroll, Time and Attendance 
 Batch Payroll Reporting: For each employee you record one line per month, detailing the 
payroll data relevant for that pay slip (e.g., the number of work days and absence hours). After 
recording data, prepare pay slips in the usual way. Back… 
 Payroll Reporting Migration: If you choose to recalculate taxes, once pay slips have been 
prepared, you can run the Check Tax in Salary report to compare and reveal discrepancies 
between the tax data calculated in the two systems. Taxes calculated in Priority are displayed in 
the Compare to column. If discrepancies are found in the report, you can correct the pay slips 
as long as they have not yet been finalized. Back… 
Financials 
 Splitting Entries by Project: To split journal entries of invoices into separate lines according to 
projects, flag the Distrib btw Projects column for the A/R or A/P account in the Entry Patterns 
sub-level of the Entry Codes form. Back… 
Warehouse Management System (WMS) and Other Field Modules  
 Inventory Storage Age: The value in this column is taken into account in PUT tasks when 
recommending bins for storage. It is also taken into account when running the Possible Bins 
for Part Storage report. If you input a date in the new Inventory Storage Date Code column, 
the report will recommend storage of a given lot/work order in bins with inventory whose date 
code falls within the permitted date range. See Setting Up WMS for more information. Back…

www.priority -software.com   
9/9 Apr. 20,'17 Ver. 05 Cat.No. LB160686 
 
 Count Frequency-Days: The value in this column will be taken into account when inventory 
count tasks are opened by the Create Inventory Count Wave program when the By Count 
Freq-Aisle option is selected. See Inventory Count (CNT) Tasks for more information. Back… 
Miscellaneous 
 Text Messages via Web Service: To send text messages as XML messages via a supplier's 
web service, flag the Send via Web Service column in the Text Messaging Definitions form, 
and fill in your username and password in the adjacent columns. Back… 
System Maintenance  
 Compose Mail for Outlook Users: If you use Outlook and you want to use the Compose Mail 
form (in the Priority web interface), flag the new Use Compose Mail column in the Mail 
Options dialogue box (menu path: Options > Mail > Mail Options > Outlook > Mail Options). 
Back…
