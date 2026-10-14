# SOP Recording a Warehouse Transfer on the Basis of Orders

- **Source:** `SOP Recording a Warehouse Transfer on the Basis of Orders.pdf`

Cat.No. A8000242 1 Ver.1 – Jun.24,’08 
 
SOP: Recording a Warehouse Transfer  
on the Basis of Orders* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of recording a transfer between two company 
warehouses, for the purpose of supplying internal orders or sales orders. 
Procedure 
1. Enter the Warehouse Transfers form. 
2. Specify the Date. The document Number appears automatically, and the Status is 
"Draft". 
3. In the General tab, check the default Sending Warehouse and Bin. Revise as 
needed. 
4. Specify the desired Receiving Warehouse and Bin. 
5. Do  one of the following: 
• To link the transfer to a single order, click the References tab and select the order 
in the Order Number column. 
• To link the transfer to multiple orders, enter the Sales Orders for Shipment sub-
level form, and record the relevant orders. 
6. Enter the Transferred Items sub-level form. The form displays all of the items 
recorded in the order(s) linked to the document. 
7. Warehouse and bin details are filled in automatically for each part, according to the 
values recorded in the upper-level form. Revise as needed. 
8. Check the From Status and To Status values. Revise as needed. 
9. Specify the Quantity of parts that you want to transfer. 
10. In the upper-level form, change the document status to the next status defined in the 
BPM workflow, until the transfer is finalized. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. A8000242 2 Ver.1 – Jun.24,’08 
11. To make revisions to the document after it is final, select Reopen Document from 
the list of Direct Activations. The program will return the document's status to "Draft". 
After making the necessary revisions, move the document to the next status. 
12. To print the document, select Print Warehouse Transfer Doc. from the list of Direct 
Activations. 
Results 
• The balance in the sending warehouse and bin is reduced by the transferred 
quantity. 
• The balance in the receiving warehouse and bin is increased by the transferred 
quantity. 
• In the case of an internal order, the supply balance is updated automatically – order 
items that have been completely transferred are flagged in the Closed column, and 
when all items have been completely transferred, the Closed column is flagged in 
the upper-level form (taking into account the value of the ICloseOrder constant).
