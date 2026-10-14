# Release Notes 18_3_E

- **Source:** `Release Notes 18_3_E.pdf`

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     1/10 
Release Notes Priority 18.3  
New Design Tool  
We completely overhauled the Form Design tool in Priority Web:  
 The new window displays the design options more clearly . 
 Now you can design fields in forms, sub -level forms , and direct activations in 
a single dialog box . 
 No more digging for that missing  column ! Simply search  for the column, sub-
level form, or activation you wish to customize.  
We also upgraded the r eport and document design:  
 The new window displays the report components cleanly, allowing you to 
make changes with ease.  
 You can search for a particular component in the report you wish to redesign.  
 When designing documents, you can also customiz e Word templates and 
use the new Containers feature .

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     2/10 
Containers  
 A container is a dynamic text component that can be integrated into  a Word 
template  and only appears when a predefined rule is met. For example,  
automatically include holiday greetings  in invoice s sent near the end of the 
year and into the start of the of  new year.   
 Containers are defined in the new Design Document window and use an  
interface similar to the existing interface for defining business rules and the 
data generator.  
Design by Packages  
 Packages enable you to easily customize the system based on your needs.  
Each package includes the various components (forms , columns and 
programs ) related to a specific topic. For example,  if you decide that the 
Sales Representatives  package is irrelevant fo r your company  because you 
don't work with sales representatives, you can hide that package, and all 
entities related to the management of sales representatives will be hidden.  
 Design by Packages is available in the new Form Design Tool. As part of the 
Form Design Tool upgrade, each component in the form lists  the package to 
which it belongs, with a short description of the purpose of the package.  
 When you choose to hide or display entities in the Form Design Tool, you 
can choose whether  to hide or disp lay the package with which it is 
associated.

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     3/10 
GDPR 
 We've added t ools the system to help you meet the new EU General Data 
Protection Regulation (GDPR). These include a n Entities Requiring 
Consent  form , which allows you to define privacy policies for each  individual 
with personal information saved in the system (contacts, leads, candidates , 
and employees).  
 A direct activation for sending privacy policies to individuals with personal 
information saved in the system has been added to the relevant forms 
(con tacts/leads/ candidates /employees)  to request consent for the policy. A 
second  direct activation enables documentation of the consent, including 
attaching the document in which  consent is expressed . 
 Employees who are also users in the system will be asked to provide 
consent in a special interface upon entering the system.  
 We've also added d irect activations for sending out saved personal 
information on an individual (upon request), as well as for deleting that  data.  
 Variou s reports have been added for assessing whether consent has been 
given for the privacy policy by individuals with information saved in the 
system.  
Account Reconciliations and Bank Reconciliations  
in a Split Worksheet  
 We have introduced a new way to manage  reconciliations : a split worksheet . 
This worksheet  provides a side -by-side view of the items being reconciled : 
debit vs. credit for account reconciliations, and bank statement vs. ledger for 
bank reconciliations.  
 Within the worksheet , you can carry out aut omatic and manual 
reconciliations. In the case of manual reconciliations, when selecting an item 
for reconciliation, the system automatically highlights matching items for 
reconciliation. When you attempt to finalize a manual reconciliation with a 
discrepa ncy, the system opens an input window for filling out an adjustment 
entry.  
 New programs for refreshing reconciliation worksheets : Refresh Acct Recon 
Worksheet  (for account reconciliations ) and Refresh Bank Recon 
Worksheet  (for bank reconciliations ). Refreshing the worksheet load s up-to-
date data for the accounts without having to close or delete pending 
reconciliations and re-preparing the worksheet .  
 The new worksheets  are only available in the Priority Web interface.  
 
Isracard Global   
 We are off ering a new credit card payment gateway : an integration with 
Isracard Global.  
 Isracard Global is launching in the US in 18.3 and will be expanded to 
additional territories in the future.  
 You can sign up with Isracard Global  directly  through the Priority  system.

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     4/10 
 The payment gateway  supp orts transmitting  a single transaction or a file of 
standing order transactions . Settings for standing orders can be set for a  
customer , service contract, or sales order/invoice . 
 The integration with Isracard Global  is only available via Priority  Web . 
Attendance Portal  
Priority 's upgraded a ttendance portal expands options for users and managers 
alike.  
All users  now have access to the following:  
 A new homepage that displays  the employee's information, attendance 
informa tion  for the current month, and vacation information (usage and 
balance)  
 Work hour and absence reporting  
 Breakdown of work hours, both as a report and in calendar form  
 Summary of attendance and absence  hours  
Managers also have access to:  
 A review of emplo yees in the team, including current -day attendance status  
 A list of birthdays in the current month for employees in the team  
 Attendance reports for employees in the team, including approval of work 
hour s and absence reports  
User Interface  
 Additional upgrad es to Word document templates:  
 Documents sen t via email based on  Business R ules can now be based on  a 
Word template . 
 Links and QR codes  can now be added to Word templates .  
 The saved reports now include reports produced from Word templates.  
Financials  
Perpetual Inventory  
We added  various improvements to Perpetual Inventory :  
 You can define a separate accounting  family for parts subject to inventory 
control . This optio n helps manage tracking of Perpetual Inventory entries.  
 You can now flag an account in  Chart of Accounts  as a  COGS -only 
account . The system will not allow you to post  journal entries that are not 
related to Perpetual Inventory for this account.  
 Price Variance by Invoice  is a new report that  allows you to analy ze 
variances between the cost of items in the Vendor Invoice and Standard Cost 
by Invoice  forms .  
 An Itemized Entry  sub -level form was added to t he COGS Transactions for 
Document  form (a sub -level form of various i nventory transactions) . The 
form displays a breakdown o f journal entries linked to the current document , 
and helps analyze Perpetual Inventory  entries .

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     5/10 
 We added a n account in the Default  Accounts  form for users of Perpetual 
Inventory  called Purchase – Non-Billable . This account serves as a default 
when  creating Perpetual Inventory entries  for Goods Receiving Vouchers  
(GRVs) which are marked as non -billable  and helps  the account manager 
identify entries that require individual attention.  
Other Upgrades to Financials  
 You can now open a payment to a vendor  from a purchase invoice  via a new 
direct activation Prepare Payment  to prepare a payment by check or bank 
transfer.  
 When preparing for a new fiscal period,  you can now open  document 
numeration templates  from the Fiscal Periods  form via the Open 
Numeration  Templates  direct activation.  
 The new Additional Bank Accounts  form (a sub -level for m of Credit Card 
Accounts ) lets you  define additional bank accounts for the credit card 
company , in the event that it transfers payments to you in different 
currencies.   
 Additional granularity was added to budget management for prepaid 
expenses, from budget controls  to budget vs. actual  reports. In the Bal. 
Sheet/P&L Items -GL Accounts  form, you can flag sections to be included in 
projected budget  usage . Amounts in accounts b elonging to these sections 
will appear under projected use in the budget . 
 We have made behind -the-scenes improvements to credit and liability 
calculation s, particularly when working with paying customers.  
 The definition of a n Exchange Rate Adjustment (Credit) account  will now 
affect adjustments entries made at the end of a fiscal period or during 
account reconciliation.  
 Delete J.Entry Items w/Zero Sums  can now be used to delete zero sum 
items from multiple journal entries . 
 
Delivery Tracking  
 Real -time tracking: Use the new SUpdStDocLin  logistic constant to 
determine if the status of documents linked to the itemization of a delivery 
tracking document is updated when data is recorded in the itemization (e.g. 
delivery failure)  — not only when the status of  the upper -level form is 
updated. Use the new Additional Status Definition  form added to the 
Reasons for Delivery Failure  form to define the status that inventory 
documents will receive when recording a reason for delivery failure in the 
tracking document.   
 Two new programs enable  you to populate a delivery tracking  document 
based on distribution data. Add Docs to Tracking Itemization  adds  
shipping documents  and sales invoices to a delivery tracking document if the 
distribution data in these documents  match those in the tracking document. 
Itemize Tracking Doc (Customers)  works similarly but can be limited to 
specific customers ' documents  that are  scheduled to be sent from a 
particular warehouse at a specific date.

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     6/10 
Customer Relations  
 CTmpCust  is a new logistic constant that determines  whether new 
customers will automatically open as regular (rather than potential ) 
customers .  
Sales, Purchasing , and Inventory  
 The Document Numeration Template  form now has a Preview  column that 
displays how the documents  will be numbered according to settings entered 
in the form.  
Sales  
 You can now define that a price quotation will automatically change its status 
when being saved as a new edition. The status can be defined in Additional 
Status Definitions (a sub -level form of Statuses for Price Quotations ).  
 Upgrades for ShipEngine users  in the US:  
o You can now define multiple shipping accounts per customer in the Accounts at 
Shippers (a sub-level form of Customers), instead of in the Additional Customer 
Data form. When entering a purchase order, you can select the relevant shipping 
account with a shipper.  
o Log screens have been added that document transmissions to ShipEngine and 
errors that returned.  
 You can now bill the customer site that appears in the Shipping Address  
sub-level form .  
 Upgrades to the  Label Generator  have been made  for creating an additional 
label  for shipment .  
 The direct activation Copy  Customer Shipment  has been added which 
creates a new customer shipment  based on an existing document . 
 Printing a Price List now includes the barcodes of the items in the Price List.  
Purchasing  
 We're h elping you take care of your customers : when you open a  new 
purchase order  based on a sales order , the new flag Reserve for Cust  will 
ensure that the invento ry will be reserved for the customer in the sales order  
when it arrive s at the warehouse.  
 Save time when entering goods received : you can now open a GRV directly 
from the Purchase Order s form  using the Open Goods Receiving Voucher  
direct activation.  
 The Supply Delays  report displays delays in the supply of parts to 
customers in open orders and historical delays  (for orders that have since 
closed).  
 The Logistic Constants  form has a new constant,  IAvailBal , which 
determines whether inventory  reserved for specific customers  will be 
included in the calculation of available inventory in Part Availability  forms.

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     7/10 
Warehouse Management System (WMS)  
We added support for storage  and replenishment  tasks at several stages and 
changed the work process with multi -stage tasks:  
 You can now define a default intermediate bin for storage in the warehouse,  
warehouse  aisles , or authorized zones for mobile device s (in the Storage 
Zones,  Aisles in Storage Zone, Authorized Zones  forms, respectively ).  
 When  preparing documents  for tasks in the warehouse, you can now 
designate the task as multi -staged. An additional input  windo w will open in 
which you define the intermediate bin  according to the default setting for the 
zone/aisle  or by manually entering a bin .   
 A variety of Create Wave programs now include an input column that lets you 
run the wave in simulation  mode . The wave will run as usual and produce a 
report but will not open  any warehouse tasks.  
 There's a new way to work  with Double Check ( DCH) tasks : you can now 
define at the  sales o rder level  whether to open a DCH task for  packing slips 
that are picked for the order . When running Prepare Documents  after the 
picking task is complete , the system opens DCH tasks in accordance with 
the definition in the column.  
 We've also  made several behind -the-scenes changes that led to a significant 
improvement in performance when it comes to working with DCH tasks.   
 IPutBalBin  is a new logistic co nstant that determines  whether to prefer 
storage in bins with existing inventory over  preferred  bins  or vice versa.  
 In the  Current Warehouse Inventory and Current Inventory by Part  forms, 
a new column  has been added for the Storage Zone  where the inventor y is 
located.  
 Create Issues to Kit Wave  now has a new split ting  method , Single Task for 
all Work Orders , that does not split tasks by the various work orders  included 
in the wave .   
Customer Service  
 When recording a customer  return as part of a service call (in the Service 
Report – Parts  form) , you can now indicate the status it will receive when 
returning to the inventory (e.g. if the item is defective).  
 The new program Delete Contract Payments enables you to delete service  
contract  payments  under the condition th at it has yet to be linked to an 
invoice .  
 In the Upcoming Payments for Contracts report, you can now display data 
for a specific date (rather than for the current or next month) .  
Serialized Part  
 The Logistic Constants  form now include s a CEndWarranty  constant, 
which determines whethe r to delete warranty data for a serialized part when  
it is  returned by a customer.  
 Serial Stamp s will now appear in documents that include printing of a group 
of serialized parts . The Serial Stamp  will  follow the serial number, with a 
hyphen between them .

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     8/10 
 The Audit Trail for Item, History of Components , and Audit Trail for 
Serial Numbers  forms now include columns that display the cost in the local 
and secondary currencies for the serialized part . In addition, these columns 
have also been added to the Audit Trail for Serial Numbers and History of 
Components  reports, which can now also be run via direct activation from 
the Catalogue of Parts w/Serial Nos. form.  
 The Catalogue of Parts w/Serial Nos. form  now also include s Last 
Incoming Trans and Last In Trans Code  columns. These columns display 
the purchasing inventory transaction  (Goods Receiving Vouchers or Vendor 
Invoice) through which the serialized part  was entere d into inventory.  
 The Prepare Servicing Plan  program now cancels service calls that were 
opened for servicing in the  past  but did not take place.  
Meters  
 The new Kit-Billed to Rding  column added to the Payment Details for 
Meters  form (sub -level of Payment Installments , itself a sub -level  of 
Service Contracts ) displays the number of pulses up to which the customer 
has been billed for a meter whose billing method is Pulse Kits.  
 The Sources of Meter Readings form now has several flags for defining the 
reading source (e.g. Orders, Service Calls, etc.). Additional flags include 
Reading After Reset (for a reading that resets the meter prior to it being 
transferred to a new customer)  and Correction (for cases wher e the 
previous reading was too high and must be revised downwards).  In the event 
of a correction , preparation  of payments  now accounts for a negative 
quantity in a meter reading .  
Production  
 The Bill of Materials  with Routing , Bill of Materials , Multi -leve l BOM 
Graph , and Bill of Materials w / Part Specs  reports now include an input 
option to limit the report to approved BOM revisions  only .  
International  
 The new  Customer Sales per State  report enables  you to analyze sales 
data by country in which the  goods  were sold.  
US 
 You can now load bank statements that use the  OFX format into the system .  
Canada  
 Sales document  printouts  (Sales Invoice s, Multi -Shipment Invoice s, Over -
the-Counter Invoices ) now display PST VAT and GST VAT.  
Europe  
 VAT Reports in Europe no w support subsidiaries . 
 The Journal of Vendor Invoices  report now includes the option to display 
Customs VAT .

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     9/10 
 The new WithheldTax for Invoices report provides details of withheld tax at 
the vendor invoice level . This report is for countries where withholding tax  for 
the vendor occur s when recording  an invoice rather than  during payment.  
Portugal  
 We've made m inor improvements to the SAFT interface.  
England  
 A Find Address by Post Code  program  has been added to additional forms 
that include post al codes : Branches, Sales Representatives, Warehouses, 
Personnel File, Company Data, Companies, Drivers/Shippers, and Bank 
Account Details .  
Mobile  
 The Application Generator  now includes the option to copy an existing 
application , which is helpful when you want to create a new application that 
is similar to an existing one.  This option is particularly useful when you want 
to create the same application in another language.  
 A new Purchasing Authorization app is now available in online app stores.  
 Many upgrades have been made to the Priority Master App :  
o Run programs and reports that include input.  
o Search for data more granularly with form.  
o Slide left or right to move between records in single-record view.  
o Open links that were sent by email in the appropriate application. 
o Utilize AM/PM time support for users in the US.  
o Create your own applications on the basis of new pre-defined applications in the 
Application Generator added to Sales, Purchasing, Customer Service, and Project 
Management.  
System Maintenance  
 We made the system more secure! We added the new Uploadable File 
Types  form : the system will block  uploads of  file types that do not appear  in 
this form.  
 For users of the API module: The new API Transaction Count report allows 
you to easily keep track of the number of API transactions utilized in a 
specified period. The report displays the number of transactions utilized by 
each user and the forms for which the transactions were utilized.  
 Impr ovements to the Tabula Task Scheduler : 
o Following the improvement in 18.2 that generates commands for running programs 
via the Tabula Task Scheduler, we've now added support for generating reports that 
are sent to a recipient via the Tabula Task Scheduler. In the event of entities with a 
similar name (program/report), you can now specify the type of entity in order to 
generate the appropriate command.

omsoftware.c-www.priority  
Cat.No . LB18000327          Ver.  02 │Sept  26,'18     10/10 
 The new Refresh Task Input by User  program , added to the Define TTS 
Tasks  form, makes it easier to update  the program input used for a  program 
or report .  
 The new AutoTTSExport  system constant allows you to determine whether 
when recording  or revising a task, the scheduler file is updated immediately 
or only when the Record Tasks in TTS File  program is run.  
Programming  
 We've released a  new version of Web SDK . A full list of change s can be 
found in the Developer Portal  at https://prioritysoftware.github.io .
