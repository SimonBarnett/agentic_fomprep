# 12-17-Issue to Kit

- **Source:** `12-17-Issue to Kit.pdf`

www.priority -software.com   
1/2 ‏Feb. 03, '15 Ver.02 Cat.No. A8000066 
 
 SOP: Issuing to Kit 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aim 
Issuing a child part to a work order kit list dedicates the entire quantity of parts exclusively to that work 
order. That is, no other work order can use the issued inventory. 
Working Assumptions 
 The child parts to be issued can be counted and measured. 
 The correct issue method has been defined for all child parts (see the Standard Operating Procedure for 
factory modeling). This should be checked before releasing any given work order. 
 The parts are always issued from a regular (Type D) warehouse to a floor (Type F) warehouse. 
Setup 
 Define child parts as issued to kits: Enter the Parts form and make sure each part to be issued is flagged 
in the Kit Component column (in the Additional Details tab). 
Procedure 
Stage I: Releasing the Work Order 
Kit issues are always made to work orders. On how to open work orders, see the relevant Standard 
Operating Procedure. 
1. Enter the Work Orders form and retrieve the desired work order. 
2. Make sure the Release column is flagged (in the Details tab). 
Stage II: Issuing to the Work Order Kit 
1. Enter the Issues to Kits sub-level form. The form displays all child parts defined in the work order kit list, 
together with their issue balance. 
2. Record the issue quantity in the Quantity column. Or flag the Approve column to copy the entire Issue 
Balance into the Quantity column. 
                                                 
 Standard Operating Procedures should be used as guidelines for customers (and their consultants) to develop their own operating 
procedures. As you will note, the following procedures are very specific and customers are strongly advised not to use them without 
prior testing to make sure that they fit their own requirements and work practices.

www.priority -software.com   
2/2 ‏Feb. 03, '15 Ver.02 Cat.No. A8000066 
 
Stage III: Issue Reports 
 Run the Kit List for Work Order report to view the kit list defined for specific work orders (including the 
operation in which each child part enters the parent part), as well as the remaining balance of child parts 
to issue. 
 Run the Pick List for Kits report to view the remaining balance of child parts to issue, together with their 
available inventory. 
 Run the Issues Needed per Work Order report to view the remaining balance of child parts to issue, 
without reference to their available inventory. 
Results 
 The issue to the kit reduces child parts from inventory in the materials warehouse and enters them into 
inventory on the plant floor. 
 The materials (kit components) on the plant floor are specifically allocated to the work order to which 
they were issued, and their inventory will be backflushed to that work order once production is 
reported.
