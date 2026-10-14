# SOP Handling Goods Receiving RCV Tasks Using a Mobile Device

- **Source:** `SOP Handling Goods Receiving RCV Tasks Using a Mobile Device.pdf`

Cat.No. LB110465 1 Ver.1 – Aug. 8, '11 
 
SOP: Handling Goods Receiving (RCV) Tasks 
Using a Mobile Device * 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
 To record the receipt of inventory to the warehouse, from the creation of an un-
itemized GRV with the "Draft" status, to creation of an RCV warehouse task and task 
reporting using a mobile device, to creation of the relevant inventory document 
(Warehouse Transfer) and itemizing the GRV with the received goods. 
Working Assumptions 
 The necessary setups have been performed for the WMS module (see the relevant 
standard operating procedure). 
 A Status has been defined which is assigned automatically to inventory documents 
prepared upon completion of transfer tasks (in the Document Types per Task Type 
form, a sub-level of Warehouse Task Types). Otherwise, the default initial status is 
assigned to these documents. 
 Pallet types have been defined and assigned numeration templates in the Pallet 
Types form. 
 A GRV with the "Draft" status has been recorded for a purchase order that has not 
yet been fully supplied and received quantities have not yet been reported. 
Note: You can open the GRV directly from your mobile device rather than in 
Priority, indicating the relevant vendor number, vendor document number, purchase 
order number (optional), and receiving warehouse and storage zone.  
 The "Draft" status is flagged in the Update by Target Doc  column (in the Statuses for 
GRVs form). 
Procedure 
Stage I: Creating a Warehouse Task Manually 
Note: This stage is meant to simulate recording a task using a mobile device. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

1. Enter the Warehouse Tasks form. 
2. Specify the Warehouse to which goods will be received. The Date and Warehouse 
Task No. are filled in automatically. 
3. In the Warehouse Task Type column, select the type RCV (Receive Goods). The 
Target Doc. Code (in the General tab) is filled in automatically. 
4. Indicate the Storage Zone to which goods will be received. 
Note: The designated storage zone determines which bins can be defined for the 
itemized task. 
5. If the received goods are being palleted, specify the desired Pallet Type Code. A 
pallet number is generated automatically, based on the template defined for the 
designated pallet type (in the Pallet Number Templates form). 
6. Click the  References tab. In the Source Document column, designate the code 
representing a "Receipt of Goods" document and specify the number of the relevant 
source document. 
7. Click the  Scheduling tab and designate the warehouse employee to whom the task 
is assigned. 
8. The task’s initial Status is "Draft". Update the Status to one that allows reporting 
(e.g., "Execute"). 
Stage II: Manually Reporting to an RCV Task 
Aim: To report performance of a goods receiving (RCV) task. 
Note: This stage is relevant for warehouse personnel who do not use mobile devices for 
reporting. 
1. Enter the Warehouse Tasks form. 
2. Retrieve the task assigned to you with the "Execute" Status. 
3. If necessary, you can print the task by selecting Print Warehouse Tasks from the 
list of Direct Activations. 
4. Enter the Warehouse Task Items sub-level form. 
5. Report each received part in a separate line. Include the following information: the 
Part Number, the Actual Qty being received, the source and target warehouse(s) 
and bins (in the From Warehouse, From Bin, To Warehouse, and To Bin columns) 
and the Pallet (where relevant). 
6. When you have finished reporting for all parts, return to the upper-level form and 
change the task Status to “Fully Reported”. 
Result 
 
The receipt of goods has been reported, but inventory balances have not yet been 
updated in the system. 
Stage III: Preparing a Warehouse Transfer Document 
Aim: To update inventory balances in the system, as a result of the task reported by 
warehouse personnel. 
Cat.No. LB110465 2 Ver.1 – Aug. 8, '11

Cat.No. LB110465 3 Ver.1 – Aug. 8, '11 
Note: This stage is relevant for warehouse personnel who do not use mobile devices for 
reporting. 
1. Enter the Warehouse Tasks form. 
2. Retrieve the task assigned to you with the “Fully Reported” Status. 
3. Select Prepare Documents from the list of Direct Activations in order to create a 
warehouse transfer document. 
Note: The transfer document will be finalized if a final status was defined for inventory 
documents prepared upon completion of a transfer task (in the Document Types per 
Task Type sub-level of the Warehouse Task Types form). Otherwise, see the relevant 
standard operating procedure for further instructions on handling this document. 
Results 
 
Inventory balances have been updated in the system, and a warehouse transfer 
document has been created, recording the transfer of goods from the unloading deck 
to the specified target storage zone, as well as the palleting of the received goods, 
where relevant. 
 The GRV linked to this warehouse transfer document has been updated with the 
received goods reported for this task. 
Process Summary 
As a result of the reported RCV tasks, inventory of palleted or non-palleted goods has 
been received and transferred to the specified target warehouse and bin, based on 
actual task reports.
