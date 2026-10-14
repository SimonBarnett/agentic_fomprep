# SOP Multi-GRV Invoices

- **Source:** `SOP Multi-GRV Invoices.pdf`

Cat.No. LB10000452 1 Ver.1 – Sep. 14,’10 
 
SOP: Multi-GRV Invoices* 
Customer:   Company Inc. 
Assigned to: Dept./Position 
Aims 
 To produce a multi-GRV invoice based on an original GRV, vendor return document 
or purchase order. 
 To produce a multi-GRV invoice that is not based on any preceding document – see 
the end of this document. 
Note: To produce a vendor invoice, see the Vendor Invoices SOP. 
Recording Multi-GRV Invoices Based on Documents 
Setups 
 Define financial parameters for vendors in the Financial Parameters for Vendors form. 
Working Assumption 
 GRVs, vendor returns and/or purchase orders have been recorded in the system. 
Procedure 
Stage I: Preparing a Multi-GRV Invoice Based on an Original 
Document 
1. Open the Multi-GRV Invoices form. 
2. In the Vendor Number  column, select the desired vendor. 
3. In the Date column, specify the desired invoice date. 
4. In the Invoice Number column, record the number of the vendor's invoice. 
5. A temporary Internal Invoice number (with the prefix T) is filled in automatically, and 
the Debit/Credit column is flagged with a D. Change this to C for a credit memo. 
Note: When the invoice is finalized, a final internal invoice number is generated 
which replaces the temporary number. 
6. By default, the journal entry's transaction date will be the invoice date. To change 
this, click the Payment Info tab and specify the desired Transaction Date. 
                                                 
* Standard Operating Procedures should be used as guidelines for customers (and their consultants) to 
develop their own operating procedures. As you will note, the following procedures are very specific 
and customers are strongly advised not to use them without prior testing to make sure that they fit their own 
requirements and work practices.

7. In the Payment Info  tab, the Payment Date column automatically displays the 
payment deadline for this invoice, calculated on the basis of the invoice date and the 
payment terms defined for this vendor. If you want to change the payment terms for 
this vendor solely for this specific invoice, do one of the following: 
 Change the date manually in the Payment Date column, or 
 Enter the Invoice – Add'l Details sub-level form and select the desired terms in 
the Payment Terms Code column, or 
 Enter the Payment Installments sub-level form and define payment in terms of 
installments (breakdown into portions of the total invoice amount). 
8. In the upper-level form, click the References tab and record any comments regarding 
the invoice in the Details column.  
9. If the invoice is based on a single GRV or return document, select the relevant 
document in the Document Number column. 
10. If the invoice is based on several GRVs: 
 Enter the GRV's for Invoice sub-level form. 
 Select a separate GRV on each line in the Document column. 
11. If the invoice is based on several vendor returns: 
 Enter the Return Documents for Invoice sub-level form. 
 Select a separate return document on each line in the Document  column. 
12. To base a multi-GRV invoice on both a GRV and a vendor return, select the relevant 
GRV in the GRV's for Invoice sub-level form, and the relevant return document in 
the Return Documents for Invoice sub-level form. The Invoice Items sub-level 
form will display credit lines due to the GRV and debit lines due to the vendor return. 
13. If the vendor invoice was received before the purchased goods, and you want to 
base the invoice on the original purchase order: 
 To base the invoice on a single purchase order, specify its number in the  Order 
Number column in the References tab. 
 To base the invoice on several purchase orders, or on lines from within several 
different purchase orders, enter the Choose Order Items sub-level form, which 
displays the lines from all open purchase orders recorded for the current vendor. 
Flag the Choose Item column to include an item in the invoice. 
14. Enter the  Invoice Items sub-level form, which automatically displays the lines from 
the GRVs, return documents and/or purchase orders selected for this invoice. 
15. In the Inv. Quantity column, the quantity of each item appears automatically, as 
recorded in the GRV. You can change this value manually if it differs from that 
recorded in the vendor's invoice. 
16. In the Unit Price column, the price of each item appears automatically, as recorded 
in the GRV or vendor return. You can change it manually. 
Note: If the PurchDocPrice constant is not set at 1, the price may be taken from a 
different source. 
Cat.No. LB10000452 2 Ver.1 – Sep. 14,’10

17. In the % Item Discount  column, the vendor discount for each item appears 
automatically, as recorded in the GRV. You can change it manually. 
Note: If the PurchDocPrice constant is not set at 1, the discount may be taken from 
a different source. 
18. If you changed the unit price or discount, you can document the reason for doing so 
in the next sub-level Invoice Item – Remarks. 
19. If there is any kind of problem with the invoice, you can change its Status to 
"Checking". This status prevents all users from deleting the pending invoice, or 
making a payment against it. 
20. Return to the upper-level form and select Finalize Invoice/Memo from the list of 
Direct Activations. Alternatively, you can leave the invoice pending and finalize a 
batch of them simultaneously (see below). In this case, change the invoice Status 
from "Draft". 
Stage II: Finalizing Pending Multi-GRV Invoices 
1. Run the Finalize Multi-GRV Invoices program. 
2. In the query form that opens, retrieve the pending invoices that you want to finalize. 
You can retrieve all the pending invoices, or according to date, customer, etc. 
3. Close the form. 
4. Click OK on the Continue Execution message. 
5. If a problem is encountered finalizing an invoice, you will receive a message referring 
you to the errors report. To view errors, run the Finalize Multi-GRV Inv's-Errors report. 
6. To finalize a single multi-GRV invoice, retrieve the invoice in the Multi-GRV Invoices 
form and select Finalize Multi-GRV Invoices from the list of Direct Activations. 
Stage III: Printing a Batch of Multi-GRV Invoices 
1. Run the Print Multi-GRV Inv/Credit Memo program. 
2. To define a batch of invoices to print, press F6 in the Invoice/Memo Number column. 
3. The Multi-GRV Invoices form opens. Press F11 and retrieve the invoices that you 
want to print. 
4. Close the form. 
5. Define the sort method for the printouts. 
6. Select the desired print format. 
7. In the Print  dialogue box, specify the number of copies and the appropriate printer. 
Click OK. 
Stage IV: Deleting Multi-GRV Invoices 
1. To delete a batch of pending multi-GRV invoices: 
 Run the Delete Pending Multi-GRV Inv's program. 
 In the query form that opens, retrieve the pending invoices that you want to delete. 
You can retrieve all the pending invoices, or according to date, customer, etc. 
Cat.No. LB10000452 3 Ver.1 – Sep. 14,’10

 Close the form. 
 Click OK on the Continue Execution message. 
2. To cancel a final multi-GRV invoice, retrieve the invoice in the Multi-GRV Invoices form 
and select Cancel Document (Original Date) or Cancel Document For Date 
(indicating the date in question) from the list of Direct Activations. 
Results 
 At the end of the process, journal entries are created automatically against the 
finalized invoices prepared by the system. 
 GRVs and return documents for which invoices were prepared are flagged as Billed 
or Credited, respectively. 
 The final invoice will appear in the C hoose list when vendor payments are made. 
 If you canceled a final invoice, it is flagged in the Canceled column, and a 
cancellation journal entry is posted against it. 
Recording a Single Multi-GRV Invoice Not Based on a 
Document 
Aim 
 To produce a multi-GRV invoice that is not based on any preceding document. 
Setups 
 Define financial parameters for vendors in the Financial Parameters for Vendors form. 
Procedure 
Preparing the Multi-GRV Invoice 
1. Open the Multi-GRV Invoices form. 
2. In the Vendor Number  column, select the desired vendor. 
3. In the Date column, specify the desired invoice date. 
4. In the Invoice Number column, record the number of the vendor's invoice. 
5. By default, the journal entry's transaction date will be the invoice date. To change 
this, click the Payment Info tab and specify the desired Transaction Date. 
6. In the Payment Info  tab, the Payment Date column automatically displays the 
payment deadline for this invoice, calculated on the basis of the invoice date and the 
payment terms for this vendor. If you want to change the payment terms defined for 
this vendor solely for this specific invoice, do one of the following: 
 Change the date manually in the Payment Date column, or 
 Enter the Invoice – Add'l Details sub-level form, and select the desired terms in 
the Payment Terms Code column, or 
Cat.No. LB10000452 4 Ver.1 – Sep. 14,’10

Cat.No. LB10000452 5 Ver.1 – Sep. 14,’10 
 Enter the Payment Installments sub-level form and define payment in terms of 
installments (breakdown into portions of the total invoice amount). 
7. In the upper-level form, click the References tab and record any comments regarding 
the invoice in the Details column. 
8. Enter the Invoice Items sub-level form. Fill in the Part Number, Inv. Quantity and 
Unit Price columns, as well as any other columns you require. 
9. If there is any kind of problem with the invoice, you can change its Status to 
"Checking". This status prevents all users from deleting the pending invoice, or 
making a payment against it. 
10. To delete a pending multi-GRV invoice, select Delete Pending Invoice/Memo  from 
the list of Direct Activations. 
11. To finalize and/or print the invoice, select Finalize Invoice/Memo or Finalize & Print 
Invoice from the list of Direct Activations. If you choose the former option, select 
Print Vendor Invoice from the list of Direct Activations to print or view the invoice, or 
to send it via e-mail. 
12. To cancel a final multi-GRV invoice, select Cancel Document (Original Date) or 
Cancel Document For Date (indicating the date in question) from the list of Direct 
Activations. 
Results 
 At the end of the process, a journal entry is created automatically against the finalized 
invoice. 
 If you canceled the final invoice, it is flagged in the Canceled column, and a 
cancellation journal entry is posted against it.
