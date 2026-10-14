# SOP Vendor Invoices

- **Source:** `SOP Vendor Invoices.pdf`

Cat.No. LB10000466 1 Ver.1 – Sep. 14,’10 
 
SOP: Vendor Invoices* 
Customer:  Company Inc. 
Assigned to: Dept./Position 
Aim 
 To produce a vendor invoice, manually or on the basis of a purchase order. 
Working Assumption 
 The billed items are not already recorded in a Goods Receiving Voucher (GRV). 
Procedure 
1. Enter the Vendor Invoices form and specify the following: 
 the Vendor Number 
 the Date recorded in the invoice sent by the vendor 
 the vendor's Invoice Number 
 the Warehouse into which the purchased goods were received (References 
tab). The default warehouse defined for vendor invoices appears automatically, 
but may be revised.  
2. By default, the journal entry's transaction date will be the invoice date. To change 
this, click the Payment Info tab and specify the desired Transaction Date. 
3. To base the invoice on one or more purchase orders: 
 Specify a single purchase order in the Order Number column (in the 
References tab). 
 Specify multiple orders in the Orders for Invoice sub-level form. 
4. In the Details column, record a brief remark pertaining to the invoice. 
5. Enter the Invoice Items sub-level form: 
 If the invoice is linked to one or more purchase orders, the purchased items 
appear automatically, and the Order Balance appears for each part. If the 
quantity received is equal to the order balance, flag the Approve column, and 
the balance will be copied to the Quantity column. 
 If no purchase orders are linked to the invoice, or you want to add items to the 
invoice, specify the Part Number, Quantity, Unit Price and % Item Discount 
for each part. The Warehouse into which the parts are received appears 
automatically (copied from the upper-level form), but may be revised. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their 
own requirements and work practices.

Cat.No. LB10000466 2 Ver.1 – Sep. 14,’10 
Note: You can record credit due from the vendor for returned parts by 
specifying negative quantities. Inventory of such parts will be reduced 
accordingly (see the operating procedures for receiving/returning goods and for 
multi-GRV invoices).  
6. You can review the Latest Part Purchases from Vend in the appropriate 
sub-level of the Invoice Items form. 
7. Enter the parallel Invoice/Memo - Remarks  sub-level form to add comments 
regarding the invoice, if desired. This text will appear in the printed invoice. 
8. If there are special payment terms for this invoice, enter the parallel Payment 
Installments sub-level form and define those terms. 
9. Return to the upper-level form. In the Price  tab, check the invoice totals and 
discounts. 
10. Finalize and/or print the invoice by selecting Finalize Invoice/Memo or Finalize 
& Print Invoice from the list of Direct Activations. If you choose the former 
option, select Print Vendor Invoice from the list of Direct Activations to print or 
view the invoice, or to send it via e-mail. 
Once the invoice is final: 
 The temporary Internal Invoice number is replaced by a permanent number 
(without the prefix T). 
 The invoice Status is changed to "Final". 
 A journal entry is recorded for the invoice. To view the itemized journal entry, 
click the magnifying glass icon in the Journal Entry No. column (in the 
References tab). 
11. To delete a pending invoice, set all item quantities to 0, then return to the upper-
level form and select Delete Pending Invoice/Memo from the list of Direct 
Activations.  
12. To cancel a final invoice for the original invoice date, select Cancel Document 
(Original Date) from the list of Direct Activations. To cancel a final invoice for a 
designated date, select Cancel Document For Date from the list of Direct 
Activations (indicating the date in question). 
Results 
 The warehouse inventory is increased by the received quantities. 
 If the invoice is linked to one or more purchase orders, the order balance of each 
purchased part is reduced automatically in the relevant order.  
 If the entire balance has been received, the purchase order item is automatically 
flagged as Closed. 
 If the entire balance of all parts in a purchase order has been received, the order 
is automatically flagged as Closed. 
 A journal entry is created for the invoice. 
 The Last Price column in the Part Catalogue is updated automatically for each 
part according to the unit price recorded in the invoice. 
Follow-up 
See the operating procedures for Payments to Vendors.
