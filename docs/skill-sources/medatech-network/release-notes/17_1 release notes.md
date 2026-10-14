# 17_1 release notes

- **Source:** `17_1 release notes.pdf`

www.priority -software.com   
1/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
 
Release Notes Priority 17.1 
User Interface 
Improvements to Priority Rich: 
 Customize the look of your forms by choosing a Dark/Light color theme from the Design 
menu. 
 The row of shortcuts in forms includes two new shortcuts: Delete Record and Send Record 
Link. 
 Additions to the home page: 
o Entities on the home page are now organized separately from the Favorites menu 
and each can be designed differently. 
o You can add entities to the home page using the dedicated Add Entity mechanism (+ 
sign on the home page), from the Search for Entity tool and from the Main Menu. 
o A new Latest Updates menu (below Recent Items ) provides quick access to 
recently updated documents, so long as their status causes them to be included in 
any user's to-do list. You can view the document type, number and other details of 
each document. 
o The LatestUpdates system constant limits the number of documents that will appear 
in the Latest Updates menu. 
o Additional design features – You can rearrange the home page tiles by drag & drop, 
or remove them by dragging to the trash can.  
o A triangle in the upper corner of a home page tile displays the number of documents 
of that type that are assigned to you. Click the triangle to access a display of these 
documents in your to-do list.  
 New Search for Entity capabilities: add the entity to the home page and open the Privilege 
Explorer directly to the entity. 
 Search results now open in a new form, allowing you to return to the form after opening a 
document. 
 Improvements to the Privilege Explorer: 
o The Privilege Explorer has been redesigned to visually and intuitively display 
privileges for each entity. 
o The new explorer displays an indicator for every entity that has not yet been 
assigned privileges.

www.priority -software.com   
2/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
o The Privilege Explorer can be opened directly to a given entity, both from the menu 
and via the Search for Entity tool. 
Payroll, Time and Attendance 
 A new Create Pay Classes program provides an easy way to open new pay classes in 
keeping with labor laws. 
 You can run the Payroll Data for Employee program by Direct Activation from the 
Personnel File form to easily open records with basic payroll data.  
 The Daily Reported Hours Overlap program provides a new tool for attendance control. 
 A History of Changes sub-level was added to the Payroll Definitions form. 
 A new mechanism for enforcing labor laws enables you to track employee labor law 
infringement. The mechanism includes: 
o A new Definition of Labor Laws form in which to define pay requirements by law. 
o A new flag in the Pay Classes form determines whether to check for labor law 
infringements based on attendance reports of employees in this class. 
o A new report displays employees' labor law infringements. 
 New options for overtime calculations: 
o New options for the DailyOvertime payroll definition support calculations of overtime 
when the shift runs into the next calendar day. 
o For users of Time & Attendance: the OvertimeOffset constant determines how 
overtime hours are offset for employees who have exceeded their global overtime or 
approved overtime threshold.  
 You can now define Global Overtime Offset per pay class or individual 
employee. If a global salary employee exceeds his/her overtime hour limit, the 
system will calculate the overtime hours due and offset the defined global 
overtime hours. 
 You can now define the number of Approved Overtime hours per pay class 
or individual employee. If an employee exceeds his/her approved overtime 
threshold, these hours will not be taken into account in salary calculations. 
 A new Yearly Summary for Employee report displays annual payroll and attendance data.  
 A new Prep Salaries for All Employees program allows you to use the Task Scheduler to 
prepare salaries when the data authorization mechanism for payroll groups is activated.

www.priority -software.com   
3/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
Financials 
 You can use the new PrepaidExpDays financial constant to indicate the number of days 
back for prepaid/deferred amounts to be considered when the Transfer 
PrepaidExp/DeferredInc program is run. 
 A new digital stamp icon was added to e-documents. 
 A new Cancel Open Period program allows you to cancel the opening of a fiscal period 
opened by mistake. 
 A new Account to Credit column in the Financial Parameters for Vendors form allows 
you to define another A/P account to credit when invoices are recorded for this vendor. 
 The new Set Text for Customer's Invoice form (sub-level of the Customers form) allows 
you to define set text that will appear on invoices for a specific customer. 
 A new Income Account column, added to the Financ. Parameters for Customers form, 
allows you to define default income accounts per customer. 
 A new Main Addresses-Invoices flag in the Customer Sites form (sub-level of 
Customers) allows you to define a site as the address to which to send multi-shipment, 
export (non-US users only) and pro forma invoices. 
 Profit centers for purchase orders are now copied from previous documents (purchase 
demands, vendor price quotes, sales orders and blanket orders). 
 The Prepare Payments program now supports payment of pro forma purchase invoices 
(flagged in the Flag Invoices for Payment form), as well as regular invoices. 
 Non-US users: 
o You can use the new PostdateDays financial constant to indicate the number of 
days back for postdated checks to be considered when the Cash Postdated Checks 
program is run. 
o Support for bimonthly VAT reporting - A new TransSumsToVAT financial constant 
allows you to determines whether VAT is reported on a monthly or bimonthly basis. 
Warehouse Management System (WMS)  
 The new Add to Packing Slip column in the Warehouse Task Items form enables you to 
include PIK and PAK task items in an existing packing slip. When preparing documents, 
instead of opening a new packing slip, the parts will be added to the designated slip. If the 
column is empty, the system will open a new packing slip. 
 Addition to the Pick Algorithm form, sub-level of Pick Strategies: "Inventory w/small 
difference from demand before inventory with large diff". Flag this step as active if you want 
the system to suggest picking from a bin with a quantity that is closest to the amount

www.priority -software.com   
4/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
required. Flag Reverse if you want inventory with a larger difference from demand to be 
used first. 
 You can now select individual parts to replenish when running the Create Replenishment 
Wave (Inv.) program. 
 The new PSurplusRcv constant allows you to define how a receipt of parts that exceeds the 
amount ordered (beyond the part's defined order tolerance) will be recorded in GRVs 
opened for an RCV task via a mobile device. The excess amount can be linked to the last 
open purchase order or added as a separate line to the GRV and not linked to any order. 
 You can now record new serial numbers in MOV tasks. 
 A new BPM flow chart was added for maintaining statuses of containers. 
Delivery Scheduling and Tracking 
 You can now schedule delivery for individual order items: 
o Use the new SOrdDelivery logistic constant to determine whether entire orders or 
individual order items will be scheduled for delivery.  
o Order items can be scheduled automatically or manually. 
 The Delivery Days form (sub-level of the Customers form) can be used to define the days 
of the week and the times at which the customer regularly receives deliveries. 
 The Itemized Tracking Document form, sub-level of the Delivery Tracking Documents 
form, can be used to record the expected time of delivery to the customer. If a time range 
was defined in the Customers form, the time recorded there will automatically be filled in, 
but may be revised. 
Sales, Purchasing and Inventory 
 The new Due Date column, in the Follow-up tab of the Sales Orders form, allows you to 
record a due date for the entire order that will automatically be assigned to any newly 
recorded order items. 
 The new SProjNegOrd logistic constant determines whether to take orders with negative 
quantities into account when calculating project profitability. 
 Additions to the Sales Opportunity Rep. Generator: the projected dates for completing 
various stages in the sales process. 
 New columns in the Sales Order Report Generator include Sales Rep Order Num., 
Shipment Code, Shipping Method and Budget Item. 
 In the Price Lists form, you can now define a price list as Not in Use, so it will no longer 
appear in Choose lists.

www.priority -software.com   
5/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
 Non-US users: The new VAT Number-Cust. column in the Sales Orders form allows you to 
record  the number of the customer's company as recognized by VAT authorities in the 
order, which will then be automatically copied to invoices linked to the order. 
 You can record the Packing Crate No. and Crate Type Code in the Itemized Quotation 
sub-level of the Price Quotation for Customers and Vendor Price Quotation forms. 
 You can define the number of days it usually takes the vendor to supply a part in the Supply 
Days column of the Parts per Vendor form. 
 You can use the Blanket Purch Order and Line-Blanket Order columns, which were 
added to the Order Items form (sub-level of the Purchase Orders form), to link each line in 
the purchase order to a different blanket order. 
 The Order Type column, added to the Vendors form, allows you to record a default order 
type that will appear automatically in any purchase order recorded to this vendor. 
 When recording a GRV, you can now record the received part's serial stamp. 
 The new Set Text for GRVs form allows you to define text that will appear in GRV printouts. 
In addition, new value was added to the PCopyPOrdTxt logistic constant that determines 
what text will be copied into GRVs that are based on purchase orders which already include 
remarks. 
 The new Set Text for Warehouse Transfers form allows you to define text that will appear 
in warehouse transfer documents and printouts. 
 You can set a variable conversion ratio for buy/sell units required in certain documents 
without generating a change in quantities in factory units in the document (similar to the 
variable conversion ratio flag for parts). Do so by flagging the Variable Conversion column 
for the pair of units in the Unit Conversions form. 
Field Sales (Mobile Application) 
 When recording a document for returned goods, the field sales rep can now specify the 
customer site where the return took place. 
Field Service (Mobile Application) 
 The field technician can now record whether to charge the customer for the labor and parts 
used in the service call. 
 When reporting labor and parts for a service call, the field technician can force a discount of 
0%, which will be used instead of the system's discount hierarchy. 
 The field technician can now record the servicing package relevant to the service call.

www.priority -software.com   
6/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
Miscellaneous 
 The Not in Use column was added to the Customer Groups and Secondary Customer 
Groups forms. Flagging this column will prevent the customer groups from appearing in 
Choose lists. 
 The new Task Report Generator, in the Customer Relations Management menu, allows 
you to design and run reports on tasks. 
 Authorizers for purchase orders, purchase demands, special budgets and project planning 
versions can be flagged as not in use. 
 The Extended Price column was added to the following documents: price quotes, vendor 
invoices, debit memos, pro forma invoices and shipping documents. 
 The new Kits Issued to Work Orders report displays the items in a kit list that have already 
been issued for production of selected work orders. 
 You can use the Overall History of Changes report to view changes that were made to a 
variety of entities (e.g., parts, contacts, tasks). 
System Maintenance and SDK 
 A new Forgot password message in the login screen assists users in restoring forgotten 
passwords via an e-mail link. 
 Improvements to the Task Scheduler: 
o Definition of tasks and their scheduling from within a Priority form, even in the 
Windows interface. 
o The task file is automatically updated from the form, and it's no longer necessary to 
run an update program. 
o New options for defining frequency of tasks. 
o E-mail notifications can be sent to designated users at the beginning/end of the 
tasks. 
o You can define multiple companies in which to run the task. 
o For a program requiring user input, you can designate the user from which the input 
is to be taken. 
o A new report displays the tasks that are defined to be run by the Task Scheduler. 
 The Privileges per Group Leader report can now be run for individual menus or even 
specific forms, reports and programs. 
 The new Compare User Priv Btw Companies report allows you to view the privileges of a 
group of users in several companies.

www.priority -software.com   
7/7 May 07,'17 Ver. 02 Cat.No. LB150412 
 
 When using the Copy Queries program, you can now copy queries to multiple users at 
once. 
 You can now limit the BPM Flow Chart Rules report to active rules. 
 New programs for copying rules in the system: 
o The Copy Business Rules and Data Gen program allows you to copy business 
rules and data generator rules from one user to another. 
o The new Switch Users in BPM Flow Chart program allows you to revise BPM rules, 
changing one user to another. 
 The new EXCELBLANKCELL system constant allows you to define how to copy empty cells 
from Excel worksheets to Priority in the Windows interface. 
 The new PerfMonitoring system constant determines whether or not to send performance 
data from Priority Rich to the performance monitoring server. 
 Priority now supports the REST API, a software architecture style used to develop 
applications and programs that interface with Priority. To work with REST you must 
purchase a license. 
International Tax Authorities  
 Portugal: The Digital Signatures program can be run from the list of Direct Activations from 
various forms (e.g., Revision of Invoice Details). 
 Mexico: The Upload Financial Data to SAT program was upgraded according to local tax 
requirements.
