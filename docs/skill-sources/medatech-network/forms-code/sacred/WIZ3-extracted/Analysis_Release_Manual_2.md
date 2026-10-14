# Analysis_Release_Manual_2

- **Source:** `Analysis_Release_Manual_2.htm`

Lab Analysis: Recording a Release Document Manually.2 
 
 
- 
 
 
 
# To itemize the release document:

 

 1 .  Enter the Tested Items sub-level form. 
 

 2 .  Specify the Part Number and Lot/Work Order of the part to be tested. 
 

 3 .  Specify the part's pre-test status in the From Status column. 
 

 4 .  The warehouse recorded in the upper-level form appears automatically for every line item, as both the warehouse in which parts were stored before testing ( From Warehouse ), and the warehouse to which parts are transferred after testing ( To Warehouse ). Revise them if necessary. 
 

 5 .  Specify the Quantity of parts receiving the new status, or the number of Packing Crates together with their Crate Type Code .
 Note: If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the tested quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the tested quantity. 
 

 6 .  In the Start Date column, specify the date from which to start calculating the expiration date of this lot/work order.
 Note: The expiration date is filled in automatically according to the shelf life period defined for this part in the Inventory Parameters for Parts form. 
 

 7 .  To record serial numbers for this part, use the Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form.
 Tip : For more information about serial numbers, run the Serial Numbers Wizard . 
 

 8 .  Enter the Analysis Results sub-level of Tested Items . The laboratory tests required for the current part appear automatically. Revise any of the test details, delete existing tests or add new ones. These changes are only valid for the current document.
