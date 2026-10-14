# Inventory Count Script

- **Source:** `Inventory Count Script.pdf`

Inventory Count Script 
Clip Link: http://www.eshbel.com/Movie_Search/Inventory_Count.htm  
Note: Yellow highlights indicate action instructions.  
Introduction (00:00-00:47) 
This clip demonstrates how to prepare and record inventory counts in Priority. It 
covers the following actions:  
 
Preparing and printing inventory count documents; 
 After the physical count, recording counted quantities in the system; 
 Refreshing count documents with updated calculated quantities;  
 Reviewing variance between calc ulated and counted quantities and 
approving the count; 
 And calculating past balances, which freeze inventory levels in the past and 
thus prevent retroactive revisions.  
It is strongly recommended that you avoid recording inventory transactions in the 
warehouses being counted, from the time you refresh the count until the approval of 
quantities, so as to prevent errors. And, of course, make sure that inventory is not 
moved from or into these warehouses at that time.   
Preparing the Inventory Count (00:48-04:57) 
The first step is to run the program that prepares inventory count documents. Each 
such document displays the calculated quantities of all items in the warehou
se, 
which will later be compared to the quantities actually counted. There are two such 
preparation programs – one that prepares a quick count and another that takes past 
balances into account. To prepare the initial count documents, before the physical 
count, use the quick count from the Inventory > Warehouse Control > Inventory 
Count > Prepare Count for Today (Quick) menu. But if yours is a manufacturing 
company and includes plant floor warehouses, use the other program from the 
Prepare Count for Past Date menu. In this demonstration, we'll prepare a quick 
count, but the same instructions apply when preparing the count for a past date.  
In the program input screen, designate the warehouses to be counted. To prepare 
the count for more than one warehouse, press F6 and retrieve the warehouses in 
the Warehouses form; then return to the program by pressing Esc. The blue 
magnifying glass icon indicates that the retrieved warehouses are saved for the 
purpose of running the program.  
Flag the Include 0 Balances column to include items in the printed count form with 
a calculated quantity of zero. This way, if there are actual quantities of these items 
in the warehouse, the people performing the count won't forget to include them and 
will have a line on which to record amounts. Flag the Select Parts option if you plan 
Cat.No. LB130440  Ver.1 – Oct. 7,’13 1

to count inventory for selected items only. In this case, a second input screen opens 
in which to select the desired items. 
Please note that an inventory count will not be recorded for warehouses flagged in 
the External Control column of the Warehouses form, for parts that are defined as 
not in use, or for parts that are not subject to Inventory Control. 
Once the program finishes, you will receive a message with the number of the 
inventory count documents opened. A separate document is opened for each 
warehouse. Let's enter the Inventory Count form and retrieve by today's Date to 
see the documents that were opened by the program. These documents all have a 
"Draft" status. The items themselves are displayed in the Itemized Inventory 
Count sub-level form. In the Calc. Qty (Factory) column, you can see the amount 
calculated by the system based on the inventory transactions recorded for each 
part.  
After running the preparation program, you can print the counting forms from the 
Inventory Count Reports menu, by selecting Print Inventory Count Form. In the 
Document column, record the number of the inventory count document created by 
the preparation program. If several documents were created, press F6 to retrieve 
them from the Inventory Count form by date.  
In the program input screen, select the desired options:  
 Choose whether or not to display ca lculated quantities in the printed forms. 
We recommend that you don't display these amounts, as they do not 
necessarily match actual inventory levels in the warehouse and might 
accidentally bias results. 
 Choose Lines Between Rows to add gridlines that make it easier to fill out 
the form.  
 And add Blank Lines at End so that there will be room to record additional 
items that do not appear in the form. 
The people performing the physical count should record amounts for loose items in 
the Quantity column and amounts for packaged items in the Crate Code and No. 
Crates columns. After all forms have been completed, you can record counted 
quantities in the system.  
Recording Counted Amounts (04:58-05:31) 
To record the counted amounts, return to the Inventory Count form, to the new 
count documents, and move to the Itemized Inventory Count sub-level form. You 
can record the amount in either of the Counted Quantity columns – in factory units 
or in buy/sell units. Or, if the items are packaged, record the code and number of 
packing crates . The system will automatically convert the crates into units, based 
on crate definitions.  
Refreshing the Count (05:32-06:40) 
If a signific
ant period has elapsed between the time the preparation program was 
run and counted quantities were recorded in the system, it is recommended that 
you recalculate inventory amounts in the system, so that any inventory transactions 
that took place in the interim will be taken into account. From the Prepare Count 
for Past Date menu, run the Prepare for Recount program.  
Cat.No. LB130440  Ver.1 – Oct. 7,’13 2

In the program input screen, record the number of the original inventory count 
document and the date of the actual count. The result is a new inventory count 
document, in which calculated quantities have been updated for the end of the work 
day selected during program input. The quantities recorded from the physical count 
are copied from the original document into the new document. Unapproved lines 
are deleted from the original document, which receives a "Final" status.  
Let's return to the Inventory Count form and retrieve one of the new documents 
using the Original Count Doc. column, where we record the number of the original 
document.  
Approving Count Lines (06:41-08:43) 
At this stage, you should examine the variance between calculated and counted 
amounts, in the Variance (Factor
y) column.  
To approve the amounts recorded for the physical count, flag the Approve 
Counted Qty column for each approved line. When you approve a line, an 
inventory transaction is recorded for the variance between the calculated amount 
and the actual counted amount. In addition, the inventory balance of the item is 
revised and inventory valuations are recalculated based on counted quantities.  
If you want to automatically approve all lines in the document, you can run the 
Approve Inventory Count program from the list of Direct Activations. Leave the 
Including 0 Qtys column blank if you want to approve only those lines with a 
counted quantity greater than zero. 
When you are finished approving the count, change the Status of the document to 
"Final". Note that inventory levels are updated regardless of the document's status, 
immediately upon approval of individual count lines. By changing the document's 
status to "Final," you prevent users from making revisions to it.  
Now let's open the Audit Trail form from the Inventory Transactions menu and 
retrieve the inventory transactions created during the count. The easiest way is to 
retrieve by the count document number in the Doc/Invoice Number column. In this 
line, for example, the quantity is negative. In the same line of the inventory count 
document, you can see that the calculated quantity is 9 and the counted quantity is 
6, so that the amount recorded in the inventory transaction – the variance between 
them – is 3. This variance is added to the calculated balance in the system, so that 
inventory levels of the item match the actual amount in stock.  
Viewing Updated Balances (08:44-09:40) 
Various inventory count reports, located in the Inventory > Warehouse Control > 
Inventory Count > Inventory Count Reports menu, provide a useful tool for 
keeping track of inventory levels.  
For instance, the Uncounted Parts in Period report displays items which haven't 
been counted within a specified time period. The Count Discrepancies report 
displays a list of items  for which calculated and counted quantities do not match, as 
well as the monetary value of the variance.  
For cases in which inventory balances do not match expected results based on the 
physical count, you can read instructions for correcting quantities in an FAQ on the 
topic. Right-click the Warehouse Control menu and select Online Help. In the 
Cat.No. LB130440  Ver.1 – Oct. 7,’13 3

Cat.No. LB130440  Ver.1 – Oct. 7,’13 4
browser window that opens, click on the question: "The balance in an inventory 
report differs from the recorded counted quantity".  
Recording Past Balances (09:41-10:45) 
At the end of the process, once you are sure the inventory balanc
es are correct, it is 
recommended that you run the program that calculates past balances. This 
program "locks" inventory balances up to a selected date. In other words, after 
running the program, no one can record an inventory transaction prior to the past 
balance date. That way, you can always be sure that inventory levels are accurate 
up to that date.  
To calculate the value of the inventory saved in the past balance, run the Costing 
for Past Balance Date program. In the commercial package, run this program from 
the Financials > Cost Analysis for Businesses > Part Costing menu. From the 
same menu, you can open the Inventory Valuation Reports menu and run a 
variety of reports on the value of your inventory.  
In the manufacturing package, the same actions can be performed from the Cost 
Analysis for Manufacturers menu.  
This concludes our demonstration of how to perform an inventory count. For 
additional assistance, run the Inventory Count Wizard.  
Related Documentation 
 Part Setup clip 
 Customer Shipments clip 
 Open a Warehouse Wizard 
 Inventory Count Wizard
