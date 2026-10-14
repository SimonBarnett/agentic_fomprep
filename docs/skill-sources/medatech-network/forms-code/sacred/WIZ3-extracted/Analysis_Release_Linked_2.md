# Analysis_Release_Linked_2

- **Source:** `Analysis_Release_Linked_2.htm`

Lab Analysis: Recording a Release Based on a Receipt or Return.2 
 
 
- 
 
 
 
# To itemize the release document:

 

 1 .  Enter the Tested Items sub-level form. All line items in the designated document with a status that requires testing appear automatically. 
 

 2 .  Make sure that the Part Number and Lot/Work Order are correct. 
 

 3 .  The warehouse recorded in the upper-level form appears automatically for every line item, as both the warehouse in which parts were stored before testing ( From Warehouse ), and the warehouse to which parts are transferred after testing ( To Warehouse ). Revise them if necessary. 
 

 4 .  Do one of the following: 
 

 ·      If the quantity of parts receiving the new status is equal to the quantity of parts that required testing, flag the Approve column. The Balance to Test value will be copied automatically to the Quantity column. 
 

 ·      If the parts receiving the new status are packed in crates, designate the Crate Type Code and the number of crates. The tested Quantity will be calculated automatically, based on crate capacity. 
 

 ·      Manually record the quantity of parts receiving the new status in the Quantity column. 
 

 Note s : 
 

 ·      If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the tested quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the tested quantity. 
 

 ·      If you subsequently open a new release document linked to the same receiving document, the updated balance (less the quantity recorded here) will appear in the Balance to Test column. 
 

 5 .  In the Start Date column, specify the date from which to start calculating the expiration date of this lot/work order.
 Note: The expiration date is filled in automatically according to the shelf life defined for this part in the Inventory Parameters for Parts form. 
 

 6 .  To record serial numbers for this part, use the Serial Numbers in Transaction or Auto Recording of Serial Nos. sub-level form.
 Tip: For more information on working with serialized parts, run the Serial Numbers Wizard .
