# Customer Setup Script

- **Source:** `Customer Setup Script.pdf`

Customer Setup Script 
 
Note: Yellow highlights indicate action instructions.  
Clip Link: http://www.eshbel.com/Movie_Search/Customer_Setup_clip.htm  
Introduction (00:00-00:41) 
This clip demonstrates the tools available in Priority for setting up customers in the 
system and for keeping track of documents and data related to customers. The 
main tool for managing all the customers in the system is the Customers form, 
which provides a comprehensive view of the customer, encompassing a wealth of 
sales and financial data. We'll cover this near the end of the clip. In the meantime, 
we'll begin by setting up a new customer in the system.  
In this clip, we'll be using the Dual-Currency package, so certain columns shown 
here may not appear, or appear differently, in the U.S. package.  
Setting up a New Customer (00:42-02:01) 
Let's open the Customers form from the CRM > Customers menu. When new 
customers are first recorded in the system, they are automatically considered 
"potential" customers, as we'll see. Begin by recording the customer's Name. Note 
that several columns have been filled in automatically: the customer is automatically 
assigned a temporary Number that begins with "T", indicating a potential customer. 
You can record marketing campaigns, price quotes and even sales orders for 
potential customers, but not shipping or financial documents. The Status column 
has been filled in with the "Potential" status.  
To convert the new customer into an "active" customer, run the Convert Potential 
Cust to Cust program from the list of Direct Activations. As a result, the customer 
is assigned a permanent Number, and an A/R account is opened with the same 
number. This number is determined by definitions in the Cust & Vend Numeration 
Templates form. Note that the customer's Status has changed to "Active".   
BPM for Customers (02:02-02:59) 
Let's look at the definitions of customer statuses, by selecting BPM Flow Chart – 
Customers from the list of Direct Activations. Right-click a status to see its 
Properties. We'll demonstrate with the "Inactive" status. In the dialogue box, you 
can flag or clear fields to change status definitions, as desired. For instance, 
remove the flag from the Include in ToDo List option so that inactive customers 
will not show up in users' to-do lists. An inactive customer will not appear in 
document Choose lists. When a "Warned" customer is recorded in various 
documents, a warning message will appear.  
An in-depth explanation of working with BPM flow charts is provided elsewhere. 
Return to the Customers form by pressing Esc.  
Cat.No. LB130064  Ver.1 – Apr. 29,’13 1

Customer Details (03:00-04:49) 
Back to defining your new customer, click the Address/Phone tab to record contact 
details, such as address, phone and fax numbers. If your company uses our Priority 
Lite interface, the address recorded here will automatically appear in Google Maps 
when clicking the Map link from customer records in mobile devices.  
You can also record the customer's E-mail address and Web Site. Pressing F6 
from these columns, or the adjacent icon, will open a new message to this address, 
or the company website, respectively.  
In the Details tab, you can designate a Sales Rep who will appear as the default 
rep in all the customer's documents. You can also flag the Change Name column, 
which will enable users to change the name of the customer in each document. 
This is particularly useful in the record used for walk-in customers. 
In the Company Data tab, you can fill in an external Company Number, such as 
the number recorded in government or tax files. If you classify your customers into 
groups, choose the relevant group in the Cust. Group column. You can also record 
the Type of Business.  
Having opened a new customer, turned this potential customer into a regular active 
one, and recorded several details, let's see how to define financial parameters for 
active customers. 
Financial Parameters for Customers (04:50-06:44) 
With the cursor in the Number column, select Financ. Parameters for Customers 
from the list of Direct Activations. Here, define the Currency in which this customer 
is billed. If you record specific financial documents for the customer in a different 
currency, such as Euros, the relevant journal entry will be recorded in both US 
Dollars and Euros.  
In the Customer tab, you can choose Payment Terms, which will appear as the 
default terms in all documents for this customer, though they can be revised. You 
can also record a Billing Customer if the amounts owed by this customer are to be 
billed to another customer.  
In the Invoices tab, you can define such parameters as whether to Round Prices 
in this customer's invoices. Dual-currency users also need to define the Invoice 
Type – "C" for local customers, or "F" for foreign ones. For a detailed explanation of 
a given column, press F1. 
In the Credit tab, you can define the customer's Credit Limit. If a document is 
recorded after the customer has exceeded this limit, either a warning or an error 
message will appear, depending on the value assigned to the CreditMsg constant 
in the Financial Constants form. You can change the definition per customer in the 
Credit Message column.  
Once customers have been active for a while, so that transactions have been 
recorded for them, you can check their credit in the Customer Credit sub-level 
form, detailed by document type.  
Additional Customer Details (06:45-09:22) 
Now that financial parameters have been recorded, let's return to the Customers 
form to review definitions of additional customer details in various sub-level forms.  
Cat.No. LB130064  Ver.1 – Apr. 29,’13 2

Define Customer Contacts in the first sub-level form. Let's switch to single-record 
mode, more suitable for defining new contacts. Pressing F6 in the E-mail Address 
column, or pressing the e-mail icon, automatically opens a new mail message to 
that address. When the cursor is located in an e-mail column, you can also choose 
the Contact option from the upper Run menu, then communicate with this contact 
directly, using Skype or Windows Messenger.  
In the Position Code column, choose the appropriate position for this contact. In 
the Type of Contact tab, flag the relevant columns. For example, if this contact is 
in charge of purchasing, flag the Sales Order Contact column so that all sales 
orders opened for this customer will automatically be linked to this person.  
You can define the customer's various locations, such as main offices, warehouses 
and stores, in the Customer Sites sub-level form. Flag one of them as the Main 
Address, which will appear as the default site in shipments and invoices recorded 
for the customer.  
In the Cust. Remarks for Internal Use sub-level form, you can write a message 
that will pop up automatically whenever a user records this customer in system 
documents.  
In the Customer Parts form, you can define the sales items usually purchased by 
the customer. If you do, only these items will appear in part Choose lists for the 
customer; although you can still view the full list of parts by pressing Ctrl+F6. If you 
also flag the Ship Cust Parts Only flag in the Details tab of the upper-level form, 
sales documents to the customer will be limited to these parts, and an error 
message will appear when trying to record items not on this list.  
By the way, you can right-click the title of any sub-level form to read help text for 
that form.  
Following Up on Existing Customers (09:23-12:05) 
Once a customer is recorded in the system, the same Customers form is also used 
for follow-up. Let's switch to query mode by pressing F11, retrieve a customer by 
name, and review the information displayed.  
In the Tasks for Customer sub-level form, you can view existing tasks for the 
customer and record new ones, such as documentation of phone calls and  
meetings with the customer. You can assign the tasks to yourself or to other users.  
In the To Do List sub-level form, you can see the various documents linked to the 
customer that are in the process of being taken care of, such as open sales orders, 
invoices, shipping documents and service contracts. Move directly to the contract 
itself by pressing F6, so as to view the contract details, then return to the 
Customers form by pressing Esc. The full list of sub-levels is available by pressing 
F5. From there, you can move directly to a specific form.  
You can see orders to the customer that have not yet been shipped in the Open 
Sales Orders sub-level form. You can also view or revise the overall discount 
granted to the customer in the Overall Discount sub-level form. In the Customer 
Price Lists sub-level form, you can link price lists to the customer that will affect the 
default prices of items in sales documents opened for that customer. You can 
update special part prices and item discounts in additional sub-level forms. A 
Cat.No. LB130064  Ver.1 – Apr. 29,’13 3

Cat.No. LB130064  Ver.1 – Apr. 29,’13 4
detailed explanation of prices and discounts in Priority is available in a separate 
clip.  
In addition to the data appearing in sub-level forms, you can also run various 
reports from the Customer Reports menu or design your own customized reports 
using the Customer Data Report Generator. 
In each of the Sales menus, you can find various relevant reports , such as reports 
on sales orders. You can also run complex analyses of orders, by date, part family, 
customer group or any other parameter, using, for example, the items in the Sales 
Orders Analysis menu. The various report generators in the system give you the 
flexibility to build your own reports containing the customer data that you want.  
This concludes our demonstration of setting up a new customer in Priority.  
Related Documentation 
 Sales Order clip 
 Prices and Discounts clip 
 Report Generators clip 
 Open Customers wizard
