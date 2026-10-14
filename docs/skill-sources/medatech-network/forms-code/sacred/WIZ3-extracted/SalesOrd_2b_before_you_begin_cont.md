# SalesOrd_2b_before_you_begin_cont

- **Source:** `SalesOrd_2b_before_you_begin_cont.htm`

Sales Orders - Setup: Set Text 
 
 
- 
 
 
 
# Assigning Set Text to Orders

 

Create set text so that certain remarks always appear in the printouts of sales orders. You can later change or delete this text for each specific order. 
 
## To assign set text:

 

 1 .  Enter the Set Text for Sales Orders form. 
 

 2 .  Record the desired text in the Set Text for Sales Orders sub-level form.
 D ual-currency users: If you are working in a language other than English, and wish to print out order confirmations in English, record set text in the Set Text for Sales Orders-Lang 2 sub-level form. Any orders opened for customers defined as receiving Printouts in Lang 2 will contain set text in English. 
 
## Notes:

 

 ·        If no set text is defined, any new sales order will “inherit” the remarks recorded for the customer (in the Customer - Remarks sub-level of the Customers form). 
 

 ·        When an order is copied from a price quotation, the quote's remarks may overwrite the set text for orders (depending on the value of the SCpyQuoteTxt constant), yet may be revised.
