# SOP Warehouse Assemblies

- **Source:** `SOP Warehouse Assemblies.pdf`

Cat.No. A8000199 1 Ver.2 – Jun.29,’08 
 
SOP: Warehouse Assemblies* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
This document describes the process of reporting warehouse assemblies. Assembly 
reports increase the inventory balance of the parent part, and reduce the balance of the 
child parts included in the parent part's bill of materials. 
Required Setups 
• Enter the Part Catalogue form and make sure that the parent part, child parts and 
work hour parts are correctly defined. 
• Enter the Inv. Transaction Documents form, move to the Assembly Report line and 
make sure that a default assembly warehouse has been defined. 
• Make sure that a default issues warehouse has been defined (either general or per 
child part, as defined in the IPartWarhsAs constant). 
Procedure 
Stage I: Preparing an Assembly Plan 
1. Enter the Warehouse Assemblies form. 
2. Specify the Date. This represents the date by which the assembly will be recorded in 
the system. Revise it later to the actual assembly date. 
3. The Warehouse and Bin columns are filled in automatically according to the defined 
defaults. Revise as needed. 
4. Enter the Assembly Reporting sub-level form. 
5. Record the Part Number of the parent part to be assembled. 
6. Specify the quantity of assembled parts in the Required Qty column. 
7. The Auto. Record Child column is flagged by default. This will record the issuing of 
child parts as defined in the BOM. Remove the check mark to report an assembly that 
was not performed according to the BOM. 
8. Enter the Assembly Components sub-level of Assembly Reporting. 
9. Do one of the following: 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

Cat.No. A8000199 2 Ver.2 – Jun.29,’08 
• If you left the Auto. Record Child column flagged, make sure that all the required 
child parts appear, and that their details (e.g. Warehouse, Bin, Required 
Quantity, Warehouse Balance) are correct. Revise as necessary. 
• Otherwise, record the child parts manually. 
10. Return to the Warehouse Assemblies upper-level form. 
11. Change the Assembly Status (in the General tab) to Active. 
12. To print the assembly document, click Print Report of Assembly  from the list of 
Direct Activations. 
Stage II: Reporting Part Issues for Assemblies 
1. Enter the Warehouse Assemblies form. and retrieve the desired assembly document 
2. If the recorded Date  differs from the date the assembly was actually performed, 
change it accordingly. 
3. Enter the Assembly Reporting sub-level form. 
4. For each line, specify the actual quantity assembled in the Assembled Qty column. 
5. Enter the Assembly Components sub-level of the Assembly Reporting form. 
6. The quantity of each issued child part appears in the Quantity Assembled column, 
as defined either in the BOM or manually. Revise as needed according to the 
production manager's printed report. Make sure the warehouse details are correct. 
Stage III: Reporting Labor for Assemblies 
1. Enter the Reported Hours sub-level of the Assembly Reporting form. 
2. Specify the Date the assembly was performed. Your name appears automatically in 
the Employee column. If you are reporting for another employee, revise the column 
accordingly. 
3. The default Part Number for work hours appears automatically. If no default was 
defined, specify the relevant work hour part. 
4. Use either the From Hour  and To Hour columns or the Total Hours column to 
record the work hours required for the current assembly. 
Stage IV: Completing the Report 
1. Return to the upper-level Warehouse Assemblies form. 
2. Change the Assembly Status to the next status defined in the BPM workflow (e.g., 
Completed). 
Note: You cannot make changes to a final assembly document. If you need to change 
the document, click Reopen Document from the list of Direct Activations. 
Results 
• The inventory balance of each child part in the designated warehouse and bin is 
reduced by the issued quantity. 
• The balance of assembled parent parts in the designated warehouse and bin is 
increased by the assembled quantity.
