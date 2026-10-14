# Receipt Return of Goods Script

- **Source:** `Receipt Return of Goods Script.pdf`

Receipt/Return of Goods Script 
Clip Link: http://www.eshbel.com/Movie_Search/receipt_return_of_goods.htm 
Note: Yellow highlights indicate action instructions.  
Introduction (00:00-01:10) 
Priority offers several different options for recording the receipt of goods from 
vendors or the return of goods to a vendor. You can: 
 Record a vendor invoice, which triggers both an inventory transaction and a 
corresponding journal entry for the shipment/return. Use negative quantities to 
indicate returned items. 
 Record a Goods Receiving Voucher (G RV), which triggers an inventory 
transaction, but does not generate a journal entry for the shipment. Here, too, 
you can use negative quantities to indicate returned items. Items recorded in 
this document can then be linked to the corresponding financial document 
and/or budget item. 
 Record a return document, which triggers an inventory transaction, but does 
not generate a corresponding journal entry. Items recorded in this document 
can then be linked to the corresponding financial document and/or budget 
item. 
In this video, we're going to demonstrate how to work with a GRV to record the 
receipt of goods and how to open a return document for received items that are 
subsequently returned. Detailed information on working with vendor invoices is 
available elsewhere. 
Recording a GRV Based on a Purchase Order (01:11-04:12) 
As with many other documents, Pr
iority enables you to link each GRV or vendor 
return document to a related document, such as a purchase order. This serves a 
dual function: firstly, it enables you to easily move back and forth between related 
documents, ensuring a transparent view of the purchase process, from the purchase 
requisition to the receipt of ordered goods and subsequent invoicing. Secondly, this 
feature enables you to automatically itemize each document recorded during the 
purchase process on the basis of the previous one. This can save your staff valuable 
time and reduce errors associated with manual data entry. 
Let's go ahead and demonstrate how to record a GRV for purchased items, based 
on an existing purchase order. To do so, we'll open the Goods Receiving Voucher 
form from the Purchase Inventory Transactions menu and select the vendor that 
supplied the goods. Today's Date is filled in automatically and the GRV is assigned a 
unique Document Number. Note that the document is initially Assigned To you and 
receives the default initial Status, but either of these values may be revised at any 
time. The Receiving Warehouse and Bin are also filled in automatically based on 
default definitions, but may be revised.At this stage, it's a good idea to record the 
Cat.No. LB130469  Ver.1 – Oct 24,’13 1

receiving document's reference number in the Vendor's Doc. column; this is 
generally the number of the vendor's shipping document or invoice. 
Next, we're going to link the GRV to the desired purchase order items. Before you 
begin, you can choose whether the GRV is to be itemized with all ordered items, or 
only with those that are due by a particular date. Specifically, if a due date is 
indicated in the To Due Date column, only those order items that are due on or prior 
to this date will be copied automatically into the GRV when you link it to a purchase 
order, as we are about to do. 
We're now ready to indicate one or more purchase orders that are supplied by this 
GRV, either in full or in part. If all of the received items appear in a single purchase 
order, simply choose that order from a list of open purchase orders recorded for the 
current vendor. You can also use the Purchase Orders for GRV sub-level form to 
link the GRV to multiple purchase orders; hold down the Ctrl key to make multiple 
selections. Alternatively, you can select individual items from one or more purchase 
orders in the parallel Choose Order Items sub-level form, by flagging the Choose 
Item column. The lists of orders and items available for selection in these two sub-
level forms are populated with all open, authorized purchase orders from the 
designated vendor that are intended for the designated receiving warehouse. 
Linking a GRV to Other Types of Documents (04:13-05:29) 
Before moving on, let's take a mo
ment to highlight some of the other columns in the 
References tab, which can be used to link the GRV to other relevant documents. 
For instance, the GRV for Cancellation column enables you to indicate that the 
current document cancels out a previous GRV that has already been finalized. The 
Vendor Invoice and Internal Invoice columns can be used to link the GRV to an 
existing invoice, in the event that you have already been billed for the received 
goods. When such a GRV is finalized, it is automatically flagged as billed. The 
Shipmt to Subcontr column is used in organizations that subcontract part of the 
production process, in order to link processed goods that are received from the 
subcontractor to the earlier document recording their shipment. Finally, the Vendor 
Return Doc. column enables you to record the receipt of new or repaired parts, 
following the return of one or more defective items in a previous vendor return 
document. When any of these columns are used to link a GRV to an existing 
document, the GRV is itemized accordingly. Additional information pertaining to each 
of these columns is provided in the column help, which is accessed by pressing F1 
from the relevant form column. 
Recording Pricing and Shipment Details (05:30-06:00) 
Moving next to the Price tab, flag the GRV as Billable, indicating that the vendor 
has not yet billed you for the goods in this shipment. Note that the vendor's default 
Currency is filled in automatically; however, this can be revised if necessary. 
Finally, click the Shipment tab and indicate the relevant shipping method and 
shipper. You can also link the shipment to a specific project if necessary, in the 
Project tab. 
Reviewing Received Items (06:01-07:27) 
Let's enter the Received Items sub-level form next, in order to review the received 
parts and their details. This form has been filled in automatically with all open items 
Cat.No. LB130469  Ver.1 – Oct 24,’13 2

in the purchase orders that we linked to the GRV. The Balance to Receive column 
displays the balance of ordered parts that have yet to be received, excluding the 
current receipt. If this balance accurately reflects the received quantity, flag the 
Approve column. As you can see, the Quantity column has now been filled in 
accordingly. Once the entire ordered quantity is supplied, the corresponding order 
item will be closed automatically. Note that you can also define order tolerance levels 
for specific parts in the Inventory Parameters for Parts form, so that order items 
will be closed even if a relatively small percentage of the order, say 5%, has not 
actually been shipped or received.  
If only a portion of the balance has been received, specify the received Quantity 
manually. Alternatively, if you are receiving packed goods, you can indicate the type 
of packing crate and the number of crates received in the provided columns. The 
received Quantity will be calculated automatically, based on the crate capacity. If 
one or more order items were copied into the GRV but were not received in the 
current shipment, simply leave the Quantity as "0"; these lines will be deleted 
automatically once the GRV is final.  
Linking Received Items to a Lot or Work Order (07:28-08:33) 
Note that the system also enables you to re
ceive goods into inventory as numbered 
lots, by means of the Internal Lot/Wk Ord column. If your company maintains 
internal lot numbers for inventory -- for instance, as part of the production process -- 
you can determine ahead of time whether the system will automatically copy the 
Vendor Lot Number into this column, assign a lot number automatically using a 
predefined template, or simply leave this column blank. You can also open the Raw 
Material Lots form directly from this form if necessary, in order to view any existing 
lots recorded for the current part.  
Alternatively, when you receive processed goods from a subcontractor, you can use 
the Internal Lot/Wk Ord column to link received goods to the work order for which 
they are intended. 
The adjacent columns can then be used to indicate the date when the designated lot 
or work order was opened as well as the date on which it expires. If a shelf life is 
defined for the current part, an expiration date will be filled in automatically, based on 
the lot's start date. 
Billing Information (08:34-10:04) 
Nex
t, let's turn our attention to the Order and Ln columns. These display the number 
of the purchase order being filled by this shipment and the line in that order in which 
each received part appears. Since the company is being billed for the entire 
shipment, we also need to make sure all received items are flagged as Billable. 
Each received item can also be linked to a Budget Item and a Profit/Cost Center if 
applicable. Both columns are filled in automatically from the purchase order, but may 
be revised. Note that Priority automatically traces charges to the budget through the 
entire chain of purchasing transactions, even if the document recorded at a particular 
stage is not a financial document, such as in the case of a purchase order or, in the 
current example, a GRV. The system "rolls" charges from one stage to the next 
(requisition to order, order to receipt and so on) as each transaction is recorded, 
ensuring that the budget is charged once -- and only once -- for a given item. This 
Cat.No. LB130469  Ver.1 – Oct 24,’13 3

functionality ensures that you can accurately compare budget appropriations with 
actual expenses/income through the entire chain of purchasing transactions. 
The Unit Price and Item Discount are also filled in automatically from the purchase 
order. Either or both of these values can be revised if necessary. Note that the Price 
Source appears in the corresponding column, as does the total Extended Price, 
including any applicable discounts. 
Additional Details (10:05-11:39) 
A variety of additional definitions can be recorded for each item in various sub-levels 
of the Received Items form. For instance, if serial numbers are maintained for one 
of the recei
ved parts, you can open new serial numbers for the part in the Auto 
Recording of Serial Nos. sub-level form, or link the part to an existing serial number 
in the Serial Numbers in Transaction sub-level form. Moreover, if you monitor the 
quality control of goods received from vendors, you can use the Analysis Results 
sub-level form to record the results of any quality control tests performed for a 
particular part or lot, rather than opening a separate document for this purpose. If 
any of the tests returns an unacceptable result, the item is automatically flagged as 
Unacceptable] in the Received Items form. Conversely, if all test results are 
acceptable, the item is flagged as Acceptable. If additional tests need to be 
performed for a given item, you can indicate this by flagging the Checking column. 
Items that are flagged for checking will not be billed along with the remainder of the 
document until the check mark is removed.  
Finally, you can view all open sales orders for any of the received items in the 
corresponding sub-level form. This is particularly useful when receiving goods that 
were specially purchased for a particular sales order. Alternatively, return to the 
upper-level form and select Open Sales Orders for Rec'd Parts from the list of 
Direct Activations in order to view all open sales orders for the parts listed in this 
document.  
Finalizing the GRV (11:40-13:09) 
Before finalizing the GRV, let's click the Price tab in order to check the Final Price of 
the received goods, including the applicable taxes and discounts. 
Once you are satisfied that all definitions are correct, click the General tab in order 
to update the document's status, indicating that it is now considered final. In our 
example, we are going to change the document's Status to Final and then exit and 
re-enter the record. As with most system documents, the properties of each GRV 
status, as well as other work flow definitions, are illustrated in a BPM flow chart, from 
which they can be updated as necessary. As per the BPM rules defined for the Final 
status, the changes we just made to the GRV triggered the following automated 
responses: the GRV was reassigned to Gery, who works in the finance department, 
and an e-mail was sent to Gery notifying him that the GRV is now ready for billing. 
If the purchase order supplied by this GRV is based on a purchase demand, you can 
also arrange to have an e-mail notification sent automatically to the initiating user 
when the purchased goods are received (i.e., when the GRV for the purchased 
goods is finalized). 
At this stage, you may want to print a copy of the GRV for your files. To do so, simply 
select Print GRV from the list of Direct Activations. You can also run a program that 
Cat.No. LB130469  Ver.1 – Oct 24,’13 4

prepares labels for the received items in a designated work area, from which they 
can subsequently be printed. 
Recording Vendor Returns (13:10-14:31) 
Let's say that one of the parts received in the GRV we just recorded was later found 
to be faulty and we decide to return it to the vendor. As previously noted, the return 
of goods can also be recorded in a GRV; for instance, the next time we record a 
GRV for this vendor, we can add a line for the faulty part, using a negative quantity. 
Alternatively, we can record the return of goods in a designated vendor return 
document. Like the Goods Receiving Voucher, the Returns to V
endor form is 
accessed from the Purchase Inventory Transactions menu . Likewise, the 
procedure for recording a return document is fairly similar to the procedure we just 
used to record a GRV.  
Specify the date the goods were returned, the number of the vendor that supplied 
the goods and the warehouse from which the goods are being returned. The 
document number, status and assigned user are all filled in automatically. 
Next, click the References tab to link the return to any related documents. In this 
case, we'll link it to our GRV, but you can also use the other columns in this tab to 
link a return document to a purchase order or an RMA document. 
Finally, click the Price tab and flag the Credit from Vendor column, to ensure that 
you are credited for the returned goods. 
Reviewing Returned Items (14:32-15:35) 
Enter the Returned Items sub-level form. The parts and their details have been filled 
in automatically according to the linked GRV. We'll begin by deleting the lines for any 
items that are not being returned and then update details for those that are. Since 
this return is based on a specific GRV, the Balance to Return column has been 
filled in with the quantity received from the vendor in the original GRV. If this balance 
accurately reflects the quantity being returned, flag the Approve column. As you can 
see, the Quantity column has now been filled in accordingly.  
Note that additional details have also been copied autom
atically from the GRV, such 
as the linked purchase order. As a result of this link between vendor return and 
purchase order, the order balance for the returned part is automatically updated in 
the original purchase order. Moreover, if the item had been linked to a Budget Item 
or a Profit/Cost Center in the original GRV, these details would be copied into the 
return document as well, ensuring that budget usage data is always up-to-date. 
Finalizing the Return Document (15:36-15:45) 
Once you are satisfied that all definitions are correct, return to the upper-level form in 
order to change the document's Status to Final. 
Changes to a Final GRV or Vendor Return Documen t (15:46-16:13) 
Once a GRV or return document is final, you can still make certain minor revisions 
from within the Revision of Final GRV or Revision of Final Vendor Returns forms, 
respectively, so long as no invoice has been issued yet. If you need to make more 
significant revisions, you'll need to reopen the document in question by selecting the 
Cat.No. LB130469  Ver.1 – Oct 24,’13 5

Cat.No. LB130469  Ver.1 – Oct 24,’13 6
relevant program from the list of Direct Activations. Don't forget to change the 
document's status back to final when you are done making your revisions. 
Reports on GRVs (16:14-17:01) 
Finally, let's review several of the reports available in Priority for following up on 
vendor shipments and returns. The Goods Received from Vendors report displays 
all receipts of materials into inventory over a specified period. The report is sorted by 
date and displays, for each received part, the quantity received, the vendor that 
supplied it, the receiving warehouse and the GRV number. A similar report is 
available for the Return of Goods to Vendors, as well. 
In addition, you can generate a report of unbilled GRVs over a designated period 
from the Accounts Payable Reports > Aging and Open Invoices menu.  
This concludes our demonstration of Priority's tools for documenting the receipt and 
return of purchased goods. 
Related Documentation 
 Receipt/Return of Goods Wizard
