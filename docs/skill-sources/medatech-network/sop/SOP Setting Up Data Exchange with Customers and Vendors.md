# SOP Setting Up Data Exchange with Customers and Vendors

- **Source:** `SOP Setting Up Data Exchange with Customers and Vendors.pdf`

Cat.No. LB10000252 1 Ver.3 – Jan.3,’12 
 
SOP: Setting Up Data Exchange  
With Customers and Vendors* 
Customer: Company Inc. 
Assigned to: Dept./Position 
Aim 
To set up Priority to run electronic data interfaces (EDIs) between companies that work 
on either the same or different Priority servers, using interfaces defined in the system. 
Note: This SOP does not document the procedure for setting up customized EDIs. 
Working Assumption 
A Data Exchange server has been installed according to current installation instructions 
available on Eshbel’s website and the instructions in the SOP for the Electronic 
Interface Designer. 
Procedure 
Stage I: Recording a Company in the Portal 
Aim for this stage: To record identifying information of companies in Priority that use 
the Data Exchange module. 
1. Enter the Company Data form. Record an e-mail address for each company that will 
be sending/receiving data via electronic interfaces. 
2. If any company is not run from the same server, contact Eshbel to receive a 
license. In such a case, record the companies using the Company Info form. 
Result: Companies that need to exchange data via electronic interfaces are defined in 
the Portal. 
Stage II: Setting Up Electronic Interfaces in the Sending Company 
Aim for this stage: To record parameters for active outgoing interfaces in the “sending” 
company. 
1. After entering Priority, select the company from which data are sent. 
2. Enter the Data Exchange Definitions form. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

3. Retrieve the outgoing interface to be activated and then update the following 
columns: 
 Active (Outgoing) - Flag this column on the line for the interface you wish to 
activate in the sending company. 
 Automatic Outgoing – For an outgoing interface of a document, flag this column 
to have data sent automatically as soon as you exit the relevant form. Otherwise, 
the interface will need to be activated manually from the Mail menu. 
 Outgoing Notificat'n – Select the value “2” in this column to be notified 
automatically when data is transmitted. 
4. Enter the Recipients of Outgoing Data sub-level form for those interfaces (e.g., 
Customers, Parts) in which the recipients of outgoing data are constant. Define 
recipients’ e-mail addresses. For interfaces in which the recipient is determined by 
the document itself (e.g., in the interface for purchase orders to vendors, each order 
is sent to the designated vendor), there is no need to define anything in this form. 
5. If interfacing between a customer and vendor, make sure that the other party 
(customer or vendor) is flagged in the Allow Data Exchange column and that a 
current e-mail address is defined. These data are recorded in the Customer 
Definitions and Vendor Definitions forms, respectively. 
Stage III: Setting Up Electronic Interfaces in the Receiving Company 
Aim for this stage: To record parameters for active incoming interfaces in the 
“receiving” company. 
1. After entering Priority, select the company to which data are received. 
2. Enter the Data Exchange Definitions form. 
3. Retrieve the incoming interface to be activated and then update the following 
columns: 
 Active (Incoming) - Flag this column on the line for the interface you wish to 
activate in the receiving company. 
 Update Incoming Data – For an incoming interface of a document, flag this 
column to have updates to the document in the sending company automatically 
reflected in the same document in the receiving company. 
 Incoming from All – Flag this column to enable data input via an interface with 
any organization. If you leave the column unflagged, you need to define the e-
mail addresses of all sources from which data can be received in the Data 
Exchange Partners sub-level form. 
 Incoming Notificat'n: Select the value “2” in this column to be notified 
automatically when data is received. 
4. To block data transmission for some of the columns in the receiving interface (for 
example, an incoming interface that creates sales orders, in which you do not want 
to receive part prices), enter the Block Data-Receipt Form Columns sub-level 
form. In the Form column, indicate the form in which the blocked column appears, 
and select the Column in Form. The data in this column will not be sent. 
Cat.No. LB10000252 2 Ver.3 – Jan.3,’12

Cat.No. LB10000252 3 Ver.3 – Jan.3,’12 
5. If interfacing between a customer and vendor, make sure that the other party 
(customer or vendor) is flagged in the Allow Data Exchange column and that a 
current e-mail address is defined. These data are recorded in the Customer 
Definitions and Vendor Definitions forms, respectively. 
Stage IV: Manual Interface Transmission 
Aim for this stage: To manually activate an outgoing interface. 
1. In the sending company, enter the relevant form and retrieve the data or document to 
be transmitted. 
2. From the Mail menu, select the Exchange Data option. 
Stage V: Tracking Outgoing and Incoming Interfaces 
Aim for this stage: To enable identification and tracking of interfaces transmitted by the 
sending company and received by the receiving company. 
1. In the sending company, enter the Outbox Journal form. Retrieve the transmitted 
interface and check whether it was received by the receiving company, or if there 
were any errors. 
2. In the receiving company, enter the Inbox Journal  form. Retrieve the incoming 
interface and check if there were any errors. To view an explanation of the error, 
enter the Details of Error sub-level form. 
Result: 
 The interfaces are defined and ready to be used. 
Process Summary 
The defined interfaces work and the defined contacts are notified regarding the 
interfaces that are sent and received.
