# EDI Installation guide

- **Source:** `EDI Installation guide.docx`

SOP: Using the Electronic Interface Designer

Aim

 To use the Electronic Interface Designer to create custom EDI interfaces.

Procedure

Stage I: Installing the ELINK server (Priority's data exchange service)

Note: This procedure should be performed with the aid of your system manager.

1. On the Priority server, enter the priority/client folder and run the setup.exe program. Select the data exchange installation and leave all of the default options.

2. Run the service on the Windows server.

Result

 The ELINK server is now running, and you can send and receive data after defining interfaces for incoming and outgoing transfers.

Stage II: Defining Mail Data for Interface Messages

Note: This procedure should be performed with the aid of your system manager.

Option 1

1. Enter Priority on the workstation from which mail will be sent. Note: You cannot use a terminal server client (RDP).

2. Run the Set Up External Mail w/o Outlook(Mail Options for Other Servers) program (Path: Office Management > Mail > Mail Options for Other Servers > Mail Options for Other Servers).

3. Record input for all parameters and flag the Send Test Message column. Make sure that the test message is received properly. Requires following information: Mail Server name (how they send mail with IP details, Port (25 for local, 465 SSL, 587 TLS), Domain, SSL, TSL if use Office 365), User name for windows admin account, Password for account which is set up on Mail server and allowed to send emails, Email address for account which is set up on Mail server and allowed to send emails

Mail Server details:

Option 2

1. Change the user that runs the Priority Data Exchange to a user with system manager privileges that can have a defined mail account (e.g., the Administrator).

2. In the server, define an MS-Outlook mail profile for that user.

3. Enter the workstation as that user and check that he/she can send mail properly.

4. Enter Priority (as any user) and, in the top Mail menu, select Mail Options and flag the Without Outlook Security Messages option.

5. Open the tabula.ini file (located in C:\Windows) and ensure that the following line appears in the [Menu] section: Outlook Messages = 0.

6. Open Outlook, enter the Tools menu and select Options. Click the Mail Format tab and ensure that Word is not flagged in the Message format section as the default program for editing e-mail messages.

How do I configure electronic interfaces (EDI) between installations?

Note: it’s important to restart Data Exchange Service and Priority after amending the setup (for example: between servers or on the same server). If EDI to be carried out on the same server than “Additional Definitions when Companies are Installed on Different Servers” should not be defined, as that would prevent EDI from working.

Following instructions in the documents "SOP - EDI with Customers and Vendors" and "SOP - Using the Electronic Interface Designer" (available in the Customer Zone of the Priority web site), use the options in the Data Exchange menu (menu path: System Management > System  Maintenance) to do the following:

Activate the incoming/outgoing interfaces

Record an e-mail address for each company that will be sending/receiving data via electronic interfaces.
Note: Configure customers/vendors with an e-mail address identical to that of the company with which they want to work (when interfacing between companies that are customer/vendor of one another).

For mirrored interfaces, configure a fixed e-mail address for the outgoing interface.

Configure and operate the Data Exchange server on one of the computers.

Additional Definitions when Companies are Installed on Different Servers

Open registered port 2618 on all servers (even if the servers are on the same network).(Not required if both are on same network and Firewall is switched off).

Confirm that Priority Data Exchange is installed on all servers (primary and secondary servers).

Designate one of the Data Exchange servers as the primary server, and include a reference to that server (by name, for example: GILDOR (my server name)) in message 3020 of the PDENVIRON program, on all servers. Confirm that the server referenced in message 3020 is accessible by name using ping (in command prompt, for example: ping gildor).

In one of the companies in the primary server that is participating in the data exchange, do the following:
Note: In version 14, perform this step in all participating companies in the primary server.

Define all companies participating in electronic interfaces (whether installed in the primary or secondary servers, and including the current company) as vendors (in the Vendors form).
Note: If necessary, create fictitious vendors for the purpose of the interface.

Enter the Vendor Info for Data Exchange form (menu path: System Management > System  Maintenance > Data Exchange) and make sure all participating companies appear as vendors, with an identifying e-mail address. Record the license name used by its installation in the Co. Name on License column.
Note: In versions prior to v.16, this form cannot be accessed from the menu, but must rather be opened via the Form Generator (retrieve by the internal form name PORTALSUP).

Open the tabula.ini file (C:\Windows), scroll to the [Environment] section and add the line Company=<comp>, where <comp> is the name of the company in which definitions were recorded in step 4 (for example: Company=edi4 (edi4 – company name)).
Note: In version 14, use the name of one of the companies in which definitions were recorded (i.e., any participating company in the primary server).

Important Note! When interfacing with more than two servers, the same configuration must be performed: designating one server as primary and the others as secondary (even when the interfaces are not from/to the primary server). In any event, all interfaces pass through the primary server.

EDI PO to SO data transfer set up:

Set up 2 Companies (on same installation or different servers)

Company A – sending data (open Purchase Orders to open Sales Orders)

Company B – receiving data (open Sales Orders based on Purchase Orders open in company A)

Define email address in Company Data form for each company

Company A – companya@mail.com

Company B – companyb@mail.com

In Company B:

Create a Customer with email address of the company which will send information through

Customer B - companya@mail.com

Create a Vendor with email address of the company which will send information through

Vendor B - companya@mail.com

In Company A:

Create a Vendor with email address of the company to which data will be sent

Vendor B –  companyb@mail.com

Vendor A –  companya@mail.com

Create a Customer with email address of the company to which data will be sent

Customer A - companyb@mail.com

Stage III: Defining a New Electronic Interface

1. Enter the Electronic Interface Designer form.

2. Record an Interface Name and Title for the new interface.

3. In the Base Form column, choose the form from which you want to export data (i.e., the form to be used by the Exchange Data item in the Mail menu).

4. In the ID Column – Sender column, specify the identifier (key) column in the sending form. For example, select the Number column (CUSTNAME) for the Customers form.

5. If necessary, select a warning message in the sending form in the Sender's Msg Number column. Note: To define additional warning messages for the form, use the Error & Warning Messages sub-level of the Form Generator.

6. Fill in the appropriate ID Column-Recipient for the interface type:

 For interfaces updating the identical record (e.g., customers, parts), the value should be identical to that of the ID Column – Sender column.

 For interfaces updating different records (e.g., purchase orders, sales orders), it is usually recommended to select a reference column, such as Sales Rep Order Num.

7. Fill in the Recipient's Msg No. column, as you did for the sender.

8. Enter the Forms in Interface sub-level form and define the forms from which data will be sent, and their target forms.

9. For each pair of forms, enter the Form Columns in Interface sub-level form and define the columns from which data will be sent, and their target columns.

10. Enter the Exchange Criteria – Form Columns sub-level form and define the columns in the sending form that must contain data in order to send the interface.

Result

 You can now set up the parameters for running the new interface in the various companies on the server, and use it as one of the standard interfaces.

Example: Defining a Price List Interface

The following defines a new electronic interface for updating price lists in one company with data from another. The interface will open a new price list or update an existing one. It will not update price list versions.

1. Enter the Electronic Interface Designer form.

2. Record "PRICELISTS" in the Interface Name column, and "Price Lists" in the Title column.

3. Select the Price List form (PRICELIST) in the Base Form column.

4. Select "Price List Code" (PLNAME) in the ID Column – Sender column.

5. Enter the Form Generator and retrieve the PRICELIST form. Enter the Error & Warning Messages sub-level and define a "Sending Interface" and "Receiving Interface" message. Record their numbers in the Msg Number column.

6. Return to the Electronic Interface Designer form and specify the defined sending message in the Sender's Msg Number column.

7. Select "Price List Code" (PLNAME) in the ID Column-Recipient column.

8. Specify the defined receiving message in the Recipient's Msg No. column.

9. Enter the Forms in Interface sub-level form and select both the Price List (PRICELIST) and the Part Prices (PARTPRICE) forms in both the Source Form and Target Form columns.

10. Enter the Form Columns in Interface sub-level form from the PRICELIST line, and define the following columns as both the Source Column and Target Column:

 "Price List Code" (PLNAME)

 "List Description" (PLDES)

 "Curr" (CODE)

11. Enter the Form Columns in Interface sub-level form from the PARTPRICE line, and define the following columns as both the Source Column and Target Column:

 "Part Number" (PARTNAME)

 "Quantity" (QUANT)

 "Price" (PRICE)

 "Curr" (CODE)

12. Enter the Exchange Criteria – Form Columns sub-level form and define "Price List Code" (PLNAME) and "List Description" (PLDES) as the columns in the sending form that must contain data in order to send the interface.

13. Define the interface as active in the two companies, and run it as a test.

Result

 The new interface will update the defined price list data in the receiving company with the revised data recorded in the sending company.

Summary

 You can now use the defined interfaces to transfer data between companies.

SOP: Set up EDI with Customers and Vendors

Customer: Company Inc.

Assigned to: Dept./Position

Aim

To set up Priority to run electronic data interfaces (EDIs) between companies that work on either

the same or different Priority servers, using interfaces defined in the system.

Note: This SOP does not document the procedure for setting up customized EDIs.

Working Assumption

A Data Exchange server has been installed according to current installation instructions available on

the Priority website and the instructions in the SOP for the Electronic Interface Designer.

Procedure

Stage I: Recording a Company in the Portal

Aim for this stage: To record identifying information of companies in Priority that use the Data

Exchange module.

1. Enter the Company Data form. Record an e-mail address for each company that will be

sending/receiving data via electronic interfaces.

2. If any company is not run from the same server, contact the service staff to receive a license.

In such a case, record the companies using the Company Info form.

Result: Companies that need to exchange data via electronic interfaces are defined in the Portal.

Stage II: Setting Up Electronic Interfaces in the Sending Company

Aim for this stage: To record parameters for active outgoing interfaces in the “sending” company.

1. After entering Priority, select the company from which data are sent.

2. Enter the Data Exchange Definitions form.

3. Retrieve the outgoing interface to be activated and then update the following columns:

Active (Outgoing) - Flag this column on the line for the interface you wish to activate in the

sending company.

Automatic Outgoing – For an outgoing interface of a document, flag this column to have

data sent automatically as soon as you exit the relevant form. Otherwise, the interface will

need to be activated manually from the Mail menu.

Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own

operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not

to use them without prior testing to make sure that they fit their own requirements and work practices.

www.pr ior i ty- sof tware.com

Cat.No. LB10000252 Ver. 04 Mar. 02,'15 2/3

Outgoing Notificat'n – Select the value “2” in this column to be notified automatically when

data is transmitted.

4. Enter the Recipients of Outgoing Data sub-level form for those interfaces (e.g., Customers,

Parts) in which the recipients of outgoing data are constant. Define recipients’ e-mail addresses.

For interfaces in which the recipient is determined by the document itself (e.g., in the interface

for purchase orders to vendors, each order is sent to the designated vendor), there is no need to

define anything in this form.

5. If interfacing between a customer and vendor, make sure that the other party (customer or

vendor) is flagged in the Allow Data Exchange column and that a current e-mail address is

defined. These data are recorded in the Customer Definitions and Vendor Definitions forms,

respectively.

Stage III: Setting Up Electronic Interfaces in the Receiving Company

Aim for this stage: To record parameters for active incoming interfaces in the “receiving” company.

1. After entering Priority, select the company to which data are received.

2. Enter the Data Exchange Definitions form.

3. Retrieve the incoming interface to be activated and then update the following columns:

Active (Incoming) - Flag this column on the line for the interface you wish to activate in the

receiving company.

Update Incoming Data – For an incoming interface of a document, flag this column to have

updates to the document in the sending company automatically reflected in the same

document in the receiving company.

Incoming from All – Flag this column to enable data input via an interface with any

organization. If you leave the column unflagged, you need to define the e-mail addresses of

all sources from which data can be received in the Data Exchange Partners sub-level form.

Incoming Notificat'n: Select the value “2” in this column to be notified automatically when

data is received.

4. To block data transmission for some of the columns in the receiving interface (for example, an

incoming interface that creates sales orders, in which you do not want to receive part prices),

enter the Block Data-Receipt Form Columns sub-level form. In the Form column, indicate the

form in which the blocked column appears, and select the Column in Form. The data in this

column will not be sent.

5. If interfacing between a customer and vendor, make sure that the other party (customer or

vendor) is flagged in the Allow Data Exchange column and that a current e-mail address is

defined. These data are recorded in the Customer Definitions and Vendor Definitions forms,

respectively.

Stage IV: Manual Interface Transmission

Aim for this stage: To manually activate an outgoing interface.

1. In the sending company, enter the relevant form and retrieve the data or document to be

transmitted.

2. From the Mail menu, select the Exchange Data option.

www.pr ior i ty- sof tware.com

Cat.No. LB10000252 Ver. 04 Mar. 02,'15 3/3

Stage V: Tracking Outgoing and Incoming Interfaces

Aim for this stage: To enable identification and tracking of interfaces transmitted by the sending

company and received by the receiving company.

1. In the sending company, enter the Outbox Journal form. Retrieve the transmitted interface and

check whether it was received by the receiving company, or if there were any errors.

2. In the receiving company, enter the Inbox Journal form. Retrieve the incoming interface and

check if there were any errors. To view an explanation of the error, enter the Details of Error

sub-level form.

Result:

The interfaces are defined and ready to be used.

Process Summary

The defined interfaces work and the defined contacts are notified regarding the interfaces that are

sent and received.
