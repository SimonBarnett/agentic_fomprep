# 17_2 release notes

- **Source:** `17_2 release notes.pdf`

www.priority -software.com   
1/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
 
Release Notes Priority 17.2 
Highlights 
 In the web interface, data export now supports tools such as Open Office and Office Online 
in addition to MS-Excel. The SPREADSHEET system constant allows you to choose 
whether to export data as an open format file supported by other spreadsheet applications, 
or to continue using MS-EXCEL (the constant does not apply to HTML and BI reports, in 
which data can only be sent to Excel).  
 Data export to spreadsheet applications now includes support for Macintosh and tablets 
(when exported in open format). 
 Priority now supports the use of REST APIs (API is a software architecture style used to 
develop applications and programs that interface with Priority) to edit data in Priority. To 
work with REST, you must purchase a license. 
 Version 17.2 supports MS-Office 2016. 
User Interface 
BPM, Business Rules Generator and Data Generator 
In the web interface/Tablets 
 New capabilities added to BPM flow charts, the Business Rules Generator and the Data 
Generator enable you to manage rules quickly and conveniently. 
o The list of rules is displayed in chart form and includes the Rule Number and Rule 
Description, making it easier to find the rules you're looking for.  
o The new More button includes the following options: Report – displays the rules in 
the current form, including the Rule Number and Rule Description; and Search – 
allows you to do a text search within the list of rules (e.g., search by the rule 
description). 
o You can add the Rule Number and Rule Description to the message that is sent. 
This helps the recipient identify a rule-generated message, as opposed to a system-
generated message. This is also useful for locating the rule that caused the message 
to appear. 
o You can change the order of the rules in the list (e.g., put the most important ones at 
the top for easy access).

www.priority -software.com   
2/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
o After defining a rule and closing the dialogue box, the screen will go back to the list of 
rules, allowing you to continue working. 
o You can flag rules as Active, or make them inactive, directly in the list of rules. 
o While defining a rule, you can now view the name of the form for which it is being 
defined. 
 When sending an e-mail message together with a document, you can send the document's 
attachments as well. 
 You can define a rule that either requires all conditions to occur (AND) or requires any one of 
the recorded conditions to occur (OR). Additionally, you are no longer limited to three 
conditions. 
 In the BPM, the system prevents users from deleting or editing a rule that they did not 
create.  
In the Windows interface (the changes do not apply to the Data Generator): 
 You can add a Rule Description which will be displayed when defining the rule and in the 
report. 
 You can add the Rule Number and Rule Description to the message that is sent. This 
helps the recipient identify a rule-generated message, as opposed to a system-generated 
message. This is also useful for locating the rule that caused the message to appear. 
  When sending an e-mail message together with a document, you can send the document's 
attachments as well. 
Note: More information can be found in the User Interface Guide in the Generators and BPM 
Flow Charts sections. 
 
More UI 
 In forms, there is now a Share shortcut on the row of icons (instead of Send Record Link) 
which includes not only the Send Record Link option, but also allows you to call via Skype 
or Dial. 
Payroll, Time and Attendance 
Reporting project hours 
 A new mechanism supports project hour authorization by project managers. The mechanism 
includes: 
o The Authorize Hours column in the Projects form, which you flag if you want 
reported hours for a given project to require authorization. 
o The Project Hour Authorization form,  where you can view authorizations of hours 
reported by employees for each project. You can also run the Authorize Project

www.priority -software.com   
3/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
Hours program by Direct Activation to authorize all hours reported for a project in a 
given month.  
 The following Direct Activations were added to the Daily Work Hours-Work Area to simplify 
the self-reporting process: Set Login Time, Set Logout Time and the Project Hr Reports 
for Salary Month report. 
 You can now report project hours automatically, based on login and logout reports, by 
running the Report Project Hours in a Batch program. To support this option, the Reports 
Project Hrs flag was added to the Payroll Data per Employee form (in the Attendance 
tab). Flagging this column indicates that the current employee must report project hours in 
addition to logging in. 
 In the new Update Work Hours/Absences sub-level of the Daily Work Hours-Work Area 
form, you can update work hours and/or absence reports as well as approve or reject the 
reports. 
 When in the Daily Work Hours-Work Area form, you can run the Reported Attendance in 
Month report by Direct Activation to view a detailed report of an employee's work hours in a 
specific month. 
Attendance 
 In the new Set Work Hours and Sick Days sub-level of the Work Hr/Absence Update-
Work Area form, you can manually set overtime hours on a specific day or calculate sick 
days for a specific employee, in a given pay slip. 
 A new Upload Reported Absences program allows you to upload all employees' absence 
reports for a specific salary month at once, regardless of the way they are paid (i.e., at the 
beginning or middle of the month). 
 The new Report Wk Hrs-Portal and Rep't Absence-Portal flags, added to the Payroll 
Data per Employee form, allow an employee (for whom the columns are flagged) to update 
work hours and/or absences in the Attendance portal. If the columns are left blank, the 
employee will be able to view absence reports in the portal but not update them. 
 You can limit an employee to reporting attendance only for himself/herself by flagging the 
new Self-report column in the Payroll Data per Employee form. 
 
Additional improvements 
 You can use the new Monthly Salary Work Area and its Direct Activations as a convenient 
and quick way to open pay slips. Meant for customers who work only with the payroll system 
(and not the time and attendance system), the work area is used to create payroll reports 
and prepare pay slips.

www.priority -software.com   
4/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
 The new Payroll Accounts form allows you to define a GL account for each payroll account, 
in a batch. The Account Initialization program updates this form automatically and defines 
a GL account for each payroll account. 
 You can prepare salaries and reports by branches and subsidiaries. You can also link an 
employee to a branch/subsidiary in all relevant payroll entities. 
 The new EndOfEmployment payroll definition allows you to automatically include owed 
vacation and convalescence days to calculations of the last salary of an employee leaving 
the company.  
Financials 
 Support of costing for fashion by styles: In the Set Costing Parameters program you can 
choose the Costing by Styles option, so that a single cost will be calculated for the style, 
which will apply to all items linked to that style. 
 You can now open, close, cancel or reopen several fiscal periods at once (instead of one by 
one) by running the following programs, respectively: Open Fiscal Period, Close Fiscal 
Period, Cancel Open Period and Reopen Fiscal Period. 
 You can use the new ManAmortizationSched financial constant to allow manual 
preparation and revision of amortization schedules in leasing transactions. 
 The new Int Rate by CalcDate column in the Leasing and Company Loans and Bank 
Loans forms allows you to determine on which day to begin calculation of interest with 
regard to variable interest loans. 
 Use the new Deleted GL Accounts form to view all the GL accounts deleted from the 
system. 
 You can use the new AssetBuyDate financial constant to open a fixed asset from within a 
purchase invoice with a purchase date taken from the transaction date of the journal entry 
opened for the invoice. 
 Non-US users: You can now choose between pro forma or multi-shipment invoices in the 
Prep Receipts for Standing Order program (when working with cash-based accounting 
only). 
Warehouse Management System (WMS) and Other Field Modules  
 You can now automatically create replenishment waves that are run by the Tabula Task 
Scheduler. 
o In the new Create Automatic Waves menu, dedicated forms were added for 
defining the settings and parameters available for creating automatic waves.

www.priority -software.com   
5/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
o The Create Automatic Waves program was added. 
 New columns allow you to differentiate between splitting methods of pick warehouse tasks 
and replenishment tasks: Split byPallet-Repln and Split by Aisle-Repln were added to the 
Task Splitting Methods form, and the previous columns in the form are now for picking. 
 When splitting replenishment tasks by aisle (when the splitting method if flagged for Split by 
Aisle-Repln), you can group together specific aisles that are to be included in the same 
replenishment task by flagging the Replenishment Group column that was added to the 
Aisles in Storage Zone form. 
 In the Create Pack Wave program, the Pick for Multiple Customers option was added to 
the Task Split Method parameter. This option allows orders from different customers to be 
included in one PAK task. 
 You can open an RCV task from within Priority that transfers goods from the unloading deck 
to a storage warehouse by running the new Create RCV Task by Direct Activation from the 
Goods Receiving Vouchers form. 
 A new On Hold status for warehouse tasks allows you to indicate that a specific task is 
currently on hold. 
 In the Bins in Storage Zone, Bins in Warehouse and Bin Types forms, the new Limit 
Pallet Weight column allows you to limit the maximum weight of pallets stored in a specific 
bin or bin type (respectively). 
 In the Company-Specific Information sub-level of the Personnel form, you can assign a 
default transport vehicle to an employee in the new Default Transport Type column. 
 A new license allows you to define a warehouse employee as working only from a mobile 
device and not from Priority. This kind of user is flagged in the User Permissions form in 
the new Mobile Storekeeper column. 
 Improvements to DCH tasks: 
o Use the Unpack Crates by Mobile Device program to unpack goods from several 
packing slips in one DCH task. 
o Support has been extended for parallel picking in PIK tasks that are followed by DCH 
tasks. For example, you can create several DCH tasks after picking, and each task 
can have several packing slips. Or you can print DCH tasks to help the employee 
doing the packing to check the items that were picked. 
o The Pick Tasks form (sub-level of Order Items) now includes DCH (doublecheck) 
tasks and its name has been changed to Pick and Doublecheck Tasks. 
 You can now open an Over-the-Counter Invoice from a mobile device.

www.priority -software.com   
6/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
 The Delivery Tracking module now supports Vendor Returns and Warehouse Transfers. 
New columns providing detailed information were added to these forms, such as Auto 
Gross Weight, Volume and Manual Gross Weight. 
 Non-US users: When preparing WMS documents in a non-English environment, via a mobile 
device, you can now define printouts in English for specific vendors/customers.  
Sales, Purchasing and Inventory 
 It is now easier to identify the source of purchase demands thanks to four sub-levels that 
were added to the Itemized Purchase Requisitions form (sub-level of Purchase 
Demands): Projected Balances (fact. units), Projected Balances (buy/sell), MRP 
Analysis - Raw Materials, and MRP Analysis - Processed Parts.  
 The MRP Analysis - Raw Materials and MRP Analysis - Processed Parts sub-levels were 
also added to the Purchase Requisitions form.  
 The MRP program now takes into account demand for bulk items at the operation in which 
they are used rather than at the first production operation. 
 You can now link a blanket order to a sales order item via the new columns, Blanket Order 
and Line – Blanket Order, in the Order Items sub-level form. 
 In the Additional Status Definitions form (sub-level of the Statuses for Orders form), a 
new Status Once Printed column allows you to determine the status to assign an order in 
the current status once it is printed. 
 For users of the Fashion module: The new SDelZeroFash logistic constant enables 
automatic deletion of lines in sales/purchase orders based on styles, when lines have been 
deleted in the Assortment sub-level form. 
 The Inactive flag was added to the Sources of Leads/Sales Opps form. The Not in Use 
flag was added to the Sales Opportunity Types and Add'l Sales Opportunity Types 
forms. Anything that is flagged in the new column will not appear in Choose lists. 
 The Ignore Vend. Address flag, added to the Remit to Address (Checks) form, affects the 
address appearing in the Check Payment - Add'l Details form. 
 For users of the Delivery Scheduling module: The new Distrib. Route Code column in the 
Sales Orders form allows you to assign a distribution route to an order.

www.priority -software.com   
7/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
Non-US users: 
 When working in a non-English environment, it is now possible to print a Customer Returns 
document in English. 
 When working in a non-English environment, you can now define part specifications in 
English as well. 
Miscellaneous 
 New improvements to the Evaluation Formats and Evaluation Recording forms include 
the option of defining one questionnaire format that is used by both an employee and his/her 
manager where the manager's questions will be hidden from the employee. 
 You can now assign statuses to each stage of the evaluation process. Use the new BPM 
Flow Chart – Evaluations program to define statuses and their properties. 
 Customer Service module: Not in Use was added to the following forms: Types of Billing 
Exemptions, Warranty Codes, Types of Service Calls, Malfunction Codes, Problem 
Codes, Resolution Codes and Servicing Packages. Anything defined as Not in Use will 
not appear in Choose lists. 
System Maintenance and SDK 
 You can build search definitions automatically in the Document Types in Search and File 
Types in Search forms by running the Initialize Search Definitions program and flagging 
the new Default Documents column. These will override any existing definitions. 
 Mail settings in Priority are now compatible with Google's new security requirements. 
 You can compare the privileges assigned to two user groups via the new Compare Menu 
Privs Btw Groups report. 
 You can now identify those users who logged in to the system as "tabula", via the new 
Windows Username column in the History of User Logins form. 
 The new Server Name column, in the More Parameters sub-level of the Define TTS Tasks 
form, allows you to run a task from a specific workstation on which the Tabula Task 
Scheduler is installed. 
 You can assign a time zone to a company in the Time Zone Name column of the 
Companies form, to enable the Tabula Task Scheduler to take the time zone into account 
when running in that company. 
 The new TZSERVER system constant allows you to determine whether when the system 
automatically records a date, hour or day of the week, the system will take the time zone 
from the user's workstation or from the server (when their time zones differ).

www.priority -software.com   
8/8 Apr. 20,'17 Ver. 05 Cat.No. LB160238 
 
 The new SQL Development Queries Log form allows you to view all the commands run by 
the SQL Development program. This provides documentation, for control purposes, of all 
transactions made via WINDBI. 
 Priority now supports writing REST APIs (API is a software architecture style used to 
develop applications and programs that interface with Priority). To work with REST, you 
must purchase a license. 
 A new automatic backup recovery tool enables SQL Server and SQL Server Express 
customers to restore their system from a backup or to copy the installation from a backup to 
a new server, without the help of a DBA. 
 Non-US users: In the Define TTS Tasks form, you can now define the Language in which 
to run tasks in the Tabula Task Scheduler, when it differs from the system's base language 
(i.e., English). 
International Tax Authorities  
 France: In keeping with French tax requirements, the new Create FEC File program creates 
a file that includes the company's journal entries during a specified time period. The Check 
Uploaded Entries (FEC) form displays a record of each time the program was run. 
 Europe: You can now base the Value Added Tax report either on transaction dates or on 
reference dates.
