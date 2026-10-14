# Priority SOP_EDI- Def21_1_E

- **Source:** `Priority SOP_EDI- Def21_1_E.pdf`

LBI2100592 Ver. 01 Oct. 11, 21 
 
 
1 
Master Data Management between Companies (Same 
Installation/ Separate Installations) 
Aim 
Managing master data and transferring data between companies in the same installation or 
to companies in another installation using master data management (MDM). 
To define custom data interfaces, see the SOP: Defining an Electronic Interface. 
If you are upgrading from the old Data Exchange service (versions 21.0 and below), see 
additional instructions in the appendix. 
Note: The instructions in this document are aimed at system administrators. 
Working Assumptions 
• All the companies sharing data between them are on the same version of Priority. 
• You have purchased the Data Exchange module. 
Process 
Stage I: Installing the Application Service and Activating Data Interface 
Exchange 
To transfer data between companies, start by Installing the Application Server. If it is 
already installed, install it again. The installation program recognizes that you own the Data 
Exchange module and will offer to install the Data Exchange component. 
 
Data Exchange installation option 
If you are planning on transferring data between companies in separate installations, make 
sure you also enable the Priority Gateway as part of the installation.

LBI2100592 Ver. 01 Oct. 11, 21 
 
 
2 
Note: The data exchange mechanism is a component of the Priority Application Server. 
There is no additional service added to the server. 
Stage II: Defining Companies for Data Exchange 
1. Open the Define Comps. for Data Exchange form. In it record the companies to 
which you wish to transfer data, or want to receive data from them. 
2. Record Company Description. 
3. For a company in the same installation: 
– Record the Company Name as it appears in the Companies form. 
– Check both the Incoming from Comp. and Outgoing to Company boxes. 
4. For a company in a separate installation: 
– Record the External Access ID of the company in the Gateway. The system 
administrator of the other installation can find this ID in the same field in the 
Companies form. 
– Check the Incoming from Comp. box if you receive data from this company. 
– Check the Outgoing to Company box if you send data to this company. 
Stage III: Linking Companies to Customers and Vendors 
Aim: Linking the companies defined in the previous stage to customers and vendors in the 
system. 
1. Open the Customer Definitions form. For customers with whom you exchange data, 
select the customer in the Customer Number field, and then choose their company 
in the Data Exchange Comp. field. 
2. Open the Vendor Definitions form. For vendors with whom you exchange data, 
select the vendor in the Vendor Number field, and then choose their company in the 
Data Exchange Comp. field. 
Result: Data exchange companies have been defined and linked to customers/vendors if 
necessary. 
Stage IV: Data Interface Definitions 
Aim: Recording definitions for active data exchange interfaces. 
Definitions for Outgoing Data Interfaces 
1. In the sending company, open the Data Exchange Definitions form. 
2. Move to the line of the interface you want active, and fill in following: 
– Active (Outgoing) - check this box to send data to other companies through 
this interface. 
– Automatic Outgoing - outgoing interfaces can be set to run automatically 
whenever you leave a record in the relevant form. If left unchecked, the 
interface must be sent manually through the command in the Mail menu.

LBI2100592 Ver. 01 Oct. 11, 21 
 
 
3 
– Nonparallel Outgoing - by default, interfaces of the same type are sent in 
parallel. For example, an interface of parts sends multiple parts at once. 
Check this box in cases where the order of transmission is critical. For 
example, if you first define a representative customer for the next few 
customers you open. Generally, you can leave this box empty and only check 
it when parallel transmission causes issues. 
– Outgoing Notifcat’n - choose a value from the list based on the type of 
messages you want to receive about outgoing interfaces. The notifaction is 
sent to the sender. 
– In the Recipients of Outgoing Data sub-level, determine the companies that 
will receive the data. 
  Note: The read-only email field in this sub-level form is purely informative and 
is meant to aid in migrating from the old Data Exchange mechanism. It does 
not affect interface definitions in any way. 
Definitions for Incoming Data Interfaces 
1. In the receiving company, open the Data Exchange Definitions form. 
2. Move to the line of the interface you want active, and fill in following: 
– Active (Incoming) - check this box to receive data from other companies 
through this interface. 
– Update Incoming Data - check this box so that updating a record in the 
source company will also update it in this company (the receiving company). If 
left empty, only new records will be sent by interface, while updates to existing 
records will be ignored. 
– Nonparallel Outgoing - check this option to allow receipt of this interface 
from any organization - that is, the system will not check if the company that 
sent the interface appears in the Companies for Incoming Data sub-level. If 
left unchecked, the companies from which this interface can be received must 
be added in this sub-level. Regardless of whether this box is checked or not, 
source companies must be checked as Incoming from Comp. in the Define 
Comps. for Data Exchange form. 
  Note: The read-only email field in this sub-level form is purely informative and 
is meant to aid in migrating from the old Data Exchange mechanism. It does 
not affect interface definitions in any way. 
– Outgoing Notifcat’n - choose a value from the list based on the type of 
messages you want to receive about outgoing interfaces. The notifaction is 
sent to the sender. 
– To limit the transfer of data in an incoming interface (such as an interface that 
opens a sales order, but which should not update the unit price), use the 
Block Data Receipt-Form Columns sub-level. Enter the form that contains

LBI2100592 Ver. 01 Oct. 11, 21 
 
 
4 
the data to be blocked in the Form field, and select the field to block in the 
Column in Form field. 
Stage V: Initiate Outgoing Interface Manually 
Aim: Manually initiating an outgoing interface (if it is not run automatically) 
1. In the source company, open the appropriate form and locate one or more records to 
be sent. 
2. From the Mail menu, select the Send with Data Exchange option. The following 
dialog box opens: 
   
  Send with Data Exchange 
3. You can choose to which companies the data is sent by marking the checkbox next 
to each one. You can also select all companies. 
4. Toggle the Send All Form Records option on to send all currently retrieved records. 
If you leave the option off, only the currently selected record is sent to the selected 
companies. 
5. Click OK to send the data.

LBI2100592 Ver. 01 Oct. 11, 21 
 
 
5 
Stage VI: Track Incoming and Outgoing Data 
Aim: Track and identify data interfaces sent from the source company and received in the 
target company. 
1. In the source company, open the Outbox Journal form. Locate the relevant interface 
and check whether it was received in the target company or there was some sort of 
error. 
2. In the target company, open the Inbox Journal form. Locate the relevant interface 
and check that it was received successfully. If there were any errors, they are listed 
in the Details of Errors sub-level. 
Adding another Company to an Existing Setup 
Use the Add Company to Data Exchange program to easily add a newly opened company 
to existing data exchange processes. The program will update existing interfaces in the 
Data Exchange Definitions form with new target companies. 
Keep in mind that the new company must first be defined as a valid target for outgoing 
interfaces in the Define Comps. for Data Exchange form (see stage II above). 
1. Run the Add Company to Data Exchange program. You should run the program in 
the source company for master data. 
2. In Company to Add, select one ore more companies to add as target companies for 
data interfaces. 
3. In Interface, select one or more data exchange interfaces to which these companies 
will be added as targets. 
4. Check the Update Records? option if you want the interfaces to be able to update 
data in the target companies, or leave it blank to only allow them to open new 
records. 
Distributing Data to the New Company 
After configuring the new company, you can now easily distribute master data to it. 
1. Run the Send All Records via Interface program, in the source company for master 
data. 
2. In Interface, select the interfaces you want to use for data distribution (e.g., Parts, 
Vendors). 
3. In Company, select the target company for the data. 
Result 
Data is sent from the source company to the target company. The data distribution process 
runs in the background, so you can continue working in the system.

LBI2100592 Ver. 01 Oct. 11, 21 
 
 
6 
Appendix: Migrating from Data Exchange Server 
If you already use the Data Exchange module, this appendix contains useful information for 
migrating to the new method. 
Before Installing the Application Server 
Before installing the application server, you must first stop and uninstall the existing Priority 
Data Exchange service from the existing Data Exchange server. 
Note that the Data Exchange server will stop operating as soon as you upgrade to version 
21.1. 
Migrating from Emails to Companies 
The old data exchange mechanism used emails to identify participants in the data 
exchange. 
The new system uses company identifiers. 
To assist in migration, after defining companies in the Define Comps. for Data Exchange 
form, you can use the Update Interface by Email action. In the input, record an email 
address, and the system will replace that email with the current company (or company 
identifier) in the following forms: 
• Data Exchanges Definitions > Recipients of Outgoing Data 
• Customer Definitions 
• Vendor Definitions
