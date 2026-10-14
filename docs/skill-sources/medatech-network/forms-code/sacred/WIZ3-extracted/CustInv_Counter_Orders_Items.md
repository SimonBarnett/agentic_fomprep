# CustInv_Counter_Orders_Items

- **Source:** `CustInv_Counter_Orders_Items.htm`

Customer Invoices - Recording an Over-the-Counter Invoice Based on a Sales Order.3 
 
 
- 
 
 
 
# To itemize the invoice:

 

 1 .  Enter the Invoice Items sub-level form. The ordered parts are filled in automatically according to the sales order linked to the invoice. 
 

 2 .  Status , Work Order , Warehouse and Bin are filled in automatically. Make sure they are correct.
 Note: If the SOnlyOneLine constant is set to zero, one order item may be split into multiple lines (one for each status, work order and bin). 
 

 3 .  The system displays the Balance to Ship (the order balance less any goods already supplied to this customer) and the Warehouse Balance (the balance of this part for the designated status, work order, warehouse and bin). Do one of the following: 
 

 ·              If the quantity of the part being supplied is equal to one of these values (whichever is smaller), flag the Approve column. The quantity will be filled in automatically. 
 

 ·              If you are supplying packed goods, designate the Crate Type Code and the number of crates. The quantity will be calculated automatically, based on crate capacity. 
 

 ·              Otherwise, specify the supplied quantity manually in the Quantity column. 
 
## Notes: 

 

 ·        If you are allowed to record partially packed crates (i.e., the IPartialPack constant is set to 1 in the Logistic Constants form), you can designate the number and type of packing crates and then revise the shipped quantity accordingly. Once you do, however, any revision to the number or type of packing crates will have no effect on the shipped quantity. 
 

 ·        Make sure you do not exceed order tolerance . 
 

 ·        Leave a quantity of 0 for any ordered items which are not being supplied to the customer. These lines will be deleted automatically when the invoice is finalized. 
 

 ·        Click for more information on shipped quantities and their effect on inventory .
