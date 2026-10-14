# SOP Inventory Counts

- **Source:** `SOP Inventory Counts.pdf`

Cat.No.LB140006 1 Ver.1 – Jan 14,’14 
 
SOP: Inventory Counts* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of recording the initial inventory count (performed 
when initializing the system), as well as subsequent routine inventory counts. 
Setup 
 Run the BPM Flow Chart-Inventory Counts program to define the BPM workflow for 
inventory counts. 
Initial Inventory Count 
Perform an initial inventory count when initializing the system or beginning to work with a 
new warehouse. 
Stage I: Recording an Inventory Count Document 
1. Enter the Inventory Count form. 
2. In the Date column, do one of the following: 
 If you are initializing the system, record the date one day before the system goes 
online. 
 If the count is for a new warehouse, record the date the count is performed. 
3. In the Warehouse column, specify the code of the warehouse for which the count is 
being performed. A separate record should be recorded for each warehouse. 
4. Enter the Itemized Inventory Count sub-level form. 
5. Record all of the parts to be counted in the current warehouse. You can copy the list 
of parts from an Excel spreadsheet. 
6. You can record up to 1000 items in this form. If there are more than 1000 items in this 
warehouse, record them in the parallel Lines to be Displayed sub-level form and its 
own Itemized Inventory Count sub-level. 
7. For each item, record the actual counted quantity. Make sure to use the appropriate 
column, according to the counting unit: factory or buy/sell. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No.LB140006 2 Ver.1 – Jan 14,’14 
8. To define the part's inventory balance in the system according to the counted 
quantity, flag the Approve column. 
9. To check each recorded inventory balance against its corresponding counted 
quantity, run the Inv. per Warehouse as of Date report. As long as the count 
document remains open, you can go back and update the quantities according to 
repeat counts. 
10. Use the Attachments sub-level form to attach any relevant documents. 
11. When all quantities have been approved, close the document by changing its 
Status to Final. 
12. To reopen a closed inventory document, click Reopen Document from the list of 
Direct Activations. 
Stage II: Initial Past Balance 
A past balance locks inventory balances on a given date. Past balances are used to 
calculate costing for a specific past date. A past balance should be run after completing 
the initial inventory count. 
1. Run the Calculate Balance for Date program. 
2. In the input screen, specify the Date of the inventory count – the day before the 
system is to go online. 
3. If it is necessary to revise an inventory count after the past balance was run, run the 
Delete Last Past Balance program. Reopen the relevant count document, make the 
necessary revisions, close the document and rerun the past balance.  
Results 
 As a result of the initial inventory count, warehouse balances are recorded in the 
system, allowing inventory transactions to be recorded. 
 As a result of running a past balance: 
 costing can be run for the past balance date 
 it is no longer possible to change inventory balances for any date prior to the past 
balance date. 
Routine Inventory Count 
Stage I: Preparing the Count 
Before recording the counted quantities, the inventory count must be prepared, either for 
the current date or for a previous date. The difference between the two is in the method 
of calculating the quantities against which the counted quantities are compared. It is very 
important to choose the correct program, as the preparatory calculations are based on 
different data. 
 Prepare Count for Past Date: Run the Prepare for Inventory Count program. In the 
input screen, specify the Warehouse, Part Number and Date. The system will 
calculate quantities according to the inventory transactions recorded between the last 
past balance date and the designated count date.

Cat.No.LB140006 3 Ver.1 – Jan 14,’14 
 Prepare Count for Today (Quick): Run the Prepare for Inventory Count program. In 
the input screen, specify the Warehouse and Part Number. The system will 
calculate quantities according to the inventory transactions recorded between the last 
past balance date and today. 
Note: For plant-floor warehouses you can only prepare inventory counts for a past date. 
Results 
 Each preparation program prepares inventory count documents for the date in 
question. 
 The calculated quantities of each part are recorded in the appropriate sub-level of the 
count document. 
Stage II: Performing the Count 
1. Enter the Inventory Count form. 
2. Retrieve the inventory count documents created by the preparation program, either by 
date or by a check mark in the Last Count column. 
3. To prepare forms in which to record the actual count, click Print Inventory Count 
Form from the list of Direct Activations. 
4. After performing the actual count, return to the form and enter the Itemized Inventory 
Count sub-level form. 
5. For each part, record the counted quantity, using the appropriate column for factory or 
buy/sell units. 
6. If the recorded quantity is ready for immediate authorization, flag the Approve 
column. 
7. After recording the counted quantities, run the Count Discrepancies report.  
8. Use this report to perform an additional physical count. Update the original count 
document with the recounted part quantities. 
9. Approve all line items in order to synchronize the system's quantities with the counted 
ones. To do so, flag the Approve column for each line. You can also return to the 
upper-level form and click Approve/Revoke Inventory Count from the list of Direct 
Activations. This program automatically approves all lines in the document, or 
revokes approval from currently approved lines. 
Note: Approving lines in which a discrepancy exists between the two quantities 
updates the inventory balance recorded in the system for such parts to match its 
counted quantity. This generates an "Inventory Count" transaction which adjusts 
inventory levels by the difference between counted and calculated quantities.  
10. To recount any quantities with major variance, run the Prepare for Recount program 
and choose one of the following options: 
 Correct variances that appeared in the original count document only. 
 Correct such variances AND update the count to a later date (i.e., take into 
account transactions recorded since the original count).

Cat.No.LB140006 4 Ver.1 – Jan 14,’14 
Note: In both cases, the program opens a new document and copies into it any lines 
from the original count which were not approved. Record and approve counted 
quantities.  
11. Use the Attachments sub-level form to attach any relevant documents. 
12. When all quantities have been approved, close the document by changing its 
Status to Final. 
13. To reopen a closed inventory document, click Reopen Document from the list of 
Direct Activations. 
Result 
 Approving the counted quantities in an inventory count form automatically updates the 
inventory balances in the system.
