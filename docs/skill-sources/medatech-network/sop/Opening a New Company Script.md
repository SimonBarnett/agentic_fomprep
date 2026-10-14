# Opening a New Company Script

- **Source:** `Opening a New Company Script.pdf`

Opening a New Company Script 
Clip Link: http://www.eshbel.com/Movie_Search/Opening_a_New_Company_clip.htm 
Note: Yellow highlights 
indicate action instructions.  
Introduction (00:00-00:30) 
In this clip, we'll demonstrate how to open a new company in Priority and set up the 
necessary initial definitions so that you can begin working with this company. These 
setups should be performed immediately upon beginning to work in Priority and, in a 
multi-company setting, they need to be repeated for each new company you define. 
The various operations we are about to demonstrate must be performed on the 
server by the system manager, who signs into Priority with the username tabula.   
Opening a New Company (00:31-04:16) 
To open a new company, run the Add Company program from the menu path: 
System Management > System Maintenance > Companies. In the program's 
input, we'll use the Company column to define a company code composed of lower-
case letters and/or numbers only. In the Full Company Name column, record the 
name of the company. We strongly recommend that you leave the Initialize 
Accounts option flagged, so that this program will automatically open a number of 
basic default accounts for the new company, along with the necessary account 
definitions.  
If you work with a dual-currency installation, you'll also need to select the desired 
Initialization Type. This parameter allows international organizations to open one 
company in Europe and a second company in the US by choosing different 
installation types when adding each company. Unless the company you are adding 
is located in the U.S., you should choose the Dual-Currency option. Consequently, 
you will also need to select the local currency and a second, foreign currency in 
which to maintain the company's financial data. Finally, click OK to continue running 
the program.  
Once the program is finished and you have received a message to that effect on the 
screen, exit and re-enter Priority, and choose the new company you added as your 
working environment. From the Companies menu we navigated to earlier, open the 
Companies form to review the company that was just added. Looking over at the 
Color column, you can see that the color currently assigned to this company is blue. 
This color is used to display the title bar when working in this company environment, 
and functions as a visual aid for users who work with several different companies. If 
you do plan on working with several different companies, you may also want to flag 
the MultiCo Exch Rates column, indicating that this company shares currency 
exchange rates with other companies in a multi-company setting. When a new 
exchange rate is recorded in one flagged company, the other flagged companies will 
be updated automatically. 
Cat.No. LB130105  Ver.1 – June 16,’13 1

If you have purchased one or more foreign language dictionaries, in order to work in 
Priority in a language other than English, you can also choose the company's 
primary language in the Lang. Code column of this form. 
From the same menu, we'll open the Company Data form in order to record basic 
details such as the company's main address and phone number. This information will 
appear in the heading of all printouts intended for the company's customers and 
vendors. You may also want to fill in the company's official registration, tax or VAT ID 
number, as it should appear on printed documents such as invoices.  
Next, we'll move to the HTML Logo column in order to upload the company's logo, 
for display on printouts for this company. Right-click on the paperclip icon, and select 
Import. In the window that opens, locate the desired image file and click Open to 
import this file into the system. 
Setting Up Financials (04:17-05:03) 
At this stage, we can close the Company Data form and begin setting up basic 
financial definitions for the company. From the Financials > General Ledger > 
Fiscal Periods menu, open the Define Fiscal Years form. We'll use this form to 
define the fiscal year from January 1 to December 31. After defining the fiscal year, 
12 fiscal periods appear automatically in the Fiscal Periods sub-level form, one for 
each full month.  
You can now run the Open Fiscal Period program, in order to begin recording 
financial transactions for the designated fiscal period. You can run this program for 
all upcoming fiscal periods up until the end of the year at this time, if necessary. 
Setting Up Taxes (05:04-05:47) 
Taxes in Pr
iority are maintained by tax codes and tax groups. When a sales 
document (e.g., price quotation, sales order, customer shipment, service call) is 
prepared for a given customer, Priority automatically calculates the correct amount 
of tax and adds it to the document. Each document “inherits” the tax from the 
previous document (sales order from a price quotation, for example). You can 
manually change the tax rate at any point. 
For dual-currency users, the same is true for purchasing documents (whereas in the 
U.S. package, tax is included in the unit price). That is, tax is calculated 
automatically and copied from one document to the next. Again, it can be changed 
manually. 
Detailed instructions on setting up tax codes and tax groups in the system and 
assigning default tax codes to customers (and vendors) are provided in the Taxes 
Wizard. 
Setting Up Financial Document Definitions (05:48-08:09) 
In Priority, each new financ
ial document is assigned a number automatically, 
according to a predefined format. At the beginning of every year (and when you first 
start to work with Priority), you need to create new numeration templates for these 
documents, by running the Open Numeration Templates program and specifying 
the current Year. You can then review the templates created for each type of 
document in the Document Numeration Templates form. In order to avoid 
confusion, make sure that the prefixes assigned to similar types of documents, such 
Cat.No. LB130105  Ver.1 – June 16,’13 2

as price quotes for customers and price quotes from vendors, don't resemble each 
other too closely. You can revise the prefix assigned to any type of document directly 
in this form, so long as you have not yet opened a document of that type. 
Move to the Financial Documents form. This form is used to define various 
attributes for each type of financial document. . The form opens in multi-record 
display mode, and you can press F4 to revert to single-record mode, which displays 
the names of columns in full. For example, it's a good idea to flag the Post Journ. 
Entries column for sales invoices, so that journal entries are posted automatically to 
the ledger when such invoices are finalized. Similarly, you may want to flag the 
Negative Sum Counter column, to ensure that sales invoices whose total amount is 
negative will have a separate numeration sequence. Use the Set Text for 
Document sub-level form to record set text that you want to appear on printouts of 
each type of financial document. 
Returning for a moment to the menu from which we opened this form, you can right 
click on the form title and select Online Help in order to access a variety of Help 
tools related to the form. In this case, several relevant FAQs are provided for the 
Financial Documents form. You can access a list of Online Help options in the 
same fashion for any entity appearing in the Main Menu, including the various sub-
menus. Let's click one of the provided FAQs to see the answer to the question: 
"Where can I define set text for the various system documents?". 
Adding System Users (08:10-08:48) 
Next, we'll demonstrate how to define the system's users. From the menu path: 
System Management > System Maintenance > Users, we'll run the Add New 
User program and fill in the relevant details. The assigned User Name may be 
shorter than the user's Full Name, and will serve to identify this user throughout the 
system. The next step is to assign the user a Privilege Group Leader. The user will 
automatically inherit all the privileges defined for that leader. Note that the number of 
Priority users that can be opened is limited to the number of licenses you have 
purchased. 
Backup (08:49-09:28) 
It is very important to back up your data regularly, by means of the Run Dail
y 
Backup program. The resulting backup file will be saved in the backup sub-folder of 
the priority directory. It is recommended that you maintain a copy of all backup files 
on an external media device, such as an external hard drive or a USB flash drive. 
You can set the daily backup to take place automatically; a detailed review of the 
backup process is provided elsewhere. 
This concludes our review of setting up a new company in Priority. For more 
information, see the Companies Wizard. 
Related Documentation 
 Getting Started Main Wizard 
 Companies Wizard 
 Taxes Wizard 
 User Interface Guide 
Cat.No. LB130105  Ver.1 – June 16,’13 3

Cat.No. LB130105  Ver.1 – June 16,’13 4
 Learning Aids clip 
 Backup & Recovery documents (separate documents are available for each server) 
 Backup & Recovery clip
