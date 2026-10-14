# 15-17-WMS Shipping Tasks with Mobile Device

- **Source:** `15-17-WMS Shipping Tasks with Mobile Device.pdf`

www.priority -software.com   
1/2 Dec. 22, '14 Ver.02 Cat.No. LB110499 
 
SOP: Handling Shipping (SHP) Tasks Using  
a Mobile Device * 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To ship goods to the customer (a branch) based on packing slips, from the creation of the 
warehouse task (manually or using a mobile device), to the task reporting, to the creation of the 
relevant inventory document (Warehouse Transfer). 
Working Assumptions 
 The necessary setups have been performed for using the WMS module (see the relevant 
standard operating procedure). 
 For each customer, a packing slip has been defined as the target document to be created upon 
completion of a "Pick for Orders" (PIK) task (in the Target Doc per Task Type/Cust. form). 
Likewise, a warehouse transfer document has been defined as the target document to be 
created upon completion of a "Ship Packed Crates" (SHP) task (see the standard operating 
procedure for setting up WMS). 
 Packing slips were created by completed PIK tasks, and the inventory in these slips is located in 
the appropriate warehouse bin and zone (the loading deck). 
Procedure 
Stage I: Creating a Shipping Task 
Aim: To open a warehouse task for shipping packed crates (type SHP). 
Note: This stage is meant to simulate recording a task using a mobile device. 
1. Enter the Warehouse Tasks form. 
2. Specify the Warehouse from which the goods will be shipped to the customer. The Date and 
Warehouse Task No. columns are filled in automatically. 
3. In the Warehouse Task Type column, select the type SHP (shipping by crates). 
Note: The Storage Zone and Target Documt columns are filled in automatically with the 
loading zone in the selected warehouse and the target “Customer Shipment” document. 
4. Click the References tab and fill in the Customer to which the goods will be shipped. 
5. The task’s initial Status is "Draft". Update the Status to one that allows reporting (e.g., 
"Execute"). 
Stage II: Manually Reporting to an SHP Task 
Aim: To report completion of the task by warehouse personnel. 
                                                
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own 
operating procedures. As you will note, the following procedures are very specific and customers are strongly advised not 
to use them without prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 Dec. 22, '14 Ver.02 Cat.No. LB110499 
 
Note: This stage is relevant for warehouse personnel who do not use mobile devices for reporting. 
1. Enter the Warehouse Tasks form. 
2. Retrieve the task assigned to you with the “Execute” Status. 
3. If necessary, you can print the task by selecting Print Warehouse Tasks from the list of Direct 
Activations. 
4. Enter the Warehouse Task Items sub-level form. 
5. List each crate in a separate line, indicating the packing slip number in the Original Doc. 
Number column. In the Source Document Code column, select "PCR" (Packing Slip). 
6. Return to the upper-level form and change the task Status to “Fully Reported”. 
Result 
 The packed crates to be shipped have been reported, but inventory balances have not yet been 
updated in the system. 
Stage III: Preparing Documents 
Aim: To update inventory balances in the system, as a result of the task reported by warehouse 
personnel. 
Note: This stage is relevant for warehouse personnel who do not use mobile devices for reporting. 
1. Enter the Warehouse Tasks form. 
2. Retrieve the task assigned to you with the “Fully Reported” Status. 
3. Select Prepare Documents from the list of Direct Activations in order to transfer the goods and 
create a corresponding warehouse transfer document. 
Results 
 Inventory balances have been updated in the system, and a warehouse transfer document has 
been created, documenting the transfer of goods from the central warehouse to the branch 
warehouse. 
 The transfer document was generated based on the crates specified in the Warehouse Task 
Items form.
