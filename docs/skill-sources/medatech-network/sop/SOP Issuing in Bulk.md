# SOP Issuing in Bulk

- **Source:** `SOP Issuing in Bulk.pdf`

Cat.No.A8000091 1 Ver.1 – Oct.19,’08 
 
SOP: Issuing in Bulk* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of issuing materials to the plant floor in bulk, that 
is, issuing raw materials required by all open and released work orders on the plant floor. 
This method is usually employed for parts that are transferred in large quantities to the 
plant floor and used by various work orders. These parts are not issued to a specific 
work order, and are taken from the inventory in the plant floor warehouse. 
Parts that are defined for bulk issue are automatically deducted from the plant floor 
warehouse when production is reported for a work order. 
Working Assumption 
• At least one work order has been opened and released, which requires one or more 
raw materials defined for bulk issue (see Setups below). 
Setups 
• Define the value of the IFloorInv  constant in the Logistic Constants form. It is 
recommended to set the constant to 2. 
• Define parts for bulk issue: 
• Enter the Parts form. 
• Retrieve the desired material for bulk issue. 
• Click the Additional Details tab and make sure the Kit Component and Manual 
Issue columns are not flagged. 
Result: The part will be transferred to the plant floor in bulk and deducted automatically 
for a given work order when production is reported. 
Procedure 
Bulk issues transfer parts to the plant floor to be used in released work orders. There are 
two ways to issue parts in bulk to the floor: 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

• By recording a warehouse transfer to the plant floor warehouse (see the appropriate 
Standard Operating Procedure), in which the parts to be transferred and their 
quantities are recorded manually. 
• By running a program that prepares issues to the plant floor. 
Stage I: Preparing Issues to the Plant Floor 
When data are properly defined (see Setups above), the following program will calculate 
required issues for the plant floor. 
1. Run the Prepare Issues to Floor Stock program. 
• Specify the date until which to calculate required issues. The system will calculate 
them for work orders whose production start dates precede the designated date. 
• Specify the plant floor warehouse for which to calculate required issues. 
Tip: To calculate issues for all plant floor warehouses, use an asterisk (*). 
2. When the program is completed, if there is a need for issues to the plant floor, the 
system notifies you that an issues document has been opened and displays its 
number. Make a note of the document number. 
Stage II: Viewing and Revising the Prepared Issues 
1. Enter the Issues to Floor Stock form. 
2. Retrieve the issues document that you want to revise. 
Tip: You can retrieve according to the number of the document opened by the 
Prepare Issues to Floor Stock program, or according to the date the document was 
opened. 
3. Enter the Issued Items sub-level form. This form displays the issues calculated by 
the system. 
4. For each line, check the following details: 
• The Date Needed and the Part Number. 
• The From Warehouse, from which the parts will be transferred to the plant floor, 
and the To Warehouse, which is the plant floor warehouse to which the parts will 
be transferred. Revise as needed. 
• The Issue Balance – the quantity to be issued, as calculated by the program. 
• The Warehouse Balance – the available quantity of parts in the sending 
warehouse.  
5. Do one of the following: 
• Flag the Approve column to copy the issue balance into the Quantity column. 
• If the quantity to be issued differs from the issue balance (for example, if there is 
insufficient inventory in the sending warehouse), record it manually in the Quantity 
column. The issue balance will be updated accordingly. 
Cat.No.A8000091 2 Ver.1 – Oct.19,’08

Cat.No.A8000091 3 Ver.1 – Oct.19,’08 
Results 
• The parts for which a quantity has been recorded will be transferred to the plant 
floor warehouse specified in each line. These parts will be reduced automatically 
from the plant floor inventory when production is reported for a work order. 
• The parts for which no quantity has been recorded will be deleted from the 
document. The next time you run the Prepare Issues to Floor Stock program, 
they will be included in the new issues document, if needed. 
Stage III: Calculating Plant Floor Inventory (Backflush) 
The Backflush program displays warnings in the case of missing issues (e.g., due to 
insufficient inventory in the plant floor warehouse). 
1. Run the Backflush program, choosing the From Last Past Bal. option.  
2. Enter the Missing Issues form and retrieve data by means of the Parent's Prod 
Report column, specifying the production report dates for which you want to check 
missing issues. 
Tip: Retrieve by all dates earlier than the one on which the Backflush was last run.  
3. The form displays child part inventory that the program did not succeed in reducing 
from the plant floor warehouse due to insufficient inventory quantities. To resolve the 
problem, open a warehouse transfer to the plant floor warehouse for the missing 
parts. Inventory balances will be updated accordingly the next time Backflush is run.  
Important: It is recommended that you run Backflush automatically (via the Tabula Task 
Scheduler), on a daily basis, as well as manually once a week. 
Results 
• Child part inventory is reduced from the plant floor warehouse, according to the 
BOMs of the manufactured work orders and the production reports recorded for 
them. 
• Any child parts that could not be deducted from inventory will have a record in the 
Missing Issues form, indicating that further treatment is necessary.
