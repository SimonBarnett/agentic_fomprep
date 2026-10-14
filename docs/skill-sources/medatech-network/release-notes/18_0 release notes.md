# 18_0 release notes

- **Source:** `18_0 release notes.pdf`

www.priority -soft ware.com   
1/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
 
Release Notes Priority  18.0 
Highlights  
Application Generator 
 We are proud to present the new application generator used for accessing Priority via mobile 
devices.  
 
More… 
Payroll , Time and Attendance  
Reporting Project Hours 
 You can view and revise project hour report data before it is loaded into the database in the new 
Interim Table-Project Hour Reps form.  
 Employees can now use the Confirm Own Project Hour Reports program to confirm all the 
project hours they reported.  
 The new Job Site column was added to the Reports of Project Hrs/Expenses form and to 
additional project reporting forms, allowing you to specify the place where the labor actually took 
place (e.g., on-site, off-site). You can list all relevant job sites in the new Job Sites form.  
 The new Billable Project Hrs column, added to the Project Hr. Reports-Work Area, displays 
the total number of project hours reported for an employee on a given date.

www.priority -soft ware.com   
2/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
Taxes 
 The new Income Tax Benefits form allows you to view tax benefits awarded employees in 
specific pay slips. 
Attendance App 
 The new app for attendance reporting can be used on tablets and mobile devices (currently 
available for android and soon to be available for IOS). New additions to the system enable easy 
interfacing with the system. The new GPSWorkHours system constant (in the Payroll 
Definitions form) determines whether it is mandatory for employees recording attendance via 
an application on a mobile device to enable GPS satellite tracking. 
Attendance Reporting 
 You can flag the new Add'l Logins column in the Daily Reported Hours form to indicate that 
more than two logins/logouts were recorded for an employee in a specific report.  
 In the same form, the Absence to Date column displays the end date of the employee's leave of 
absence. You can also display an employee's work hour or absence reports on the online 
Attendance portal by flagging the Display on Portal column. 
 The new Define API Key for Google Maps program allows you to install or delete a Google 
Maps API key. When working with the Attendance portal, this is used to track and save the 
user's street address at the time of his/her login and logout.  
Payroll Definitions 
 An employee's average monthly work hours is now displayed in the Avg Wk Hrs in Month 
column of the Monthly Salaries form. The new AverageHoursCalc payroll definition (in the 
Payroll Definitions form) determines how the average is calculated.  
 The new PartialVacationDays payroll definition determines whether the annual quota of 
vacation days to which an employee is entitled will be rounded down to whole numbers or 
whether partial days will be allowed.  
 The new DaysToMakeChanges payroll definition allows you to set the number of days within 
which you can make revisions to previous pay slips once they are finalized.  
General 
 Support was added for new payroll accounts in the Payroll Accounts (cont.) form, including 
accounts for employer disability expenses, employer severance pay expenses and more.  
 You can now record a voluntary deduction payroll component against a voluntary deduction 
account in the VoluntaryDeduct Acct column of the Payroll Data per Employee form.

www.priority -soft ware.com   
3/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
 New additions to the Earnings and Deductions report allow you to run the report by 
department, and to compare the report to the previous month. 
 Flag the new Record Holidays input column when running the Update Payroll/Financ. 
Constants program to record the current year's holidays in the Holidays (Office Closed) form. 
Financial s 
Update Weights of Indirect Costs 
 Priority's new tool in the Update Weights of Indirect Costs menu allows you to automatically 
calculate weights for profit centers, which will be used to allocate indirect costs among them. 
More… 
Bank Reconciliations 
 When running the Finalize Reconciliation program (by Direct Activation from the 
Reconciliation Worksheet), if all lines in the reconciliation are statement items without 
corresponding journal entry items, you can now choose whether to record a separate adjustment 
entry per line or one for all lines. 
 You can cancel a bank reconciliation via the new Cancel Reconciliation program run by Direct 
Activation from the Bank Statement Items form or the Itemized Statement form (sub-level of 
the Record Bank Statements form). For more information, see Bank Reconciliations. 
Accounts Receivable and Accounts Payable 
 You can now easily prepare receipts from within the Multi-Shipment Invoices, Sales Invoices, 
Invoice Revisions and (for non-US users) Export Invoices forms via the Record a Receipt 
program, run by Direct Activation. The program prepares receipts for payments made by check, 
cash or bank transfer. For more information, see Multi-Shipment Invoices, Sales Invoices and 
Recording an Export Invoice. 
 The Tax Exempt Income column was added to the Accounts for Customer Groups form, 
allowing you to define a GL account for income from tax-exempt sales to customers in specific 
groups. The column was also added to the Acc'ts for Cust Group in Family form (sub-level of 
the Accounts for Families form).  
 You can now run the Prep Receipts for Standing Order program for sales invoices (in addition 
to pro forma and multi-shipment invoices).  
 Use the new OneInvPerActDate financial constant to prepare separate multi-shipment invoices 
for shipping documents whose dates fall in different fiscal periods.  
 Use the new ActPayTerms financial constant to calculate payment terms (and the payment 
date) in multi-shipment invoices starting from the activity date (as opposed to the invoice date).

www.priority -soft ware.com   
4/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
 You now have the option to Prepare and Finalize payments in one step in the Prepare 
Payments program.  
General 
 You can now track changes made to specific financial constants when running the Changes to 
Financial Constants report. 
 In the Balance Sheet, Trial Balance and Consolidated Balance Sheet reports, you can now 
choose between a regular balance sheet, a schedule and a schedule that includes A/R and A/P 
details.  
 The new BlockProvEntries financial constant allows you to prevent the posting of provisional 
entries to the ledger.  
 The new Part to Charge column in the Payments for Project and Payments for Project 
Order forms allows you to record a specific part for a project payment that will appear on 
invoices (instead of the general "Project Payment" part number). For more information, see 
Billing to a Project. 
 The new Acct Ledgers by Fin Statemt Item report allows you to view account ledgers sorted 
by trial balance item or balance sheet/P&L item.  
 The new Budg in Effect Only flag added to the Budget Explorer allows you to limit results to 
the budget items included in the budget version in effect.  
US Users: Support for NACHA 
 You can now upload bank transfer payments via NACHA by using the items in the NACHA 
Interface-Payables menu. 
 You can now bill customers for standing order payments via NACHA by using the items in the 
NACHA Interface-Receivables menu.  
More… 
Warehouse Management System (WMS)  and Other Field Modules   
 You can now split pick tasks into several steps: 
o The Intermed. Pick Bin column was added to the Storage Zones, Aisles in Storage 
Zone and Authorized Zones forms, allowing you to record a default intermediate bin to 
which to pick parts temporarily until the last pick task. 
o When flagged, the Last Task column, added to the Warehouse Tasks form, indicates 
that this pick task is the last in a set of multiple pick tasks (or the only task in a regular 
pick task).

www.priority -soft ware.com   
5/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
o To open a set of multiple pick tasks, run the Execute Next Pick Task program by Direct 
Activation from the Warehouse Tasks form to define the current task as one step in a 
set of pick tasks. Once the task is completed and you have run the Prepare Documents 
program for it, another task will be opened for the next pick step.  
For more details, see Working With Sets of Multiple Pick Tasks.  
 The new Master Pallets form and its sub-level, Pallets on Master Pallets, allow you to define 
master pallets and to view details of pallets stored on each master pallet. 
 In pick tasks, when picking by items, you can now display each order item on a separate line 
even when the part numbers are identical. To do so, select the Sep. Part per Ord Ln option in 
the input column of the Create Pick Wave (by Part) program.  
For more information, see Picking by Part (PIK) Tasks. 
 New field licenses in the User Permissions form: 
o The Field Deliv Tracking license enables users to work with the Field Delivery 
Tracking module. 
o The API Field License enables users to interface with Priority via a REST API through 
an external program. 
Sales , Purchasing and Inventory  
 Report Generators: 
o New columns in the Sales Orders Report Generator include start and end times, 
address details and territory code. 
o New columns in the Transaction Report Generator include the branch code and name. 
o New columns in the Customer Invoice Rept Generator and the Purch Invoice Report 
Generator include the budget item, transaction date and payment terms. 
 When printing a shipping document or packing slip, the warehouse and bin from which the items 
were taken are now displayed.  
 For your convenience, you can open a sales invoice or shipping document straight from the 
Sales Orders form via the new Prepare Shipping Doc/Sales Inv program.  
 You can now manage versions of sales orders: To save the current version of the sales order 
and to open a new version, run the Save Version program by Direct Activation from the Sales 
Orders form. Use the Sales Order Versions form (sub-level of Sales Orders) to view previous 
versions of the sales order.  
 The new RoundPOrd financial constant enables you to round prices in purchase documents.  
 The new Unbilled Docs by Branch report allows you to view customer shipments and service 
calls that have not been billed, sorted by branch.

www.priority -soft ware.com   
6/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
 By recording a value in the new Required No. Crates column in the Assembly Reporting form 
(sub-level of Warehouse Assembly), the quantity of required parts will be calculated by 
multiplying the number of required crates by the crate's capacity (provided that the Required 
Qty column is blank and the crate type is recorded in the adjacent column). 
 The new Inactive column was added to the Sources of Leads/Sales Opps form. Sources 
flagged in this column will not appear in Choose lists and a warning message will appear if they 
are assigned to any lead or sales opportunity.  
Customer Service  
Service Contracts 
 You can now open service contracts straight from the Customer Shipments and Sales 
Invoices forms via the Open Service Contract program run by Direct Activation.  
 Priority now lets you open fixed assets for serialized parts in the Service Contracts form: 
o The new Open Assets for Service Contract program can be run by Direct Activation to 
open assets. The assets can then be viewed in the new Assets Opened for Contract 
sub-level form. 
o To manually set the cost of the asset that will be opened for the serialized part when the 
above program is run, use the new Asset Cost-Manual column in the Items in Contract 
sub-level form. 
Service Calls 
 A new Parts Used in Service Calls form conveniently displays parts and quantities used for 
repairs or servicing during service calls. For instance, you can retrieve parts used in service calls 
for a given customer or parts handled by a given technician. 
 The Cutoff Response Hour column, added to the Catalogue of Parts w/Serial Nos., Service 
Parameters for Part, Billing Details-Service Contract and Items in Contract forms, allows 
you to define response times in service calls according to the time the call was placed.  
 The Mandatory End Date column, added to the Service Calls and Active Service Calls forms, 
displays the date by which the service call must be completed. If this date has passed, the new 
End Date Passed column will be flagged automatically. 
 When printing service calls, you can now select the W/Extended Part Desc format. 
For more information, see Service Calls and Setting Up Customer Service. 
General 
 The Serial'd Part/Contract Data Migr interface supports migration of serialized part and service 
contract data from an external system to Priority. More…

www.priority -soft ware.com   
7/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
 You can now track the history of customers that leased/bought a given serialized part via the 
Customer Number and Customer Name columns added to the Audit Trail for Serial 
Numbers form. In the case of purchased parts, vendor information is displayed in the Vendor 
Number and Vendor Name columns added to the form. 
Programming and System Maintenance  
 The new programming tool, Web SDK, allows you to develop new Priority interfaces with 
JavaScript. 
 A new sub-level form, History of Changes, added to the Define TTS Tasks form, allows you to 
view changes made to tasks in the Tabula Task Scheduler. 
 A new form, Authorizatn for Employees by Co., allows you to select companies in which the 
user is authorized to view employee data. The user will only have access to records of 
employees when viewing data for these companies. To authorize a user to view employee data 
for all companies in the system, flag the Employees in All Companies column in the 
Company-Specific Information form (sub-level of the Personnel File).  
 When the PRIVUSERS system constant is set to 1, the tabula (system manager) group will now 
have write privileges for the following columns in the User Permissions form: Manage User 
Group, Manage All Users, Manage Companies, Manage Privileges and Run Upgrades (up 
to now, only the tabula user could revise these columns).  
Miscellaneous  
 US users will now record and view hours in the AM/PM format.  
 Users of the Compose Mail form can now attach up to 500 files in the Attachments sub-level 
form. 
 The new FixFrozen planning constant determines how to handle work orders frozen for 
planning (i.e., work orders flagged in the Freeze Planning column of the Work Orders form), 
when preparing a work plan via MRP for Manufacturers. More… 
 Priority now supports sending text messages via a web service provided by an internal supplier. 
To this end, the following columns were added to the Text Messaging Definitions form: 
Windows User Name, Windows Password, Domain and SOAP Action. 
 UK users can now record the name of the state and county in the States/Counties sub-level of 
the Countries form. The state and county will then appear on printouts. 
 The new Country Settings form (sub-level of the Countries form) allows you to turn customer 
and vendor bank codes into non-mandatory columns in all financial documents that include bank

www.priority -soft ware.com   
8/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
details, if your company is located in a country where bank codes are not recorded in the 
system. 
 Priority's International (Dual-currency) installation has been combined with the American 
installation into one English language installation. Therefore, you no longer have to input the 
Initialization Type when running the Add Company program. Record the country in which your 
company is located instead.

www.priority -soft ware.com   
9/1
1 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
More Information  
Application Generator 
 Use the Application Generator form to define the app's name and language, and use the sub-
level forms to define the forms and form columns that can be accessed via the app. 
 To send the QR code required to use the app to users, run the Send Link to App program by 
Direct Activation from the Application Generator form. Users then scan the code into their 
mobile device. 
 To update the definitions of an existing app, run the Refresh Application program by Direct 
Activation from the form and the update will be sent automatically to all app users. 
 The apps created via the generator use an API. To use them, you must install an application 
server. 
 Users must be defined as having an API license or an API field license (in the User 
Permissions form) in order to access Priority via the app. 
 Updating records via an app uses up your quota of API transactions. You can run the View 
License Details report to view the number of API and interface transactions already used 
against your licensed quota.  
For more information, see The Priority Application Generator.  
Back… 
Weights 
The feature includes: 
 A Definition of Load Parameters form in which to define parameters for loading data from 
external files, which contain specific types of costs (e.g., employees' phone bill data). 
 A Load File to Interim Table program for loading indirect costs from an external file into the 
Weight Calculation Interim Tbl form. 
 A Check Validity of Data in Table report to check the data loaded into the form. 
 The Clear Weight Calc Interim Table program to delete data from the interim table. 
 The Update Weights by Sums program, used to calculate weights for profit centers, based on 
sums recorded in the .interim table. 
 You can also run the Update Weights by Proj Reports program to calculate weights of indirect 
costs based on the ratio of reported project hours In this case, first fill in the Employee Costs 
form. 
For more information, see Automatically Distributing Weights of Indirect Costs. 
 Back…

www.priority -soft ware.com   
10/
11 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
Serialized Parts and Contract Data Migration 
Using the Serial'd Part/Contract Data Migr interface: 
 You can define the way records are structured in the original data file in the Load File 
Definitions form. 
 Use the Load Ser. Parts/Contracts to Tbl program to load service contract and serialized part 
data from an external data file into an interim table in the Serialized Part/Contract Int Tbl form. 
 You can run the Check Data in Interim Table report to identify errors in data loaded into the 
interim table. 
 Use the Load Serialized Parts to DB and Load Contracts to Database programs to load the 
data for serialized parts and service contracts from the interim table into the appropriate system 
forms. If errors are encountered during the loading process, the Load Errors report is produced 
automatically. 
 You can run the Clear Interim Table program to delete all data from the interim table. Back… 
NACHA 
Accounts Payable 
 Use the Flag Bank Transfers for NACHA form to flag those transfers that you wish to upload 
via NACHA.  
 In the Bank Transfers to be Uploaded report, you can view all bank transfers that will be 
included in the payment transfer file when the Run NACHA Interface-Payables program is run. 
The report will include all bank transfers flagged in the above form whose document and/or 
payment date falls within the specified report period.  
 Use the Run NACHA Interface-Payables program to create the payment transfer file which can 
then be uploaded to NACHA. To view any bank transfers that could not be uploaded to the 
payment file, as well as the reason for the load failure, run the NACHA Payables – Errors 
report.  
 You can use the NACHA Transfers-Log of Changes form to view revisions made to records in 
the Flag Bank Transfers for NACHA form. 
 In the History of NACHA Payables report, you can track runs of the Run NACHA Interface-
Payables program in a designated period. 
Accounts Receivable 
 Run the Transfers for Upload-Receivables report to view any receipts that have been 
prepared to collect standing order payments via an electronic interface, which have not yet been 
loaded to a file during the designated period.

www.priority -soft ware.com   
11/
11 
May 03,'17 Ver. 02 Cat.No. LB17000430 
 
 You can use the Run NACHA Interface-Receivables program to create a file of receipts for 
collection of standing order payments via NACHA . If any errors are encountered, you are 
referred to the NACHA Receivables – Errors report. 
 In the Revise NACHA Details-Receivables form you can revise lines in receipts that failed to 
load when submitted via NACHA. 
 Run the History of NACHA Receivables report to view details of any runs of the Run NACHA 
Interface-Receivables program in a designated period. 
For more information, see Preparing NACHA Credit and Debit Payments.  
Back… 
Miscellaneous 
 If work order production has started, the FixFrozen planning constant allows you to shorten the 
duration of frozen work orders by changing the production start date in the work plan so that it 
reflects the time required to complete production of the work order. For more information, see 
Running MRP for Manufacturers and Purchase Planning.  
Back…
