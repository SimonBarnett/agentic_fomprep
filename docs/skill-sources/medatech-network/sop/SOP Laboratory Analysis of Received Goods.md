# SOP Laboratory Analysis of Received Goods

- **Source:** `SOP Laboratory Analysis of Received Goods.pdf`

Cat.No. LB10000166 1 Ver.1 – June 7,’10 
 
SOP: Laboratory Analysis of Received Goods* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Procedure Summary 
When certain parts are received from a vendor, they are assigned a default status that 
indicates that they cannot be used or sold. At this point, laboratory tests are performed in 
order to determine the quality of these goods. If the goods receive acceptable test 
results, they are transferred to the appropriate warehouse and can be used. If goods are 
rejected, they are set aside for disposal or returned to the vendor. 
Setups 
 In the Defect Codes form, record a code and description for each possible cause of 
rejection. 
 In the Inventory Statuses form, make sure the "Hold" status is flagged in the 
Laboratory Testing column and make sure that the For Sale and Issue to Floor 
columns are not flagged for this status. 
 For each part that requires testing before use, make sure that the default Entry 
Status is defined as "Hold" (in the Inventory Parameters for Parts form). Whenever 
receipt of this part is recorded, it will automatically receive this status. 
 In the Inv. Transaction Documents form, make sure a default warehouse is defined 
for testing (on the Lab Release line). 
 To define required laboratory tests for a specific part, retrieve the part in question in 
the Part Catalogue form and enter the Required Analyses sub-level form. 
Procedure 
Aim: To monitor the quality control of goods that are received into inventory with the 
"Hold" status. When the parts are released from laboratory testing, new statuses will be 
assigned to the tested goods (e.g., Goods, Reject). 
1. Enter the Laboratory Release form.  
2. Specify the Date testing was done. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

3. In the Document Type column (in the General tab), select the code representing the 
type of document on which the laboratory release is based (e.g., GRV). 
4. Specify the relevant document number in the Receiving Document column. The 
warehouse recorded in the original document is filled in automatically in the 
Warehouse column. 
5. Enter the Tested Items sub-level form. All line items in the designated document 
with a status that requires testing (i.e., "Hold") appear automatically. 
6. Make sure that the status of the part prior to testing (i.e., "Hold") appears in the  From 
Status column. 
7. Enter the Analysis Results sub-level of the Tested Items form. The laboratory tests 
required for the current part appear automatically. 
8. For each test, specify the result in the Result column. The Acceptable or 
Unacceptable column is flagged automatically, based on lab test definitions. 
9. Return to the Tested Items  form. 
10. For parts that are acceptable: 
 The "Goods" status is assigned to the released part in the Status column. Record 
the tested quantity in the Quantity column or designate a Packing Crate Code 
and the number of crates. 
 The warehouse recorded in the upper-level form appears automatically as both the 
warehouse in which parts were stored before testing (From Warehouse), and the 
warehouse to which parts are transferred after testing (To Warehouse). Revise 
them if necessary. 
11. For parts that are rejected: 
 Record the new Status of the part (i.e., "Reject"). 
 Record the tested quantity in the Quantity column or designate a Packing Crate 
Code and the number of crates. 
 Specify the appropriate  Defect Code (based on values defined in the Defect 
Codes form).  
 The warehouse recorded in the upper-level form appears automatically as both the 
warehouse in which parts were stored before testing (From Warehouse), and the 
warehouse to which parts are transferred after testing (To Warehouse). Revise 
the To Warehouse to a designated "Rejected Goods" warehouse. 
12. To record remarks pertaining to the current document, enter the parallel Remarks 
sub-level form. 
13. Return to the upper-level form and assign the document the final Status. 
14. To print the document, select Print Laboratory Release Doc. from the list of Direct 
Activations. 
Note: A single release document can contain one line for parts that are released from 
testing with the Goods status and another line for parts that are released with the Reject 
or MRB status. 
Cat.No. LB10000166 2 Ver.1 – June 7,’10

Cat.No. LB10000166 3 Ver.1 – June 7,’10 
Result 
 After recording the release of parts from laboratory testing, the recorded quantity of 
tested parts with the Goods status has been added to the part's inventory balance in 
the specified warehouse and parts with the Reject status have been transferred to 
the "Rejected Goods" warehouse.
