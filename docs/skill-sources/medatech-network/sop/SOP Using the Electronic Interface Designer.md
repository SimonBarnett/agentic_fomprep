# SOP Using the Electronic Interface Designer

- **Source:** `SOP Using the Electronic Interface Designer.pdf`

Cat.No.A8000107 1 Ver.1 – Dec.15,’08 
 
SOP: Using the Electronic Interface Designer* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To use the Electronic Interface Designer to create custom EDI interfaces. 
Procedure 
Stage I: Installing the ELINK server (Priority's data exchange service) 
Note: This procedure should be performed with the aid of your system manager. 
1. On the Priority server, enter the priority/client folder and run the setup.exe program. 
Select the data exchange installation and leave all of the default options. 
2. Run the service on the Windows server.  
Result 
 
The ELINK server is now running, and you can send and receive data after defining 
interfaces for incoming and outgoing transfers. 
Stage II: Defining Mail Data for Interface Messages 
Note: This procedure should be performed with the aid of your system manager. 
Option 1 
1. Enter Priori
ty on the workstation from which mail will be sent. 
Note: You cannot use a terminal server client. 
2. Run the Set Up External Mail w/o Outlook program. 
3. Record input for all parameters and flag the Send Test Message column. Make sure 
that the test message is received properly. 
Option 2 
1. 
Change the user that runs the Priority Data Exchange to a user with system manager 
privileges that can have a defined mail account (e.g., the Administrator). 
2. In the server, define an MS-Outlook mail profile for that user. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

3. Enter the workstation as that user and check that he/she can send mail properly. 
4. Enter Priority (as any user) and, in the top Mail menu, select Mail Options and flag 
the Without Outlook Security Messages option. 
5. Open the tabula.ini file (located in C:\Windows) and ensure that the following line 
appears in the [Menu] section: Outlook Messages = 0. 
6. Open Outlook, enter the Tools menu and select Options. Click the Mail Format tab 
and ensure that Word is not flagged in the Message format section as the default 
program for editing e-mail messages. 
Stage III: Defining a New Electronic Interface 
1. Enter the Electronic Interface Designer form. 
2. Record an Interface Name and Title for the new interface. 
3. In the Base Form column, choose the form from which you want to export data (i.e., 
the form to be used by the Exchange Data item in the Mail menu). 
4. In the ID Column – Sender column, specify the identifier (key) column in the 
sending form. For example, select the Number column (CUSTNAME) for the 
Customers form. 
5. If necessary, select a warning message in the sending form in the Sender's Msg 
Number column.  
Note: To define additional warning messages for the form, use the Error & Warning 
Messages sub-level of the Form Generator. 
6. Fill in the appropriate ID Column-Recipient for the interface type: 
 For interfaces updating the identical record (e.g., customers, parts), the value 
should be identical to that of the ID Column – Sender column. 
 For interfaces updating different records (e.g., purchase orders, sales orders), it is 
usually recommended to select a reference column, such as Sales Rep Order 
Num.  
7. Fill in the Recipient's Msg No. column, as you did for the sender. 
8. Enter the Forms in Interface sub-level form and define the forms from which data 
will be sent, and their target forms. 
9. For each pair of forms, enter the Form Columns in Interface sub-level form and 
define the columns from which data will be sent, and their target columns. 
10. Enter the Exchange Criteria – Form Columns sub-level form and define the 
columns in the sending form that must contain data in order to send the interface. 
Result 
 
You can now set up the parameters for running the new interface in the various 
companies on the server, and use it as one of the standard interfaces. 
Cat.No.A8000107 2 Ver.1 – Dec.15,’08

Example: Defining a Price List Interface 
The following defines a new electronic interface for updating price lists in one company 
with data from another. The interface will open a new price list or update an existing one. 
It will not update price list versions. 
1. Enter the Electronic Interface Designer form. 
2. Record "PRICELISTS" in the Interface Name column, and "Price Lists" in the Title 
column. 
3. Select the Price List form (PRICELIST) in the Base Form column. 
4. Select "Price List Code" (PLNAME) in the ID Column – Sender column. 
5. Enter the Form Generator and retrieve the PRICELIST form. Enter the Error & 
Warning Messages sub-level and define a "Sending Interface" and "Receiving 
Interface" message. Record their numbers in the Msg Number column.  
6. Return to the Electronic Interface Designer  form and specify the defined sending 
message in the Sender's Msg Number column. 
7. Select "Price List Code" (PLNAME) in the ID Column-Recipient column. 
8. Specify the defined receiving message in the Recipient's Msg No. column. 
9. Enter the Forms in Interface sub-level form and select both the Price List 
(PRICELIST) and the Part Prices (PARTPRICE) forms in both the Source Form 
and Target Form columns. 
10. Enter the Form Columns in Interface sub-level form from the PRICELIST line, and 
define the following columns as both the Source Column and Target Column: 
 "Price List Code" (PLNAME) 
 "List Description" (PLDES) 
 "Curr" (CODE) 
11. Enter the Form Columns in Interface sub-level form from the PARTPRICE line, and 
define the following columns as both the Source Column and Target Column: 
 "Part Number" (PARTNAME) 
 "Quantity" (QUANT) 
 "Price" (PRICE) 
 "Curr" (CODE) 
12. Enter the Exchange Criteria – Form Columns sub-level form and define "Price List 
Code" (PLNAME) and "List Description" (PLDES) as the columns in the sending form 
that must contain data in order to send the interface. 
13. Define the interface as active in the two companies, and run it as a test. 
Result 
 
The new interface will update the defined price list data in the receiving company 
with the revised data recorded in the sending company. 
Cat.No.A8000107 3 Ver.1 – Dec.15,’08

Cat.No.A8000107 4 Ver.1 – Dec.15,’08 
Summary 
 You can now use the defined interfaces to transfer data between companies.
