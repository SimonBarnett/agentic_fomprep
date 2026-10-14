# SOP Assembly Tasks

- **Source:** `SOP Assembly Tasks.pdf`

Cat.No. LB110487 1 Ver.1 – Aug. 7,’11 
 
SOP: Assembly Tasks* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aim 
 To report assembly tasks in order to add to the inventory of the parent part and 
subtract from the inventory of child parts in the BOM, from the creation of an 
assembly document, to the manual creation of a warehouse task, to task 
reporting, and to updating the relevant inventory document (assembly document). 
Working Assumptions 
 The necessary setups have been performed for the WMS module (see the 
relevant standard operating procedure). 
 A status has been defined for documents that are prepared automatically upon 
completion of an ASM task (in the Document Types per Task Type form, a sub-
level of Warehouse Task Types). Otherwise, the default initial status is assigned 
to these documents. 
 All parent and child parts have been defined in the Part Catalogue form. 
 A default warehouse has been assigned to the assembly warehouse in the Inv. 
Transaction Documents form (document code = ASM). 
Procedure 
Stage I: Creating an Assembly Document 
Aim: To open an assembly document. 
1. Enter the Warehouse Assembly form. 
2. The Date column indicates the date for which the assembly will be recorded. 
Revise this to match the actual date of assembly. 
3. The Warehouse and Bin are filled in automatically with default values. Revise as 
necessary to the relevant bin and assembly warehouse. 
Stage II: Creating an Assembly Task 
Aim: To open a warehouse task for an assembly (ASM) task. 
Note: This stage is relevant for warehouse personnel who do not use mobile devices 
for reporting. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

1. Enter the Warehouse Tasks form. 
2. Record the following details: 
 Warehouse: Select the warehouse where the assembly is being performed. 
The Date, Status and Warehouse Task No. columns are filled in 
automatically. 
 Warehouse Task Type: Select type “ASM” (assembly). The Target Documt 
column is filled in automatically. 
3. Click the  References tab and fill in the assembly document number in the 
Original Document column. The To Warehouse and To Storage Zone columns 
are filled in automatically (based on the assembly document definitions). 
4. Move to the Warehouse Task Items sub-level form and specify the Part 
Number and Planned Qty to be assembled. 
5. Return to the upper-level form and change the task Status to “Execute”. 
Stage III: Manually Reporting to an ASM Task 
Aim: To report completion of the task by warehouse personnel. 
Note: This stage is relevant for warehouse personnel who do not use mobile devices 
for reporting. 
1. Enter the Warehouse Tasks form. 
2. Retrieve the task assigned to you with the “Execute” Status. 
3. If necessary, you can print the task by selecting Print Warehouse Tasks from 
the list of Direct Activations. 
4. Enter the Warehouse Task Items sub-level form. 
5. Record the assembled quantity in the Actual Qty column. 
6. Return to the upper-level form and change the task Status to “Fully Reported”. 
Result 
 
The assembled parent parts have been reported, but inventory balances have not 
yet been updated in the system. 
Stage IV: Preparing Documents 
Aim: To update inventory balances in the system, as a result of the task reported by 
warehouse personnel. 
Note: This stage is relevant for warehouse personnel who do not use mobile devices 
for reporting. 
1. Enter the Warehouse Tasks form. 
2. Retrieve the task assigned to you with the “Fully Reported” Status. 
3. Select Prepare Documents from the list of Direct Activations in order to update 
the assembly document. 
Note: The assembly document will be finalized if a final status was defined for 
inventory documents prepared upon completion of an ASM task (in the Document 
Types per Task Type sub-level of the Warehouse Task Types form). Otherwise, see 
the relevant standard operating procedure for further instructions on handling this 
document. 
Cat.No. LB110487 2 Ver.1 – Aug. 7,’11

Cat.No. LB110487 3 Ver.1 – Aug. 7,’11 
Results 
 The assembly document has been updated with the actual quantity reported in 
the Warehouse Tasks form. 
 Inventory balances have been updated in the system.
