# 13-17-Getting Started

- **Source:** `13-17-Getting Started.pdf`

www.priority -software.com   
1/5 30/11/ /4102  Ver.02 Cat.No. LB10000002  
 
SOP: Getting Started* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To define the necessary data to start working in the system. 
Notes: 
 This document does not elaborate on all steps in each stage of the procedure. For more detailed 
instructions, see the relevant SOPs for each stage. 
 This document does not detail every single option provided by the system, but focuses on those 
definitions and data that are needed to start working on a regular basis. 
Procedure 
Stage I: Opening a Company 
1. Run the Add Company program to open the company in which you will be working (the working 
environment), according to the instructions in the relevant SOP. 
Note: Do not overwrite the predefined demo environment. 
2. When you have completed all the instructions listed in the relevant SOP and defined basic data 
in the working environment, open a second demo environment that will contain real data for your 
company, as described in the relevant SOP. 
Note: It is recommended that you periodically delete your old demo environment and set up an 
updated demo environment in its place. 
Stage II: Setting Up Users and Privileges 
1. Define new users and assign the necessary privileges to each, according to the instructions in 
the relevant SOP.  
2. Set up a personnel file for each user as follows: 
a. Enter the Users form and retrieve the desired user. Move to the Employee ID column 
and press F6 twice to view the user's Personnel File. 
b. Record employee data for the user, as described in the SOP for opening an employee 
record. 
Note: Not every company employee is also a system user. For example, your company may 
employ warehouse personnel who are not defined as system users. In such a case, you should 
set up a personnel file for each warehouse employee and flag the Inactive User column. 
Stage III: Setting Up Finances 
1. Currencies: 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/5 30/11/ /4102  Ver.02 Cat.No. LB10000002  
 
a. Enter the Currencies form and verify that all currencies you require are defined in the 
system. For detailed instructions on setting up currencies, see the SOP for setting up 
finances. 
b. Record current exchange rates for each currency, as described in the relevant SOP. 
2. Financial Statements: 
 Enter the Makeup of Financial Statements form and define the properties of the various 
financial statements used by your company. For detailed instructions on defining financial 
statements, see the relevant SOP. 
3. General Ledger: 
a. Make sure that all necessary GL accounts have been opened and defined as desired. 
For detailed instructions on defining GL accounts, see the relevant SOP. 
Note: It is also possible to revise the numbers of existing accounts. 
b. Open A/R accounts, as described in the SOP for opening a customer. 
c. Open A/P accounts, as described in the SOP for opening a vendor. 
4. Default Accounts: Enter the Default Accounts form. In the Account No. column, assign a GL 
account that will serve as the default account for each type of transaction. Define new GL 
accounts as necessary (see step 3a above). 
Notes: 
 You can view a detailed explanation of each type of account in the Help Text (Base 
Language) sub-level form. 
 If your company does not work with one or more of the predefined default accounts, you need 
not assign it a GL account. 
5. Cashiers: Set up your company's cashiers, according to the instructions in the relevant SOP. 
6. Bank Accounts: Define bank accounts for your company, according to the instructions in the 
relevant SOP. 
7. Credit Card Companies: Set up the credit card companies with which your company works, 
according to the instructions in the SOP for setting up finances. 
8. Fiscal Years/Periods: Define fiscal years and periods used to record financial transactions in the 
ledger, according to the instructions in the relevant SOP. 
9. Opening Balances: Record opening balances for each account using one of the following 
methods: 
 Manually record a single journal entry against the Opening Balance account (see the SOP for 
recording journal entries). 
 Import journal entries that were recorded in an external system (see the SOP for data 
migration). 
 To migrate data from a previous system, contact your implementor. 
10. Tax Definitions: 
 In the U.S. package, your next tasks are to set up for sales tax and assign tax codes to your 
customers. For more detailed instructions, run the Taxes Wizard. 
 In the dual-currency package, your next tasks are to set up VAT, withholding tax and tax 
prepayment definitions. For more detailed instructions, see the SOPs for withheld tax reports 
and setting up finances or run the Taxes Wizard. 
11. Payment Terms: Review the predefined payment terms and adapt them to your needs, 
according to the instructions in the SOP for setting up finances.  
12. Numeration Template And Other Properties:

www.priority -software.com   
3/5 30/11/ /4102  Ver.02 Cat.No. LB10000002  
 
a. Before recording financial documents in Priority, run the Open Numeration Templates 
program. 
Note: There are several predefined numeration templates that serve as the default for 
all types of financial documents. These can be revised in the Document Numeration 
Templates form, after you have run the Open Numeration Templates program. 
b. Enter the Inv. Transaction Documents and Financial Documents forms to define the 
attributes of each type of document used in your company (e.g., how many days 
ahead can documents of this type be postdated and whether users can finalize a 
document with a total amount of 0). 
c. Each type of financial document is linked to a predefined journal entry code, which 
appears automatically when recording a document of that type. To define additional 
journal entry codes, enter the Journal Entry Codes form. For more detailed 
instructions, see the relevant SOP. 
Stage IV: Setting Up Inventory 
1. Warehouses: 
 Enter the Warehouses form and open records for your warehouses and define various 
warehouse attributes, according to the instructions in the relevant SOP. 
2. Parts: 
 Enter the Part Catalogue and define the parts you work with (both purchased and sold parts), 
according to the instructions in the relevant SOP. 
 Enter the Parts form and define the bill of materials for any parent part (e.g., an assembled 
part), according to the instructions in the SOP for creating BOM revisions. 
3. Initial Inventory Count: 
 To initialize the system's inventory of parts, you must perform an initial inventory count. This 
count creates inventory of the parts stored in your warehouses before work with the system 
has begun. For detailed instructions on recording inventory counts, see the relevant SOP. 
4. Past Balances: 
 After recording the initial inventory count, run the Calculate Balance for Date program, 
according to the instructions in the SOP for inventory counts. 
Note: A past balance "locks" inventory balances in all warehouses for any given date in the 
past. That is, once a past balance has been calculated, you cannot record or revise inventory 
transactions dated prior to the past balance date. 
Stage V: Sales 
 After opening records for your company's customers, you can define a variety of price lists, 
discounts and bonuses for parts and part families, and link them to specific customers. For more 
detailed instructions, see the SOP for defining customer prices & discounts. 
Stage VI: Purchasing 
1. After defining the vendors with which your company works, you can define each vendor's part 
list, according to the instructions in the SOP for opening customer/vendor part numbers. 
2. To work with vendor price lists, see the relevant SOP. 
3. To assign a single purchase price to each part, enter the Part Catalogue, click the Prices & 
Costs tab and record the part's Purch Price. This price will appear by default in vendor price 
quotations and purchase orders, but may be revised manually for specific documents. 
Note: If you do not work with vendor price lists, make sure the value of the PPriceByList logistic 
constant is defined as 0.

www.priority -software.com   
4/5 30/11/ /4102  Ver.02 Cat.No. LB10000002  
 
Stage VII: Business Process Management (BPM) 
1. When recording the various types of documents discussed in this SOP, each document can be 
assigned one of a list of predefined statuses (e.g., Authorized, Final). 
2. To maintain control over business processes, you can add new statuses (in addition to the 
predefined ones), revise status properties, define permitted sequences of status allocation, and 
create status rules, for each type of document. For detailed information, see the User Interface 
Guide. 
Stage VIII: Setting Constants 
Work in the system is influenced by various constants. To check that these constants are 
appropriately defined for your company, enter the following forms: 
 System Constants 
 Logistic Constants 
 Financial Constants 
 Planning Constants 
 Production Constants 
Notes: 
 You can view a detailed explanation of each constant and its possible values in the Help Text 
(Base Language) sub-level form. 
 It is recommended that you review all constants in the above forms and make sure that they are 
defined in accordance with your company's needs. 
 A number of these constants are mentioned in the Setups section of the other SOPs mentioned 
in this document. 
Stage IX: Backup & Recovery 
To create a backup of the data in your system, see the appropriate document: 
 Backup & Recovery - Tabula 
 Backup & Recovery - Zoom 
 SQL Server: Backup & Recovery 
 SQL Server Express: Backup/Recov  
Tips 
 To view an explanation of an open system form, press Ctrl+F1. 
 To view an explanation of a specific form column, move the cursor to the column in question and 
press F1. 
 To access relevant documentation from the Eshbel web site, click the right mouse button from a 
menu item (without actually selecting that item) and select Online Help. In the Explorer window 
that opens, the following options appear: 
 Standard operating procedures (SOPs) that pertain to the selected entity. 
 Frequently asked questions (FAQs) that pertain to the selected entity.  
 You can also view an interactive guide or Wizard for a detailed explanation of many of the 
system's processes (accessed via the Help menu).

www.priority -software.com   
5/5 30/11/ /4102  Ver.02 Cat.No. LB10000002  
 
Results 
 The system has been initialized and you can now start working on a regular basis. 
 The system has been adapted to fit your company's work practises (by means of constants and 
BPM flow charts).
